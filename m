Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2BECA9EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623B42064B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=antmicro-com.20150623.gappssmtp.com header.i=@antmicro-com.20150623.gappssmtp.com header.b="ruKkzUTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403958AbfJWJrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:47:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36058 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403892AbfJWJrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:47:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so20368939ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 02:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5D/98Qr89wbFVwJF6mHbYmv3d9VRFdzIYm8k8FiOp5Q=;
        b=ruKkzUTLntI3NhquKP/wJRZ6g55f8qwwq2c7Nv6kUCNo/8739j6EMpou5VAceCo4F7
         Kno/a9xQ/VkQKHNdgtUzz+41CwDqq48GcCyy/OMy0jflV+VgCFrsuMlJZgA+yQFCIKwY
         py9iGz4lxpF9o7r44+4/1rOPtHKFqWbjAO0K3HHZ1pq7nftQLvdUqSUdRRt0S4xio/zb
         hizTwaUGasT+nZ1LU1dSY3MPgpuhDGVmI00IxGEbgLOXl7bLapvovLDDSNBaUxC5zXK3
         flndj8nW84qUVbUinRsHIvErTyxBw2NLcJiDAHo/UKeNufh3ZDD+VrXVrJZ6wPxx42Jg
         WOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5D/98Qr89wbFVwJF6mHbYmv3d9VRFdzIYm8k8FiOp5Q=;
        b=o/4SHtYOvP+uIOjnQwx8bBGW8/6tpfZMyCaPOY217Mm/V1wHVtUybqczva83T2IFjz
         Hv4dOIqmw56znw5GNNdSHRIQJpD7uUh/0tz/r9kd/Dmr6JQYmJXbttVg1eBWdm4xcSUR
         3RWO6rwQYSq9LRhHxIvByRltlsLC8zcFsW0s0iR0vV0tM7JW9fsewl4kYSSS22KpkkNs
         0QwV0MF61KJQdlKF5FG3bIc2Foh/1c77ijjFMvPivI/aQsDcjgYppsX8kGWizroERNWu
         yWg41GyHpE0FRUk112Ws6S28wClF3TfCF4WPI5QKLhgIK3OmmK6HQ2Z06pC2ONlnlY5Q
         L2Bg==
X-Gm-Message-State: APjAAAWCFirSuy9O457EA8pciT47yZam0PJSJpDGIXeO9u6zYytdmTDw
        kBlAVQtXCrCUE5iDQeqDVnfbpQ==
X-Google-Smtp-Source: APXvYqzTJhJA80ZJmQC6Cou54jLksvBq8AuI1omdjiPQAP0+y0Az4jIN3QbUqcMmN7Vw5GhWh0od6A==
X-Received: by 2002:a2e:8684:: with SMTP id l4mr21199174lji.53.1571824019631;
        Wed, 23 Oct 2019 02:46:59 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id k9sm1129230ljk.91.2019.10.23.02.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:46:58 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:46:54 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20191023114634.13657-1-mholenko@antmicro.com>
References: <20191023114634.13657-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023114634.13657-0-mholenko@antmicro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filip Kokosinski <fkokosinski@internships.antmicro.com>

Add vendor prefix for LiteX SoC builder.

Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
---
No changes in v2.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c5ec0a..dae98f826290 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -537,6 +537,8 @@ patternProperties:
     description: Linux-specific binding
   "^linx,.*":
     description: Linx Technologies
+  "^litex,.*":
+    description: LiteX SoC builder
   "^lltc,.*":
     description: Linear Technology Corporation
   "^logicpd,.*":
-- 
2.23.0

