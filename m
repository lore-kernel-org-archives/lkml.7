Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120EFC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EF1206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="vvgl8u3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfDBMjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:39:04 -0400
Received: from tomli.me ([153.92.126.73]:33510 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDBMjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:39:04 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id b6f569d2;
        Tue, 2 Apr 2019 12:39:00 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:ddd9:ae88)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Tue, 02 Apr 2019 12:39:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=4XBSMbqz8X+fsl/Txp8qZiRU0vX7ODPdDo4Mjh3qeEs=; b=vvgl8u3bmFwZC8QDdl6ozeboNMJOlVqSiAX3zYpiXmGMEaWPMmXBami73LMufVrEam22617+3Zp2yAbRRZ88XlHm0NxV0u8uvLwBjaCBlpKKv1pu8ftuBKmAu6N04rSh12WKzcPDp/lVvJGs4hjXRneRc5QxhSOdv41jE9nJU1ZkcD6khnUhqjBj7aKmKHE4pTkR6j4DTFxfRR1iblJYOCtT1GrDdWJmnEeCXZOTz+hVtceNZMyuej3kxuBhbhejJ9fosEeSem7GHwRgb/g457ousKT5DVrDO3B4rbbGyYOlFoFMHOT5GdN7LKeGaonNLiJGQPijFb+tnaQocNXoxQ==
Date:   Tue, 2 Apr 2019 20:38:50 +0800
From:   Tom Li <tomli@tomli.me>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yifeng Li <tomli@tomli.me>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, linux-fbdev@vger.kernel.org
Subject: Re: linux-next: build warning after merge of the fbdev tree
Message-ID: <20190402123849.GA4562@localhost.localdomain>
References: <20190402093007.0b03b02e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402093007.0b03b02e@canb.auug.org.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 09:30:07AM +1100, Stephen Rothwell wrote:
> Hi Bartlomiej,
> 
> After merging the fbdev tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/video/fbdev/sm712fb.c: In function 'smtc_blank':
> drivers/video/fbdev/sm712fb.c:900:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     smtc_seqw(0x6b, 0x02);
>     ^~~~~~~~~~~~~~~~~~~~~
> drivers/video/fbdev/sm712fb.c:901:3: note: here
>    case 0x720:
>    ^~~~
> 
> Introduced by commit
> 
>   f627caf55b8e ("fbdev: sm712fb: fix crashes and garbled display during DPMS modesetting")
> 

Nice catch! Thanks!

This bug was introduced by me while attempting to fix another issue, a result of
my copy-paste error. Since it only reprograms the clock to a different frequency,
it's only a benign issue without visible side-effect, so it also evaded Sudip
Mukherjee's code review and regression tests.

But what's I'm more concerned here is the failure of scripts/checkpatch.pl. I
thought ./checkpatch.pl should have caught it, but for some reasons it cannot
detect this one.

$ ./scripts/checkpatch.pl 0001-fbdev-sm712fb-fix-crashes-and-garbled-display-during.patch
total: 0 errors, 0 warnings, 105 lines checked

So I mistakenly assumed the patch doesn't have a problem... It seems checkpatch.pl
cannot detect fallthroughs in nested switch/case statements? I'm not sure. Should I
report it to the maintainers of checkpatch.pl?

Anyway, please apply the following patch ASAP.

Thanks,
Tom Li

From 040fa4e6cc8b338cd845c11fd3efd7394ca55108 Mon Sep 17 00:00:00 2001
From: Yifeng Li <tomli@tomli.me>
Date: Tue, 2 Apr 2019 20:25:20 +0800
Subject: [PATCH] fbdev: sm712fb: fix memory frequency by avoiding a
 switch/case fallthrough.

A fallthrough in switch/case was introduced in f627caf55b8e ("fbdev:
sm712fb: fix crashes and garbled display during DPMS modesetting"),
due to my copy-paste error, which would cause the memory clock frequency
for SM720 to be programmed to SM712.

Since it only reprograms the clock to a different frequency, it's only
a benign issue without visible side-effect, so it also evaded Sudip
Mukherjee's code review and regression tests. scripts/checkpatch.pl
also failed to discover the issue, possibly due to nested switch
statements.

This issue was found by Stephen Rothwell by building linux-next with
-Wimplicit-fallthrough.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: f627caf55b8e ("fbdev: sm712fb: fix crashes and garbled display during DPMS modesetting")
Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/video/fbdev/sm712fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 1e2503b52c6f..f1dcc6766d1e 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -898,6 +898,7 @@ static int smtc_blank(int blank_mode, struct fb_info *info)
 		case 0x712:
 			smtc_seqw(0x6a, 0x16);
 			smtc_seqw(0x6b, 0x02);
+			break;
 		case 0x720:
 			smtc_seqw(0x6a, 0x0d);
 			smtc_seqw(0x6b, 0x02);
-- 
2.20.1

