Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F4BECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839AC20854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503331AbfJQSWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:22:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34137 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503306AbfJQSWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:22:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so2185996pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 11:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=Vl0993kFOVCbFbBd0f73Vm2bgxp+dYjZuoT4X6x3qbo=;
        b=IQpC/m3Dx7nJXX0LAVYEatGa5KPkcw8HLARbJFyH2tSciNC4mrb7aLXCkLwrbYHHEE
         lF1cBBGxzTlYRh22RSZfUDhsiSAfnZhDIADysrxArsl4VNJo+p6dK2kpGeuERlspLnkE
         oMSl/yek6Aw6TG7/dtRNuMwLCQTVH0dr0zrwj9QC1y+GAxQkc0gkfxIjt9kdPTYq/tqR
         IevhQU+mWZWC9J2/0mWgONS5l2mlYBZdoKgRC/yEwwGTm3gDR+33g4ilNtEej9a60TmB
         jxIyCrVZdW3a0VyoAPySlgFiei2ZfSy2J6od4Wngva9yIQhg4oPVm3zUeDIDsBMxW3lf
         /6rg==
X-Gm-Message-State: APjAAAUvJPnyPqAifMLgVbP7B+9+mdy9TuRR0MJUc1g7phajc7C71lYH
        LIARKWlZ2V7sQJbmtoruDspMsw==
X-Google-Smtp-Source: APXvYqynD9rVIS1o3qWTvaQTxl9H6HgwDspwax1m/MNQ8kaTqQ6suPLQuCl8IkuSxv3eFErDBkUQ1g==
X-Received: by 2002:a17:90a:1b49:: with SMTP id q67mr6162405pjq.115.1571336554301;
        Thu, 17 Oct 2019 11:22:34 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s36sm3153399pgk.84.2019.10.17.11.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:22:33 -0700 (PDT)
Subject: [PATCH 3/3] pci: Default to PCI_MSI_IRQ_DOMAIN
Date:   Thu, 17 Oct 2019 11:19:37 -0700
Message-Id: <20191017181937.7004-4-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017181937.7004-1-palmer@sifive.com>
References: <20191017181937.7004-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     tony.luck@intel.com, fenghua.yu@intel.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, bhelgaas@google.com, will@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        kstewart@linuxfoundation.org, pbonzini@redhat.com,
        firoz.khan@linaro.org, yamada.masahiro@socionext.com,
        longman@redhat.com, mingo@kernel.org, peterz@infradead.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>, michal.simek@xilinx.com,
        helgaas@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can tell, the only reason there was an architecture
whitelist for PCI_MSI_IRQ_DOMAIN is because it requires msi.h.  I've
built this for all the architectures that play nice with make.cross, but
I haven't boot tested it anywhere.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/pci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index a304f5ea11b9..77c1428cd945 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -52,7 +52,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86 || RISCV
+	def_bool y
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
-- 
2.21.0

