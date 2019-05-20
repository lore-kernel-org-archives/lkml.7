Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B5DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0C420675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gtvzu97z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392798AbfETRRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:17:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37261 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392787AbfETRRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:17:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id n27so4496020pgm.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kLaahNyJDteVyYuPA7Hla97IH5sQOygePiHnSOoUkeI=;
        b=Gtvzu97z445O6uGMv89N2dLIETQ6JHu7Eiq7PzToKyLQWKd6wkhHcrBk9W92NMFlA4
         kaOWpbZQVcmdUezlkfmTeOOWYhPmSdJcghDhT5g52EXJpVKuTnSiN4AM72bigV+4lGml
         QHytfAYDR1ehxN+QQLnLAqEycy6gthhkkXmWO6cF3rC5S/VtffoEH5eGJqMfh2Bf2bgm
         TxbSb//JuVfke9SWMtaeFOH4sxXrEgmw4LsnRjOUJ+5vELTlwrGUy4UDjWUysfMvuPFu
         PUYwNuunDIRwfF7jiPhjSxy/BaKYD9GTZr91pPrbmNj0QnJKukztFzH2vh7Btx+L8TGR
         iK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kLaahNyJDteVyYuPA7Hla97IH5sQOygePiHnSOoUkeI=;
        b=rLPCUgxs6+r1KH0/FobrBBIJTCvoy7jkNU+yZ7iap4Q7iwTzrDEtLaxIjPy3ukPgfh
         cnVuh1ZUdCIuC81MXbCW0G1TaCCt+IiuhLPI0jeKMtey+bX92v0wFjbVbrjjR8HN1uXt
         3Np67zipEmAgL7Mpd32c9xurry/dN/cvR5YJEBhKLElkpB08RSofrjw0irl9MQp+4X1O
         Pk74QoWG/A0PYsUTzIHKdO5bmexZ0hTt6SXTlBOpJ5x4dZz5u21wb/9ZqajZPo0upSw4
         PY+GurSaZYDLvjRBXjkQN3GJBzbilhZDbBTTHWZvh8fir2wp4DvOwqvAFEvVooaA1C6c
         6WxA==
X-Gm-Message-State: APjAAAX1JTi1DdCS2rKSAUED6FEp2peePJl3m61DsARHAPPWgFuh5NpI
        /1dRU5SJMHnHxTEnA/uXqhJ6YQ==
X-Google-Smtp-Source: APXvYqzruiPOXwGzgF8V1G8Uxb9II5ATN51r8f8i36ba81jTt8MDQUaa04iy6oDfh4Yo19Y5yJ412g==
X-Received: by 2002:a62:75d8:: with SMTP id q207mr49266275pfc.35.1558372649589;
        Mon, 20 May 2019 10:17:29 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t25sm30364229pfq.91.2019.05.20.10.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 10:17:28 -0700 (PDT)
Date:   Mon, 20 May 2019 10:17:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     arnd@arndb.de, subashab@codeaurora.org, david.brown@linaro.org,
        agross@kernel.org, davem@davemloft.net,
        ilias.apalodimas@linaro.org, cpratapa@codeaurora.org,
        syadagir@codeaurora.org, evgreen@chromium.org, benchan@google.com,
        ejcaruso@google.com, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] net: qualcomm: rmnet: mark endianness of struct
 rmnet_map_dl_csum_trailer fields
Message-ID: <20190520171755.GV2085@tuxbook-pro>
References: <20190520135354.18628-1-elder@linaro.org>
 <20190520135354.18628-8-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520135354.18628-8-elder@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20 May 06:53 PDT 2019, Alex Elder wrote:

> Two 16-bit fields (csum_start_offset and csum_length) in the
> rmnet_map_dl_csum_trailer structure are currently defined to have
> type u16.  But they are in fact big endian values, so should be
> properly represented as __be16 values.
> 
> No existing code actually references these fields (they're ignored by
> rmnet_map_ipv4_dl_csum_trailer() and rmnet_map_ipv6_dl_csum_trailer()).
> Changing their type therefore causes no harm, so just fix them.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
> index fb1cdb4ec41f..775b98d34e94 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
> @@ -52,8 +52,8 @@ struct rmnet_map_header {
>  struct rmnet_map_dl_csum_trailer {
>  	u8  reserved1;
>  	u8  flags;		/* RMNET_MAP_DL_* */
> -	u16 csum_start_offset;
> -	u16 csum_length;
> +	__be16 csum_start_offset;
> +	__be16 csum_length;
>  	__be16 csum_value;
>  } __aligned(1);
>  
> -- 
> 2.20.1
> 
