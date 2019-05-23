Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6376C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01DE21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+4H2kGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbfEWSfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:35:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44967 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbfEWSfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:35:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so3559175pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 11:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UGdXyM1CME4KwYx3fgLzBPCxywcWE4oo6EgOOlK8Fv4=;
        b=k+4H2kGkwk5LvYzjyAAzDQV621YQlhBCwYT7yzcPAaSpAEtVqW+TY+zhTG0yvSkrWj
         GQ6z3IUyCmpIffYXzTHyJq69fwRULEX54aMbMK8faxxk0RX1LWtkIXRgTxhkqQC7u7tH
         tz+W5oBXaKlZkhj8p/DOp4G833AnDwbzOKzqnKuiQ7Z82brOcHR6P+bX2ODxOYgpVCqh
         eivtfvor7iBVK83n3zl6enzJmyP5Q4SFoHjprVqRATAADIilXxgW2Rn50ZCAQV4BbSjk
         ACiKS4kvcD/YhpAqkTWULi+QhSJeu8ODFTdFMrk2QloGc6ebfTZQ9awBYhGHX44Af+dt
         NI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UGdXyM1CME4KwYx3fgLzBPCxywcWE4oo6EgOOlK8Fv4=;
        b=I+vwedaQJTIKKTYXIpkK2xf5w/sLgp5KSvT3wVEHxATR0he337QipxmLVJmm8oQRZa
         PxAh0hzjMaQKk+GYydKIE9XbowyN/xMMAnAhfrjXyvUpniBWbM3kgLgGZ6Sk0TCQ42vH
         fsCnP5psLiu9kXAelfScO1nhPdgBt9fNw/c7noi1YzKn6D3+HAZhjeKVGlxTR+97cbyC
         azd8JhwiGfw6PO2JMEa4rrJUkMO3zs9IU6i6vMxNhdqEFF9zkXJfZXHjd8d9QFgRsuqf
         0dJJJusdrS3oN9VyXsydHS8qpsWrNWVPrmtSWsi6lU2O7Um58QZ8zz6j/vV9ubY3SriT
         vUGg==
X-Gm-Message-State: APjAAAW7RXQedE4nj1wXEYQAm6Ds3Hxb7WsBG1d+UjVYnGGFfplR2k4C
        qntmDZwuS5fFIyCqey2+kGU=
X-Google-Smtp-Source: APXvYqyAGgM62zL/Uh7TSDVYGilK6ktbyrCOFvLMxfqhvED4rFqQqXGVfzjK0DQt2Kn6xYezxdLwMQ==
X-Received: by 2002:a65:42c3:: with SMTP id l3mr75585700pgp.372.1558636517476;
        Thu, 23 May 2019 11:35:17 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id o7sm123715pfp.168.2019.05.23.11.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 11:35:16 -0700 (PDT)
Date:   Fri, 24 May 2019 00:05:10 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     reg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        NeilBrown <neil@brown.name>,
        Peter Vernia <peter.vernia@gmail.com>,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-pci: pci-mt7621: Remove unneeded variable err
Message-ID: <20190523183510.GA12942@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_request_pci_bus_resources function will return -EBUSY/-ENOMEM
in fail case and returns 0 on success.

So no need to store return value in err variable.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 03d919a..bc2a3d1 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -596,17 +596,12 @@ static int mt7621_pcie_request_resources(struct mt7621_pcie *pcie,
 					 struct list_head *res)
 {
 	struct device *dev = pcie->dev;
-	int err;
 
 	pci_add_resource_offset(res, &pcie->io, pcie->offset.io);
 	pci_add_resource_offset(res, &pcie->mem, pcie->offset.mem);
 	pci_add_resource(res, &pcie->busn);
 
-	err = devm_request_pci_bus_resources(dev, res);
-	if (err < 0)
-		return err;
-
-	return 0;
+	return devm_request_pci_bus_resources(dev, res);
 }
 
 static int mt7621_pcie_register_host(struct pci_host_bridge *host,
-- 
2.7.4

