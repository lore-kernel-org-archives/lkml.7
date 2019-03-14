Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878E5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A5021852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Tm3BZQvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfCNL6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:58:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36457 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCNL6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:58:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id e4so4382545edi.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ftb4UF2DFtp5DpCzuPVl1UGyRR8z7f9ihjw4aJH6NKM=;
        b=Tm3BZQvlWU5ffy8ayz1uU2s+czblWbIqFg5bBQ1RSypRg4QV4rHqbLoRvzzMp0MOvi
         mcipADBDU+JbA6SAIfhezY4TnxMPVcuo5cMxvz+rEV8LRTxuj+R4/IS1sTjILiVA3s2B
         XCvaZ2PZ9GOjscyCUHN3sDM/RxhKB6MxfF1Qbi5NCueJUHtNNhpccbv1wdbhf5TxtPYj
         ESoeU5sBzofzL/tYbb2ztgrlpiIYX2a3OFfxPHt/sBXq/p36XSLNbGj3Pr+y7Dy/GSyT
         8Pg/N6GLq/bvvV+oF+UYSqrrix8bVBZN+XcaDZaa4ZTQntIVGv4Lm03blXplUHysqs/U
         1gJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ftb4UF2DFtp5DpCzuPVl1UGyRR8z7f9ihjw4aJH6NKM=;
        b=Vwksib6QmUOXwkWyOdypKdZRrG1KYSmE0NoUTY2PB0b1HqdDPIWoomyTYH5FUMydb+
         kf1yAQhxMLrGkoNYQ5sR1WhSVY0DAHDYnETM6bEMqCHzK24W4iTYSl8/c1BQIE5VpMwe
         zg5bmgVPaKJKcP3ByH783evWIjkybrzXk5u1doWqvH+jdb67wOAEBMbMHyeX4Ner7Gwk
         NKNhim83smgJ0pCNkaCN3ovdBs+1TsQZt9Im05y6Ocr2AjWNG0WPLrN04y9WV7hsfFDF
         17gvvD+4bIJdbvZsz0AiSIXRnyaYNqlodjmmpS8BbqS5B9rHz5sBD8/X0lCY6E9tedo7
         AFwA==
X-Gm-Message-State: APjAAAUKLsAGni5rSxlnboBkRYxiyFeok4bKjs4nEvTsZbqAwytViuOn
        yxaCjdqCEfFpNOBrFAhZTArYgg==
X-Google-Smtp-Source: APXvYqx3ofxp15pHDj0Ee8AJTi1tpTQ2T3twKXlOa4TWTxt48Nrd3qXdlNW6qX3GhLiSSDS4Q+tKxA==
X-Received: by 2002:a17:906:69c8:: with SMTP id g8mr32486028ejs.75.1552564724494;
        Thu, 14 Mar 2019 04:58:44 -0700 (PDT)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w6sm1360862eds.0.2019.03.14.04.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:58:43 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v2 1/7] iommu: Move iommu_group_create_direct_mappings to
 after device_attach
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Date:   Thu, 14 Mar 2019 11:57:36 +0000
Cc:     Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <864DF17D-7D9D-445B-B3FC-5AA308C0B179@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
To:     iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an IOMMU driver requires to know which IOMMU a domain is associated
to initialise a domain then it will do so in device_attach, before which
it is not safe to call iommu_ops.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3ed4db334341..1c6ffbb2d20e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -652,8 +652,6 @@ int iommu_group_add_device(struct iommu_group =
*group, struct device *dev)
=20
 	dev->iommu_group =3D group;
=20
-	iommu_group_create_direct_mappings(group, dev);
-
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
 	if (group->domain)
@@ -662,6 +660,8 @@ int iommu_group_add_device(struct iommu_group =
*group, struct device *dev)
 	if (ret)
 		goto err_put_group;
=20
+	iommu_group_create_direct_mappings(group, dev);
+
 	/* Notify any listeners about change to group. */
 	blocking_notifier_call_chain(&group->notifier,
 				     IOMMU_GROUP_NOTIFY_ADD_DEVICE, =
dev);
--=20
2.17.1

