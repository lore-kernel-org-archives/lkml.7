Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C628FECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E55720854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503340AbfJQSWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:22:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45963 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503289AbfJQSWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:22:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so1805178pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 11:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=2KT/1Ua4Ne08bIcLoxtdMsARQdKvdiD630BlGhWeLtw=;
        b=bQdsL2rit3I8H2bpx70ulWWPrHJc7vIUSejZbeDRN1emDkd+ay3R6vqsS4trKRooF/
         wiJ9r1y2JSxvuG6XD04geCd7VLHBU2KO6OV4X5+JR6URhHczxgiuCbnirmufbEJKYNv2
         P7LpL0rGwWab0mGE5A6qYchOiHRPCW7AabHmkN5ratW3aCSCb9HfNobF0xEInXsDFYzD
         ECP+/a08RD2e9cqvlepQYp3lfzv0ayvPb3SryTLgPUgd/VrjImP+GKgCmoSyAugAOPCZ
         cdPXVSOjB/i5A/BgrYVTOPXoKJkVRT3R60DXONE/i64XSpisr9DKa6J+TUIIA0fxaCaL
         uivg==
X-Gm-Message-State: APjAAAWeE0pmK0SYAPuSjYTnJbjlvDTSwc+/FTye92itm5ucWhdSEXvk
        eDixIJimiuxHZKcwiS39aJfGYw==
X-Google-Smtp-Source: APXvYqzRFMnoGzdJ2pTmCdShwyvvireoh2sq3hfvaMP0TW/8NOqgFYu+GU8GpPpVrwDdC5UWEBAmzA==
X-Received: by 2002:a63:5423:: with SMTP id i35mr5812604pgb.128.1571336551338;
        Thu, 17 Oct 2019 11:22:31 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id u5sm4007226pfl.25.2019.10.17.11.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:22:30 -0700 (PDT)
Subject: [PATCH 1/3] ia64: Use the generic msi.h
Date:   Thu, 17 Oct 2019 11:19:35 -0700
Message-Id: <20191017181937.7004-2-palmer@sifive.com>
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

Without this I can't enable PCI_MSI_IRQ_DOMAIN, which as far as I can
tell only depends on generic functionality provided by msi.h.
PCI_MSI_IRQ_DOMAIN has historically had a whitelist of supported
architectures, but that list is getting long enough that it's cleaner to
just enable it everywhere.

This builds with an ia64 defconfig, but I have no access to ia64 and
therefor can't even boot test it.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/ia64/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 390393667d3b..22d6dbefa7d7 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -6,6 +6,7 @@ generic-y += irq_work.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += msi.h
 generic-y += preempt.h
 generic-y += trace_clock.h
 generic-y += vtime.h
-- 
2.21.0

