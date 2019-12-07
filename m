Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5806FC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 12:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0BB2053B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 12:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytbBU3WG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfLGMCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 07:02:45 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44393 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfLGMCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 07:02:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so7243021lfa.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 04:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WCHftxVyszB2Wm7Mx9nwVJT5KwAoHKsTgufbG3ZvSE0=;
        b=ytbBU3WGJ0ZQjaUeGfDOGl3u4A5i8tgrxA0IewP25ocFnCwA1+3oTAyMV69GqIGkXL
         NGotBHGibozbI7wv7KFb5d9JbZux3LyufzbW1NznboOPwhfW7JdKsPCsvOURwBmZHK5h
         cV1xLr8ML2hyWZ4bsH8RrKbCOUaTWijO3wL+MJHl8bXJx35eFwBAC4uMgLcvVwz/TwkH
         WIhaRgR5+9aXLw3VJ1XU5hzQbE8F3/mwTTVkTFB+0EdX7PAp8BlG/47YvSLdEg7WS8TU
         EpLGTMe03jOVW9kRiKaFsGWNfu4UR5aoauIt1FIrN4d+U24nlQRb4G5+LFkvlcT/sqi7
         KXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WCHftxVyszB2Wm7Mx9nwVJT5KwAoHKsTgufbG3ZvSE0=;
        b=lMoI1//7QxceV3bcKNGfLaon8OYV8z44UoF6W8Dxkxvobs7QZiahGxMG1adqwtoFb+
         K6zkc3qA63mvNQI5MYQZQ0CgvLreBBehREuYqAl7M+RauLh3Z/RfN6FpE8xGHtAK54Ox
         TYyI7GNicAbfXLqM3H/xq9Z4P4VRfFdwOYbChGWE42sPctKkuGasHGZrfFx2nUZEqADA
         CALDGvc5xeoNAvfEm1qvSZiyZAVPN9cRZPXX8VDqInCnXz0jQ+alxS4x5lySBb3b4n1J
         1Ana1nrQ6c94sbqHlHOSjQkDFxpMr1W49RmCBIdmldKEPpZRxKmzwrJi1xIRy3HzgD9p
         zsSg==
X-Gm-Message-State: APjAAAXXwt3L2CTfrrm/1g6GCJxvM1TX9fX3lLrYcBLOAILbuPzkqygy
        Rc3m/0Bb2/Ce9tz5GiRlUZXTAw==
X-Google-Smtp-Source: APXvYqwOD/d+/DkXfUkGc3KyoTi79Bdx7cgJRxrgmIbl7SG4d3y3GDgiWqZvNP75SSDTmNeFCYLtmw==
X-Received: by 2002:ac2:4c2b:: with SMTP id u11mr10809676lfq.46.1575720162331;
        Sat, 07 Dec 2019 04:02:42 -0800 (PST)
Received: from khorivan (57-201-94-178.pool.ukrtel.net. [178.94.201.57])
        by smtp.gmail.com with ESMTPSA id p12sm2553575lfc.43.2019.12.07.04.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 04:02:41 -0800 (PST)
Date:   Sat, 7 Dec 2019 14:02:39 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        nsekhar@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: ti: davinci_cpdma: fix warning "device
 driver frees DMA memory with different size"
Message-ID: <20191207120238.GB2798@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        nsekhar@ti.com, linux-kernel@vger.kernel.org
References: <20191204165029.9264-1-grygorii.strashko@ti.com>
 <20191204.123718.1152659362924451799.davem@davemloft.net>
 <0c6b88b2-31b1-11f0-7baa-1ecd5f4b6644@ti.com>
 <20191207114419.GA2798@khorivan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191207114419.GA2798@khorivan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2019 at 01:44:20PM +0200, Ivan Khoronzhuk wrote:
