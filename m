Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1637EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D794320850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9td7hl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfCVBhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:37:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45154 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfCVBhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:37:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so299833pgk.12;
        Thu, 21 Mar 2019 18:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=toku51UzmiPi3rR2sl+L6YkS0YZjwvzzrs/Nn4j4q44=;
        b=L9td7hl5L1qW5lVntAySMEYX5mxSraAqac7HcyageH46/VRbAL1rIlfMPZCYJ2M4wz
         4yyyZYw+kI30r5zYaJqkFLHxe4T6gRRUQMzfoT5ew0mJYVvsuNAZBeNCLtUpJ989cOOc
         4wqdzoWBUAj57UYh7h4YJx2Uwo3HxJMllQYdnb4+53coMkzUS7VCW7MiPWpJqaPQ8rzy
         fkifH8w/woZrpnnDXYGaAKyJidRiRqLV1k/xlMfksEpSI6N+A7eXDKoawW8kKzrNcJ6B
         XljN5gNrM1puGSXWPRXVUwzhRqE7KEFEyf/mMG9yMmkv8NOLEPYoEDvmbK9oQPDlgwTi
         r0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=toku51UzmiPi3rR2sl+L6YkS0YZjwvzzrs/Nn4j4q44=;
        b=PbBpjFk2VYG6Q420sv7Eb1sIFsfa+LiJGdYiXYYBeaPiQ0FWww5CroSfLgJACoZBCg
         LbY6vvdMScSw4FJKoaUeB9pXZmN/EDYk7YjOH/C7IbXHfBDZRBMjsbe6Wi7CotwCwzUB
         WMffGnDcfjnZ2P4lihtpidHPTfLP8j9OeparTW0M/HNVdwV9RYIrxIwACNuJmdyBExsH
         dhabyz8P54BedpsdV+G5nP1twioDDZLkqZiL/Ua00By7hogZBeWx1mwUG2LVjzjMnPNq
         kC7OERDMcj+EMr/bBTIVyDb/0Oa2/FvCgdugRamJWOYaAF0UG5rNCqePAAJVnbPCaqDO
         VhNQ==
X-Gm-Message-State: APjAAAVc7uZv7MVW/FpYyFIFILth8/urWS+JVB//WLc0x3CtI0WIObrF
        DXklmjl1d6aPLxw/MiOgqSE=
X-Google-Smtp-Source: APXvYqzHuN92YkvCkkyL1xLV7V7kRSnb/6WyX3pw5kDI7I/a3RkFQObzAlchEn8DBPV7jqy/hXrRCg==
X-Received: by 2002:a63:bd51:: with SMTP id d17mr6315409pgp.117.1553218657148;
        Thu, 21 Mar 2019 18:37:37 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id j14sm7718866pfe.12.2019.03.21.18.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 18:37:36 -0700 (PDT)
Subject: Re: [PATCH] of: use correct function prototype for
 of_overlay_fdt_apply()
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        robh+dt@kernel.org
Cc:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190322002342.24831-1-chris.packham@alliedtelesis.co.nz>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <57043d9a-97d0-1d12-4542-8755d5ef998d@gmail.com>
Date:   Thu, 21 Mar 2019 18:37:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322002342.24831-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/19 5:23 PM, Chris Packham wrote:
> When CONFIG_OF_OVERLAY is not enabled the fallback stub for
> of_overlay_fdt_apply() does not match the prototype for the case when
> CONFIG_OF_OVERLAY is enabled. Update the stub to use the correct
> function prototype.
> 
> Fixes: commit 39a751a4cb7e ("of: change overlay apply input data from unflattened to FDT")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  include/linux/of.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index e240992e5cb6..28797e1a9982 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1449,7 +1449,8 @@ int of_overlay_notifier_unregister(struct notifier_block *nb);
>  
>  #else
>  
> -static inline int of_overlay_fdt_apply(void *overlay_fdt, int *ovcs_id)
> +static inline int of_overlay_fdt_apply(void *overlay_fdt, u32 overlay_fdt_size,
> +				       int *ovcs_id)
>  {
>  	return -ENOTSUPP;
>  }
> 

Thanks!

Reviewed-by: Frank Rowand <frank.rowand@sony.com>
