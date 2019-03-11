Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3730C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898482054F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfCKPzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:55:15 -0400
Received: from foss.arm.com ([217.140.101.70]:56580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbfCKPzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:55:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22051A78;
        Mon, 11 Mar 2019 08:55:14 -0700 (PDT)
Received: from [10.1.196.92] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 345133F59C;
        Mon, 11 Mar 2019 08:55:13 -0700 (PDT)
Subject: Re: [PATCH] irqchip/gic: fix passing wrong start irq number to
 irq_alloc_descs() for secondary GICs
To:     Liu Xiang <liu.xiang6@zte.com.cn>, tglx@linutronix.de
Cc:     jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com
References: <1552315928-3292-1-git-send-email-liu.xiang6@zte.com.cn>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 mQINBE6Jf0UBEADLCxpix34Ch3kQKA9SNlVQroj9aHAEzzl0+V8jrvT9a9GkK+FjBOIQz4KE
 g+3p+lqgJH4NfwPm9H5I5e3wa+Scz9wAqWLTT772Rqb6hf6kx0kKd0P2jGv79qXSmwru28vJ
 t9NNsmIhEYwS5eTfCbsZZDCnR31J6qxozsDHpCGLHlYym/VbC199Uq/pN5gH+5JHZyhyZiNW
 ozUCjMqC4eNW42nYVKZQfbj/k4W9xFfudFaFEhAf/Vb1r6F05eBP1uopuzNkAN7vqS8XcgQH
 qXI357YC4ToCbmqLue4HK9+2mtf7MTdHZYGZ939OfTlOGuxFW+bhtPQzsHiW7eNe0ew0+LaL
 3wdNzT5abPBscqXWVGsZWCAzBmrZato+Pd2bSCDPLInZV0j+rjt7MWiSxEAEowue3IcZA++7
 ifTDIscQdpeKT8hcL+9eHLgoSDH62SlubO/y8bB1hV8JjLW/jQpLnae0oz25h39ij4ijcp8N
 t5slf5DNRi1NLz5+iaaLg4gaM3ywVK2VEKdBTg+JTg3dfrb3DH7ctTQquyKun9IVY8AsxMc6
 lxl4HxrpLX7HgF10685GG5fFla7R1RUnW5svgQhz6YVU33yJjk5lIIrrxKI/wLlhn066mtu1
 DoD9TEAjwOmpa6ofV6rHeBPehUwMZEsLqlKfLsl0PpsJwov8TQARAQABtCNNYXJjIFp5bmdp
 ZXIgPG1hcmMuenluZ2llckBhcm0uY29tPokCOwQTAQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYC
 AwECHgECF4AFAk6NvYYCGQEACgkQI9DQutE9ekObww/+NcUATWXOcnoPflpYG43GZ0XjQLng
 LQFjBZL+CJV5+1XMDfz4ATH37cR+8gMO1UwmWPv5tOMKLHhw6uLxGG4upPAm0qxjRA/SE3LC
 22kBjWiSMrkQgv5FDcwdhAcj8A+gKgcXBeyXsGBXLjo5UQOGvPTQXcqNXB9A3ZZN9vS6QUYN
 TXFjnUnzCJd+PVI/4jORz9EUVw1q/+kZgmA8/GhfPH3xNetTGLyJCJcQ86acom2liLZZX4+1
 6Hda2x3hxpoQo7pTu+XA2YC4XyUstNDYIsE4F4NVHGi88a3N8yWE+Z7cBI2HjGvpfNxZnmKX
 6bws6RQ4LHDPhy0yzWFowJXGTqM/e79c1UeqOVxKGFF3VhJJu1nMlh+5hnW4glXOoy/WmDEM
 UMbl9KbJUfo+GgIQGMp8mwgW0vK4HrSmevlDeMcrLdfbbFbcZLNeFFBn6KqxFZaTd+LpylIH
 bOPN6fy1Dxf7UZscogYw5Pt0JscgpciuO3DAZo3eXz6ffj2NrWchnbj+SpPBiH4srfFmHY+Y
 LBemIIOmSqIsjoSRjNEZeEObkshDVG5NncJzbAQY+V3Q3yo9og/8ZiaulVWDbcpKyUpzt7pv
 cdnY3baDE8ate/cymFP5jGJK++QCeA6u6JzBp7HnKbngqWa6g8qDSjPXBPCLmmRWbc5j0lvA
 6ilrF8m5Ag0ETol/RQEQAM/2pdLYCWmf3rtIiP8Wj5NwyjSL6/UrChXtoX9wlY8a4h3EX6E3
 64snIJVMLbyr4bwdmPKULlny7T/R8dx/mCOWu/DztrVNQiXWOTKJnd/2iQblBT+W5W8ep/nS
 w3qUIckKwKdplQtzSKeE+PJ+GMS+DoNDDkcrVjUnsoCEr0aK3cO6g5hLGu8IBbC1CJYSpple
 VVb/sADnWF3SfUvJ/l4K8Uk4B4+X90KpA7U9MhvDTCy5mJGaTsFqDLpnqp/yqaT2P7kyMG2E
 w+eqtVIqwwweZA0S+tuqput5xdNAcsj2PugVx9tlw/LJo39nh8NrMxAhv5aQ+JJ2I8UTiHLX
 QvoC0Yc/jZX/JRB5r4x4IhK34Mv5TiH/gFfZbwxd287Y1jOaD9lhnke1SX5MXF7eCT3cgyB+
 hgSu42w+2xYl3+rzIhQqxXhaP232t/b3ilJO00ZZ19d4KICGcakeiL6ZBtD8TrtkRiewI3v0
 o8rUBWtjcDRgg3tWx/PcJvZnw1twbmRdaNvsvnlapD2Y9Js3woRLIjSAGOijwzFXSJyC2HU1
 AAuR9uo4/QkeIrQVHIxP7TJZdJ9sGEWdeGPzzPlKLHwIX2HzfbdtPejPSXm5LJ026qdtJHgz
 BAb3NygZG6BH6EC1NPDQ6O53EXorXS1tsSAgp5ZDSFEBklpRVT3E0NrDABEBAAGJAh8EGAEC
 AAkFAk6Jf0UCGwwACgkQI9DQutE9ekMLBQ//U+Mt9DtFpzMCIHFPE9nNlsCm75j22lNiw6mX
 mx3cUA3pl+uRGQr/zQC5inQNtjFUmwGkHqrAw+SmG5gsgnM4pSdYvraWaCWOZCQCx1lpaCOl
 MotrNcwMJTJLQGc4BjJyOeSH59HQDitKfKMu/yjRhzT8CXhys6R0kYMrEN0tbe1cFOJkxSbV
 0GgRTDF4PKyLT+RncoKxQe8lGxuk5614aRpBQa0LPafkirwqkUtxsPnarkPUEfkBlnIhAR8L
 kmneYLu0AvbWjfJCUH7qfpyS/FRrQCoBq9QIEcf2v1f0AIpA27f9KCEv5MZSHXGCdNcbjKw1
 39YxYZhmXaHFKDSZIC29YhQJeXWlfDEDq6nIhvurZy3mSh2OMQgaIoFexPCsBBOclH8QUtMk
 a3jW/qYyrV+qUq9Wf3SKPrXf7B3xB332jFCETbyZQXqmowV+2b3rJFRWn5hK5B+xwvuxKyGq
 qDOGjof2dKl2zBIxbFgOclV7wqCVkhxSJi/QaOj2zBqSNPXga5DWtX3ekRnJLa1+ijXxmdjz
 hApihi08gwvP5G9fNGKQyRETePEtEAWt0b7dOqMzYBYGRVr7uS4uT6WP7fzOwAJC4lU7ZYWZ
 yVshCa0IvTtp1085RtT3qhh9mobkcZ+7cQOY+Tx2RGXS9WeOh2jZjdoWUv6CevXNQyOUXMM=
Organization: ARM Ltd
Message-ID: <8c88993d-f763-4ab8-5444-f618642929a1@arm.com>
Date:   Mon, 11 Mar 2019 15:55:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552315928-3292-1-git-send-email-liu.xiang6@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2019 14:52, Liu Xiang wrote:
> For secondary GICs, the start irq number should skip over SGIs
> and PPIs. Its value should be 32. So we should pass hwirq_base to 
> irq_alloc_descs() rather than a constant number 16.
> 
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
> ---
>  drivers/irqchip/irq-gic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index ba2a37a..351f576 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1157,7 +1157,7 @@ static int gic_init_bases(struct gic_chip_data *gic, int irq_start,
>  
>  		gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
>  
> -		irq_base = irq_alloc_descs(irq_start, 16, gic_irqs,
> +		irq_base = irq_alloc_descs(irq_start, hwirq_base, gic_irqs,
>  					   numa_node_id());
>  		if (irq_base < 0) {
>  			WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
> 

I suggest you look at __irq_alloc_descs(), and understand what the 
various parameters mean. What you're doing here has absolutely no 
effect.

The right thing to do would be to get rid of this altogether, except 
that we have exactly *one* platform in the tree that is still non-DT 
(some unmaintained Cavium piece of junk). But we can still simplify it, 
as this guy doesn't have a secondary GIC (it is braindead enough).

What I'm suggesting instead is:

From b41fdc4a7bf9045e4871c5b15905ea732ffd044f Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Mon, 11 Mar 2019 15:38:10 +0000
Subject: [PATCH] irqchip/gic: Drop support for secondary GIC in non-DT systems

We do not have any in-tree platform with this pathological setup,
and only a single system (Cavium's cns3xxx) isn't DT aware.

Let's drop the secondary GIC support for now, until we remove
the above horror altogether.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-cns3xxx/core.c    |  2 +-
 drivers/irqchip/irq-gic.c       | 45 ++++++++++++---------------------
 include/linux/irqchip/arm-gic.h |  3 +--
 3 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 7d5a44a06648..f676592d8402 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -90,7 +90,7 @@ void __init cns3xxx_map_io(void)
 /* used by entry-macro.S */
 void __init cns3xxx_init_irq(void)
 {
-	gic_init(0, 29, IOMEM(CNS3XXX_TC11MP_GIC_DIST_BASE_VIRT),
+	gic_init(IOMEM(CNS3XXX_TC11MP_GIC_DIST_BASE_VIRT),
 		 IOMEM(CNS3XXX_TC11MP_GIC_CPU_BASE_VIRT));
 }
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ba2a37a27a54..fd3110c171ba 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1089,11 +1089,10 @@ static void gic_init_chip(struct gic_chip_data *gic, struct device *dev,
 #endif
 }
 
-static int gic_init_bases(struct gic_chip_data *gic, int irq_start,
+static int gic_init_bases(struct gic_chip_data *gic,
 			  struct fwnode_handle *handle)
 {
-	irq_hw_number_t hwirq_base;
-	int gic_irqs, irq_base, ret;
+	int gic_irqs, ret;
 
 	if (IS_ENABLED(CONFIG_GIC_NON_BANKED) && gic->percpu_offset) {
 		/* Frankein-GIC without banked registers... */
@@ -1145,28 +1144,21 @@ static int gic_init_bases(struct gic_chip_data *gic, int irq_start,
 	} else {		/* Legacy support */
 		/*
 		 * For primary GICs, skip over SGIs.
-		 * For secondary GICs, skip over PPIs, too.
+		 * No secondary GIC support whatsoever.
 		 */
-		if (gic == &gic_data[0] && (irq_start & 31) > 0) {
-			hwirq_base = 16;
-			if (irq_start != -1)
-				irq_start = (irq_start & ~31) + 16;
-		} else {
-			hwirq_base = 32;
-		}
+		int irq_base;
 
-		gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
+		gic_irqs -= 16; /* calculate # of irqs to allocate */
 
-		irq_base = irq_alloc_descs(irq_start, 16, gic_irqs,
+		irq_base = irq_alloc_descs(16, 16, gic_irqs,
 					   numa_node_id());
 		if (irq_base < 0) {
-			WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
-			     irq_start);
-			irq_base = irq_start;
+			WARN(1, "Cannot allocate irq_descs @ IRQ16, assuming pre-allocated\n");
+			irq_base = 16;
 		}
 
 		gic->domain = irq_domain_add_legacy(NULL, gic_irqs, irq_base,
-					hwirq_base, &gic_irq_domain_ops, gic);
+						    16, &gic_irq_domain_ops, gic);
 	}
 
 	if (WARN_ON(!gic->domain)) {
@@ -1195,7 +1187,6 @@ static int gic_init_bases(struct gic_chip_data *gic, int irq_start,
 }
 
 static int __init __gic_init_bases(struct gic_chip_data *gic,
-				   int irq_start,
 				   struct fwnode_handle *handle)
 {
 	char *name;
@@ -1231,32 +1222,28 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 		gic_init_chip(gic, NULL, name, false);
 	}
 
-	ret = gic_init_bases(gic, irq_start, handle);
+	ret = gic_init_bases(gic, handle);
 	if (ret)
 		kfree(name);
 
 	return ret;
 }
 
-void __init gic_init(unsigned int gic_nr, int irq_start,
-		     void __iomem *dist_base, void __iomem *cpu_base)
+void __init gic_init(void __iomem *dist_base, void __iomem *cpu_base)
 {
 	struct gic_chip_data *gic;
 
-	if (WARN_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR))
-		return;
-
 	/*
 	 * Non-DT/ACPI systems won't run a hypervisor, so let's not
 	 * bother with these...
 	 */
 	static_branch_disable(&supports_deactivate_key);
 
-	gic = &gic_data[gic_nr];
+	gic = &gic_data[0];
 	gic->raw_dist_base = dist_base;
 	gic->raw_cpu_base = cpu_base;
 
-	__gic_init_bases(gic, irq_start, NULL);
+	__gic_init_bases(gic, NULL);
 }
 
 static void gic_teardown(struct gic_chip_data *gic)
@@ -1399,7 +1386,7 @@ int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq)
 	if (ret)
 		return ret;
 
-	ret = gic_init_bases(*gic, -1, &dev->of_node->fwnode);
+	ret = gic_init_bases(*gic, &dev->of_node->fwnode);
 	if (ret) {
 		gic_teardown(*gic);
 		return ret;
@@ -1459,7 +1446,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	if (gic_cnt == 0 && !gic_check_eoimode(node, &gic->raw_cpu_base))
 		static_branch_disable(&supports_deactivate_key);
 
-	ret = __gic_init_bases(gic, -1, &node->fwnode);
+	ret = __gic_init_bases(gic, &node->fwnode);
 	if (ret) {
 		gic_teardown(gic);
 		return ret;
@@ -1650,7 +1637,7 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
 		return -ENOMEM;
 	}
 
-	ret = __gic_init_bases(gic, -1, domain_handle);
+	ret = __gic_init_bases(gic, domain_handle);
 	if (ret) {
 		pr_err("Failed to initialise GIC\n");
 		irq_domain_free_fwnode(domain_handle);
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 626179077bb0..0f049b384ccd 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -158,8 +158,7 @@ int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq);
  * Legacy platforms not converted to DT yet must use this to init
  * their GIC
  */
-void gic_init(unsigned int nr, int start,
-	      void __iomem *dist , void __iomem *cpu);
+void gic_init(void __iomem *dist , void __iomem *cpu);
 
 int gicv2m_init(struct fwnode_handle *parent_handle,
 		struct irq_domain *parent);
-- 
2.20.1

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
