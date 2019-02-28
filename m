Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D8FC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7665921850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="GAZEHifM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfB1EpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 23:45:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41117 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfB1EpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 23:45:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id y5so9107275plk.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 20:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=t+aWm2f1Ovz5udXHw1QwvAiXhGl3Vs08iEXC3B/95X0=;
        b=GAZEHifMvPW56QkfM4k8OkBD9bEVYQklVMaZ9DwSBVd/jXLEZtYjGCUvXIJC+IkF10
         Fuvddc0NpuZJiaRt55M3eCtpMV6cntCeZeyVFZ8w9z8ppx2d04h8j6J0BxXSb93xwX0K
         d511kockwfcnfNy+lM+a/eIv/MuFM+ttgaepU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=t+aWm2f1Ovz5udXHw1QwvAiXhGl3Vs08iEXC3B/95X0=;
        b=D3jzHkbLxkNCZWso06CoWG0PLg5+ZNuu3XBAg51+OrTjtF9fMx7h4dHa8FggQEK73X
         QGJqRoFeV0nQbdpRV3QuYKdesyfHuKf0StbqdOSPy8L0afhYDxCDXKdNTGFPrgeME3i3
         FO9vxosdNzmQyWpkiiSp8JzL6E3ppHsRiDbTtvFHZw1chWocu+0t13b2YBx0ZDkxtZQV
         8s+ukk9OZC9744oDEAutDezwexgWd/1U+rcCaDP+n4xBgN4w0UdqZW/zLYE4THI757VY
         AKKw+fZWQtKAOCwCoPK3pq12nWlqJ2IpFrQF+YaYZ3Kr1mXzqqH8XDA5HguNvgoqHh7z
         21Bw==
X-Gm-Message-State: AHQUAuZJEacjvsJXwlHxyfPYxNOGt+Hic3NDqhtPXOUHy75aJ3k0G4Ke
        dqydJ2HJUqqmVwDt8rSltX8YmavjZuc=
X-Google-Smtp-Source: AHgI3IbRlnKWycyhYRlqUK80rUcR6DI10bGA6BVDsHLEJlJNuYl127BSeczlmcG7I0qefrBrRkMaww==
X-Received: by 2002:a17:902:46a4:: with SMTP id p33mr6003800pld.48.1551329100554;
        Wed, 27 Feb 2019 20:45:00 -0800 (PST)
Received: from localhost (203-59-50-226.dyn.iinet.net.au. [203.59.50.226])
        by smtp.gmail.com with ESMTPSA id z67sm33216997pfi.152.2019.02.27.20.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 20:44:59 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        mpe@ellerman.id.au
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ego@linux.vnet.ibm.com,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv: powercap: Add hard minimum powercap
In-Reply-To: <1551260002-26792-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1551260002-26792-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date:   Thu, 28 Feb 2019 15:44:56 +1100
Message-ID: <871s3s34jb.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:

> In POWER9, OCC(On-Chip-Controller) provides for hard and soft system
> powercapping range. The hard powercap range is guaranteed while soft
> powercap may or may not be asserted due to various power-thermal
> reasons based on system configuration and workloads. This patch adds
> a sysfs file to export the hard minimum powercap limit to allow the
> user to set the appropriate powercap value that can be managed by the
> system.

Maybe it's common terminology and I'm just not aware of it, but what do
you mean by "asserted"? It doesn't appear elsewhere in the documentation
you're patching, and it's not a use of assert that I'm familiar with...

Regards,
Daniel

