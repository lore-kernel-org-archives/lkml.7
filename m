Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D4BC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62448218CA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDLasy29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfGEMBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:01:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35892 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfGEMBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:01:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so9049318ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bwcx4Wrt/iXqyeT5/Qi9DpMy8WMhSBFAEuk3MBcreWs=;
        b=PDLasy29nXLVksqy7cLdFBOQ9g2BdW8VmAJB2XAM3FVzzudxYV1GYTh4MxhCTAhdRY
         I2eU7LywN45QJfSknrIMQcUhoFzKrFlbBXQDiWO6sbH9bRermdHBGkNFBwbt3Dey734R
         MLg9SOSXh8SW1giZ1GMV975NOYl7iUiaPi6QMePfFqIhiC2aHaE7zyV3pFtm3ncn2AqN
         GzHLIRxgQtIoaBvYzUNMsHlhw7MtFqXZhGDAnNf38XhdqKak8Af/TBkCAeaEEwI22phG
         Cdi8EBwpTxIl071uBoKLN5i/SLqStnx6Qba+01fW4FVWgH5SiFipPCRQ2pD5Zxr73ip0
         IjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Bwcx4Wrt/iXqyeT5/Qi9DpMy8WMhSBFAEuk3MBcreWs=;
        b=SneTXJB1i2SF+4JCNOM7QIQz5vAe3YxYoGskLm4tO5PCkbCDC2W0VeGizDdxtnDi/A
         b2bv8sYmCnZrD9MY09QICEUGKAPvuQPLp5A3/wF8j5JHbU2v/87yo9JYKA14ljjW5EKe
         44pgTUAWvSI9M9hExGC79yKA3TdNG3ut0262Z1R2KzJN96FEj/vUm2AC3EMj2KtKDWZc
         Ge/KCb1m64Aal7pwJPKqx1gidKCof6NG/f8PQjKrkDj169bgpx615ravAChPC+hf7QAg
         WeQcwM/5BGeOOTABpsTs6yByibB1A9JEFKIw2vZt3h1oW0UT7vnypTCK0ZlrYG6AuH0w
         GIJg==
X-Gm-Message-State: APjAAAUJmjnr9Mg9DE7IQgbz0PFv0nnx4k+65iDF8sYjDYg59R2+Dv8r
        g+NfVS/8rZCJHkN4jODRLOF5tg==
X-Google-Smtp-Source: APXvYqymqamwctlOmGse9fcGqqLcn0TvUuXCUQ+EQ0I3fubLivDV0hSv0DHD5tkqr5to/nt2Tz02tg==
X-Received: by 2002:a2e:3a13:: with SMTP id h19mr1946573lja.220.1562328079191;
        Fri, 05 Jul 2019 05:01:19 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id h18sm1351494lfc.40.2019.07.05.05.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jul 2019 05:01:18 -0700 (PDT)
Date:   Fri, 5 Jul 2019 15:01:16 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com
Subject: Re: [PATCH v7 net-next 5/5] net: ethernet: ti: cpsw: add XDP support
Message-ID: <20190705120114.GA3587@khorivan>
Mail-Followup-To: Jesper Dangaard Brouer <brouer@redhat.com>,
        grygorii.strashko@ti.com, davem@davemloft.net, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com
References: <20190704231406.27083-1-ivan.khoronzhuk@linaro.org>
 <20190704231406.27083-6-ivan.khoronzhuk@linaro.org>
 <20190705131354.15a9313c@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190705131354.15a9313c@carbon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 01:13:54PM +0200, Jesper Dangaard Brouer wrote:
>On Fri,  5 Jul 2019 02:14:06 +0300
>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>
>> +static int cpsw_xdp_tx_frame(struct cpsw_priv *priv, struct xdp_frame *xdpf,
>> +			     struct page *page)
>> +{
>> +	struct cpsw_common *cpsw = priv->cpsw;
>> +	struct cpsw_meta_xdp *xmeta;
>> +	struct cpdma_chan *txch;
>> +	dma_addr_t dma;
>> +	int ret, port;
>> +
>> +	xmeta = (void *)xdpf + CPSW_XMETA_OFFSET;
>> +	xmeta->ndev = priv->ndev;
>> +	xmeta->ch = 0;
>> +	txch = cpsw->txv[0].ch;
>> +
>> +	port = priv->emac_port + cpsw->data.dual_emac;
>> +	if (page) {
>> +		dma = page_pool_get_dma_addr(page);
>> +		dma += xdpf->data - (void *)xdpf;
>
>This code is only okay because this only happens for XDP_TX, where you
>know this head-room calculation will be true.  The "correct"
>calculation of the head-room would be:
>
>  dma += xdpf->headroom + sizeof(struct xdp_frame);
>
>The reason behind not using xdpf pointer itself as "data_hard_start",
>is to allow struct xdp_frame to be located in another memory area.

My assumption was based on:

struct xdp_frame *convert_to_xdp_frame(struct xdp_buff *xdp)
{
	...
	xdp_frame = xdp->data_hard_start;
	...

	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
	...
}

But agree, it doesn't contradict the reason in question.
So, better use proposed variant. Will check and do this in v8 a little later:

dma += xdpf->headroom + sizeof(struct xdp_frame);

>This will be useful for e.g. AF_XDP transmit, or other zero-copy
>transmit to go through ndo_xdp_xmit() (as we don't want userspace to
>be-able to e.g. "race" change xdpf->len during transmit/DMA-completion).
>
>
>> +		ret = cpdma_chan_submit_mapped(txch, cpsw_xdpf_to_handle(xdpf),
>> +					       dma, xdpf->len, port);
>> +	} else {
>> +		if (sizeof(*xmeta) > xdpf->headroom) {
>> +			xdp_return_frame_rx_napi(xdpf);
>> +			return -EINVAL;
>> +		}
>> +
>> +		ret = cpdma_chan_submit(txch, cpsw_xdpf_to_handle(xdpf),
>> +					xdpf->data, xdpf->len, port);
>> +	}
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
