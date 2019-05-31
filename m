Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D698C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF32F26BF7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jHgduwRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfEaQZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:25:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39437 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfEaQZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:25:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id p24so1924409lfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 09:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B2eNH84CQyPYJfD+FLgHh5s2OtUHwmqU+oP9mQ4knKk=;
        b=jHgduwRkv8cq1Iw2Qr/v0kqjbbSwS85egp1jh5ECiucFpPCkkltnaz8wHcZa1woNfO
         VRDx2MYbkRVbvQreCVhjyfeQvXFsufQl9qfUoHhtI5nYCQVQEbfH0GKTe+kHlgYR2N83
         gAYpMrIdwgy/Z8Nra3wGyOs3jQ64BGucjnQbKG8RJS5s+6ALlm3wmSkcdiQgz8BXWsP7
         OpYhlKp0px0qEAxe3MmN80PLihgE7Hb1pdLZe8DZeibaQHR5lsyT8lJstEhejHnTzgoW
         +Hw8m3RsBPuJmqjnGPp7YL19BVrclzTB297SFdZb0cq3aJrLwy/9RjbBVXZ2NlMKpijV
         sbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=B2eNH84CQyPYJfD+FLgHh5s2OtUHwmqU+oP9mQ4knKk=;
        b=h0vysnE5uhhwN9bc/RVRMzCqHJRE+ELvXUDa+w9rksnnXIOLkGeEn6HcrlLVZhRvPq
         XXOJjNcOOCdMeCUTuaqWlfKp+USxzhk9J79TcXquNRUcSkQUAcgMudpCKo/SifqHo//V
         1WKcz9nwXjOXQt5qXTj69GiCVunJTUK4+lwzu7CXwBqTsJbsxVmt5vMbzT0xC6ODztP8
         X6jGVpMxhq73g1WyH+H2S8xzyX1qyO7Jj57YBRCP9JD6SEpQZh3o2Ui6Qk1fcXMoHKKM
         +wvxVW9RsD6vs4OumPv84dZCYWOjecPrVS+2d1PsFjvA/+/B8ToUf2YGtU5GKrqQKOaq
         PeKw==
X-Gm-Message-State: APjAAAXAYKgSwFOlhBrPq1/UepQDV49E2e9gSwtzilePpKdrzR/PJNG9
        fhhWe3DsvGvsvoR+Sb1eEhiIvw==
X-Google-Smtp-Source: APXvYqwBkOdukVGASs4QfUwbU7bk+mmcvhcuTBnDOILOS97xASuRBkP4Wl3zxZi883DoZx+t624GXg==
X-Received: by 2002:a19:4b4c:: with SMTP id y73mr5969188lfa.129.1559319927370;
        Fri, 31 May 2019 09:25:27 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 16sm1126209lfy.21.2019.05.31.09.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 09:25:26 -0700 (PDT)
Date:   Fri, 31 May 2019 19:25:24 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net,
        ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com
Subject: Re: [PATCH v2 net-next 7/7] net: ethernet: ti: cpsw: add XDP support
Message-ID: <20190531162523.GA3694@khorivan>
Mail-Followup-To: Jesper Dangaard Brouer <brouer@redhat.com>,
        grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net,
        ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com
References: <20190530182039.4945-1-ivan.khoronzhuk@linaro.org>
 <20190530182039.4945-8-ivan.khoronzhuk@linaro.org>
 <20190531174643.4be8b27f@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190531174643.4be8b27f@carbon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 05:46:43PM +0200, Jesper Dangaard Brouer wrote:

Hi Jesper,

>
>Hi Ivan,
>
>From below code snippets, it looks like you only allocated 1 page_pool
>and sharing it with several RX-queues, as I don't have the full context
>and don't know this driver, I might be wrong?
>
>To be clear, a page_pool object is needed per RX-queue, as it is
>accessing a small RX page cache (which protected by NAPI/softirq).

There is one RX interrupt and one RX NAPI for all rx channels.

>
>On Thu, 30 May 2019 21:20:39 +0300
>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>
>> @@ -1404,6 +1711,14 @@ static int cpsw_ndo_open(struct net_device *ndev)
>>  			enable_irq(cpsw->irqs_table[0]);
>>  		}
>>
>> +		pool_size = cpdma_get_num_rx_descs(cpsw->dma);
>> +		cpsw->page_pool = cpsw_create_page_pool(cpsw, pool_size);
>> +		if (IS_ERR(cpsw->page_pool)) {
>> +			ret = PTR_ERR(cpsw->page_pool);
>> +			cpsw->page_pool = NULL;
>> +			goto err_cleanup;
>> +		}
>
>On Thu, 30 May 2019 21:20:39 +0300
>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>
>> @@ -675,10 +742,33 @@ int cpsw_set_ringparam(struct net_device *ndev,
>>  	if (cpsw->usage_count)
>>  		cpdma_chan_split_pool(cpsw->dma);
>>
>> +	for (i = 0; i < cpsw->data.slaves; i++) {
>> +		struct net_device *ndev = cpsw->slaves[i].ndev;
>> +
>> +		if (!(ndev && netif_running(ndev)))
>> +			continue;
>> +
>> +		cpsw_xdp_unreg_rxqs(netdev_priv(ndev));
>> +	}
>> +
>> +	page_pool_destroy(cpsw->page_pool);
>> +	cpsw->page_pool = pool;
>> +
>
>On Thu, 30 May 2019 21:20:39 +0300
>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>
>> +void cpsw_xdp_unreg_rxqs(struct cpsw_priv *priv)
>> +{
>> +	struct cpsw_common *cpsw = priv->cpsw;
>> +	int i;
>> +
>> +	for (i = 0; i < cpsw->rx_ch_num; i++)
>> +		xdp_rxq_info_unreg(&priv->xdp_rxq[i]);
>> +}
>
>
>On Thu, 30 May 2019 21:20:39 +0300
>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>
>> +int cpsw_xdp_reg_rxq(struct cpsw_priv *priv, int ch)
>> +{
>> +	struct xdp_rxq_info *xdp_rxq = &priv->xdp_rxq[ch];
>> +	struct cpsw_common *cpsw = priv->cpsw;
>> +	int ret;
>> +
>> +	ret = xdp_rxq_info_reg(xdp_rxq, priv->ndev, ch);
>> +	if (ret)
>> +		goto err_cleanup;
>> +
>> +	ret = xdp_rxq_info_reg_mem_model(xdp_rxq, MEM_TYPE_PAGE_POOL,
>> +					 cpsw->page_pool);
>> +	if (ret)
>> +		goto err_cleanup;
>> +
>> +	return 0;
>
>
>
>-- 
>Best regards,
>  Jesper Dangaard Brouer
>  MSc.CS, Principal Kernel Engineer at Red Hat
>  LinkedIn: http://www.linkedin.com/in/brouer

-- 
Regards,
Ivan Khoronzhuk
