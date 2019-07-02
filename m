Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150D2C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D081021721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FqVp5GV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfGBLhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 07:37:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44377 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfGBLhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 07:37:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so16502164ljc.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 04:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZFgp+qJ/j22ILu0xrjnvZPHOj6PUWhsFcPpe+e4Y7bU=;
        b=FqVp5GV3gJryDY3UmmOF4FJLcHhVIXPZ9oMw8qcdcSKg6ztJ6HRJRg98o5gddvyV40
         vAiOvXNF1UDxC5Fasoz/E8danEk7p3dE7Sh1TVfsO5r/0135uOY/EaO+7Z0b5K02KfwO
         fPhkhVlEmtqRg9OwQ0pnBRLb6U0G6OSzQRlYk6es1ZI4Vtmc08vQ6HQHWkNIcwXTEfky
         kp6k7SGse7YejOE0jGnAEXVwMMGRQ73g/UuENgRz/oRZe5eJeuPmXPTmNig/mLzTDd9T
         9amKmQvJA1mmajihWheI4aKqYmUEJnXjW1vIjIjdEeGmAhLfiSrK6/69qFEUtifNgOXP
         JUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ZFgp+qJ/j22ILu0xrjnvZPHOj6PUWhsFcPpe+e4Y7bU=;
        b=pte5RsUn+GIE341S7pwaDRXSZHFCDSc9bk3f+mXKK70iwSJTCBnSpHcdrKQrcOrRZF
         8hBniAeXaOe395QykU5c0oCVyZDLlc5BJcqUEeL9HyVe2NFF5xyutNqctcIvgFghEMQE
         vrjrnxrrvRxCj0hIXXV8+yxEGfg+/oGh1Mp4r13ltAIpHG1AdUXYfxx+rzdxa0XPQz2W
         d6wOlJYtvCAc08anxYg9TYUxH/B3eOhKIjchhj+xJ9R/Jd2cJ94OXmBq3Mu2v0NdU/x3
         GSWV/IQHF0NQo44I+wzJO6igTlsf7uwlSWTJ50btsv2LYcmfBfiVFyaos08cflHRm988
         537A==
X-Gm-Message-State: APjAAAWBFv7xTioPbeHlvporpyU7CsxQ8suwMRjw5ctPyWuUmfa4Jkpb
        cxvJwhmtrRXY9G8eti0UfjQT2w==
X-Google-Smtp-Source: APXvYqwgxkawZGohpYPdKCeEogT1H8dr5eFxYTigT5z5pSlK9j0WWi+02uK6h2/vnsR3M1nH7v7+0A==
X-Received: by 2002:a2e:9857:: with SMTP id e23mr16694622ljj.217.1562067462281;
        Tue, 02 Jul 2019 04:37:42 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id l25sm3699985lja.76.2019.07.02.04.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 04:37:41 -0700 (PDT)
Date:   Tue, 2 Jul 2019 14:37:39 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com
Subject: Re: [PATCH v5 net-next 6/6] net: ethernet: ti: cpsw: add XDP support
Message-ID: <20190702113738.GB4510@khorivan>
Mail-Followup-To: Jesper Dangaard Brouer <brouer@redhat.com>,
        grygorii.strashko@ti.com, davem@davemloft.net, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com
References: <20190630172348.5692-1-ivan.khoronzhuk@linaro.org>
 <20190630172348.5692-7-ivan.khoronzhuk@linaro.org>
 <20190701181901.150c0b71@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190701181901.150c0b71@carbon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 06:19:01PM +0200, Jesper Dangaard Brouer wrote:
