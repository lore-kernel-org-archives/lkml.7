Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508BAC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 04:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2091D206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 04:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p49ufNmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfGBEhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 00:37:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44267 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfGBEhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 00:37:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so8446263plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 21:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DC7T/1epSdwbqDWlhU77s7p6S8E3+rl5WhjQziUAp3Y=;
        b=p49ufNmqYf8JRR5G6e2SINTKVPTvV4SdImOKWOUQp+vXexeQ7fRafUiq5Poy0V8faU
         E/zc1Hz+LB3WE/ZeYL1gGnHssal6w69pUfEsCQs9S2NBzgYx71J08wHTa3RBBk3GkPhg
         sHfnlB12M0vzbcGXRBRifYiulW4GgmIcOVhdcttHxbBuTFj2zCBrX+v5J2XYixHEOg5G
         pZRMnz3STMwCz4B1tVcbthRgK97BjO6HP9qisr8Y/aTrUdhV7V2dVDyN6F2aCP6rFjRc
         AnXg2HLD15oh6JfPU3Y3ALXdTDCwkz2vYsWHu2JfBAiB6aGtrOZFGo+LbrZ8UVAbJigK
         +icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=DC7T/1epSdwbqDWlhU77s7p6S8E3+rl5WhjQziUAp3Y=;
        b=TR35EhHz59mk7bozO3/S+bOlX0XEjpDP3iq1zHvpBPvcv1ZwpGkKwHIPiVVsRf9SRX
         xz/3Wj0ijnBRzICmmWMiPrshVplyZSCci0fiqJuZFxHShfc80591dJGW8tnNPk7gu/FW
         M2PhBSDrSd1vXNUF2ojQOFU/TGNmVmPoZPVWxMVQdGJDKYMqPU84XMROZMsl+gwiEwBK
         NOK4jIDJ2JVziiRCXGyRNy0QHskqYtElB9KMG0ZJgZpcX4wIpOII4jy0VZytunn8JJnK
         MgdKFiaeeNshJp9VsgwbNirq/N5i3bY7+9n6lvOS9zIfn4mGdYhne+uCeeeCns6ZG2nA
         rKRA==
X-Gm-Message-State: APjAAAVCjeG3idvZiVZqhdx8r9IKLGCCVc/XVK+Yhy8RvTK9AQjny11Y
        B7rDJEC1RWu9CrmZK2526maY8jJf
X-Google-Smtp-Source: APXvYqyP+V1ZurARnQp09iaSwvmVd8yk1r5uiFEKPm0Rcd48E+ZKhTidU8KQ1RokPwypizlrDtRFSw==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr33525329plp.168.1562042234468;
        Mon, 01 Jul 2019 21:37:14 -0700 (PDT)
Received: from voyager.au.ibm.com (bh02i525f01.au.ibm.com. [202.81.18.30])
        by smtp.gmail.com with ESMTPSA id 85sm16028873pfv.130.2019.07.01.21.37.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 21:37:13 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     Jeremy Kerr <jk@ozlabs.org>
Cc:     Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH] MAINTAINERS: Add FSI subsystem
Date:   Tue,  2 Jul 2019 14:07:05 +0930
Message-Id: <20190702043706.15069-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subsystem was merged some time ago but we did not have a maintainers
entry.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01a52fc964da..2a5df9c20ecb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6498,6 +6498,19 @@ F:	fs/crypto/
 F:	include/linux/fscrypt*.h
 F:	Documentation/filesystems/fscrypt.rst
 
+FSI SUBSYSTEM
+M:	Jeremy Kerr <jk@ozlabs.org>
+M:	Joel Stanley <joel@jms.id.au>
+R:	Alistar Popple <alistair@popple.id.au>
+R:	Eddie James <eajames@linux.ibm.com>
+L:	linux-fsi@lists.ozlabs.org
+T:	git git://git.kernel.org/pub/scm/joel/fsi.git
+Q:	http://patchwork.ozlabs.org/project/linux-fsi/list/
+S:	Supported
+F:	drivers/fsi/
+F:	include/linux/fsi*.h
+F:	include/trace/events/fsi*.h
+
 FSI-ATTACHED I2C DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-i2c@vger.kernel.org
-- 
2.20.1

