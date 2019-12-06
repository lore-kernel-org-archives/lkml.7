Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4909EC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180F824673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyPQPMqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfLFVjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 16:39:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41352 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfLFVi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:38:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id s18so3995406pfd.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 13:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7tnHP49bcbdj6wbVlgmEh/i8N9jDvFKi9kaAZwgRO58=;
        b=TyPQPMqMEZSbzOq4YJ/CvyzohiFL0nmwcH8xHd7uNVwqdGTgbtf0zTU4yDZK1m7Vyx
         hlYdg2gEo6eO6NHj76PC38ouj8DYqG4UVvy/IzsnpWtq4/6d27V38a3kSPzQTyRtkR8Y
         2M6qvvr0p5NKM43hOouFg3JyFqzJj8i+zZ4l9OaZ89xWFzoA01K5obewearyD4XEXHvc
         zOIIvRBWygSG4Kst7lrgh+0haf87ZCGEIH/a8AKlLmbyJASFzCV/3fynQziQjZUvx72H
         TVDQRhfWyvqzoj/HeARTIzz7Qk776PoUSWj/v2R7ml8Voe5PoswscOetD8p5kipOy5gv
         t7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7tnHP49bcbdj6wbVlgmEh/i8N9jDvFKi9kaAZwgRO58=;
        b=dW21asuq0H4sn0eMqynwK47tk2PTqo9lRnteo5iDOX4ZPrw7vsySnWsHa7DH7E8iwC
         LATWDfNnNazLoTKrTC+EDpJGF/W9inl4vWqQsF9km22nkWHWVI0ZkJ/BBE5A59KSRTnw
         070EcDlrMlSUJtlu2qPrf5eBZMYerrMhkXjcGh5p8/3idAihUXxOVwGJoZwsI4Ujs3Vf
         C+TKa0KVhgNyn2Q0UFVvYphRk9RYEFxK1ZaFHYbfeXyKR4OVkynTJdkyIYtMG0B+N9T/
         fcjjuvi2/f3iDSo6UfZ2vh757LEfCqI4Nh3cdRsBbtiN6+MH6P+21QOqfUt/2+fUVx32
         8VmA==
X-Gm-Message-State: APjAAAXPn+g3IFHN548UblntFxJThr9e9gsuEhhoVmUulCTOVc88LOFC
        sHZe7HT4Ofb+EiwxnwiyWsk=
X-Google-Smtp-Source: APXvYqy2mcWYMGqjSshbYvqQi62LTZgqbF8ADTCo4gLwYPawIPjikZb3TSZDYbkVlgy2vV0XN6ksiQ==
X-Received: by 2002:a63:5056:: with SMTP id q22mr5820145pgl.20.1575668337654;
        Fri, 06 Dec 2019 13:38:57 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id d65sm17368579pfa.159.2019.12.06.13.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 13:38:57 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        Cong Wang <xiyou.wangcong@gmail.com>,
        John Garry <john.garry@huawei.com>
Subject: [Patch v3 2/3] iommu: optimize iova_magazine_free_pfns()
Date:   Fri,  6 Dec 2019 13:38:02 -0800
Message-Id: <20191206213803.12580-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191206213803.12580-1-xiyou.wangcong@gmail.com>
References: <20191206213803.12580-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the magazine is empty, iova_magazine_free_pfns() should
be a nop, however it misses the case of mag->size==0. So we
should just call iova_magazine_empty().

This should reduce the contention on iovad->iova_rbtree_lock
a little bit, not much at all.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/iommu/iova.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index cb473ddce4cf..184d4c0e20b5 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -797,13 +797,23 @@ static void iova_magazine_free(struct iova_magazine *mag)
 	kfree(mag);
 }
 
+static bool iova_magazine_full(struct iova_magazine *mag)
+{
+	return (mag && mag->size == IOVA_MAG_SIZE);
+}
+
+static bool iova_magazine_empty(struct iova_magazine *mag)
+{
+	return (!mag || mag->size == 0);
+}
+
 static void
 iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 {
 	unsigned long flags;
 	int i;
 
-	if (!mag)
+	if (iova_magazine_empty(mag))
 		return;
 
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
@@ -820,16 +830,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 	mag->size = 0;
 }
 
-static bool iova_magazine_full(struct iova_magazine *mag)
-{
-	return (mag && mag->size == IOVA_MAG_SIZE);
-}
-
-static bool iova_magazine_empty(struct iova_magazine *mag)
-{
-	return (!mag || mag->size == 0);
-}
-
 static unsigned long iova_magazine_pop(struct iova_magazine *mag,
 				       unsigned long limit_pfn)
 {
-- 
2.21.0

