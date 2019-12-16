Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF1CC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F11B2166E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYemngY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfLPPkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:40:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35125 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfLPPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:40:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so7836427wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 07:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMcR8IvhqwKdqvk3MOsa4sjnCibF6aBm6/rKYId8yOU=;
        b=aYemngY8sm3R+2gECU80Pbl0HOOlN6o06z/NUXwrdu0PyIkLRmYO+UOoyiah7BBfE2
         fEfUdpJMcVhsPLGDiIX95S+Gd4837h9qPLAsR0UJUvwRkoCBm9KlMJLYNlexqBRTmgFv
         1rDtuv1aVdu24JT2Qje03YAiu93Ls0llB1Am0O3Rw1CwuTlGY+6l/vMEPOf7lJj/omHS
         77q58xghbmWK0T/pZiCvvltNmeLpFcMkZj8/hLSHr3s0AUI0pwpFcUR3VL0KTFrMIabX
         gtjTJk3iQ38HjQvUZkr9pEk2eGyIeYoS69J/HBXPnRoqlirIIuhj+dPaeo93KyCbvT6c
         DPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMcR8IvhqwKdqvk3MOsa4sjnCibF6aBm6/rKYId8yOU=;
        b=PBfwkq/A/AE72VjCPF2bLZ+MHJOK4JvB7yZ+FQ6eaBH+JSviS64yk/5rpjwKPccr00
         pL8/Y/aubo6l+m0YcOvoUPBA1FWNPwNM/VFlW46Kc8xIcgqDHHo41ydRTAAdLMTOoLRa
         wseYliLwllq7YLcEOcvjijnBMKvRD2VVmqIle+UaZ0lYayvSBQKrEyQilvEauTSczkwB
         hfE+Y4bHc5WVdaef5Zp8HQmM2rO17bkkNsY8eVw4Jug5is1qeXQKR/nHtQNjZ9Bv8F/z
         IAxOoMbDehBNWNIbBgLTMugfEkcS2zxZZfOCKo+hirXpP3u5xyBmGx/IPUcwPAbV/UHj
         rzbw==
X-Gm-Message-State: APjAAAXP3DYZfMAaTfbdk3yOduk1ZLwGLlXwUfBeLQtUeGqewOnrZGU5
        Ki/K2ZazvWrtT8hHpohydQ==
X-Google-Smtp-Source: APXvYqz1HW3jI0abUFjkNtrzG17hAYe+n0BOF4YTLhBJSmgVD71P1zeLJz+yC1ay/UhACnzoEMSHZw==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr29913158wro.209.1576510803796;
        Mon, 16 Dec 2019 07:40:03 -0800 (PST)
Received: from ninjahub.lan (host-92-15-174-53.as43234.net. [92.15.174.53])
        by smtp.googlemail.com with ESMTPSA id u24sm14504514wml.10.2019.12.16.07.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 07:40:03 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] kernel: locking: add releases(lock) annotation
Date:   Mon, 16 Dec 2019 15:39:52 +0000
Message-Id: <20191216153952.37038-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add releases(lock) annotation to remove issue detected by sparse tool.
warning: context imbalance in xxxxxxx() - unexpected unlock

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/locking/spinlock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 0ff08380f531..bb088fcf2be5 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -187,6 +187,7 @@ EXPORT_SYMBOL(_raw_spin_unlock);
 
 #ifndef CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE
 void __lockfunc _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
+	__releases(lock)
 {
 	__raw_spin_unlock_irqrestore(lock, flags);
 }
@@ -203,6 +204,7 @@ EXPORT_SYMBOL(_raw_spin_unlock_irq);
 
 #ifndef CONFIG_INLINE_SPIN_UNLOCK_BH
 void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)
+	__releases(lock)
 {
 	__raw_spin_unlock_bh(lock);
 }
@@ -275,6 +277,7 @@ EXPORT_SYMBOL(_raw_read_unlock_irq);
 
 #ifndef CONFIG_INLINE_READ_UNLOCK_BH
 void __lockfunc _raw_read_unlock_bh(rwlock_t *lock)
+	__releases(lock)
 {
 	__raw_read_unlock_bh(lock);
 }
@@ -331,6 +334,7 @@ EXPORT_SYMBOL(_raw_write_unlock);
 
 #ifndef CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE
 void __lockfunc _raw_write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+	__releases(lock)
 {
 	__raw_write_unlock_irqrestore(lock, flags);
 }
@@ -347,6 +351,7 @@ EXPORT_SYMBOL(_raw_write_unlock_irq);
 
 #ifndef CONFIG_INLINE_WRITE_UNLOCK_BH
 void __lockfunc _raw_write_unlock_bh(rwlock_t *lock)
+	__releases(lock)
 {
 	__raw_write_unlock_bh(lock);
 }
-- 
2.23.0

