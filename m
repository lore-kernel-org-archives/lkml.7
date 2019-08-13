Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D73C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27DF205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="tYcrzUhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfHMVLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:11:35 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40162 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfHMVLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:11:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id e8so7365212qtp.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 14:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=5DO9+iiMXCnTxtn8kwS2obogFdAM5hjWuU5VPWQaLfs=;
        b=tYcrzUhl5ircfJr1bs2q5kQPK6/jwLBoImHl3kWYeFY+3XOA3Qzyzo+gXYlxbVv7Kj
         NGuEgYU1tEffEOG8uffyJCThrNLl99RjrMCoCWsSaWypdc3X/O3d6MOwh+Sk68+k6PbS
         aXEkHsZChosQeQeFomYIwBbKjBpvk7zYct5DIQPOMKPdtHJWqWnGlEfrs+YNxJUw6Xgh
         KJiuLLLOlst+61lwP+Xvr2KP0lF27LBAzbEBn8iKz7TNRMST98M+KCiUFDzKVnwaWUQe
         Slabew/eXCQCTjQnUK/FwU7QgK2dxLBJioRP90JCriKk+W6ewp78wkVy3goYii7NKyy6
         OEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=5DO9+iiMXCnTxtn8kwS2obogFdAM5hjWuU5VPWQaLfs=;
        b=j22KpzMW3BybbXvYja1mBya1MT1tm1PJI9UwadG35CtXoptusnlwHeQiaNFgop6hvA
         9AmU6x2FkARiFuDG4sRpYBr7FFSSKU+DXrAy4dAQBEN6bh46HgxFYfetCQ/de8huZcUn
         oLhfO4vXM+1g+YOa9KFNq/X8bae57c2GPbklygE4ikfZfhmHBJgIbSce+WsqbYdi9br1
         HqsPynwQ3vXVVP8fz0B8oImWPB3yDDcfvDpTYBFgVqIhA6wDU9Z2dIra9wMLOc4DkNuq
         HY/RHnx8JiEiv7GAZ8Uz3d8tDw6LDt8e6IXHrxMRcly4Se5rrEK1ttq44L4DhjgRblrp
         k9Xw==
X-Gm-Message-State: APjAAAWJvsxZGfnI6P5TpIO2QjJks4k65DMIBIpmXVyNpBd2o+a7OaNO
        pdDRyiYsrQFhYlmqE0sJmtvWlg==
X-Google-Smtp-Source: APXvYqwXnH6BSNDMXssyIYCybM9bhgzE9wbjMU4CueLHzjlps+cYdJzD+gHjkEYo2NVLUhdkdWiBFw==
X-Received: by 2002:a05:6214:110c:: with SMTP id e12mr198694qvs.126.1565730693427;
        Tue, 13 Aug 2019 14:11:33 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id q73sm35531390qke.90.2019.08.13.14.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 14:11:33 -0700 (PDT)
Date:   Tue, 13 Aug 2019 14:11:23 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     netdev@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 02/12] net: stmmac: Prepare to add Split
 Header support
Message-ID: <20190813141123.1df0daf2@cakuba.netronome.com>
In-Reply-To: <342007d6ac2b44db03d113e7e8bf0310caa77ea0.1565602974.git.joabreu@synopsys.com>
References: <cover.1565602974.git.joabreu@synopsys.com>
        <342007d6ac2b44db03d113e7e8bf0310caa77ea0.1565602974.git.joabreu@synopsys.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019 11:44:01 +0200, Jose Abreu wrote:
