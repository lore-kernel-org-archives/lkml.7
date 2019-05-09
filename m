Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7BAC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE4E216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kpYQBalW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfEIIxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 04:53:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43547 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfEIIxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:53:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x498qruH1467753
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 9 May 2019 01:52:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x498qruH1467753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557391974;
        bh=UAplFKrGueTVtx1S3VgkdblcoegBhRfJCEfTMM6XrHg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=kpYQBalWYRp7F2dzQmCA4Y+QvCgpLQHnz4pa7Yf9Y3wL5BFoxgUkWdzn0rxXmesHE
         0DU3dCMKSp2cAtdquZSRY+tzfGjeQXKqNCHxZdMbCCIw3Sm82avnTsvb2jzNY/YGe3
         /vaoWxMft6OFicbpFpKATINgY6omS3LjR8Y7oKlSLX3J0BGtncxkvKc8IPVEPklXu2
         wLy3vKHT/RlfL+UVNPHZmKpXqyNicVOug5MlK6DBtdph1JUrZG0Zzz2SQ43h45D9MQ
         x5QWVDhADjUG9aor7hlFyKlQnfQm8nIoedhxI07D0ng8aNb8wfNn1BlK3OIcVo65br
         a3ndTY2cTMumA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x498qrgG1467750;
        Thu, 9 May 2019 01:52:53 -0700
Date:   Thu, 9 May 2019 01:52:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Miroslav Lichvar <tipbot@zytor.com>
Message-ID: <tip-fdc6bae940ee9eb869e493990540098b8c0fd6ab@git.kernel.org>
Cc:     hpa@zytor.com, richardcochran@gmail.com, tglx@linutronix.de,
        john.stultz@linaro.org, mingo@kernel.org, mlichvar@redhat.com,
        prarit@redhat.com, omosnace@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: prarit@redhat.com, omosnace@redhat.com, mlichvar@redhat.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, john.stultz@linaro.org,
          richardcochran@gmail.com, hpa@zytor.com
In-Reply-To: <20190417084833.7401-1-mlichvar@redhat.com>
References: <20190417084833.7401-1-mlichvar@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] ntp: Allow TAI-UTC offset to be set to zero
Git-Commit-ID: fdc6bae940ee9eb869e493990540098b8c0fd6ab
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fdc6bae940ee9eb869e493990540098b8c0fd6ab
Gitweb:     https://git.kernel.org/tip/fdc6bae940ee9eb869e493990540098b8c0fd6ab
Author:     Miroslav Lichvar <mlichvar@redhat.com>
AuthorDate: Wed, 17 Apr 2019 10:48:33 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 9 May 2019 10:46:58 +0200

ntp: Allow TAI-UTC offset to be set to zero

The ADJ_TAI adjtimex mode sets the TAI-UTC offset of the system clock.
It is typically set by NTP/PTP implementations and it is automatically
updated by the kernel on leap seconds. The initial value is zero (which
applications may interpret as unknown), but this value cannot be set by
adjtimex. This limitation seems to go back to the original "nanokernel"
implementation by David Mills.

Change the ADJ_TAI check to accept zero as a valid TAI-UTC offset in
order to allow setting it back to the initial value.

Fixes: 153b5d054ac2 ("ntp: support for TAI")
Suggested-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Link: https://lkml.kernel.org/r/20190417084833.7401-1-mlichvar@redhat.com

---
 kernel/time/ntp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 92a90014a925..f43d47c8c3b6 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -690,7 +690,7 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 		time_constant = max(time_constant, 0l);
 	}
 
-	if (txc->modes & ADJ_TAI && txc->constant > 0)
+	if (txc->modes & ADJ_TAI && txc->constant >= 0)
 		*time_tai = txc->constant;
 
 	if (txc->modes & ADJ_OFFSET)
