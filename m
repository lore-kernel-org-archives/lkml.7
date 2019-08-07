Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5400BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297FF214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+iTI8A4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfHGV6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:58:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45210 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfHGV6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:58:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so42856949pgp.12;
        Wed, 07 Aug 2019 14:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=uIeRwaRIiqOqi4dTrdidnKMKO6PgxCzxKDJrRVdKeuM=;
        b=K+iTI8A4/vw5vwjYLchA92CdhPvkoYtq0ubnVX4cw4ann8i8mcEXeicaqDLHGiFq3H
         //HgH7Ig4hb2JHjuMUW1wXCZfk1gbHg1n3K02Dr0KePTKB5wZRhzw5yTfkKU8R/xfqNi
         zAofO3ymOeUXwtRRjxF0vbIxB5Zk4WQOP9pxYiWHsM3RFgADPge+w/99YYf41p1jXMan
         eYvcGq2yMYwetf6v2Gmfgv/DeMx2gqxDlcjDSUQRMvMi9TPdGaPbEHxzi9Vs+MFLp6m1
         l2QE2c4Fr5ALLvwJjE6MAsxYjmhvvavZ43E2dnSRNwD6HYNbOa+Dj90O+R+LmSmMQ8Pf
         JnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=uIeRwaRIiqOqi4dTrdidnKMKO6PgxCzxKDJrRVdKeuM=;
        b=da4UhCuls59VOoWUUU4AwHUaGsr+7dhCE80VFY4y2c74JKGpY5H8sOHSAIWMLV8NDC
         h6DlEY7WjvhJS2EBYlFn5MMlMCFBtCkPRbdTp9kaqLlhxY1DUuakWWuT55Ji9rsZwU6z
         FwKiMqRrbfFNulk66POg0D+BNYDOdqdXmJPgd+pcMskg4u4yn6xENkwNUiD5ozfKqXrJ
         B8No3/ByhXf0hdXCpPAWvqoWuY88kzXWaoFQ9ZuPYJ/1EHbNSUnE4uhuINf3XfiVPPRE
         jwC6S3802aGIlpfcid5sBJ+gfv/lIHqZl20azhDabt9CYS+CW+nnltaghRi6nmT7GfTT
         78jg==
X-Gm-Message-State: APjAAAWs9ZgI2yWqL4AU9x7igyuj3NjYc84yfJrIiPTod53wI+dGczCd
        tb/6CWtDajoawR2GO6eiydX0ePGT
X-Google-Smtp-Source: APXvYqzxxy3akodFeVrbjOVv/thI20P8HvBuyhwYaMoDkKyd/v1+YtUgorzhevyiYsfIGusZKlrNAA==
X-Received: by 2002:a63:4c5a:: with SMTP id m26mr9467336pgl.270.1565215118345;
        Wed, 07 Aug 2019 14:58:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o14sm181941539pfh.153.2019.08.07.14.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 14:58:37 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.3-rc4
Date:   Wed,  7 Aug 2019 14:58:35 -0700
Message-Id: <1565215115-11064-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.3-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.3-rc4

Thanks,
Guenter
------

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.3-rc4

for you to fetch changes up to a95a4f3f2702b55a89393bf0f1b2b3d79e0f7da2:

  hwmon: (lm75) Fixup tmp75b clr_mask (2019-08-07 14:50:49 -0700)

----------------------------------------------------------------
Fixes to lm75 and nct7802 drivers

In lm75 driver, fix TMP75B chip description to ensure correct
initialization. In nct7802 driver, fix in4 presence detection.

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: (nct7802) Fix wrong detection of in4 presence

Iker Perez del Palomar Sustatxa (1):
      hwmon: (lm75) Fixup tmp75b clr_mask

 drivers/hwmon/lm75.c    | 2 +-
 drivers/hwmon/nct7802.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)
