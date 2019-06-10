Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3383C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A82E20820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="DNscEI5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389938AbfFJVNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:13:17 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:9204 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfFJVNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:13:17 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id B4F99844;
        Mon, 10 Jun 2019 23:13:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1560201194; x=1562015595; bh=ARkpqDw6hh5K+0monDK5QS19Np6XwBxbJQx
        bed0bnp0=; b=DNscEI5WOdOU5DBDL0y/wOTaHbSZ35U80+dkOcNWgqOc8N5oV+e
        weGSxcGuvJ1g0S0GiDNMxDmoVtN/WSHgTkoWvhDzfzPLnBDey1CsxJH7h1jl7p+O
        aMnUrztGihiusjsxMNuh47zI6p/1+/O2+o3yl5TPHns45w6lyVU46PeElDVuLXWF
        zRVqvI/tHLR4Gkg4pli4+GHg/gkfMQv6LsWwBRV2dbPCGIPkwXlCqG+Idaa+oKoU
        z7gTrCPRSjF0CTvUs7P2Tm5iPtlp9LVL6gDUKmSVE54pSH22NPuZYUtQcOKrx7Ga
        LEwHOd7+ZTRnVOKKfK7N6c/982FTmjigQOyvFGt4GSFmTE2NTUBj4zQddDOASoS6
        U3JMgL7StJuqdgEwSxb4sg2TySbwgtRi8Rd6rJTXonRXdfKaly05yKKYpp3qKh3r
        6ggayiLNtfYY7ygRZZH624JRVeRO5+eULJM5psD1SgLCYAdR3sHO7BDSDH0zKcQf
        4grQrVlHzupIxFnoEwFhRrzWUMdsIuSbDeRMMGunW5SyZ+ikMuqyqq8WsGLcOdMs
        5Lxa5au4jfSpcO7A0RzMlD0Ehz034xV7/w4ewF4M6ysy0GpiaMi2PybK9M1XsxRG
        mpjIi4RgMNGAu489QCg37P1XWOdoW3ivw7oniGbgnk8H3i2CzN0RKmGE=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M5isNbMaxBm5; Mon, 10 Jun 2019 23:13:14 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 346D111C;
        Mon, 10 Jun 2019 23:13:14 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 1A3F82023;
        Mon, 10 Jun 2019 18:26:39 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 16/33] docs: locking: convert docs to ReST and rename to *.rst
Date:   Mon, 10 Jun 2019 18:26:37 +0200
Message-ID: <2479388.eidelHUoWk@harkonnen>
In-Reply-To: <d5a915447d63fce96cbf463a512cce89423776c3.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org> <d5a915447d63fce96cbf463a512cce89423776c3.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In data Sunday, June 9, 2019 4:27:06 AM CEST, Mauro Carvalho Chehab ha 
scritto:
> Convert the locking documents to ReST and add them to the
> kernel development book where it belongs.
> 
> Most of the stuff here is just to make Sphinx to properly
> parse the text file, as they're already in good shape,
> not requiring massive changes in order to be parsed.
> 
> The conversion is actually:
>   - add blank lines and identation in order to identify paragraphs;
>   - fix tables markups;
>   - add some lists markups;
>   - mark literal blocks;
>   - adjust title markups.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/kernel-hacking/locking.rst      |   2 +-
>  Documentation/locking/index.rst               |  24 ++
>  ...{lockdep-design.txt => lockdep-design.rst} |  51 ++--
>  .../locking/{lockstat.txt => lockstat.rst}    | 221 ++++++++++--------
>  .../{locktorture.txt => locktorture.rst}      | 105 +++++----
>  .../{mutex-design.txt => mutex-design.rst}    |  26 ++-
>  ...t-mutex-design.txt => rt-mutex-design.rst} | 139 ++++++-----
>  .../locking/{rt-mutex.txt => rt-mutex.rst}    |  30 +--
>  .../locking/{spinlocks.txt => spinlocks.rst}  |  32 ++-
>  ...w-mutex-design.txt => ww-mutex-design.rst} |  82 ++++---
>  Documentation/pi-futex.txt                    |   2 +-
>  .../it_IT/kernel-hacking/locking.rst          |   2 +-

Limited to translations/it_IT

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>

>  drivers/gpu/drm/drm_modeset_lock.c            |   2 +-
>  include/linux/lockdep.h                       |   2 +-
>  include/linux/mutex.h                         |   2 +-
>  include/linux/rwsem.h                         |   2 +-
>  kernel/locking/mutex.c                        |   2 +-
>  kernel/locking/rtmutex.c                      |   2 +-
>  lib/Kconfig.debug                             |   4 +-
>  19 files changed, 428 insertions(+), 304 deletions(-)
>  create mode 100644 Documentation/locking/index.rst
>  rename Documentation/locking/{lockdep-design.txt => lockdep-design.rst}
> (93%) rename Documentation/locking/{lockstat.txt => lockstat.rst} (41%)
> rename Documentation/locking/{locktorture.txt => locktorture.rst} (57%)
> rename Documentation/locking/{mutex-design.txt => mutex-design.rst} (94%)
> rename Documentation/locking/{rt-mutex-design.txt => rt-mutex-design.rst}
> (91%) rename Documentation/locking/{rt-mutex.txt => rt-mutex.rst} (71%)
> rename Documentation/locking/{spinlocks.txt => spinlocks.rst} (89%) rename
> Documentation/locking/{ww-mutex-design.txt => ww-mutex-design.rst} (93%)
> 





