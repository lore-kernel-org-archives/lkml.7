Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CC5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F8C2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="B/o/gfHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfCVRnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:43:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39690 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfCVRnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:43:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id m13so1958570lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IMZyRvjTUJeXcyRJIt9BLHdj0+q+YadZU/4CnekWVCQ=;
        b=B/o/gfHZWjYbWJHqRjEbFyWu0kUzjrPb1foz3cnBpLuUV4kIaDcbO5xS5GqEKi/VOl
         Uz8ITaf57VJsn16Fgs3mQePwmdBOzqg4gk4/lM96R0RMljGjDIXfxUXwV/EMijjorCyD
         xdVTWG4ulpRgm9+tBE/8/F2Mk0fb2dFBLYSo45BViQTfWgfASEKiYtdaFgD7b2PfmRto
         Kg0ZHoTBN5Lk7rN/VSIY6YlvHwvWblJ0X1afKiY4YW5paMY+j6H+NPMZSHx0Z3GHFMED
         81y3yzJJhoTSkljy1EJUfaUzIv9G0oselYFTksBXuxKqjbAnZ9/ACD5LMSyHgE7eQZoF
         jlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IMZyRvjTUJeXcyRJIt9BLHdj0+q+YadZU/4CnekWVCQ=;
        b=L2nNgorrk/kPw0ab0F7oronQof+75Tt3/hDh3RsBPdo//Uw9KiclUwhDHSmSmC41Se
         qfT+1Sa0iirb22V9XrGgfk3IIZXu82eqq0msxK+kexRUlEtP9cL6gB+9v29m8BQPH5ni
         vOkodGe88q1/McMroov/KjAWub8Qxpy88B3/KV7/JXSt6YwXP4qqdmPec1qDxCd561st
         hDArt4f4uYR92hhH6Sm6P4igswBzsdAQ3LCXVCyEiNJiPzpP8jwwEDV45Iq4WHJVHbmu
         aJGkmIOPvLt/pbsxMmRbI0PzRIPi95j+63HoD5jgffEPeSAnJVu4KUegaGUrWy33FLED
         9/jQ==
X-Gm-Message-State: APjAAAVaOORO95rVRd4Fl6bBUfFpDsobXWA1F067KrBd4Nn4KB3cI+vG
        BYhnI+Rj8yn7xYqUSbfnm5IFDQ==
X-Google-Smtp-Source: APXvYqwGlmAiwpa2Tm4ZwX4ZGEN3Y1vnHzePPZ+l3htJJ6q6Zx2yMn4/w7K5SCWXmi0/5KAihX3iwg==
X-Received: by 2002:ac2:50d8:: with SMTP id h24mr5738535lfm.7.1553276610764;
        Fri, 22 Mar 2019 10:43:30 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.92])
        by smtp.gmail.com with ESMTPSA id l12sm1797539lfc.61.2019.03.22.10.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 10:43:29 -0700 (PDT)
Subject: Re: [PATCH v8 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1548658158-5460-1-git-send-email-masonccyang@mxic.com.tw>
 <1548658158-5460-2-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <75c4642b-536e-f596-158d-387a63a5f6c5@cogentembedded.com>
Date:   Fri, 22 Mar 2019 20:43:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1548658158-5460-2-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 01/28/2019 09:49 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

   I've just found an error due to which my flash couldn't be read.

[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..ea12017
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,804 @@
[...]
> +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
> +					const struct spi_mem_op *op,
> +					u64 *offs, size_t *len)
> +{
> +	struct rpc_spi *rpc = spi_controller_get_devdata(spi->controller);

> +	if (op->dummy.nbytes) {
> +		rpc->smenr |= RPC_SMENR_DME;
> +		rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes);

   SMDMCR.DMCYC is in bits -- you forgot to multiply by 8.

> +		rpc->totalxferlen += op->dummy.nbytes;
> +	}[...]
> +static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
> +				   struct spi_message *msg)
> +{
> +	struct spi_transfer *t, xfer[4] = { };
> +	u32 i, xfercnt, xferpos = 0;
[...]
> +	if (xfercnt > 3 && xfer[2].len && xfer[2].tx_buf) {
> +		rpc->smenr |= RPC_SMENR_DME;
> +		rpc->dummy = RPC_SMDMCR_DMCYC(xfer[2].len);

    Here as well, I guess.

[...]

MBR, Sergei
