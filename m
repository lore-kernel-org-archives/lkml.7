Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB03C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB91218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMIvnfGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfLTOBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:01:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38269 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfLTOBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:01:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so5269490pfc.5;
        Fri, 20 Dec 2019 06:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rmndQSfUhMKSBa59IXjCNwpke6ypkvvZSBqhrxOoIlc=;
        b=mMIvnfGxPcxXOQYw82e8IgWhFuiBJZVDycjqJ+2ned43kbYM6h9RQ9QZVST2pHCjjg
         UPJqugcgS8+nxXUALrxOka7E31Wf7B3JYGLhj8iKEIt9WHP4uUdi8M+lfNPjPauTNWtX
         PSpjVQ13hX3rCIWTFrEI7fyUAaynAtIhfMuAE5kxAdWp9ki+4xcgBV9k+c2vlTlT7RwY
         2RH+nu1L7lG91YW2oIxDtoKn5gjbc42yZvjsuNoRVYDTO/jxlzfuQP82TU5O2a22ZsXS
         SdhqUcH6Den3jzd8CBYtYkcI0YJ+qrLdFKJTk74bv7agGOsBXe7bQHOFJppfdn21lwQF
         DawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rmndQSfUhMKSBa59IXjCNwpke6ypkvvZSBqhrxOoIlc=;
        b=QeYRnusUqLF/1BvAZFFwyayov3FOOpWx9fNlhcXrVjjiRomxeNRVdUpeW3Fd6yyZGk
         llgL34x5gAcjqeE67e3tSkpWDAEMbf5hFUjf1fnM22w9KWpS8fqHnwGT2oNk0qbX1S/P
         ecwzr2ceZyWlbJTtqJugae6jMxfHu94CiEI2faEl8XfwOIQv2vZAwRmsOuL60BKELwEP
         5hvMQSEDtqRf0+ntRz94+gS1tWyafNqz1oXszQB5f6EN3zthjvzI8WBVHcpCxnPdxhGf
         Tyx/G+m8+kUOhOaCb2/+BLmVOOEADJaGSYbTs1Ld/dmC3Jz0ef7AkIQKbjhVWpj8rX/z
         9GIQ==
X-Gm-Message-State: APjAAAWscFAjsyBPypyk3JQPXUZMfuyjw1wRvu+jJEnkLBvyoXvQpUbp
        +qOnWovWyDkptf9y+QzzxRs=
X-Google-Smtp-Source: APXvYqyGNCL+TUlRRWKdJBjJUx9wn9CACPxu1G1DFW+3XWx1Vp9nzc9h0hNq1YskXAKoj64jbgg9DQ==
X-Received: by 2002:a63:5718:: with SMTP id l24mr14821738pgb.136.1576850468755;
        Fri, 20 Dec 2019 06:01:08 -0800 (PST)
Received: from smtp.gmail.com ([2804:d57:1704:ad00:f7ce:4bf3:7351:3dea])
        by smtp.gmail.com with ESMTPSA id 133sm12956456pfy.14.2019.12.20.06.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 06:01:08 -0800 (PST)
Date:   Fri, 20 Dec 2019 11:01:02 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Jonathan.Cameron@huawei.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: ad7192: Fix DTC error in reg schema
Message-ID: <20191220140102.wurhkwuhjcthply4@smtp.gmail.com>
References: <20191212134037.1049-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212134037.1049-1-benjamin.gaignard@st.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12, Benjamin Gaignard wrote:
> Add minimum field to be compliant to json-schema
> 
> Fixes: d898f9ac542f9 ("dt-bindings: iio: adc: Add dt-schema for AD7292")
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> index b68be3aaf587..d804a8a78bea 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> @@ -53,6 +53,7 @@ patternProperties:
>          description: |
>            The channel number. It can have up to 8 channels numbered from 0 to 7.
>          items:
> +          minimum: 0
>            maximum: 7
>  
>        diff-channels:
> -- 
> 2.15.0
> 

Hi Benjamin,

Sorry for the late reply.

This issue has already been tackled down. I think it should be in
mainline now.
Anyway, thanks for your contribution. Nice holiday and a happy new year.


Thanks,

Marcelo
