Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6354EECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFD720673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dIkMInmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfJNH6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:58:47 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:44955 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbfJNH6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:58:45 -0400
Received: by mail-pg1-f173.google.com with SMTP id e10so5627242pgd.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 00:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y50RYUfHeI2he8tBZWuhHfSekRhLtbksYVRqOP2O+os=;
        b=dIkMInmTpj1JrGLM5HMmR344M6bRmXAeYAMiVi8arb1/TJiPi/qUU0epeb2VIbDM4G
         LV3tlygKC4jC/jZvI/TTi1aSMecsChNYTb6670nu93b6lUDkYL20QDgOWQLg7FTCeez4
         X8Zy9epQLServXDvDch8Pk3PiKVzYr6g96SSq+yK5zc5ImZYUoncGr9E/hXE1UiCYKiB
         +eJ5zOPomeSEH68qwDViDJScGl1/s35QWBNtfxK/BCDsB8akxoVVse1MfiXLl/gWOB57
         IqRHEKdJM1AE9swDJi3rcCokwXduEo8RYy7FP6TrgWhL62naqVU5cXxMuEEmSgXFMq9V
         rl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y50RYUfHeI2he8tBZWuhHfSekRhLtbksYVRqOP2O+os=;
        b=MKlKHLSOZ8ZuP5HFjx6KWQ4YXfqGzkCx8ovTwmKdw3O5YycqWrOnx5ZTXo8OTU05bQ
         6z1b5QoeusZxLR14uefNK6zZJGjsd2gM/01jpICoLnmxozw+Zort8Wjizl4ti//ibuge
         9AfT9XHQhVIXRuzuHX72Y4bAQe6NNuahNEt3ChW0ZvFoDw7NG9+9MDovzOqR01SzqDPP
         3EkGJaxWBO4+dTjGF7mSUF0sSGkJK/HWrGJrgLVMCf6q9nCRD2H2akxkR/b+hpwPPUGK
         vLvV2969KL43h+6FJq0EuG26PJ7GBmlHlY1bpx0oJmM8yTWuSbBYVUNubwtddueOZr0A
         ZKmQ==
X-Gm-Message-State: APjAAAWD4HBoOOfRR3evPndLJWM0xodi+1D6FDPX7ReKUvOHWFkLp2Gq
        BVCqkRk0D6Qtvj31Ta3kFHlLjA==
X-Google-Smtp-Source: APXvYqz1elBbSRERXVRjYUz8rt7tmJgHaye/RY5uPh+nlyfBFC3t6Ntdv7LmkGs0yOyrkFPOBQvtXg==
X-Received: by 2002:a62:3685:: with SMTP id d127mr159897pfa.179.1571039924723;
        Mon, 14 Oct 2019 00:58:44 -0700 (PDT)
Received: from localhost.localdomain (111-241-168-233.dynamic-ip.hinet.net. [111.241.168.233])
        by smtp.gmail.com with ESMTPSA id j126sm16583137pfb.186.2019.10.14.00.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 00:58:43 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Green Wan <green.wan@sifive.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Yash Shah <yash.shah@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 4/4] MAINTAINERS: Add Green as SiFive PDMA driver maintainer
Date:   Mon, 14 Oct 2019 15:54:27 +0800
Message-Id: <20191014075502.15105-5-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191014075502.15105-1-green.wan@sifive.com>
References: <20191014075502.15105-1-green.wan@sifive.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MAINTAINERS for SiFive PDMA driver.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a69e6db80c79..62d5b249be65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14778,6 +14778,12 @@ F:	drivers/media/usb/siano/
 F:	drivers/media/usb/siano/
 F:	drivers/media/mmc/siano/
 
+SIFIVE PDMA DRIVER
+M:	Green Wan <green.wan@sifive.com>
+S:	Maintained
+F:	drivers/dma/sf-pdma/
+F:	Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+
 SIFIVE DRIVERS
 M:	Palmer Dabbelt <palmer@sifive.com>
 M:	Paul Walmsley <paul.walmsley@sifive.com>
-- 
2.17.1