> In order to add Split Header support, stmmac_rx() needs to take into
> account that packet may be split accross multiple descriptors.
> 
> Refactor the logic of this function in order to support this scenario.
> 
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>
> 
> ---
> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Jose Abreu <joabreu@synopsys.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   6 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 149 +++++++++++++---------
>  2 files changed, 95 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 80276587048a..56158e1448ac 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -74,6 +74,12 @@ struct stmmac_rx_queue {
>  	u32 rx_zeroc_thresh;
>  	dma_addr_t dma_rx_phy;
>  	u32 rx_tail_addr;
> +	unsigned int state_saved;
> +	struct {
> +		struct sk_buff *skb;
> +		unsigned int len;
> +		unsigned int error;
> +	} state;
>  };
>  
>  struct stmmac_channel {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b2e5f4ecd551..a093eb4ec275 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3353,9 +3353,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  {
>  	struct stmmac_rx_queue *rx_q = &priv->rx_queue[queue];
>  	struct stmmac_channel *ch = &priv->channel[queue];
> +	unsigned int count = 0, error = 0, len = 0;
> +	int status = 0, coe = priv->hw->rx_csum;
>  	unsigned int next_entry = rx_q->cur_rx;
> -	int coe = priv->hw->rx_csum;
> -	unsigned int count = 0;
> +	struct sk_buff *skb = NULL;
>  
>  	if (netif_msg_rx_status(priv)) {
>  		void *rx_head;
> @@ -3369,9 +3370,27 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		stmmac_display_ring(priv, rx_head, DMA_RX_SIZE, true);
>  	}
>  	while (count < limit) {
> +		enum pkt_hash_types hash_type;
>  		struct stmmac_rx_buffer *buf;
> +		unsigned int prev_len = 0;
>  		struct dma_desc *np, *p;
> -		int entry, status;
> +		int entry;
> +		u32 hash;
> +
> +		if (!count && rx_q->state_saved) {
> +			skb = rx_q->state.skb;
> +			error = rx_q->state.error;
> +			len = rx_q->state.len;
> +		} else {
> +			rx_q->state_saved = false;
> +			skb = NULL;
> +			error = 0;
> +			len = 0;
> +		}
> +
> +read_again:
> +		if (count >= limit)
> +			break;

Is this stopping the NAPI poll once @limit descriptors were seen?
It should probably be okay to ignore the limit until you get a full
frame? I'd think it'd be best to finish up the frame while the state 
is hot in the CPU cache.. WDYT?

>  		entry = next_entry;
>  		buf = &rx_q->buf_pool[entry];
> @@ -3407,28 +3426,24 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  			page_pool_recycle_direct(rx_q->page_pool, buf->page);
>  			priv->dev->stats.rx_errors++;
>  			buf->page = NULL;
> +			error = 1;
> +		}
> +
> +		if (unlikely(error & (status & rx_not_ls)))

Looks suspicious - sure this is supposed to be error & (status & bla)
and not error && ... ?

> +			goto read_again;
> +		if (unlikely(error)) {
> +			if (skb)
> +				dev_kfree_skb(skb);
> +			continue;
> +		}
> +
> +		/* Buffer is good. Go on. */
> +
> +		if (likely(status & rx_not_ls)) {
> +			len += priv->dma_buf_sz;
>  		} else {
> -			enum pkt_hash_types hash_type;
> -			struct sk_buff *skb;
> -			unsigned int des;
> -			int frame_len;
> -			u32 hash;
> -
> -			stmmac_get_desc_addr(priv, p, &des);
> -			frame_len = stmmac_get_rx_frame_len(priv, p, coe);
> -
> -			/*  If frame length is greater than skb buffer size
> -			 *  (preallocated during init) then the packet is
> -			 *  ignored
> -			 */
> -			if (frame_len > priv->dma_buf_sz) {
> -				if (net_ratelimit())
> -					netdev_err(priv->dev,
> -						   "len %d larger than size (%d)\n",
> -						   frame_len, priv->dma_buf_sz);
> -				priv->dev->stats.rx_length_errors++;
> -				continue;
> -			}
> +			prev_len = len;
> +			len = stmmac_get_rx_frame_len(priv, p, coe);
>  
>  			/* ACS is set; GMAC core strips PAD/FCS for IEEE 802.3
>  			 * Type frames (LLC/LLC-SNAP)
> @@ -3439,57 +3454,71 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  			 */
>  			if (unlikely(priv->synopsys_id >= DWMAC_CORE_4_00) ||
>  			    unlikely(status != llc_snap))
> -				frame_len -= ETH_FCS_LEN;
> -
> -			if (netif_msg_rx_status(priv)) {
> -				netdev_dbg(priv->dev, "\tdesc: %p [entry %d] buff=0x%x\n",
> -					   p, entry, des);
> -				netdev_dbg(priv->dev, "frame size %d, COE: %d\n",
> -					   frame_len, status);
> -			}
> +				len -= ETH_FCS_LEN;
> +		}
>  
> -			skb = netdev_alloc_skb_ip_align(priv->dev, frame_len);
> -			if (unlikely(!skb)) {
> +		if (!skb) {
> +			skb = netdev_alloc_skb_ip_align(priv->dev, len);

Since you're in NAPI call perhaps something like napi_alloc_skb() could
speed things up a little? But please also see below..

> +			if (!skb) {
>  				priv->dev->stats.rx_dropped++;
>  				continue;
>  			}
>  
> -			dma_sync_single_for_cpu(priv->device, buf->addr,
> -						frame_len, DMA_FROM_DEVICE);
> +			dma_sync_single_for_cpu(priv->device, buf->addr, len,
> +						DMA_FROM_DEVICE);
>  			skb_copy_to_linear_data(skb, page_address(buf->page),
> -						frame_len);
> -			skb_put(skb, frame_len);
> +						len);
> +			skb_put(skb, len);
>  
> -			if (netif_msg_pktdata(priv)) {
> -				netdev_dbg(priv->dev, "frame received (%dbytes)",
> -					   frame_len);
> -				print_pkt(skb->data, frame_len);
> -			}
> +			/* Data payload copied into SKB, page ready for recycle */
> +			page_pool_recycle_direct(rx_q->page_pool, buf->page);
> +			buf->page = NULL;
> +		} else {
> +			unsigned int buf_len = len - prev_len;
>  
> -			stmmac_get_rx_hwtstamp(priv, p, np, skb);
> +			if (likely(status & rx_not_ls))
> +				buf_len = priv->dma_buf_sz;
>  
> -			stmmac_rx_vlan(priv->dev, skb);
> +			dma_sync_single_for_cpu(priv->device, buf->addr,
> +						buf_len, DMA_FROM_DEVICE);
> +			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> +					buf->page, 0, buf_len,
> +					priv->dma_buf_sz);
>  
> -			skb->protocol = eth_type_trans(skb, priv->dev);
> +			/* Data payload appended into SKB */
> +			page_pool_release_page(rx_q->page_pool, buf->page);
> +			buf->page = NULL;
> +		}
>  
> -			if (unlikely(!coe))
> -				skb_checksum_none_assert(skb);
> -			else
> -				skb->ip_summed = CHECKSUM_UNNECESSARY;
> +		if (likely(status & rx_not_ls))
> +			goto read_again;
>  
> -			if (!stmmac_get_rx_hash(priv, p, &hash, &hash_type))
> -				skb_set_hash(skb, hash, hash_type);
> +		/* Got entire packet into SKB. Finish it. */
>  
> -			skb_record_rx_queue(skb, queue);
> -			napi_gro_receive(&ch->rx_napi, skb);
> +		stmmac_get_rx_hwtstamp(priv, p, np, skb);
> +		stmmac_rx_vlan(priv->dev, skb);
> +		skb->protocol = eth_type_trans(skb, priv->dev);
>  
> -			/* Data payload copied into SKB, page ready for recycle */
> -			page_pool_recycle_direct(rx_q->page_pool, buf->page);
> -			buf->page = NULL;
> +		if (unlikely(!coe))
> +			skb_checksum_none_assert(skb);
> +		else
> +			skb->ip_summed = CHECKSUM_UNNECESSARY;
>  
> -			priv->dev->stats.rx_packets++;
> -			priv->dev->stats.rx_bytes += frame_len;
> -		}
> +		if (!stmmac_get_rx_hash(priv, p, &hash, &hash_type))
> +			skb_set_hash(skb, hash, hash_type);
> +
> +		skb_record_rx_queue(skb, queue);
> +		napi_gro_receive(&ch->rx_napi, skb);

Did you look into using napi_gro_frags() family of APIs?
I think Eric said those are more efficient from GRO perspective..

> +		priv->dev->stats.rx_packets++;
> +		priv->dev->stats.rx_bytes += len;
> +	}
> +
> +	if (status & rx_not_ls) {
> +		rx_q->state_saved = true;
> +		rx_q->state.skb = skb;
> +		rx_q->state.error = error;
> +		rx_q->state.len = len;
>  	}
>  
>  	stmmac_rx_refill(priv, queue);

