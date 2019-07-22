Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10090C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BE4218BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="QldmT9XY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfGVUY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 16:24:28 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44329 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfGVUY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:24:27 -0400
Received: by mail-yb1-f195.google.com with SMTP id a14so15401301ybm.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IbSm7aUPCPODZOR8QIAKq+60N3QfY43kv2h3mhmy9JI=;
        b=QldmT9XYK72SQ7U5ZxUvFimH+3fpq2KpaUvK4DEG6/EWgWERMqrrT4+MiCC0IWH3od
         j4KowEjinazaD1qQm76hTIXKFED8g/eZLUSCIYV1i1IfC6lJ/Vb3HHnebc25GjVEpTC9
         9FfCuNm1aCAuWjvqSIk63VhYZVBtTf6Yq0ybK9NiF5EdpahXmdtOqj2lAiFTOr2KEmj+
         pcXQdynuGP63E8J3loL6eM3KW7YYvjQ6/tpG2QY4uobV8JM9JYIDTs9NwAPtKUj7Ag+C
         XPKiv/+QqcmXBDFTXdetWaxlTb3p1uW5kGS7ilfnH94zyq3uWUB4eObAFfqOgQra6SVG
         aHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IbSm7aUPCPODZOR8QIAKq+60N3QfY43kv2h3mhmy9JI=;
        b=RQ8lqz4nnJvJYP5Mb+DMBFkh/Ly4dw4Itu+p3+32f3q98B9LvZBa8H1uMwGIC7dPs9
         G+So+YvtBk69r2V2Jcj/O7+hC25HhLr3MHBuhurh1x5KfVcJMjL1Uz5ZJ5HIsVK2wWTB
         T6bec9yBkHLj1/E4heJoRjUgykBAT/m2UV1cG+w/7dwooT8E/od7K9dbeuzXlyODKqtx
         AbzUQNqLcR6ewi7qw7gvmAeX5aq3k1Cpj+kBDHBLVYiOh4H4Svn8AxiBicFDWmnYxJu8
         lNzIf966wFL6HWf2boF7Hik+916LsuFoHyRgaZMaiDPY/8ra+YSwi/FkRDTi1KUsNF1S
         NjiA==
X-Gm-Message-State: APjAAAXg4H5gY1pNqITbuaIYif7w4pJyvlAVCHkOHtAq0yeHxSeRjgpf
        CdA0rMkc7dN1sekxE3N64hHfgQ==
X-Google-Smtp-Source: APXvYqyiLrWQvLw3OHqzVi7sTTnhZapQbW476w12mH0kcbo7VOE8BPKT9pASdcod3zGG35cHMYtwVA==
X-Received: by 2002:a05:6902:508:: with SMTP id x8mr47454720ybs.406.1563827066965;
        Mon, 22 Jul 2019 13:24:26 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id k126sm9433394ywf.36.2019.07.22.13.24.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 13:24:26 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:24:26 -0400
From:   Sean Paul <sean@poorly.run>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Douglas Anderson <dianders@chromium.org>,
        Adam Jackson <ajax@redhat.com>
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi: Refuse DDC/CI transfers on the
 internal I2C controller
Message-ID: <20190722202426.GL104440@art_vandelay>
References: <20190722181945.244395-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722181945.244395-1-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:19:45AM -0700, Matthias Kaehlcke wrote:
> The DDC/CI protocol involves sending a multi-byte request to the
> display via I2C, which is typically followed by a multi-byte
> response. The internal I2C controller only allows single byte
> reads/writes or reads of 8 sequential bytes, hence DDC/CI is not
> supported when the internal I2C controller is used. The I2C

This is very likely a stupid question, but I didn't see an answer for it, so
I'll just ask :)

If the controller supports xfers of 8 bytes and 1 bytes, could you just split
up any of these transactions into len/8+len%8 transactions?

Sean

> transfers complete without errors, however the data in the response
> is garbage. Abort transfers to/from slave address 0x37 (DDC) with
> -EOPNOTSUPP, to make it evident that the communication is failing.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - changed DDC_I2C_ADDR to DDC_CI_ADDR
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 045b1b13fd0e..28933629f3c7 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -35,6 +35,7 @@
>  
>  #include <media/cec-notifier.h>
>  
> +#define DDC_CI_ADDR		0x37
>  #define DDC_SEGMENT_ADDR	0x30
>  
>  #define HDMI_EDID_LEN		512
> @@ -322,6 +323,13 @@ static int dw_hdmi_i2c_xfer(struct i2c_adapter *adap,
>  	u8 addr = msgs[0].addr;
>  	int i, ret = 0;
>  
> +	if (addr == DDC_CI_ADDR)
> +		/*
> +		 * The internal I2C controller does not support the multi-byte
> +		 * read and write operations needed for DDC/CI.
> +		 */
> +		return -EOPNOTSUPP;
> +
>  	dev_dbg(hdmi->dev, "xfer: num: %d, addr: %#x\n", num, addr);
>  
>  	for (i = 0; i < num; i++) {
> -- 
> 2.22.0.657.g960e92d24f-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
