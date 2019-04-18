Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94733C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9DA214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2y+3+R1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388518AbfDRJkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:40:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45266 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388434AbfDRJkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:40:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id t11so1100461lfl.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 02:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YfIjr0zyL/zB/ySkDylci38puxV173t2ZaoIGpSFki0=;
        b=c2y+3+R1YY3a6WyvcA2bxPasssHWsKiL8UpUJ6YLVnOwqPpWHqjinruShh7ofc+JAz
         /7FUCWvmjc1CNISrMVtsqqGqdq03WGdT9lOiuqX33mr9HJuTq1s0HO7lYkXRJmS6BEnb
         MJbTaX2MRmun1zEle0piVl9FONBe7ViwTkqy5AR11FPqIPPYab7erfJxBISH/DVfbXkC
         Sh50xTfAhLx/MPBPB1t86S9nUR1x4JZJCo6tBA7VeX6OxQIZiLmFoeL3P94CSzBV72WC
         9VepBa7AccVtHfieZgaHSFQgba8CyVzhfwMBI5Lo3PED3uiy59D7zIx0t2kCQE8H16ab
         REKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=YfIjr0zyL/zB/ySkDylci38puxV173t2ZaoIGpSFki0=;
        b=MOus/q+4Eud+JlaQ5gErLaEYHKZtXz7XmpJ1O28sXdeR6jVU82UtXY8C/ht5t8w8nM
         QLinYtvGs8HRe/5NyXiEGxUXSl2YQd7GRX6tQ/7n/q013QyK3/P8oMMFII4UOod7h2RG
         tx92/HAwCJ/0sa49dZ6utIo9ahMcAqVOthdCFokCM8WfilkC3IyAeqLsq+tuFXhyCcFA
         5OAEPXS28m5k1JHXCEsMIlU1PqykSobJozXxf4vNPwvTotZbtBPAXM/jY2Ne3zRln1bY
         fNy4hROzmFb5qHuXu2VEHeyJt5pCn6evmdIdLrZE74cc09hR084iTgDp4qtu3RWWg37m
         gZiA==
X-Gm-Message-State: APjAAAUHadhSBA1rwT0k6rkaEVkpAc9h5PGiLm13e7dgnR+8I5VCYoHu
        KqtKed4/Q1Z+QTv0IVjKEQiR8A==
X-Google-Smtp-Source: APXvYqzqoyKMZaQPvumoov2mwxIfGIstZOLEGWGOoGfECzRzlg00bTSvGqyPe9XXuHg0dgk1vw8v8A==
X-Received: by 2002:ac2:547a:: with SMTP id e26mr10448475lfn.148.1555580412835;
        Thu, 18 Apr 2019 02:40:12 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id h12sm358576lfj.45.2019.04.18.02.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 02:40:12 -0700 (PDT)
Date:   Thu, 18 Apr 2019 12:40:10 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        ilias.apalodimas@linaro.org, hawk@kernel.org,
        xdp-newbies@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        aniel@iogearbox.net, John Fastabend <john.fastabend@gmail.com>
Subject: Re: [RFC PATCH 3/3] net: ethernet: ti: cpsw: add XDP support
Message-ID: <20190418094008.GB27879@khorivan>
Mail-Followup-To: Jakub Kicinski <jakub.kicinski@netronome.com>,
        grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        ilias.apalodimas@linaro.org, hawk@kernel.org,
        xdp-newbies@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        aniel@iogearbox.net, John Fastabend <john.fastabend@gmail.com>
References: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
 <20190417174942.11811-4-ivan.khoronzhuk@linaro.org>
 <CAJpBn1y0odvL97-kP5yzKC+tN=fx178nxigfBfDwXhRhPRvDuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJpBn1y0odvL97-kP5yzKC+tN=fx178nxigfBfDwXhRhPRvDuQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 03:46:56PM -0700, Jakub Kicinski wrote:
