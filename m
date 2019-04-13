Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA792C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 05:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CAC20850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 05:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sm1YrjiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfDMFzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 01:55:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42022 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfDMFzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 01:55:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so14562771wrx.9;
        Fri, 12 Apr 2019 22:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7kPnzm2JkTCyO+F1wvn6GNnMXZwa00o8M2W4gddE+0M=;
        b=Sm1YrjiDIYiaw+NB3hDgfJYPnuqkVpwpzJRPenxUL+IzhJdwVpHpsBXFWBgq+rC3Ou
         qyiQPVhc9Gt0KIOM54Gz6n6i8/oY9DmWLcEnu8o28F2D2w101Pxf5V1v1zQnF91yy7Lj
         G0aThmNwbaVWnGZGBrY+TMFbio+zGFqRqBHjnWS86+LEace7NY22jr8Leb0/4KlOylz8
         BVscnMKMnpzAkByPqjiTmj+MmyKVa9miWbsgvBIOcg3JHM4ZCrbVjXNynrcqR45JMWXP
         k87mRS0cfsFQXrRbkCEHUZvCmz2PHxmRzvMQnx/X7iykl9N1r38CdJ7bCSdADG+onDfo
         XKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7kPnzm2JkTCyO+F1wvn6GNnMXZwa00o8M2W4gddE+0M=;
        b=sYk5LPiq8W5P/Of8XlrqfAHtqAteK1oeckCNIwh1q9JljDHSHWyXO20YzV/3sTAgSF
         okTH2qx6Hc36c50yjaDT4B/2i4O1/qoSYSP/ffMcMtGyudqYkcpdxI8+3QnnRPOkH15N
         HTYd0lBfGbfyy0YcJaBr+U0M9psBfnWXPBpNNaG1zjM64mS/HbOoVK9q3wMSTo0X3mW5
         tkCeorGLEFO5gFQ85pB9Rx99zBEY1/q7HePkRVfDDFpqN35x5auuCUca2PbGbHNGq2Gi
         Mljr/AtZu4oZLz8xeSoqI4JZWb015uRTERVaDGewHAAqgiFckQHDT/cEQUKVxNS5GNaz
         ufaw==
X-Gm-Message-State: APjAAAV5GDExGJ6uCiJQFFQJwxmdhINZlxkpQ5welWQYYYrmWdlOkrdo
        z0/ajrlnid+PXzKRupBpMQI=
X-Google-Smtp-Source: APXvYqwIzidec8wTcXaGYZC/WqlNcMl/5D/NJcVt+xRiyV/gWicnEEzoCX7WBjsuliRyfZBcIDjfmw==
X-Received: by 2002:adf:ef8e:: with SMTP id d14mr36156780wro.81.1555134904011;
        Fri, 12 Apr 2019 22:55:04 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2def:500:2ca3:f513:3ec4:694])
        by smtp.gmail.com with ESMTPSA id n13sm47649062wrw.67.2019.04.12.22.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 22:55:02 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] MAINTAINERS: fix style in KEYS-TRUSTED entry
Date:   Sat, 13 Apr 2019 07:54:48 +0200
Message-Id: <20190413055448.5434-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
further maintainer to the KEYS-TRUSTED section entry.

In fact, ./scripts/checkpatch.pl -f MAINTAINERS complains:

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #8581: FILE: MAINTAINERS:8581:
  +M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

The issue was detected when writing a script that parses MAINTAINERS.

Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for trusted keys")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
v1: https://lore.kernel.org/patchwork/patch/1040412/
  - Joe Perches clarified that this is a style defect. 

v2: applies cleanly to v5.1-rc4 and next-20190412

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2359e12e4c41..75bb276aed1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8578,7 +8578,7 @@ F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.ibm.com>
-M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
 M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
-- 
2.17.1

