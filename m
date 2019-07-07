Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F28C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 10:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F231A20665
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 10:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZocZeRO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfGGKKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 06:10:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58753 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfGGKKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 06:10:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x67AA0Wu879360
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 7 Jul 2019 03:10:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x67AA0Wu879360
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562494201;
        bh=h6AxCnF8Cy9JvxbrLLPGcxIHpYIAsA8NGwjX/2T0TCA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ZocZeRO/C5/UqyHn+1CMBh4ddZ9hqA1l97JNRwkfeyw/m7mgxJ0CzoP1DuUrL1CUL
         dQxCAduNUMfmQxZb1OERSxf9fRQQa6fOhEuQN3pzRSD5Ly7qUkmgS7gO9WiJyOD81m
         ErFEMFfTSvk3bVkGiVQm8wYT5NhBeAIddM9fuxpDSQdWK7M/knc5az2Zxuebiwg9fI
         J6/zsVm/Jo+fqqPsq4GWYZ8s07QWY/E+vtuPbtrhvtoSzWn2K9prbSKuMt2shaE0qB
         AkyYskedAr5VrTSeZ60Y1RMYLOsaWWcw1yG7pfnJ3sYz/SB+9+snH2VCloDtWEDJyg
         E9h5QsOSojJAg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x67AA07K879357;
        Sun, 7 Jul 2019 03:10:00 -0700
Date:   Sun, 7 Jul 2019 03:10:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for zhengbin <tipbot@zytor.com>
Message-ID: <tip-9176ab1b848059a0cd9caf39f0cebaa1b7ec5ec2@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, zhengbin13@huawei.com
Reply-To: mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          zhengbin13@huawei.com
In-Reply-To: <1562460701-113301-1-git-send-email-zhengbin13@huawei.com>
References: <1562460701-113301-1-git-send-email-zhengbin13@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] time: Validate user input in
 compat_settimeofday()
Git-Commit-ID: 9176ab1b848059a0cd9caf39f0cebaa1b7ec5ec2
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

Commit-ID:  9176ab1b848059a0cd9caf39f0cebaa1b7ec5ec2
Gitweb:     https://git.kernel.org/tip/9176ab1b848059a0cd9caf39f0cebaa1b7ec5ec2
Author:     zhengbin <zhengbin13@huawei.com>
AuthorDate: Sun, 7 Jul 2019 08:51:41 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 7 Jul 2019 12:05:40 +0200

time: Validate user input in compat_settimeofday()

The user value is validated after converting the timeval to a timespec, but
for a wide range of negative tv_usec values the multiplication overflow turns
them in positive numbers. So the 'validated later' is not catching the
invalid input.

Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1562460701-113301-1-git-send-email-zhengbin13@huawei.com

---
 kernel/time/time.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 7f7d6914ddd5..5c54ca632d08 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -251,6 +251,10 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
 	if (tv) {
 		if (compat_get_timeval(&user_tv, tv))
 			return -EFAULT;
+
+		if (!timeval_valid(&user_tv))
+			return -EINVAL;
+
 		new_ts.tv_sec = user_tv.tv_sec;
 		new_ts.tv_nsec = user_tv.tv_usec * NSEC_PER_USEC;
 	}
