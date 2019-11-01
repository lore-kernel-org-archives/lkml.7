Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35EDCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B167B2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikqziVfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfKAUmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 16:42:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40945 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfKAUmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 16:42:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id q2so4942787ljg.7;
        Fri, 01 Nov 2019 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZGSw0Pf1yR7L0D2XUywPAXmKwfJWwLsrgldLsCFIOFg=;
        b=ikqziVfgGr73GAy1cRnOZrkrHml/aNL1IkBEoAFKaKqFBgzoosvRYbOKj/h2wPjDZ4
         /Uh62d2CtaE+6aLHFYv9eJ3fgMwIDzViNazwXGHJ0IfNQ3+tcn5csPR1u8hU0JGjV3f2
         R5lus91udvDRirSnmLkNl6B9H2GVfshZuPWFEYspsSiI7JWCuLSRbHIQfork2RYavLtA
         ArNQFvTmBYmOeBDQH9ylAsmE1z5A6Wcu2TyfXtW8Gee1xCyx2pjLC4fttuIxyATyiPNK
         yHj1+ObGAXtYhJj1RN9fNoy7ISvmB5vrRVXl/pHHv62yY0n8K9xcaiPb71RAqbNcwfFe
         3ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZGSw0Pf1yR7L0D2XUywPAXmKwfJWwLsrgldLsCFIOFg=;
        b=CHgZ1dJz/O+a5f/BeVz02JzTUA6mmUk51xvLcHSED9Lgx3MPBblk6DWporOPtCCiM1
         /8wbVDmbEPZjYl4jgWtPHrBflYIwgPWGnGM+r/wEbBLebsIepICigKq3teggKtclm3hi
         eG4U94mxfBFpWeEW6BajelZ7yRo9MWF1DnVXOCDYK5QWGsqE9F4vIcmtWl5FDUA9YqJO
         9r+TVTEIbWFNitcbLM1syUpJGYhKq2YelOiHjyDs6ZAeMA0xpE1BQshz9NYvIaCfUFED
         3QM4dzwNwWejMO7dv2s5ghnPthKkQiGkVe0J2qrvRzyZvCswIaInprkaRIGj7m/AXfVD
         v8yg==
X-Gm-Message-State: APjAAAXG0sPYV5nfKzoXJR6ipkZLu79hCBV3Klab2d9VpWKR7jbs1v7Y
        Nybn/6LOHkV32ryD/pXGv1U=
X-Google-Smtp-Source: APXvYqxYE3IyIX8b2BVVt44CkmPEeeQhwtVdacK9SIq4c59o5QNNJVjRK0M+MlQmVg8WgBbtlV6xTQ==
X-Received: by 2002:a05:651c:313:: with SMTP id a19mr9543563ljp.199.1572640969006;
        Fri, 01 Nov 2019 13:42:49 -0700 (PDT)
Received: from debian-tom.home (2-111-15-75-dynamic.dk.customer.tdc.net. [2.111.15.75])
        by smtp.gmail.com with ESMTPSA id 190sm3766098ljj.72.2019.11.01.13.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 13:42:48 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+a0d209a4676664613e76@syzkaller.appspotmail.com
Subject: [PATCH] Fix invalid-free in bcsp_close()
Date:   Fri,  1 Nov 2019 21:42:44 +0100
Message-Id: <20191101204244.14509-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <000000000000109f9605964acf6c@google.com>
References: <000000000000109f9605964acf6c@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported an invalid-free that I introduced fixing a memleak.

bcsp_recv() also frees bcsp->rx_skb but never nullifies its value.
Nullify bcsp->rx_skb every time it is freed.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+a0d209a4676664613e76@syzkaller.appspotmail.com
---
 drivers/bluetooth/hci_bcsp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index fe2e307009f4..cf4a56095817 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -591,6 +591,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 			if (*ptr == 0xc0) {
 				BT_ERR("Short BCSP packet");
 				kfree_skb(bcsp->rx_skb);
+				bcsp->rx_skb = NULL;
 				bcsp->rx_state = BCSP_W4_PKT_START;
 				bcsp->rx_count = 0;
 			} else
@@ -606,6 +607,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 			    bcsp->rx_skb->data[2])) != bcsp->rx_skb->data[3]) {
 				BT_ERR("Error in BCSP hdr checksum");
 				kfree_skb(bcsp->rx_skb);
+				bcsp->rx_skb = NULL;
 				bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
 				bcsp->rx_count = 0;
 				continue;
@@ -630,6 +632,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 				       bscp_get_crc(bcsp));
 
 				kfree_skb(bcsp->rx_skb);
+				bcsp->rx_skb = NULL;
 				bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
 				bcsp->rx_count = 0;
 				continue;
-- 
2.20.1

