Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C91DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0025F2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ZjnJYxOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfDBPdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:33:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46261 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBPdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:33:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so4192009wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CEZv4uzh5Ly4ogK+JYDKMFnRY/k24/YL82pMRtEDad4=;
        b=ZjnJYxOpzUpKL2uXYVNwkROSA4h3dFZn/BTY0FO/0niv9YAVTOKGzpKjBwIvs/VzJ1
         Sor09hYni9aWarL7X0Btv7hb7cYJNpPSwzKBAaVEa2DEBMYyax7nrGHD0vidNAByj6XZ
         UZw4po0+l819XI31TSGyQARA9wldzEsrNPdDbkR2RG80YGq3LDI29MryzNWlPdC3s5Zn
         pO1aVwAkQj1lnCePy7pm05xHUcu6I3f6/2PPkQIrAqRemRJpsa334cexLFRyiH/QO6Rx
         fdeZl9TdkeE9NHxSfDsGi1aqG1JaVHVtWkF+nNB1iYt0ejIoJl8N7P2ZahtdoE8RLNLv
         nvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CEZv4uzh5Ly4ogK+JYDKMFnRY/k24/YL82pMRtEDad4=;
        b=c25bWlUwb1Gp1SkKS8vQWYGyJP62lDj1gPKAtBhVN/DC78Lk7yxBTGgHmcGe1irlFU
         7/xvqWEMWKCneSjmtFo6D9LeuH9QkjRnMxn4z7SvNobj/omH/16qR//bw/6Rj1CM/wB3
         Qn1f/omSIN4cS3ErJue0kOB+nXfyfVmRlQ8QO4KS73KimEpDyOyL5hKzTD6nL2K/2jUY
         lp1TwdeQZoh8ISvguDxJMBEDpsH42DzDHD69e9iIqmj+Z0p42jzwSk/Ss1CE4+WNEBu3
         1GArKkD6vDAE3Eb23jmiYuoeupr48+zldAyvjt7VCWeYrcf6ZnKIANsBbZM02wF1YeYW
         lRBg==
X-Gm-Message-State: APjAAAVXxsr4CPRUUL5CXUa3bD1UhQCZYbhpf3pL58uQ78cPYQ0YNSb5
        EoyGbR6CJhP3aghV4m3kMBLeDCRTYoeg5Q==
X-Google-Smtp-Source: APXvYqx055+2aOiMBHpSQ+8A5YRpEyHowsa10Ez6PVl0Lp1y6jCTZHHFite4a70KiIv0UgQMkhDZXA==
X-Received: by 2002:adf:b6a3:: with SMTP id j35mr45963497wre.25.1554219200784;
        Tue, 02 Apr 2019 08:33:20 -0700 (PDT)
Received: from localhost.localdomain ([185.197.132.10])
        by smtp.gmail.com with ESMTPSA id s2sm14400335wmc.7.2019.04.02.08.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 08:33:20 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jannh@google.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [GIT PULL] pidfd fixes for v5.1-rc3
Date:   Tue,  2 Apr 2019 17:33:07 +0200
Message-Id: <20190402153307.18672-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This should be an uncontroversial fix for pidfd_send_signal() by Jann to
better align it's behavior with other signal sending functions:

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd-fixes-v5.1-rc3

for you to fetch changes up to 556a888a14afe27164191955618990fb3ccc9aad:

  signal: don't silently convert SI_USER signals to non-current pidfd (2019-04-01 23:03:18 +0200)

In one of the early versions of the patchset it was suggested to not
unconditionally error out when a signal with SI_USER is sent to a
non-current task (cf. [1]). Instead, pidfd_send_signal() currently silently
changes this to a regular kill signal. While this is technically fine, the
semantics are weird since the kernel just silently converts a user's request
behind their back and also no other signal sending function allows to do
this. It gets more hairy when we introduce sending signals to a specific
thread soon.
So let's align pidfd_send_signal() with all the other signal sending
functions and error out when SI_USER signals are sent to a non-current
task.

Please consider pulling this fix!
Thanks!
Christian

/* References */
[1]: https://lore.kernel.org/lkml/87zhtjn8ck.fsf@xmission.com/

----------------------------------------------------------------
pidfd fixes for v5.1-rc3

----------------------------------------------------------------
Jann Horn (1):
      signal: don't silently convert SI_USER signals to non-current pidfd

 kernel/signal.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index b7953934aa99..f98448cf2def 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3605,16 +3605,11 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		if (unlikely(sig != kinfo.si_signo))
 			goto err;
 
+		/* Only allow sending arbitrary signals to yourself. */
+		ret = -EPERM;
 		if ((task_pid(current) != pid) &&
-		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL)) {
-			/* Only allow sending arbitrary signals to yourself. */
-			ret = -EPERM;
-			if (kinfo.si_code != SI_USER)
-				goto err;
-
-			/* Turn this into a regular kill signal. */
-			prepare_kill_siginfo(sig, &kinfo);
-		}
+		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
+			goto err;
 	} else {
 		prepare_kill_siginfo(sig, &kinfo);
 	}
