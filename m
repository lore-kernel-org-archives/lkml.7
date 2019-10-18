Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F291CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A6220872
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG+DDVPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392972AbfJRW3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:29:50 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38826 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfJRW3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:29:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id e11so6279144otl.5;
        Fri, 18 Oct 2019 15:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYjp0Wpg6EG197+ZFDkyqIAQeoiHNqMZ3URZHgzwFVk=;
        b=CG+DDVPEaOnFGfnX2ISfmL4mZqbzmEAIbGWfbjxRDSLmPn6aIYcFS4gTZVXm9Bj8ej
         YLVGNj0lRCT1EXe7sRHLW5UA2jIi7j7FNKz1y6joV8CnrEp4V9jrmIIMbqFuMXviV4K8
         bowTCm/uuDEqVWieqWY/M0KNygZXEIOevq3qLdPILARttNQekgxdMyTC6KjipZpad35Y
         8Qcg0DPWbum/kFeLmko9f/uSHaHrDDfp2fZWnB34r/fz7Q2c1rKZ9s1VYf0Bt/guFKp8
         9ObVAM20hKcDZG+FlOcDCz3FbMoJc9NFyuUGaCushW6golxrlPVqduTiTZdLtUwnqpwJ
         KQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYjp0Wpg6EG197+ZFDkyqIAQeoiHNqMZ3URZHgzwFVk=;
        b=aiZdu5k8cCzxHvJqWs3vN5Cb5xBhFxJOl4sQBdHyLSJR3Y8hB+R/dEm+j8zDZ5g/yq
         gxfCtBHIUdd5d2X7razi2zhLFMxW4bGcfxmwp+rmu/ul0FCTBQIIpeACXRHE5M4hoxjU
         cYecwNBKfRFkxEtn8I1RO5oyZA3hukhGIXZnvJrR75ucXHVLgH7r4Wghb1ltbmEyjpP+
         VGSfXfNjOWEO+NObSq3DmgKVAwd6Mjj5BqHNfXedjuD5oY9vQq1H+9sE2iUG720es7wM
         awgcMS5ZiUhHqbzBdUIFsvIeOgzBP+yXq0T0NdhDg/xdGVEOZoPBbKbTPCa/2somg08O
         LICg==
X-Gm-Message-State: APjAAAUlLuNb6E3+9+tly3ELnSUzv53dZfpG7p35io2ENX0Au7W2J5nx
        EFkRcQ0H6JKu/qCIilisjhk=
X-Google-Smtp-Source: APXvYqwqQOprKFp6KyDaZ0PVvUETxuW3CphHo+XWTDhUp53PiifgIminlDOngOXLSRhP6Xt3LFcmYw==
X-Received: by 2002:a9d:ba6:: with SMTP id 35mr1229290oth.143.1571437789127;
        Fri, 18 Oct 2019 15:29:49 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id q18sm1871422otk.57.2019.10.18.15.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:29:48 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Amit K Bag <amit.k.bag@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH -next] Bluetooth: btusb: Remove return statement in btintel_reset_to_bootloader
Date:   Fri, 18 Oct 2019 15:29:24 -0700
Message-Id: <20191018222924.49256-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018111343.5a34ee33@canb.auug.org.au>
References: <20191018111343.5a34ee33@canb.auug.org.au>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang and CONFIG_BT_INTEL unset, the following error
occurs:

In file included from drivers/bluetooth/hci_ldisc.c:34:
drivers/bluetooth/btintel.h:188:2: error: void function
'btintel_reset_to_bootloader' should not return a value [-Wreturn-type]
        return -EOPNOTSUPP;
        ^      ~~~~~~~~~~~
1 error generated.

Remove the unneeded return statement to fix this.

Fixes: b9a2562f4918 ("Bluetooth: btusb: Trigger Intel FW download error recovery")
Link: https://github.com/ClangBuiltLinux/linux/issues/743
Reported-by: <ci_notify@linaro.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/bluetooth/btintel.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index d2311156f778..a69ea8a87b9b 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -185,6 +185,5 @@ static inline int btintel_download_firmware(struct hci_dev *dev,
 
 static inline void btintel_reset_to_bootloader(struct hci_dev *hdev)
 {
-	return -EOPNOTSUPP;
 }
 #endif
-- 
2.23.0