>On Thu, Dec 05, 2019 at 12:48:46PM +0200, Grygorii Strashko wrote:
>>
>>
>>On 04/12/2019 22:37, David Miller wrote:
>>>From: Grygorii Strashko <grygorii.strashko@ti.com>
>>>Date: Wed, 4 Dec 2019 18:50:29 +0200
>>>
>>>>@@ -1018,7 +1018,7 @@ static int cpdma_chan_submit_si(struct submit_info *si)
>>>> 	struct cpdma_chan		*chan = si->chan;
>>>> 	struct cpdma_ctlr		*ctlr = chan->ctlr;
>>>> 	int				len = si->len;
>>>>-	int				swlen = len;
>>>>+	int				swlen;
>>>> 	struct cpdma_desc __iomem	*desc;
>>>> 	dma_addr_t			buffer;
>>>> 	u32				mode;
>>>>@@ -1040,6 +1040,7 @@ static int cpdma_chan_submit_si(struct submit_info *si)
>>>> 		chan->stats.runt_transmit_buff++;
>>>> 	}
>>>>+	swlen = len;
>>>> 	mode = CPDMA_DESC_OWNER | CPDMA_DESC_SOP | CPDMA_DESC_EOP;
>>>> 	cpdma_desc_to_port(chan, mode, si->directed);
>>>>-- 
>>>>2.17.1
>>>>
>>>
>>>Now there is no reason to keep a separate swlen variable.
>>>
>>>The integral value is always consumed as the length before the descriptor bits
>>>are added to it.
>>>
>>>Therefore you can just use 'len' everywhere in this function now.
>>>
>>
>>Sry, but seems i can't, at least i can't just drop swlen.
>>
>>Below in this function:
>>	writel_relaxed(0, &desc->hw_next);
>>	writel_relaxed(buffer, &desc->hw_buffer);
>>	writel_relaxed(len, &desc->hw_len);
>>	writel_relaxed(mode | len, &desc->hw_mode);
>>^^ here the "len" should be use
>>
>>	writel_relaxed((uintptr_t)si->token, &desc->sw_token);
>>	writel_relaxed(buffer, &desc->sw_buffer);
>>	writel_relaxed(swlen, &desc->sw_len);
>>^^ and here "len"|CPDMA_DMA_EXT_MAP if (si->data_dma) [1]
>>
>>	desc_read(desc, sw_len);
>>
>>so additional if statement has to be added at [1] if "swlen" is dropped
>>
>>-- 
>>Best regards,
>>grygorii
>
>Seems like yes,
>
>And the "swlen" can be avoided like this:
>
>--- a/drivers/net/ethernet/ti/davinci_cpdma.c
>+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
>@@ -1018,7 +1018,6 @@ static int cpdma_chan_submit_si(struct submit_info *si)
>       struct cpdma_chan               *chan = si->chan;
>       struct cpdma_ctlr               *ctlr = chan->ctlr;
>       int                             len = si->len;
>-       int                             swlen = len;
>       struct cpdma_desc __iomem       *desc;
>       dma_addr_t                      buffer;
>       u32                             mode;
>@@ -1046,7 +1045,7 @@ static int cpdma_chan_submit_si(struct submit_info *si)
>       if (si->data_dma) {
>               buffer = si->data_dma;
>               dma_sync_single_for_device(ctlr->dev, buffer, len, chan->dir);
>-               swlen |= CPDMA_DMA_EXT_MAP;
>+               writel_relaxed(len | CPDMA_DMA_EXT_MAP, &desc->sw_len);
>       } else {
>               buffer = dma_map_single(ctlr->dev, si->data_virt, len, chan->dir);
>               ret = dma_mapping_error(ctlr->dev, buffer);
>@@ -1054,6 +1053,7 @@ static int cpdma_chan_submit_si(struct submit_info *si)
>                       cpdma_desc_free(ctlr->pool, desc, 1);
>                       return -EINVAL;
>               }
>+               writel_relaxed(len, &desc->sw_len);
>       }
>
>       /* Relaxed IO accessors can be used here as there is read barrier
>@@ -1065,7 +1065,6 @@ static int cpdma_chan_submit_si(struct submit_info *si)
>       writel_relaxed(mode | len, &desc->hw_mode);
>       writel_relaxed((uintptr_t)si->token, &desc->sw_token);
>       writel_relaxed(buffer, &desc->sw_buffer);
>-       writel_relaxed(swlen, &desc->sw_len);
>       desc_read(desc, sw_len);
>
>       __cpdma_chan_submit(chan, desc);
>
>But not sure what is better.
>

Or like this:

--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -1018,7 +1018,6 @@ static int cpdma_chan_submit_si(struct submit_info *si)
        struct cpdma_chan               *chan = si->chan;
        struct cpdma_ctlr               *ctlr = chan->ctlr;
        int                             len = si->len;
-       int                             swlen = len;
        struct cpdma_desc __iomem       *desc;
        dma_addr_t                      buffer;
        u32                             mode;
@@ -1046,7 +1045,6 @@ static int cpdma_chan_submit_si(struct submit_info *si)
        if (si->data_dma) {
                buffer = si->data_dma;
                dma_sync_single_for_device(ctlr->dev, buffer, len, chan->dir);
-               swlen |= CPDMA_DMA_EXT_MAP;
        } else {
                buffer = dma_map_single(ctlr->dev, si->data_virt, len, chan->dir);
                ret = dma_mapping_error(ctlr->dev, buffer);
@@ -1065,7 +1063,7 @@ static int cpdma_chan_submit_si(struct submit_info *si)
        writel_relaxed(mode | len, &desc->hw_mode);
        writel_relaxed((uintptr_t)si->token, &desc->sw_token);
        writel_relaxed(buffer, &desc->sw_buffer);
-       writel_relaxed(swlen, &desc->sw_len);
+       writel_relaxed(si->data_dma ? len | CPDMA_DMA_EXT_MAP : len, &desc->sw_len);
        desc_read(desc, sw_len);

        __cpdma_chan_submit(chan, desc);

But it's branched twice then.

-- 
Regards,
Ivan Khoronzhuk
