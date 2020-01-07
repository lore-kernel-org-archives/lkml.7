Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894B2C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529BF206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI1RkU0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgAGWHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:07:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45147 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgAGWHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:07:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so1215938wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 14:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=p+D7flg+dO8+adOesNJVsnD1CEu5UMtEMphYCC1lUTM=;
        b=TI1RkU0qph4uUUxkuE1XcvovjBgB4Tu04BPVoYtAqNhsn3KNBQvDwB9QIRnwc//Spu
         D9CFm+82W98868LTob7bdpUrEkd70AuDqE8/FIUbJr2hUEK1sxzJS1xL9hNwokUqDFE6
         ErbXXul1dyBK/l543De5c1NSFCdxdHQejbdRkQ+RqvESIl1jbGxwlu17JN4sas94SmEe
         SUbfOIwSk04+CDdY6zyU5dmeQx4dvjuJmqWfz9Dvqkc1F78OZrRitrUvNcf5dBJCclgw
         sI3q4O0Xk1nN09Z6nUiJhOhvOjrm6dasGKTn0RL4Zwso/DL2/q8wKq22L9547Dt0FYe1
         3V4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p+D7flg+dO8+adOesNJVsnD1CEu5UMtEMphYCC1lUTM=;
        b=J5UwTUzrnJbWvc5xNerQVSxyQcj3MrSd6KHUPUlTkiDgxnMLVEFt4SsRuQ2u4ODqZt
         llF+/NIDvd30/emj0tbAZ4/xHmDIMGQeDPHoI+npHaN/E+0WdnifjOqbT3b1qI00dSG+
         wj0wnfMalvMotWGvNqJrC+CRoVAsrWVEcSJNWHAkNchVeVJyST5JozyLB7A4kS750+lL
         e2J7o9nbdvddDsIruI0eVfMm8JvpfTsfth/PWQiIhTpZITPqOahLIuegH4thGTC3ujNM
         veS6NfXoy/sHNzf41jFFdd0DN5geKmNwleWF5KbLd2mgEVnqlLZdfosQf9bApCuXr37G
         kxoQ==
X-Gm-Message-State: APjAAAUgDeKtcyprQjconSoo6b+JdYsTw6SpBjDvi8b2MJKW3IJkVm9x
        PCmOre6Sq2qpvqXLNJsKG5JC7lavSiI=
X-Google-Smtp-Source: APXvYqx6/fkpnq/EoBTM9LVGPuI23pFQGq9ctGh/ISywZH8CPo3D1/Tx3myOGdTjV6E+pCB19RIXSg==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr1146474wrp.167.1578434840557;
        Tue, 07 Jan 2020 14:07:20 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id e12sm1632482wrn.56.2020.01.07.14.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 14:07:19 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: removing extra ;
Date:   Wed,  8 Jan 2020 00:07:17 +0200
Message-Id: <20200107220717.31447-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an extra ; after the end of a function, which needs to be removed

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index b680b0caa69b..aef4de36b7aa 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -36,7 +36,7 @@ enum hl_device_status hl_device_status(struct hl_device *hdev)
 		status = HL_DEVICE_STATUS_OPERATIONAL;
 
 	return status;
-};
+}
 
 static void hpriv_release(struct kref *ref)
 {
-- 
2.17.1

