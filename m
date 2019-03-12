Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79137C10F06
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0612087F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="X5Xrgw/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfCLA1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:27:46 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54858 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726411AbfCLA1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:27:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6AFE38EE14F;
        Mon, 11 Mar 2019 17:27:45 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id btyX2mUdqYuW; Mon, 11 Mar 2019 17:27:45 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D13618EE130;
        Mon, 11 Mar 2019 17:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552350465;
        bh=vnClVX+46Zy+ewYZTrYhTy3tlexaWaxa6VVtGc2Z0oY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=X5Xrgw/l+HxS0AvfPBwZUGI5inzApyAg7e2Ekp8garBt9085Y7p9p/Y55g54yCOme
         ljIG3Hz91UcYKNLalX3AYb8y4rO1FbX4ohKNtQUDMVKmoEw3OS5M3ChA9MEdnhYJYa
         3gJl7749KhLgJRrBHo7be7HfKF31qXZ540681Mn4=
Message-ID: <1552350463.23859.8.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Make timeout logic simpler and more robust
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Calvin Owens <calvinowens@fb.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Date:   Mon, 11 Mar 2019 17:27:43 -0700
In-Reply-To: <358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com>
References: <358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 16:54 -0700, Calvin Owens wrote:
> e're having lots of problems with TPM commands timing out, and we're
> seeing these problems across lots of different hardware (both v1/v2).
> 
> I instrumented the driver to collect latency data, but I wasn't able
> to find any specific timeout to fix: it seems like many of them are
> too aggressive. So I tried replacing all the timeout logic with a
> single universal long timeout, and found that makes our TPMs 100%
> reliable.
> 
> Given that this timeout logic is very complex, problematic, and
> appears to serve no real purpose, I propose simply deleting all of
> it.

"no real purpose" is a bit strong given that all these timeouts are
standards mandated.  The purpose stated by the standards is that there
needs to be a way of differentiating the TPM crashed from the TPM is
taking a very long time to respond.  For a normally functioning TPM it
looks complex and unnecessary, but for a malfunctioning one it's a
lifesaver.

Could you first check it's not a problem we introduced with our polling
changes?  My nuvoton still doesn't work properly with the default poll
timings but it works flawlessly if I use the patch below.  I think my
nuvoton is a bit out of spec (it's a very early model that was software
upgraded from 1.2 to 2.0) because no-one else on the list seems to see
the problems I see, but perhaps you are.

James

---

From 249d60a9fafa8638433e545b50dab6987346cb26 Mon Sep 17 00:00:00 2001
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 11 Jul 2018 10:11:14 -0700
Subject: [PATCH] tpm.h: increase poll timings to fix tpm_tis regression

tpm_tis regressed recently to the point where the TPM being driven by
it falls off the bus and cannot be contacted after some hours of use.
This is the failure trace:

jejb@jarvis:~> dmesg|grep tpm
[    3.282605] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
[14566.626614] tpm tpm0: Operation Timed out
[14566.626621] tpm tpm0: tpm2_load_context: failed with a system error -62
[14568.626607] tpm tpm0: tpm_try_transmit: tpm_send: error -62
[14570.626594] tpm tpm0: tpm_try_transmit: tpm_send: error -62
[14570.626605] tpm tpm0: tpm2_load_context: failed with a system error -62
[14572.626526] tpm tpm0: tpm_try_transmit: tpm_send: error -62
[14577.710441] tpm tpm0: tpm_try_transmit: tpm_send: error -62
...

The problem is caused by a change that caused us to poke the TPM far
more often to see if it's ready.  Apparently something about the bus
its on and the TPM means that it crashes or falls off the bus if you
poke it too often and once this happens, only a reboot will recover
it.

The fix I've come up with is to adjust the timings so the TPM no
longer falls of the bus.  Obviously, this fix works for my Nuvoton
NPCT6xxx but that's the only TPM I've tested it with.

Fixes: 424eaf910c32 tpm: reduce polling time to usecs for even finer granularity
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 4b104245afed..a6c806d98950 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -64,8 +64,8 @@ enum tpm_timeout {
 	TPM_TIMEOUT_RETRY = 100, /* msecs */
 	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
 	TPM_TIMEOUT_POLL = 1,	/* msecs */
-	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
-	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
+	TPM_TIMEOUT_USECS_MIN = 750,      /* usecs */
+	TPM_TIMEOUT_USECS_MAX = 1000,      /* usecs */
 };
 
 /* TPM addresses */
