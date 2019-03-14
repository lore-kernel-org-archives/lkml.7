Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7033AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2762085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Pwr+knt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfCNL7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:59:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34687 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCNL7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:59:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id a16so4383260edn.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YK4KAdlUPdR/CpVcF8N7JN3GvsgIXwp3MNpNK0t6Zn8=;
        b=Pwr+knt1ifF+/E2LNBzRWHVL/MsPvZCHXTe8t8jCb20+fM+JU2oKg9r7wNKlRDT8C7
         Olar78K7g8PaljcSdDWcwzWip797V2PPCwo2vEIRaOhCctYpWCMy99LKzSRgJMtI3LZL
         vUT0yXDmFZ5Q1fDNbiwWbkcHybTZtD2p7ZVV/AaDLQVBhvjkMTvUAGm9hWFOblljSVNU
         j2vERcRAWkn30AAm6Q+wpmbEsAuDrD7ntOMifwzHK/YXMMqoBJtc2xrxEeZ7E3H/nYtE
         J3g0vPEEUAj+nzeBCJ+9vqWjd/HB3KBu6iwq0tMzQlFQzIWJ/0HTxhzXejqxbuIBMd4b
         NylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YK4KAdlUPdR/CpVcF8N7JN3GvsgIXwp3MNpNK0t6Zn8=;
        b=Rq4zzDHpGMQQjbXJerO4OAxozJd/uHwmm3qUpNggIJ3ZwiVsni6O0gwcm8Qh8W1snh
         bkv7RV5vYXcY97HUjn0/7XhjRMpBX9I2UtX0F+qWzZYL7WhXZX41fwLAZXf86F9J5Lts
         K8ePkb/Hsu68pbWxRBCWBqZN2Xa3oki9NEbM/pLbcbMAC5EOYRK86SzwvAIek53UWPm3
         0dCSSPQ5NHtd7826QzxJhIDXZ5WW9ZdM1SeQVo+s9ErkRf0qjQ3PIB10IEKSoomrhvTy
         0V1cgilUMVMxcYozq/pI3OeF0XA9cxc3Ov3EU6udOdF4woWdcuglkkW7ofMXnSkRYhAS
         XYDQ==
X-Gm-Message-State: APjAAAVsFrbWtqePp6kAL9CGY1NRJ2cFTlw5qWUTTsF/7+kOUVzP7lNU
        Vkokf0BrHIXmaKSHSYcZCiXGFfbE26Y=
X-Google-Smtp-Source: APXvYqyZSEr6IYlfJghWaupj5rmZpq+gjQ0383orp1ogS1uQfa1Uy3A+aWplB9ekiizov5sS+UOJiw==
X-Received: by 2002:a17:906:69c8:: with SMTP id g8mr32488982ejs.75.1552564792201;
        Thu, 14 Mar 2019 04:59:52 -0700 (PDT)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w6sm1360862eds.0.2019.03.14.04.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:59:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v2 4/7] iommu/vt-d: Ignore domain parameter in attach_device
 if  device requires identity map
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Date:   Thu, 14 Mar 2019 11:58:43 +0000
Cc:     Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8A19A7A-91CB-4297-9445-47DB248B7817@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
To:     iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device requires an identity map then it is not safe to attach a
domain that can remap addresses. Warn the user if this occurs.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/intel-iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2e00e8708f06..104d36f225a7 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5101,6 +5101,11 @@ static int intel_iommu_attach_device(struct =
iommu_domain *domain,
 		}
 	}
=20
+	if (iommu_no_mapping(dev)) {
+		dmar_domain =3D si_domain;
+		dev_warn(dev, "VT-d: Device is required to use identity =
IOMMU mapping, ignoring domain attached\n");
+	}
+
 	iommu =3D device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return -ENODEV;
--=20
2.17.1

