Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE82C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F299206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ja3w7OgL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QNxF/zRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfCVRoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:44:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57294 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfCVRoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:44:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5093360E5C; Fri, 22 Mar 2019 17:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553276641;
        bh=aMAcRlXeGBMR0RMmlEs8ir/knaSfE4KBBBCHBltkd2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ja3w7OgLq52+Xe5+YPlbtPkwPkxmkCAzHUHLVcPWSkNkgCWI4Q4tym1FH6luj7xQE
         o0dzLilI5CsRASa8Pku+dg9WRDB0x+6kpXSkIeVUSeRAn4/t8F5KhM4J3/3N23SUdN
         /z517mi03X2Vrz1US5yu4o+G+pzE+XRJPWrMM3S0=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 96ACE60D35;
        Fri, 22 Mar 2019 17:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553276639;
        bh=aMAcRlXeGBMR0RMmlEs8ir/knaSfE4KBBBCHBltkd2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QNxF/zRN6vo2rFM1c1zbrPSJjICncP/yKlPpb8S+3Svu/6LHYmFUHguMrOUG0rxGh
         KZGhBWeweIZBoAfE06iRDjD6PzdfbtIZK6feFlgSMbZ06WtvyTV8cuaMF7deI4p7jQ
         1s8a5qMcW1SwdlQtQeks2flo+0rAreqAg1w6Yv+g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96ACE60D35
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 22 Mar 2019 11:43:58 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH v4 04/10] of: irq: add helper to remap interrupts to
 another irqdomain
Message-ID: <20190322174358.GA10883@codeaurora.org>
References: <20190313211844.29416-1-ilina@codeaurora.org>
 <20190313211844.29416-5-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190313211844.29416-5-ilina@codeaurora.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I observed an issue with return value being set to 0, when a match is
not found in the irqdomain-map.

On Wed, Mar 13 2019 at 15:20 -0600, Lina Iyer wrote:
>From: Stephen Boyd <swboyd@chromium.org>
>
>Sometimes interrupts are routed from an interrupt controller to another
>in no specific order. Having these in the drivers makes it difficult to
>maintain when the same drivers supports multiple variants with different
>mapping. Also, specifying them in DT makes little sense with a bunch of
>numbers like -
>	<0, 13>, <5, 32>,
>
>It makes more sense when we can have the parent handle along with
>interrupt specifiers for the incoming interrupt as well as that of the
>outgoing interrupt like -
>	<22 0 &intc 36 0>,
>	<24 0 &intc 37 0>,
>	<26 0 &intc 38 0>,
>
>And the interrupt specifiers can be interpreted using these optional
>properties -
>	irqdomain-map-mask = <0xff 0>;
>	irqdomain-map-pass-thru = <0 0xff>;
>
>The irqdomain-map-mask reads the input interrupt specifier to parse the
>incoming interrupt port. The format of the output port is specified with
>the irqdomain-map-pass-thru property.
>
>Let's add a helper function to parse this from DT and match a struct
>irq_fwspec using the input interrupt specifier from the irqdomain-map
>and the valid bits specified in the irqdomain-map-mask and copy the
>output interrupt specifier from the map to irq_fwspec per the mask in
>irqdomain-map-pass-thru property for the matched interrupt.
>
>Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>---
>Changes in v4:
>	- Fix commit text spelling and verbosity
>---
> drivers/of/irq.c       | 125 +++++++++++++++++++++++++++++++++++++++++
> include/linux/of_irq.h |   1 +
> 2 files changed, 126 insertions(+)
>
>diff --git a/drivers/of/irq.c b/drivers/of/irq.c
>index e1f6f392a4c0..a1534f947ed4 100644
>--- a/drivers/of/irq.c
>+++ b/drivers/of/irq.c
>@@ -273,6 +273,131 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
> }
> EXPORT_SYMBOL_GPL(of_irq_parse_raw);
>
>+int of_irq_domain_map(const struct irq_fwspec *in, struct irq_fwspec *out)
>+{
>+	char *stem_name;
>+	char *cells_name, *map_name = NULL, *mask_name = NULL;
>+	char *pass_name = NULL;
>+	struct device_node *cur, *new = NULL;
>+	const __be32 *map, *mask, *pass;
>+	static const __be32 dummy_mask[] = { [0 ... MAX_PHANDLE_ARGS] = ~0 };
>+	static const __be32 dummy_pass[] = { [0 ... MAX_PHANDLE_ARGS] = 0 };
>+	__be32 initial_match_array[MAX_PHANDLE_ARGS];
>+	const __be32 *match_array = initial_match_array;
>+	int i, ret, map_len, match;
>+	u32 in_size, out_size;
>+
>+	stem_name = "";
>+	cells_name = "#interrupt-cells";
>+
>+	ret = -ENOMEM;
>+	map_name = kasprintf(GFP_KERNEL, "irqdomain%s-map", stem_name);
>+	if (!map_name)
>+		goto free;
>+
>+	mask_name = kasprintf(GFP_KERNEL, "irqdomain%s-map-mask", stem_name);
>+	if (!mask_name)
>+		goto free;
>+
>+	pass_name = kasprintf(GFP_KERNEL, "irqdomain%s-map-pass-thru", stem_name);
>+	if (!pass_name)
>+		goto free;
>+
>+	/* Get the #interrupt-cells property */
>+	cur = to_of_node(in->fwnode);
>+	ret = of_property_read_u32(cur, cells_name, &in_size);
>+	if (ret < 0)
>+		goto put;
>+
>+	/* Precalculate the match array - this simplifies match loop */
>+	for (i = 0; i < in_size; i++)
>+		initial_match_array[i] = cpu_to_be32(in->param[i]);
>+
>+	ret = -EINVAL;
This value...
>+	/* Get the irqdomain-map property */
>+	map = of_get_property(cur, map_name, &map_len);
>+	if (!map) {
>+		ret = 0;
>+		goto free;
>+	}
>+	map_len /= sizeof(u32);
>+
>+	/* Get the irqdomain-map-mask property (optional) */
>+	mask = of_get_property(cur, mask_name, NULL);
>+	if (!mask)
>+		mask = dummy_mask;
>+	/* Iterate through irqdomain-map property */
>+	match = 0;
>+	while (map_len > (in_size + 1) && !match) {
>+		/* Compare specifiers */
>+		match = 1;
>+		for (i = 0; i < in_size; i++, map_len--)
>+			match &= !((match_array[i] ^ *map++) & mask[i]);
>+
>+		of_node_put(new);
>+		new = of_find_node_by_phandle(be32_to_cpup(map));
>+		map++;
>+		map_len--;
>+
>+		/* Check if not found */
>+		if (!new)
>+			goto put;
>+
>+		if (!of_device_is_available(new))
>+			match = 0;
>+
>+		ret = of_property_read_u32(new, cells_name, &out_size);
Gets overwritten by this, and set to 0.
>+		if (ret)
>+			goto put;
>+
>+		/* Check for malformed properties */
>+		if (WARN_ON(out_size > MAX_PHANDLE_ARGS))
>+			goto put;
>+		if (map_len < out_size)
>+			goto put;
>+
>+		/* Move forward by new node's #interrupt-cells amount */
>+		map += out_size;
>+		map_len -= out_size;
>+	}
>+	if (match) {
If  match is not found, then ret remains 0.

>+		/* Get the irqdomain-map-pass-thru property (optional) */
>+		pass = of_get_property(cur, pass_name, NULL);
>+		if (!pass)
>+			pass = dummy_pass;
>+
>+		/*
>+		 * Successfully parsed a irqdomain-map translation; copy new
>+		 * specifier into the out structure, keeping the
>+		 * bits specified in irqdomain-map-pass-thru.
>+		 */
>+		match_array = map - out_size;
>+		for (i = 0; i < out_size; i++) {
>+			__be32 val = *(map - out_size + i);
>+
>+			out->param[i] = in->param[i];
>+			if (i < in_size) {
>+				val &= ~pass[i];
>+				val |= cpu_to_be32(out->param[i]) & pass[i];
>+			}
>+
>+			out->param[i] = be32_to_cpu(val);
>+		}
>+		out->param_count = in_size = out_size;
>+		out->fwnode = of_node_to_fwnode(new);
>+	}
>+put:
>+	of_node_put(cur);
>+	of_node_put(new);
>+free:
>+	kfree(mask_name);
>+	kfree(map_name);
>+	kfree(pass_name);
>+
>+	return ret;
>+}
>+EXPORT_SYMBOL(of_irq_domain_map);
>+
> /**
>  * of_irq_parse_one - Resolve an interrupt for a device
>  * @device: the device whose interrupt is to be resolved
>diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
>index 1214cabb2247..86342502a62a 100644
>--- a/include/linux/of_irq.h
>+++ b/include/linux/of_irq.h
>@@ -32,6 +32,7 @@ static inline int of_irq_parse_oldworld(struct device_node *device, int index,
> }
> #endif /* CONFIG_PPC32 && CONFIG_PPC_PMAC */
>
>+extern int of_irq_domain_map(const struct irq_fwspec *in, struct irq_fwspec *out);
> extern int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq);
> extern int of_irq_parse_one(struct device_node *device, int index,
> 			  struct of_phandle_args *out_irq);
>--
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>a Linux Foundation Collaborative Project
>
--8<---
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 2653abfaf09d..e12f27403b3a 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -361,32 +361,36 @@ int of_irq_domain_map(const struct irq_fwspec *in, struct irq_fwspec *out)
                map += out_size;
                map_len -= out_size;
        }
