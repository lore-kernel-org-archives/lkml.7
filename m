Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0A9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728F7206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ogttafCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfCDPqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:46:09 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34772 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfCDPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:46:07 -0500
Received: by mail-ed1-f68.google.com with SMTP id a16so4636837edn.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 07:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ftb4UF2DFtp5DpCzuPVl1UGyRR8z7f9ihjw4aJH6NKM=;
        b=ogttafCu4B+1DyiO3tKK7ZqZKWS6sk+/RwRfxqp90RIPEP/ZcU5JlpgVWGOLY4PvW7
         DvtGaZ1DcWvUzPjFfqrKzfVOvxr84zrCh2RqFwJXiXDjtrS1NtRBV1LP4FnbNEj4OYRK
         GypebpVjfCJYRVB4SZm1e8Mvz9ItevnZHlRhzQZXamc5YRvskrrgi2+eCTqT/dQudRv+
         ZMeWI3Zzixvw5IzbhL19KgkvROS0NByrbOvQj+B0FUwxF2zlT/XojZmIJh/l2kIMa4X2
         6xJZsN8tyJrM5h7C6YuO81KClB1KdYrED9BxnsS60YTncqLUG6oElU+jyYgw2UKDKrUn
         +u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ftb4UF2DFtp5DpCzuPVl1UGyRR8z7f9ihjw4aJH6NKM=;
        b=VSUupdwogx9iJ4GpSfY8UOLKs7FYi3HprXZ5a4yZRI3oMpfC0wdpu/GiFoM7s+qWwt
         H5erWe8EGAvGd0ImyFCIBwb+oOozSqZuhCz8tAW7UMO3OMsAegnlcvRykt9q9MkFn/uw
         0vnn/9WBBCCYF+5GkfECNmIS7uUgNN3IcyMzWU5OmOSrZVSA7pl3UYWz2468Yck255xh
         xu6V7CHsYuGNVfdtmcdTBoKCtAFFnmjoDP8BgZiCrXhBqjLHJEdj20kysGbKmckjQPqk
         kUYAa6VeKPGTWoRzVWmsCdK/pII66/jvW7ZV7x7VuUEOlBwysvFziCadn//lbcdTFHoO
         HLxQ==
X-Gm-Message-State: APjAAAU2XeNiMMg6Zbu1YA2fFcj7HnWq1ZlXTiamDSDI9Os3vN84bb82
        nZit9AT8JuDu3wmokJ1XdMGGcUw6+20=
X-Google-Smtp-Source: APXvYqyHU/6Zo5Wk7+8YyEhAhste/ggkRVY+rq2OVdQNUFsybyJdneON17gH2Mkx/sw4x9v/KWPZ2Q==
X-Received: by 2002:a17:906:a296:: with SMTP id i22mr13270623ejz.62.1551714365933;
        Mon, 04 Mar 2019 07:46:05 -0800 (PST)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n25sm2183785edd.83.2019.03.04.07.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:46:05 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH 1/4] iommu: Move iommu_group_create_direct_mappings to after
 device_attach
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
Date:   Mon, 4 Mar 2019 15:45:07 +0000
Cc:     Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <17CE1B8C-9E81-4954-8D23-5B2F20A3104F@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
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



