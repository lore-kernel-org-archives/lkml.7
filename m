Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE71ACA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 13:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58C320862
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 13:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4ht0Nl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKBNsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 09:48:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38023 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfKBNsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 09:48:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id v9so12364249wrq.5;
        Sat, 02 Nov 2019 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c6XCwH0Bc3ksK3DNKL/I9xx6zN9r95PVwFoFmujv9Ko=;
        b=D4ht0Nl8C0j6YIY13ogsQxOesmweTzfotAuALJLnmd9uUTNQS1gODqolDEiGGkjm2Q
         ssW+WAebTIiTuP+uoWKqXVP+t3Cnss0M9xDmIkGDl3t0J3bLbBLcQ9Fu951UIsa/bo/C
         sag+drqUbxFLH+JR98lyVhf9Wv9gzvd5V1n96GenNEo2ACXGJz3EQZ6S3EPYkZ05gqoG
         eS8Mtaip/Ytu909u0IHN6Jhmd9Es3UgXts61u/VXSQrmziiusoT+gl1m4R2ej0Ka0DCA
         xlJMhUyDpJi47XSyvSs5cy+bplGIMj6QYHjFPOhF6y/7XVtYHZWyCb0Ty40lA3jUU4Yp
         RsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c6XCwH0Bc3ksK3DNKL/I9xx6zN9r95PVwFoFmujv9Ko=;
        b=prlAiHULTB2r0bcG6fpFDlZn/M+B79rsn+2HOP85aIosmdPVEMKNVahu9GSml+F5rC
         jLDttQxr2v7xQAYZt/UbWZW2wxOcp7ovmNZCRpx39Fi70j/+f8sY87k7qLexCIGafoi4
         xq86xsQ7EUX1/jp4znWi2BE6wk+fX2yaHiz7woNJJoQgDN28mcGyxWUO0e/C25aFdTKu
         nsSow1iq9rrYYVeCHEBpOqoFvxbpXptEXsT3yR/v340MlHMu5Jy+wUAWzHQjVeNpuB6I
         3sZQ06QhLldq2QwS+z+p8avccOlwfvBZBXWJ3OZ1a+///atEaPCnZmmyoM7TKs4P63HO
         +Wlg==
X-Gm-Message-State: APjAAAUeL5/ZifOUGjrFhT90cJNTObVheyeJimBBCkBGD69UDFp0+q4o
        3pCBhYgFqQ1eThEHexyizDs=
X-Google-Smtp-Source: APXvYqy8wDtLLHQaE1OgZSNrzDUgSTuigXrUi+tu6FdFgUhsiQppzOVCnhdOVg+cnbH8mo/obJYgSA==
X-Received: by 2002:a05:6000:14a:: with SMTP id r10mr14868052wrx.310.1572702484342;
        Sat, 02 Nov 2019 06:48:04 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id c15sm9051270wmb.45.2019.11.02.06.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2019 06:48:02 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Fixes for v5.4-rc6
Date:   Sat,  2 Nov 2019 14:48:00 +0100
Message-Id: <20191102134800.3847540-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.4-rc6

for you to fetch changes up to 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3:

  Revert "pwm: Let pwm_get_state() return the last implemented state" (2019-10-21 16:48:52 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Fixes for v5.4-rc6

It turned out that relying solely on drivers storing all the PWM state
in hardware was a little premature and causes a number of subtle (and
some not so subtle) regressions. Revert the offending patch for now.

----------------------------------------------------------------
Thierry Reding (1):
      Revert "pwm: Let pwm_get_state() return the last implemented state"

 drivers/pwm/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)