>On Wed, 17 Apr 2019 20:49:42 +0300, Ivan Khoronzhuk wrote:
>> Add XDP support based on rx page_pool allocator, one frame per page.
>> This patch was verified with af_xdp and xdp drop. Page pool allocator
>> is used with assumption that only one rx_handler is running
>> simultaneously. DMA map/unmap is reused from page pool despite there
>> is no need to map whole page.
>>
>> Due to specific of cpsw, the same TX/RX handler can be used by 2
>> network devices, so special fields in buffer are added to identify
>> an interface the frame is destined to.
>>
>> XDP prog is common for all channels till appropriate changes are added
>> in XDP infrastructure.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>
>> @@ -902,22 +947,169 @@ static void cpsw_rx_vlan_encap(struct sk_buff *skb)
>>       }
>>  }
>>
>> +static inline int cpsw_tx_submit_xdpf(struct cpsw_priv *priv,
>> +                                   struct xdp_frame *xdpf,
>> +                                   struct cpdma_chan *txch)
>> +{
>> +     struct cpsw_common *cpsw = priv->cpsw;
>> +
>> +     return cpdma_chan_submit(txch, cpsw_xdpf_to_handle(xdpf), xdpf->data,
>> +                              xdpf->len,
>> +                              priv->emac_port + cpsw->data.dual_emac);
>> +}
>> +
>> +static int cpsw_xdp_tx_frame(struct cpsw_priv *priv, struct xdp_frame *frame)
>> +{
>> +     struct cpsw_common *cpsw = priv->cpsw;
>> +     struct cpsw_meta_xdp *xmeta;
>> +     struct cpdma_chan *txch;
>> +     int ret = 0;
>> +
>> +     frame->metasize = sizeof(struct cpsw_meta_xdp);
>> +     xmeta = frame->data - frame->metasize;
>> +     xmeta->ndev = priv->ndev;
>> +     xmeta->ch = 0;
>> +
>> +     txch = cpsw->txv[0].ch;
>> +     ret = cpsw_tx_submit_xdpf(priv, frame, txch);
>> +     if (ret) {
>> +             xdp_return_frame_rx_napi(frame);
>> +             ret = -1;
>> +     }
>> +
>> +     /* If there is no more tx desc left free then we need to
>> +      * tell the kernel to stop sending us tx frames.
>> +      */
>
>So you're using the same TX ring for XDP and stack?  How does that
Yes.

>work?  The stack's TX ring has a lock, and can be used from any CPU,
>while XDP TX rings are per-PCU, no?
Yes and no.
am572 has more queues then CPU num, How I can choose tx queue not based on CPU
num? It's always shared and has to have lock, and cpdma is done in this way.

Here another thing bothering me, I send it to queue 0 always, instead of
taking cpu num. Not sure about this, but I expect to have some tx queue
not bind to cpu and didn't find a way it can be changed dynamically in
redirect.

>
>> +     if (unlikely(!cpdma_check_free_tx_desc(txch))) {
>> +             struct netdev_queue *txq = netdev_get_tx_queue(priv->ndev, 0);
>> +
>> +             netif_tx_stop_queue(txq);
>> +
>> +             /* Barrier, so that stop_queue visible to other cpus */
>> +             smp_mb__after_atomic();
>> +
>> +             if (cpdma_check_free_tx_desc(txch))
>> +                     netif_tx_wake_queue(txq);
>> +     }
>> +
>> +     return ret;
>> +}
>
>> +static struct page_pool *cpsw_create_rx_pool(struct cpsw_common *cpsw)
>> +{
>> +     struct page_pool_params pp_params = { 0 };
>> +
>> +     pp_params.order = 0;
>> +     pp_params.flags = PP_FLAG_DMA_MAP;
>> +
>> +      /* set it to number of descriptors to be cached from init? */
>> +     pp_params.pool_size = descs_pool_size;
>> +     pp_params.nid = NUMA_NO_NODE; /* no numa */
>> +     pp_params.dma_dir = DMA_FROM_DEVICE;
>
>DMA_FROM_DEVICE looks suspicious if you support TX, shouldn't this be
>BIDIRECTIONAL?
Not sure about this. DMA_FROM_DEVICE is used for RX and fits in redirect to
another inf. In case of redirect each dev is using own dma map, but TX, maybe
better to behave in similar way? if no then probably you are right I can't
avoid this with TX case. I need properly test this case for sure, thanks!

>
>> +     pp_params.dev = cpsw->dev;
>> +
>> +     return page_pool_create(&pp_params);
[...]

>> +     new_xmeta->ndev = ndev;
>> +     new_xmeta->ch = ch;
>> +     dma = new_page->dma_addr + CPSW_HEADROOM;
>> +     ret = cpdma_chan_submit_mapped(cpsw->rxv[ch].ch, new_page, (void *)dma,
>> +                                    pkt_size, 0);
>>       if (WARN_ON(ret < 0))
>> -             dev_kfree_skb_any(new_skb);
>> +             page_pool_recycle_direct(pool, new_page);
>> +     else
>> +             kmemleak_not_leak(new_xmeta); /* Is it needed? */
>>
>> -     return 0;
>> +     return flush;
>>  }
>
>On a quick scan I don't see DMA syncs, does the DMA driver takes care
>of making sure the DMA sync happens?
In prev. patch to cpdma layer
[RFC PATCH 1/3] net: ethernet: ti: davinci_cpdma: add dma mapped submit

