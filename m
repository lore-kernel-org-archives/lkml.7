Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FDEC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6952084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="QlNN6nnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfDIUHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:07:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37627 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfDIUHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:07:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id o19so13309521lfl.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Suw+of2KaJH2zATB+QZvfdbvIVGQDJppxQSWgUkDE3E=;
        b=QlNN6nnI7UO9A/eH6AbZCtnZ8P+46TBOb4KOzu1xkjAesFjq0bpLlHg+5cVN5YBOel
         T4RN8DjcMMPLpaaEG+jqSlugnz8xo+nRr/yS/F/YCstTEFpRaTydwoEhVK6vHepPog74
         g3XWIWdbbyxAssfbVbDFXsiWPgwAzbVd4Y6fczLXSiBK0wLmA+0T3T03JIiwiebYxDIJ
         Gq1tfijzh4NAf81Mmnnc2oidMkH+Rd7SjBR+4K9TRAdReNV+0MJDbruDebKdgAT0lexa
         u+YZ+7U5ZiOvQWPWGp/dgECR12ovRKRFL8CX3gQhH0sd4U8QHWoBVzss9M+I+qw6xFWf
         VQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Suw+of2KaJH2zATB+QZvfdbvIVGQDJppxQSWgUkDE3E=;
        b=EA3VEki5D8ochWxUTtFTj/BvsOnZ+q0HuBMCpiys/MzvBiLyB88Rz3vlILvYzIuvxA
         7FDEn+kcGxTsqeIghCk4fmwCDFmqm4znpOKlIYbrMHnDOk6jtmiM6YkYwzbZf+vbqHLb
         JmVnR36iH8ZqiuQFQswXeRqVYQy2WzlWbFKiVOWlGYyn2iGk4ZqgjUSLd0QeCwK5bo0o
         vZnQqE8C6Fpyw8nTXuHqquv1lzTW/dS7V5hiia7Ao6KkDmPYDa61622xsvP7QCkX93/J
         5W0e/2/ntEOeu9M7c2lfposPQge9bYRYJrqCF55TBwdMdTc7SY8299AV54IallRyM8tM
         g/Jw==
X-Gm-Message-State: APjAAAV3di9ORzjNW6XyjhKlVLYL09Ji7gfNgBru3McHzhGH9h4RZ7IG
        P/3IQfXNJQRN7FA3pFne1C+083ExPEk=
X-Google-Smtp-Source: APXvYqy46sotQ+yYiksstKg8POCSozd7nmydUG6NCTNYm9ZniUshigdqidWOHMXN1mVBeH4lMrDGbg==
X-Received: by 2002:ac2:4981:: with SMTP id f1mr984618lfl.67.1554840435469;
        Tue, 09 Apr 2019 13:07:15 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.87.214])
        by smtp.gmail.com with ESMTPSA id m28sm7419405lfc.54.2019.04.09.13.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 13:07:14 -0700 (PDT)
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, lee.jones@linaro.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <a2dc294f-f2a1-2469-1f44-db67f9b8cc10@cogentembedded.com>
Date:   Tue, 9 Apr 2019 23:07:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03/29/2019 11:20 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]

> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..037f273
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
[...]
[...]
> +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
> +					u64 offs, size_t len, const void *buf)
> +{
> +	struct rpc_spi *rpc =
> +			spi_controller_get_devdata(desc->mem->spi->controller);
> +	int ret;
> +
> +	if (offs + desc->info.offset + len > U32_MAX)
> +		return -EINVAL;
> +
> +	if (len > RPC_WBUF_SIZE)
> +		len = RPC_WBUF_SIZE;
> +
> +	ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
> +	if (ret)
> +		return ret;
> +
> +	rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
> +				    &desc->info.op_tmpl, &offs, &len);
> +
> +	regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, RPC_CMNCR_MD);
> +
> +	regmap_write(rpc->regmap, RPC_SMDRENR, 0);
> +
> +	regmap_update_bits(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_STRTIM(7) |
> +			   RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF,
> +			   RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF);
> +
> +	memcpy_toio(rpc->wbuf, buf, len);

   Wait, doesn't the manual say that the whole 256-byte buffer should be
filled?  I think that short chunks have to be written w/o WBUF (done, in fact,
by the HF driver).

> +
> +	regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
> +	regmap_write(rpc->regmap, RPC_SMADR, offs);
> +	regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
> +	regmap_write(rpc->regmap, RPC_SMCR, rpc->smcr | RPC_SMCR_SPIE);
> +	ret = wait_msg_xfer_end(rpc);
> +	if (ret)
> +		goto err_out;
> +
> +	regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RCF);
> +
> +	regmap_update_bits(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_STRTIM(7) |
> +			   RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF,
> +			   RPC_PHYCNT_STRTIM(6));
> +
> +	return len;
> +
> +err_out:
> +	return reset_control_reset(rpc->rstc);
> +}
[...]

MBR, Sergei
