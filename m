Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392C9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098A82068E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJpN8oX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfKUTUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:20:24 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46933 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUTUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:20:23 -0500
Received: by mail-yb1-f195.google.com with SMTP id v15so1756689ybp.13;
        Thu, 21 Nov 2019 11:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5B+GZajOqvaWvyzmWPDZzufXjntzU+RPEV9A9XVVQyo=;
        b=UJpN8oX6taG3hiXL3UIBtKV6E+OkOVjWAzHslQhY+K6ckeSXOnVCAP6wrFFszzGfp+
         aeert+sNqCmeC66DOsU8DnpuIfRsTHWCi6noxVe2aoiLV4vihp5Og5H46X7H2jb3Jmt3
         gC4G6Bd08BSo5xnj+Eq5qeao34CS4b43Y+9VVTXHIdo6AF146VwuZV60CKFJmqG1R/4X
         00JOt/YOO6aQoLYmPZT8jbaYJuL3J+B1gg0JiB9KC1Fhg5Gvyl+moZWrKEVCxiQC5gIJ
         nl/wWU+UQhjmADSyB20y/yQQgkbI+0MBFNJ9+lljbVsqaAjz0D+Z+0fYwLUHVY8ikRcI
         nOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5B+GZajOqvaWvyzmWPDZzufXjntzU+RPEV9A9XVVQyo=;
        b=T8SMqcPF/MLPr2pmeFgfdjL/RO2oHFXPqoUKiqE6CIuXO/Os0nJK3AJUsHOhB9yMAK
         E3OlvBmJ8JjnN7xOemXOcun+4g+8rUqnQLfaefPLi4eni1VRyWv/VnnAgEAWXaLpYXJd
         bObr7SBB60B6jYNdZGQrDg8MLnT4A3+Zz2qw3q3gHAKjVR5o7z1ahchPaHlmBQjTYvQ2
         Frl0nZRgIZryTrE5hzt0mWL9rnuHEK5l7gdQtiPauItWR4yiBV8em6SeKYThHkfAwq+p
         MhnAldqjGQvR0HQiC5QhzpxR0vaUF7nIjyh+nFuj3NKhZsyFqvW8oI2zeLb2xzJj7Aug
         6i8Q==
X-Gm-Message-State: APjAAAWWd8wwy9leSy/K6bCumlfO9Km7m5FGPxsepDJASR4Zk40Da5F9
        Acvm7HUA07nXM+mjamUskb6Nkj25
X-Google-Smtp-Source: APXvYqzEI1D/obtYWE32GEKFLojM9e1YVwapptIfI0wc/LK/BXu7KX0g4QzpPTr80jFQQ7V/fGS9BA==
X-Received: by 2002:a25:e6d4:: with SMTP id d203mr7877161ybh.43.1574364022446;
        Thu, 21 Nov 2019 11:20:22 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id l76sm1115976ywl.24.2019.11.21.11.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 11:20:22 -0800 (PST)
Subject: Re: [PATCH] of: overlay: add_changeset_property() memory leak
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>, geert@linux-m68k.org,
        Alan Tull <atull@kernel.org>
References: <1574363816-13981-1-git-send-email-frowand.list@gmail.com>
Message-ID: <9eda204f-aaa0-54a1-83eb-a012ddeeaac3@gmail.com>
Date:   Thu, 21 Nov 2019 13:20:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574363816-13981-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 11/21/19 1:16 PM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> No changeset entries are created for #address-cells and #size-cells
> properties, but the duplicated properties are never freed.  This
> results in a memory leak which is detected by kmemleak:
> 
>  unreferenced object 0x85887180 (size 64):
>    backtrace:
>      kmem_cache_alloc_trace+0x1fb/0x1fc
>      __of_prop_dup+0x25/0x7c
>      add_changeset_property+0x17f/0x370
>      build_changeset_next_level+0x29/0x20c
>      of_overlay_fdt_apply+0x32b/0x6b4
>      ...
> 
> Fixes: 6f75118800acf77f8 ("of: overlay: validate overlay properties #address-cells and #size-cells")
> Reported-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/overlay.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index c423e94baf0f..9617b7df7c4d 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -305,7 +305,6 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>  {
>  	struct property *new_prop = NULL, *prop;
>  	int ret = 0;
> -	bool check_for_non_overlay_node = false;
>  
>  	if (target->in_livetree)
>  		if (!of_prop_cmp(overlay_prop->name, "name") ||
> @@ -318,6 +317,25 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>  	else
>  		prop = NULL;
>  
> +	if (prop) {
> +		if (!of_prop_cmp(prop->name, "#address-cells")) {
> +			if (!of_prop_val_eq(prop, overlay_prop)) {
> +				pr_err("ERROR: changing value of #address-cells is not allowed in %pOF\n",
> +				       target->np);
> +				ret = -EINVAL;
> +			}
> +			return ret;
> +
> +		} else if (!of_prop_cmp(prop->name, "#size-cells")) {
> +			if (!of_prop_val_eq(prop, overlay_prop)) {
> +				pr_err("ERROR: changing value of #size-cells is not allowed in %pOF\n",
> +				       target->np);
> +				ret = -EINVAL;
> +			}
> +			return ret;
> +		}
> +	}
> +
>  	if (is_symbols_prop) {
>  		if (prop)
>  			return -EINVAL;
> @@ -330,33 +348,18 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>  		return -ENOMEM;
>  
>  	if (!prop) {
> -		check_for_non_overlay_node = true;
>  		if (!target->in_livetree) {
>  			new_prop->next = target->np->deadprops;
>  			target->np->deadprops = new_prop;
>  		}
>  		ret = of_changeset_add_property(&ovcs->cset, target->np,
>  						new_prop);
> -	} else if (!of_prop_cmp(prop->name, "#address-cells")) {
> -		if (!of_prop_val_eq(prop, new_prop)) {
> -			pr_err("ERROR: changing value of #address-cells is not allowed in %pOF\n",
> -			       target->np);
> -			ret = -EINVAL;
> -		}
> -	} else if (!of_prop_cmp(prop->name, "#size-cells")) {
> -		if (!of_prop_val_eq(prop, new_prop)) {
> -			pr_err("ERROR: changing value of #size-cells is not allowed in %pOF\n",
> -			       target->np);
> -			ret = -EINVAL;
> -		}
>  	} else {
> -		check_for_non_overlay_node = true;
>  		ret = of_changeset_update_property(&ovcs->cset, target->np,
>  						   new_prop);
>  	}
>  
> -	if (check_for_non_overlay_node &&
> -	    !of_node_check_flag(target->np, OF_OVERLAY))
> +	if (!of_node_check_flag(target->np, OF_OVERLAY))
>  		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
>  		       target->np, new_prop->name);
>  
> 

Can you please check whether this patch fixes the memleak that you
found and fixed in "[PATCH 1/2] of: overlay: fix properties memory leak"?

Thanks,

Frank