>
>>  static void cpsw_split_res(struct net_device *ndev)
>
>> @@ -2684,6 +2949,63 @@ static int cpsw_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>>       }
>>  }
>>
>> +static int cpsw_xdp_prog_setup(struct net_device *ndev, struct bpf_prog *prog)
>> +{
>> +     struct cpsw_priv *priv = netdev_priv(ndev);
>> +     struct bpf_prog *old_prog;
>> +
>> +     if (!priv->xdp_prog && !prog)
>> +             return 0;
>> +
>> +     old_prog = xchg(&priv->xdp_prog, prog);
>> +     if (old_prog)
>> +             bpf_prog_put(old_prog);
>> +
>> +     return 0;
>> +}
>> +
>> +static int cpsw_ndo_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
>> +{
>> +     struct cpsw_priv *priv = netdev_priv(ndev);
>> +
>> +     switch (bpf->command) {
>> +     case XDP_SETUP_PROG:
>> +             return cpsw_xdp_prog_setup(ndev, bpf->prog);
>> +
>> +     case XDP_QUERY_PROG:
>> +             bpf->prog_id = priv->xdp_prog ? priv->xdp_prog->aux->id : 0;
>
>Consider using xdp_attachment_query() and friends.  This way you'll
>also return the flags.
I will.

>
>> +             return 0;
>> +
>> +     default:
[...]

>> -     cpsw->rxv[0].ch = cpdma_chan_create(cpsw->dma, 0, cpsw_rx_handler, 1);
>> +     cpsw->rxv[0].ch =
>> +         cpdma_chan_create(cpsw->dma, 0, cpsw_rx_handler, 1);
>>       if (IS_ERR(cpsw->rxv[0].ch)) {
>>               dev_err(priv->dev, "error initializing rx dma channel\n");
>>               ret = PTR_ERR(cpsw->rxv[0].ch);
>>               goto clean_dma_ret;
>>       }
>>
>> +     ret = xdp_rxq_info_reg(&priv->xdp_rxq[0], ndev, 0);
>> +     if (ret)
>> +             goto clean_dma_ret;
>> +
>> +     ret = xdp_rxq_info_reg_mem_model(&priv->xdp_rxq[0], MEM_TYPE_PAGE_POOL,
>> +                                      cpsw->rx_page_pool);
>> +     if (ret)
>> +             goto clean_dma_ret;
>> +
>>       ale_params.dev                  = &pdev->dev;
>>       ale_params.ale_ageout           = ale_ageout;
>>       ale_params.ale_entries          = data->ale_entries;
>
>I think you need to unreg the mem model somewhere on the failure path,
>no?
yes, seems so. Thanks.

>
>
>> @@ -3786,6 +4195,7 @@ static int cpsw_probe(struct platform_device *pdev)
>>       pm_runtime_put_sync(&pdev->dev);
>>  clean_runtime_disable_ret:
>>       pm_runtime_disable(&pdev->dev);
>> +     page_pool_destroy(cpsw->rx_page_pool);
>>  clean_ndev_ret:
>>       free_netdev(priv->ndev);
>>       return ret;
>> @@ -3809,6 +4219,7 @@ static int cpsw_remove(struct platform_device *pdev)
>>
>>       cpts_release(cpsw->cpts);
>>       cpdma_ctlr_destroy(cpsw->dma);
>> +     page_pool_destroy(cpsw->rx_page_pool);
>>       cpsw_remove_dt(pdev);
>>       pm_runtime_put_sync(&pdev->dev);
>>       pm_runtime_disable(&pdev->dev);

-- 
Regards,
Ivan Khoronzhuk
