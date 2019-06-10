Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18A7C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45A820859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="Lbfc/E8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391179AbfFJQYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:24:17 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:48560 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389927AbfFJQYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:24:17 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id A05BC403C9;
        Mon, 10 Jun 2019 18:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1560183854; x=1561998255; bh=4bpS8XQNGbDvLWL5Tu0rslp1K0w4sKNibrp
        rpGYwGH4=; b=Lbfc/E8mnx4qr/xRVmvwpJNjreFxLBG1J9En/UscbACfH5ewC4o
        fdM5vNL18CAajaJ3rwNnqKg5Pecm49ZPpbgDv0r0bFBXrMeE/eFFXPNCC66mE4tE
        LYLpjzXakF4sFhYEt4OAuBsWaSYkdplWpf1PwVaouLYQt0/1/wV005H8ABcKd6+x
        L7cinuwe6q2Hctbwv42ZlPY0qSJueKXegUniFnNieutN4CspU6qTaeNn6TGYSf35
        BfblhDncQCJFkGpt7Kk92bBNvDpVwmQYsaH/sGO9ukCZYNMMfnKU/TyZkDa5iZuo
        LPZlROLxBzlImuJrhW3J7+5KZA5Xd5uk3F1jzr8lTRX2EB7cJq4SzH2ANG/S/fE+
        5ju2DrIRELuGL9TmsppNoNL0nF0/1rwrTVvI0EhnYkVNkBok/mXMm/2x9MZPuIhb
        W0d5WXmGs1DQEOEqSkYE05tJEWA4Nu2/pukwymh1Kv7Ce9I44DMgVeqw03TdEVkw
        T+JXxAUuO4uRM/+pwXANQa6p/DkJ0UoATw2v8Kb97t7+tP1J2nL4A7hRZgxVwCmk
        I5wgnyTpg8whQpZ+jx+L2IrDjr0/zXhgZ52pgI+N74z17+8yWAmXnV7LsoiszXIn
        ahEq2dSpCjh1nU5gSy5q7Xf9FtRBlHKzHghVvaEpnqo4VfnAshoMcebg=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lIboWi3tIZq2; Mon, 10 Jun 2019 18:24:14 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 0847E402AB;
        Mon, 10 Jun 2019 18:24:12 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 58491439;
        Mon, 10 Jun 2019 18:24:12 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 09/33] docs: fault-injection: convert docs to ReST and rename to *.rst
Date:   Mon, 10 Jun 2019 18:24:10 +0200
Message-ID: <1693516.ET8j6nyPp2@harkonnen>
In-Reply-To: <5bbdd14f23a8fa66164ac38d84662091b90adddc.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org> <5bbdd14f23a8fa66164ac38d84662091b90adddc.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In data Sunday, June 9, 2019 4:26:59 AM CEST, Mauro Carvalho Chehab ha 
scritto:
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
>  ...ault-injection.txt => fault-injection.rst} | 265 +++++++++---------
>  Documentation/fault-injection/index.rst       |  20 ++
>  ...r-inject.txt => notifier-error-inject.rst} |  18 +-
>  ...injection.txt => nvme-fault-injection.rst} | 174 ++++++------
>  ...rovoke-crashes.txt => provoke-crashes.rst} |  40 ++-
>  Documentation/process/4.Coding.rst            |   2 +-
>  .../translations/it_IT/process/4.Coding.rst   |   2 +-

Limited to translations/it_IT

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>

>  .../translations/zh_CN/process/4.Coding.rst   |   2 +-
>  drivers/misc/lkdtm/core.c                     |   2 +-
>  include/linux/fault-inject.h                  |   2 +-
>  lib/Kconfig.debug                             |   2 +-
>  tools/testing/fault-injection/failcmd.sh      |   2 +-
>  12 files changed, 290 insertions(+), 241 deletions(-)
>  rename Documentation/fault-injection/{fault-injection.txt =>
> fault-injection.rst} (68%) create mode 100644
> Documentation/fault-injection/index.rst
>  rename Documentation/fault-injection/{notifier-error-inject.txt =>
> notifier-error-inject.rst} (83%) rename
> Documentation/fault-injection/{nvme-fault-injection.txt =>
> nvme-fault-injection.rst} (19%) rename
> Documentation/fault-injection/{provoke-crashes.txt => provoke-crashes.rst}
> (45%)
> 