-       if (match) {
-               /* Get the irqdomain-map-pass-thru property (optional) */
-               pass = of_get_property(cur, pass_name, NULL);
-               if (!pass)
-                       pass = dummy_pass;

-               /*
-                * Successfully parsed a irqdomain-map translation; copy new
-                * specifier into the out structure, keeping the
-                * bits specified in irqdomain-map-pass-thru.
-                */
-               match_array = map - out_size;
-               for (i = 0; i < out_size; i++) {
-                       __be32 val = *(map - out_size + i);
-
-                       out->param[i] = in->param[i];
-                       if (i < in_size) {
-                               val &= ~pass[i];
-                               val |= cpu_to_be32(out->param[i]) & pass[i];
-                       }
+       if (!match) {
+               ret = -EINVAL;
+               goto put;
+       }

-                       out->param[i] = be32_to_cpu(val);
+       /* Get the irqdomain-map-pass-thru property (optional) */
+       pass = of_get_property(cur, pass_name, NULL);
+       if (!pass)
+               pass = dummy_pass;
+
+       /*
+        * Successfully parsed a irqdomain-map translation; copy new
+        * specifier into the out structure, keeping the
+        * bits specified in irqdomain-map-pass-thru.
+        */
+       match_array = map - out_size;
+       for (i = 0; i < out_size; i++) {
+               __be32 val = *(map - out_size + i);
+
+               out->param[i] = in->param[i];
+               if (i < in_size) {
+                       val &= ~pass[i];
+                       val |= cpu_to_be32(out->param[i]) & pass[i];
                }
-               out->param_count = in_size = out_size;
-               out->fwnode = of_node_to_fwnode(new);
+
+               out->param[i] = be32_to_cpu(val);
        }
+       out->param_count = in_size = out_size;
+       out->fwnode = of_node_to_fwnode(new);
 put:
        of_node_put(cur);
        of_node_put(new);


