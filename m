Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D23FC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C343218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcU/Og0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfGDLLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 07:11:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40943 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbfGDLLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 07:11:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so6172098wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 04:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l8xOwRoeewzebcQAt1yKxsHLrRV9J9YjppTfdC6bYO4=;
        b=AcU/Og0Im9zeCUoAjQfz6t1TPM7Mfh0ysWoMMrnoAxopui+jfwRP+8ITrmS17IrY1C
         KEs0UE42QQXFtM3Plib24n04BsaZx7YpdSdT+lXwkDmW5UXo5AVmjENp8T4Yk5L4W3qL
         ya3qtdkWWGhERgwew7vMxaZiQ0oib0yFn8XnrueuwqH8INdv94RXEj/zk8dU3Gtn4O0A
         6EwHajqBOaWPjJJmtSLrm8PZE5Ma9nIUkyig0AkkUrnFH46TF6oLK4F+36SuPCPJzrid
         vsMqp3WqEkNc7NWqF0JoS9TZcj/Wt9C7JFdlMtv8VS6Ms36Kj4I2IsGthBfqv69AJ3yx
         KAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l8xOwRoeewzebcQAt1yKxsHLrRV9J9YjppTfdC6bYO4=;
        b=bffMdWuWsV34vVU1JoQjba9wxp721DE/hcg690QRHiGCawOE50/eZ294oUfe4XFriq
         zF8F8VpcrCwWbQLM5dod0ZH5oCvZp958sVSbQTDgDkvljByL2eXCbn9RaMQjg+YtWJN/
         mrLwC91Kg7+q4+d6UcLKFUgfefwdLXpb5NMv+P3gJILmRlLAblzrGwIUNoK3F6qTzW7M
         SpVQjU6AHS8EVfioklecuV3Eccp7HXAJxASAnr/Hnp/60qgN7I6Opz/oBe/R3Ay3nFIA
         c9GJQ7KXFxtn+pvqKkr+3ggYxrGr0q4Y3cejY1xSDoNmgw+/GlCIAXjoJFS3Yps+xYaD
         D7Cg==
X-Gm-Message-State: APjAAAVnmbA2oDZk/YJNAuyIZmP9v2tnudOXHoFOkYruFgTsancFWbKN
        5fDFl0o8PRM2xfhFI01nLYdd1w==
X-Google-Smtp-Source: APXvYqwc3n6Z1DTK4DI0irtOTjnyQp+cY9JrkG89Fk1+0XQ7A/1JudehcvBrF5/bUdDdbNSumzT99A==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr32763692wrn.54.1562238673665;
        Thu, 04 Jul 2019 04:11:13 -0700 (PDT)
Received: from apalos (athedsl-428434.home.otenet.gr. [79.131.225.144])
        by smtp.gmail.com with ESMTPSA id r4sm4942586wrv.34.2019.07.04.04.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 04:11:12 -0700 (PDT)
Date:   Thu, 4 Jul 2019 14:11:09 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH net-next 3/3] net: stmmac: Introducing support for Page
 Pool
Message-ID: <20190704111109.GA12011@apalos>
References: <cover.1562149883.git.joabreu@synopsys.com>
 <1b254bb7fc6044c5e6e2fdd9e00088d1d13a808b.1562149883.git.joabreu@synopsys.com>
 <20190704120018.4523a119@carbon>
 <BN8PR12MB3266BC5322AADFAC49D9BAFAD3FA0@BN8PR12MB3266.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR12MB3266BC5322AADFAC49D9BAFAD3FA0@BN8PR12MB3266.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 10:13:37AM +0000, Jose Abreu wrote:
> From: Jesper Dangaard Brouer <brouer@redhat.com>
> 
> > The page_pool DMA mapping cannot be "kept" when page traveling into the
> > network stack attached to an SKB.  (Ilias and I have a long term plan[1]
> > to allow this, but you cannot do it ATM).
> 
> The reason I recycle the page is this previous call to:
> 
> 	skb_copy_to_linear_data()
> 
> So, technically, I'm syncing to CPU the page(s) and then memcpy to a 
> previously allocated SKB ... So it's safe to just recycle the mapping I 
> think.
> 
> Its kind of using bounce buffers and I do see performance gain in this 
> (I think the reason is because my setup uses swiotlb for DMA mapping).

Maybe. Have you tested this on big/small packets?
Can you do a test with 64b/128b and 1024b for example?
The memcpy might be cheap for the small sized packets (and cheaper than the dma
map/unmap)

> 
> Anyway, I'm open to some suggestions on how to improve this ...
> 
> > Also remember that the page_pool requires you driver to do the DMA-sync
> > operation.  I see a dma_sync_single_for_cpu(), but I didn't see a
> > dma_sync_single_for_device() (well, I noticed one getting removed).
> > (For some HW Ilias tells me that the dma_sync_single_for_device can be
> > elided, so maybe this can still be correct for you).
> 
> My HW just needs descriptors refilled which are in different coherent 
> region so I don't see any reason for dma_sync_single_for_device() ...
I am abit overloaded at the moment. I'll try to have a look at this and get back
to you

Cheers
/Ilias
