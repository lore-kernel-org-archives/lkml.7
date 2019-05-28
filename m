Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EABC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68CE21721
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfE1WyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 18:54:14 -0400
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:44770 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726706AbfE1WyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:54:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id DAD23100E86C1;
        Tue, 28 May 2019 22:54:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tooth68_77d281f3dc0c
X-Filterd-Recvd-Size: 2281
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 May 2019 22:54:11 +0000 (UTC)
Message-ID: <3598cd48fe0c7c8c7155baf56f965c53a88eb067.camel@perches.com>
Subject: Re: [tip:irq/core] genirq/irqdomain: Remove WARN_ON() on
 out-of-memory condition
From:   Joe Perches <joe@perches.com>
To:     mingo@kernel.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        geert+renesas@glider.be, linux-tip-commits@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Tue, 28 May 2019 15:54:09 -0700
In-Reply-To: <tip-43b98d876f89dce732f50b71607b6d2bbb8d8e6a@git.kernel.org>
References: <20190527115742.2693-1-geert+renesas@glider.be>
         <tip-43b98d876f89dce732f50b71607b6d2bbb8d8e6a@git.kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-28 at 13:23 -0700, tip-bot for Geert Uytterhoeven wrote:
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
[]
> @@ -139,7 +139,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
>  
>  	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
>  			      GFP_KERNEL, of_node_to_nid(of_node));
> -	if (WARN_ON(!domain))
> +	if (!domain)
>  		return NULL;
>  
>  	if (fwnode && is_fwnode_irqchip(fwnode)) {

This could also use the struct_size macro if desired.

Oddly, this seems to reduce object size (gcc 8.3.0)
but it's probably unrelated.

---
 kernel/irq/irqdomain.c | 2 +-.
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e7d17cc3a3d7..93a984a82154 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -137,7 +137,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 
 	static atomic_t unknown_domains;
 
-	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
+	domain = kzalloc_node(struct_size(domain, linear_revmap, size),
 			      GFP_KERNEL, of_node_to_nid(of_node));
 	if (!domain)
 		return NULL;