>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  .../ABI/testing/sysfs-firmware-opal-powercap       | 10 ++++
>  arch/powerpc/platforms/powernv/opal-powercap.c     | 66 +++++++++-------------
>  2 files changed, 37 insertions(+), 39 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-firmware-opal-powercap b/Documentation/ABI/testing/sysfs-firmware-opal-powercap
> index c9b66ec..65db4c1 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-opal-powercap
> +++ b/Documentation/ABI/testing/sysfs-firmware-opal-powercap
> @@ -29,3 +29,13 @@ Description:	System powercap directory and attributes applicable for
>  		  creates a request for setting a new-powercap. The
>  		  powercap requested must be between powercap-min
>  		  and powercap-max.
> +
> +What:		/sys/firmware/opal/powercap/system-powercap/powercap-hard-min
> +Date:		Feb 2019
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Description:	Hard minimum powercap
> +
> +		This file provides the hard minimum powercap limit in
> +		Watts. The powercap value above hard minimum is always
> +		guaranteed to be asserted and the powercap value below
> +		the hard minimum limit may or may not be guaranteed.
> diff --git a/arch/powerpc/platforms/powernv/opal-powercap.c b/arch/powerpc/platforms/powernv/opal-powercap.c
> index d90ee4f..38408e7 100644
> --- a/arch/powerpc/platforms/powernv/opal-powercap.c
> +++ b/arch/powerpc/platforms/powernv/opal-powercap.c
> @@ -139,10 +139,24 @@ static void powercap_add_attr(int handle, const char *name,
>  	attr->handle = handle;
>  	sysfs_attr_init(&attr->attr.attr);
>  	attr->attr.attr.name = name;
> -	attr->attr.attr.mode = 0444;
> +
> +	if (!strncmp(name, "powercap-current", strlen(name))) {
> +		attr->attr.attr.mode = 0664;
> +		attr->attr.store = powercap_store;
> +	} else {
> +		attr->attr.attr.mode = 0444;
> +	}
> +
>  	attr->attr.show = powercap_show;
>  }
>  
> +static const char * const powercap_strs[] = {
> +	"powercap-max",
> +	"powercap-min",
> +	"powercap-current",
> +	"powercap-hard-min",
> +};
> +
>  void __init opal_powercap_init(void)
>  {
>  	struct device_node *powercap, *node;
> @@ -167,60 +181,34 @@ void __init opal_powercap_init(void)
>  
>  	i = 0;
>  	for_each_child_of_node(powercap, node) {
> -		u32 cur, min, max;
> -		int j = 0;
> -		bool has_cur = false, has_min = false, has_max = false;
> +		u32 id;
> +		int j, count = 0;
>  
> -		if (!of_property_read_u32(node, "powercap-min", &min)) {
> -			j++;
> -			has_min = true;
> -		}
> -
> -		if (!of_property_read_u32(node, "powercap-max", &max)) {
> -			j++;
> -			has_max = true;
> -		}
> +		for (j = 0; j < ARRAY_SIZE(powercap_strs); j++)
> +			if (!of_property_read_u32(node, powercap_strs[j], &id))
> +				count++;
>  
> -		if (!of_property_read_u32(node, "powercap-current", &cur)) {
> -			j++;
> -			has_cur = true;
> -		}
> -
> -		pcaps[i].pattrs = kcalloc(j, sizeof(struct powercap_attr),
> +		pcaps[i].pattrs = kcalloc(count, sizeof(struct powercap_attr),
>  					  GFP_KERNEL);
>  		if (!pcaps[i].pattrs)
>  			goto out_pcaps_pattrs;
>  
> -		pcaps[i].pg.attrs = kcalloc(j + 1, sizeof(struct attribute *),
> +		pcaps[i].pg.attrs = kcalloc(count + 1,
> +					    sizeof(struct attribute *),
>  					    GFP_KERNEL);
>  		if (!pcaps[i].pg.attrs) {
>  			kfree(pcaps[i].pattrs);
>  			goto out_pcaps_pattrs;
>  		}
>  
> -		j = 0;
>  		pcaps[i].pg.name = kasprintf(GFP_KERNEL, "%pOFn", node);
> -		if (has_min) {
> -			powercap_add_attr(min, "powercap-min",
> -					  &pcaps[i].pattrs[j]);
> -			pcaps[i].pg.attrs[j] = &pcaps[i].pattrs[j].attr.attr;
> -			j++;
> -		}
> -
> -		if (has_max) {
> -			powercap_add_attr(max, "powercap-max",
> -					  &pcaps[i].pattrs[j]);
> -			pcaps[i].pg.attrs[j] = &pcaps[i].pattrs[j].attr.attr;
> -			j++;
> -		}
> +		for (j = 0; j < ARRAY_SIZE(powercap_strs); j++) {
> +			if (of_property_read_u32(node, powercap_strs[j], &id))
> +				continue;
>  
> -		if (has_cur) {
> -			powercap_add_attr(cur, "powercap-current",
> +			powercap_add_attr(id, powercap_strs[j],
>  					  &pcaps[i].pattrs[j]);
> -			pcaps[i].pattrs[j].attr.attr.mode |= 0220;
> -			pcaps[i].pattrs[j].attr.store = powercap_store;
>  			pcaps[i].pg.attrs[j] = &pcaps[i].pattrs[j].attr.attr;
> -			j++;
>  		}
>  
>  		if (sysfs_create_group(powercap_kobj, &pcaps[i].pg)) {
> -- 
> 1.8.3.1
