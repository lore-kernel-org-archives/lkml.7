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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CCEC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1613206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WU+cjX6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfKUQz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:55:28 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:47061 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKUQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:55:28 -0500
Received: by mail-yw1-f66.google.com with SMTP id i2so1442338ywg.13;
        Thu, 21 Nov 2019 08:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wk5v7/X0jZcqwNwgZ9ExtYiD+9LZHDYkMo+MHCqNDlo=;
        b=WU+cjX6PryvO660Dp27hixmMkHdbCRIqjno76TmdHV7r6IuoyDmFaqhHZkTInoHYrF
         JpLn/zeD/HBavn8FzJbei5PE0ebQ8/QaFrPqWk966nVfzytXFqiatk8WQjirJBIIBBF6
         I+vpnXXPljS702Z9/vKwWn0us+Rpw6sRRWaob7JDTzLVrLmMuir6hPpq4ksvufVzEmlv
         7gLpToB17jQ3v/8pCqWOnCyZO5vT+ssAp1qvCGS8c6MH15WvBJRr4Yu6qlHHbDeUKIcH
         hrmsBEwMGpcGbHgJAtLaWrFhEOB6xLYcFgS+qWkgnO3OsTbagyO7R4cUYOIIPV2bYD/F
         FGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wk5v7/X0jZcqwNwgZ9ExtYiD+9LZHDYkMo+MHCqNDlo=;
        b=C3pUs9b8cG8JMGuWbnGxLI7fzuz2fOd8iDZ+0O17Oc2KCVG0kam1JspMB+GaOI+dN7
         FO54XdsJ1SY+1Q7bpCfbbG0j1UcA/kHywFI/Vdqgqlc30t3A77TzJsfSuBw6WNVHlNsr
         q5hiEqRn+QVBOcdXMOf0WWqIC8+lABvDzOygni1EBh+sLVrG7refLngNCMNdA2wX6Q0E
         JaDDAO8EdsK9AcoL+tO+Q5lhFrqjr+7BMvUUmVy6ApMgt+MgFn8actav7W2ot5nN4Hym
         0rJpcxxIuw4x4EyPJH8/87SZTQzAz6DWbL5cVC2tA5Hct7/JqtCM+tmXdtLC/XY+sgV5
         zDqA==
X-Gm-Message-State: APjAAAXtG8NqT2ig54JARDIftErxVdFoJ7i5jUNj57IJyCCWyEtx6MNu
        uM94yWv8y5ERb4/kwhb2qxE=
X-Google-Smtp-Source: APXvYqytyN+7LvfvE4zxeWlee1iRxvOUrdscD+DO7/bs+Xm4INPKtvYH7u58ANm9NzkmLmS6xPUJYw==
X-Received: by 2002:a0d:d204:: with SMTP id u4mr5836603ywd.199.1574355327542;
        Thu, 21 Nov 2019 08:55:27 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id z14sm962522ywj.74.2019.11.21.08.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 08:55:27 -0800 (PST)
Subject: Re: [PATCH 1/2] of: overlay: fix properties memory leak
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        pantelis.antoniou@konsulko.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
References: <20191118132809.30127-1-vincent.whitchurch@axis.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <53898749-ab88-19c3-77e7-6c81a8b0e8ee@gmail.com>
Date:   Thu, 21 Nov 2019 10:55:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118132809.30127-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 11/18/19 7:28 AM, Vincent Whitchurch wrote:
> No changeset entries are created for #address-cells and #size-cells
> properties, but the duplicated properies are never freed.  This results
> in a memory leak which is detected by kmemleak:
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
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/of/overlay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index c423e94baf0f..5f8869e2a8b3 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -360,7 +360,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>  		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
>  		       target->np, new_prop->name);
>  
> -	if (ret) {
> +	if (ret || !check_for_non_overlay_node) {
>  		kfree(new_prop->name);
>  		kfree(new_prop->value);
>  		kfree(new_prop);
> 

Thanks for finding and proposing a fix for the memory leak.

The proposed patch conveniently uses check_for_non_overlay_node
which leads to a nice small patch.  But ends up adding an
additional hidden meaning to the variable, resulting in more
fragile code.

I will propose a different solution and ask you to test it
to make sure it also solves the memory leak.

-Frank
