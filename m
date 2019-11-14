Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A56CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A882071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EZv+Wg45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKNR6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:58:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43011 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfKNR6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:58:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id a18so2946803plm.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 09:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xtjRZ4N/dj5TnunKPr1ub8m5J6PxcC016TNe/Bh9Z1k=;
        b=EZv+Wg45gytZ+SSGZ2MxGiIv9faCbFgA5DBq38RREWXPPOYxT+1YkOhGIBThM1zv2s
         TR/ceK4mmS3CtlaSEFdD51xZIXTwPfo9bq+cgqr+TzMCuaniV2rwiM15zbih8G8djOBO
         1qkqwFzqGT11ywk/B3nSxFkc47m8FodSOHUBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xtjRZ4N/dj5TnunKPr1ub8m5J6PxcC016TNe/Bh9Z1k=;
        b=nwp98FyjFWczNiRDOK0c1FBjf+Jmlw50s6AUuIz6CjxX2SAcyIMYb9+jGh/uTWX/B1
         bTao5uFCLcBkkazpgZbm6HMqa64yxRYJQSqHQr4qen2/PHAe1me7toHwHMwOwaTNg6V0
         2XfdDYmRnYz0B6GBGp671SveJzwtnd2yPuxADvQnbKAeE3PMgSujwFiGoVM6+iZr18rD
         kjvFabNOVQfqvjUmscaa0AlZsd/TE/3wGLs2eoTDvSl2YRskia+LTxT2y03Cde7yVADJ
         HTIq9oCyoSrFesgnAiC2x3V6STeLHjGthRiGKJNAQi1c2IcGi9KmJVxOYXA73HpxDGXe
         u2gA==
X-Gm-Message-State: APjAAAU+QI0ie0G5Q41l3UPZ82kufkbHp6CULfN2HMOFn8y1cdaetAoc
        Bcw5KV6QYZEIEg5asI93DjXWUQ==
X-Google-Smtp-Source: APXvYqzLuxA1NXzpc+PtqUC7hvdD8QB6bq/rvafa9MU7QspCSAYdGw0pn8iQHHA0/Bk6SqzTzc8SsQ==
X-Received: by 2002:a17:902:d917:: with SMTP id c23mr10706341plz.199.1573754318761;
        Thu, 14 Nov 2019 09:58:38 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 13sm6901904pgu.53.2019.11.14.09.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 09:58:37 -0800 (PST)
Date:   Thu, 14 Nov 2019 09:58:36 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v4 4/4] dt-bindings: net: broadcom-bluetooth: Add pcm
 config
Message-ID: <20191114175836.GI27773@google.com>
References: <20191112230944.48716-1-abhishekpandit@chromium.org>
 <20191112230944.48716-5-abhishekpandit@chromium.org>
 <0642BE4E-D3C7-48B3-9893-11828EAFA7EF@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0642BE4E-D3C7-48B3-9893-11828EAFA7EF@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 01:21:06AM +0100, Marcel Holtmann wrote:
> Hi Abhishek,
> 
> > Add documentation for pcm parameters.
> > 
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > 
> > ---
> > 
> > Changes in v4:
> > - Fix incorrect function name in hci_bcm
> > 
> > Changes in v3:
> > - Change disallow baudrate setting to return -EBUSY if called before
> >  ready. bcm_proto is no longer modified and is back to being const.
> > - Changed btbcm_set_pcm_params to btbcm_set_pcm_int_params
> > - Changed brcm,sco-routing to brcm,bt-sco-routing
> > 
> > Changes in v2:
> > - Use match data to disallow baudrate setting
> > - Parse pcm parameters by name instead of as a byte string
> > - Fix prefix for dt-bindings commit
> > 
> > .../devicetree/bindings/net/broadcom-bluetooth.txt    | 11 +++++++++++
> > 1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > index c749dc297624..42fb2fa8143d 100644
> > --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > @@ -29,6 +29,11 @@ Optional properties:
> >    - "lpo": external low power 32.768 kHz clock
> >  - vbat-supply: phandle to regulator supply for VBAT
> >  - vddio-supply: phandle to regulator supply for VDDIO
> > + - brcm,bt-sco-routing: 0-3 (PCM, Transport, Codec, I2S)
> > + - brcm,pcm-interface-rate: 0-4 (128KBps, 256KBps, 512KBps, 1024KBps, 2048KBps)
> > + - brcm,pcm-frame-type: 0-1 (short, long)
> > + - brcm,pcm-sync-mode: 0-1 (slave, master)
> > + - brcm,pcm-clock-mode: 0-1 (slave, master)
> 
> I think that all of them need to start with brcm,bt- prefix since it is rather Bluetooth specific.
> 
> > 
> > 
> > Example:
> > @@ -40,5 +45,11 @@ Example:
> >        bluetooth {
> >                compatible = "brcm,bcm43438-bt";
> >                max-speed = <921600>;
> > +
> > +               brcm,bt-sco-routing = [01];
> > +               brcm,pcm-interface-rate = [02];
> > +               brcm,pcm-frame-type = [00];
> > +               brcm,pcm-sync-mode = [01];
> > +               brcm,pcm-clock-mode = [01];
> >        };
> 
> My personal taste would be to add a comment after each entry that gives the human readable setting.

I'd suggest to define constants in include/dt-bindings/bluetooth/brcm.h
and use them instead of literals, with this we wouldn't rely on (optional)
comments to make the configuration human readable.
