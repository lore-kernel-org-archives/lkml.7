Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DBDC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772BC2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hSugsegB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407938AbfJQHMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:12:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56012 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390955AbfJQHMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:12:18 -0400
Received: from zn.tnic (p200300EC2F0EE5002D4E61DE73F59AD4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:e500:2d4e:61de:73f5:9ad4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 93A8A1EC0C5C;
        Thu, 17 Oct 2019 09:12:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571296336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=16YyLhyi0/ld10NgFhnLQrsm3L287XWQxM/Pm2X4Cyc=;
        b=hSugsegBKl7eO5AMrP1TuZsJ3Q06p5X8VLWwlsv8xrw0XOg2p/QPBpr4pa6v2aZvnZnfLD
        0qRoIRu0s9r7e/0rRIBAjopvZxh3CDlOeN/Q+BTPUV7N/fgx5K6k8SRly2CB5n3o7Tuvm8
        npFqju7Hkq47dKbOQuumeK25GiVSkJ0=
Date:   Thu, 17 Oct 2019 09:12:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-tip-commits@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?Q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip: perf/core] perf trace: Introduce --filter for tracepoint
 events
Message-ID: <20191017071205.GA14441@zn.tnic>
References: <tip-95bfe5d4tzy5f66bx49d05rj@git.kernel.org>
 <157111750352.12254.17113253973879925388.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <157111750352.12254.17113253973879925388.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 05:31:43AM -0000, tip-bot2 for Arnaldo Carvalho de Melo wrote:
> The following commit has been merged into the perf/core branch of tip:
> 
> Commit-ID:     d4097f1937f2242d0aa0a7c654d2159a6895e5c8
> Gitweb:        https://git.kernel.org/tip/d4097f1937f2242d0aa0a7c654d2159a6895e5c8
> Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
> AuthorDate:    Tue, 08 Oct 2019 07:33:08 -03:00
> Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
> CommitterDate: Wed, 09 Oct 2019 11:23:52 -03:00
> 
> perf trace: Introduce --filter for tracepoint events
> 
> Similar to what is in 'perf record', works just like there:
> 
>   # perf trace -e msr:*
>    328.297 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
>    328.302 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
>    328.306 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
>    328.317 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
>    328.322 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
>    328.327 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
>    328.331 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
>    328.336 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
>    328.340 :0/0 ^Cmsr:write_msr(msr: FS_BASE, val: 140240388381888)

I wonder if you guys can force this val:'s format to be always hex?
Because MSR values are a lot more "natural" in hex...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
