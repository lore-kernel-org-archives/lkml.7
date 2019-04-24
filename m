Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A10C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12810214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy+OhRkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfDXWwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:52:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41579 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfDXWwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:52:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so10076477pfd.8;
        Wed, 24 Apr 2019 15:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=f2TB4C5yEGkgZUfkue71jvwzczjS2hO+A5aSMxqeLl0=;
        b=gy+OhRkPyYQ4iInnymOmHXBpIXT6DY49ROH5stFaq7QnMulJXkegtTtKy4/vd2FWMg
         0jub25IFxEP9Wx4iZkaYmYEpBJt6KbGo9s3CjdD+Mom4pL0D4x4WV7QnI7gfP0cdak+d
         x7F/cWWm5Zd9VFG0wF2iXpuDIV8bDDr+x8oyQvpsCq12gQmhVJf7bNMJgFXuWwEFBC4h
         7E5raRvtmFfr2tvAavZ2qe7oIxBJhBJOQb4YiFSZ+hWrgb4+xREfIZE9TAhtiVawIrlg
         jQMytEu9Ohj0f841p9lBVa2nJCyPVYYBuId3TB+jnOWj3d/dKL0Lp23CQbp34OLCwufW
         inHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f2TB4C5yEGkgZUfkue71jvwzczjS2hO+A5aSMxqeLl0=;
        b=GW+31KkQ4Yijut6gogt+7YMcrHQtDSREa8UYJssnSqKpC3ouncP4ZoIFtAu0aeX3gf
         HkZBScaVqWkGmueAGSodKILsNcAilw5FEenfPd6jFVUSpzM7nXE799fN1UFYoTZFj2Mj
         pzKq+6UIufsCc1MfXN1FBK3Gb07uVPY23Bie5NPCTnjkLAYeKog99xjBEEkUOJitD65i
         rOxh1z7AoNQFSlSqgPVGhDYmtZHLP+wuWczKUSrDrQAJxFZgjNxcTzyD521/0txTZ7Ew
         E5A8tbkMn6HRnVhEUu3zNvPIJXig+GZqMBNTyBaE2jiqFhiSesjBke8ExNFMOqukvFCo
         Q43Q==
X-Gm-Message-State: APjAAAVU99ADp4G9w9yzT7h3XS8k7f03wucKJp0tf2P1ajOl3xkNq9T7
        y6O629RYhNEKU5mL4yVEcOo=
X-Google-Smtp-Source: APXvYqyGsMnmj4NS0HgKBb2PcdqFJZUM25U2zIvcZ+XIKvTydOaANKOGAtA/35HW/cZ1VBI5LWDH4A==
X-Received: by 2002:a63:10c:: with SMTP id 12mr34432847pgb.276.1556146358163;
        Wed, 24 Apr 2019 15:52:38 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id q5sm29521529pff.97.2019.04.24.15.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 15:52:37 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:52:35 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     rafael.j.wysocki@intel.com, robh+dt@kernel.org,
        mark.rutland@arm.com, hadess@hadess.net, frowand.list@gmail.com,
        m.felsch@pengutronix.de, agx@sigxcpu.org, yannick.fertre@st.com,
        arnd@arndb.de, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, broonie@kernel.org
Subject: Re: [PATCH 3/5] input: edt-ft5x06 - Call devm_of_device_links_add()
 to create links
Message-ID: <20190424225235.GA225055@dtor-ws>
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
 <20190424101913.1534-4-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190424101913.1534-4-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Wed, Apr 24, 2019 at 12:19:11PM +0200, Benjamin Gaignard wrote:
> From: Yannick FertrÃ© <yannick.fertre@st.com>
> 
> Add a call to devm_of_device_links_add() to create links with suppliers
> at probe time.
> 
> Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 702bfda7ee77..ac9f7e85efb0 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -1167,6 +1167,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, tsdata);
>  
> +	devm_of_device_links_add(&client->dev);
> +

This seems pretty generic action and I believe it should be done in
generic code, either bus (i2c, spi, etc), or in device core.

Thanks.

-- 
Dmitry