>On Sun, 30 Jun 2019 20:23:48 +0300
>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>
>> +static int cpsw_ndev_create_xdp_rxq(struct cpsw_priv *priv, int ch)
>> +{
>> +	struct cpsw_common *cpsw = priv->cpsw;
>> +	int ret, new_pool = false;
>> +	struct xdp_rxq_info *rxq;
>> +
>> +	rxq = &priv->xdp_rxq[ch];
>> +
>> +	ret = xdp_rxq_info_reg(rxq, priv->ndev, ch);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!cpsw->page_pool[ch]) {
>> +		ret =  cpsw_create_rx_pool(cpsw, ch);
>> +		if (ret)
>> +			goto err_rxq;
>> +
>> +		new_pool = true;
>> +	}
>> +
>> +	ret = xdp_rxq_info_reg_mem_model(rxq, MEM_TYPE_PAGE_POOL,
>> +					 cpsw->page_pool[ch]);
>> +	if (!ret)
>> +		return 0;
>> +
>> +	if (new_pool) {
>> +		page_pool_free(cpsw->page_pool[ch]);
>> +		cpsw->page_pool[ch] = NULL;
>> +	}
>> +
>> +err_rxq:
>> +	xdp_rxq_info_unreg(rxq);
>> +	return ret;
>> +}
>
>Looking at this, and Ilias'es XDP-netsec error handling path, it might
>be a mistake that I removed page_pool_destroy() and instead put the
>responsibility on xdp_rxq_info_unreg().
As for me this is started not from page_pool_free, but rather from calling
unreg_mem_model from rxq_info_unreg. Then, if page_pool_free is hidden
it looks more a while normal to move all chain to be self destroyed.

>
>As here, we have to detect if page_pool_create() was a success, and then
>if xdp_rxq_info_reg_mem_model() was a failure, explicitly call
>page_pool_free() because the xdp_rxq_info_unreg() call cannot "free"
>the page_pool object given it was not registered.
Yes, it looked a little bit ugly from the beginning, but, frankly,
I have got used to this already.

>
>Ivan's patch in[1], might be a better approach, which forced all
>drivers to explicitly call page_pool_free(), even-though it just
>dec-refcnt and the real call to page_pool_free() happened via
>xdp_rxq_info_unreg().
>
>To better handle error path, I would re-introduce page_pool_destroy(),
So, you might to do it later as I understand, and not for my special
case but becouse it makes error path to look a little bit more pretty.
I'm perfectly fine with this, and better you add this, for now my
implementation requires only "xdp: allow same allocator usage" patch,
but if you insist I can resend also patch in question afterwards my
series is applied (with modification to cpsw & netsec & mlx5 & page_pool).

What's your choice? I can add to your series patch needed for cpsw to
avoid some misuse.

>as a driver API, that would gracefully handle NULL-pointer case, and
>then call page_pool_free() with the atomic_dec_and_test().  (It should
>hopefully simplify the error handling code a bit)
>
>[1] https://lore.kernel.org/netdev/20190625175948.24771-2-ivan.khoronzhuk@linaro.org/
>
>
>> +void cpsw_ndev_destroy_xdp_rxqs(struct cpsw_priv *priv)
>> +{
>> +	struct cpsw_common *cpsw = priv->cpsw;
>> +	struct xdp_rxq_info *rxq;
>> +	int i;
>> +
>> +	for (i = 0; i < cpsw->rx_ch_num; i++) {
>> +		rxq = &priv->xdp_rxq[i];
>> +		if (xdp_rxq_info_is_reg(rxq))
>> +			xdp_rxq_info_unreg(rxq);
>> +	}
>> +}
>
>Are you sure you need to test xdp_rxq_info_is_reg() here?
Yes it's required in my case as it's used in error path where
an rx queue can be even not registered and no need in this warn.

>
>You should just call xdp_rxq_info_unreg(rxq), if you know that this rxq
>should be registered.  If your assumption failed, you will get a
>WARNing, and discover your driver level bug.  This is one of the ways
>the API is designed to "detect" misuse of the API.  (I found this
>rather useful, when I converted the approx 12 drivers using this
>xdp_rxq_info API).
>
>-- 
>Best regards,
>  Jesper Dangaard Brouer
>  MSc.CS, Principal Kernel Engineer at Red Hat
>  LinkedIn: http://www.linkedin.com/in/brouer

-- 
Regards,
Ivan Khoronzhuk
