Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA753C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D6021D71
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfJKGS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 02:18:28 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35793 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726401AbfJKGS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:18:28 -0400
X-IronPort-AV: E=Sophos;i="5.67,283,1566856800"; 
   d="scan'208";a="405698121"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 08:18:25 +0200
Date:   Fri, 11 Oct 2019 08:18:25 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Wambui Karuga <wambui.karugax@gmail.com>
cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/5] staging: octeon: remove typedef
 declaration for cvmx_wqe_t
In-Reply-To: <1b16bc880fee5711f96ed82741f8268e4dac1ae6.1570773209.git.wambui.karugax@gmail.com>
Message-ID: <alpine.DEB.2.21.1910110817340.2662@hadrien>
References: <cover.1570773209.git.wambui.karugax@gmail.com> <1b16bc880fee5711f96ed82741f8268e4dac1ae6.1570773209.git.wambui.karugax@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Oct 2019, Wambui Karuga wrote:

> Remove typedef declaration from struct cvmx_wqe_t in

You can remove the _t from the name as well.

> drivers/staging/octeon/octeon-stubs.h.

It's not really necessary to give the name of the file in the log message,
as it can easily be seen below.

julia

> Also replace its previous uses with new struct declaration.
> Issue found by checkpatch.pl
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/staging/octeon/ethernet-rx.c  |  6 +++---
>  drivers/staging/octeon/ethernet-tx.c  |  2 +-
>  drivers/staging/octeon/ethernet.c     |  2 +-
>  drivers/staging/octeon/octeon-stubs.h | 22 +++++++++++-----------
>  4 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
> index 0e65955c746b..63e15a70f3e7 100644
> --- a/drivers/staging/octeon/ethernet-rx.c
> +++ b/drivers/staging/octeon/ethernet-rx.c
> @@ -60,7 +60,7 @@ static irqreturn_t cvm_oct_do_interrupt(int irq, void *napi_id)
>   *
>   * Returns Non-zero if the packet can be dropped, zero otherwise.
>   */
> -static inline int cvm_oct_check_rcv_error(cvmx_wqe_t *work)
> +static inline int cvm_oct_check_rcv_error(struct cvmx_wqe_t *work)
>  {
>  	int port;
>
> @@ -135,7 +135,7 @@ static inline int cvm_oct_check_rcv_error(cvmx_wqe_t *work)
>  	return 0;
>  }
>
> -static void copy_segments_to_skb(cvmx_wqe_t *work, struct sk_buff *skb)
> +static void copy_segments_to_skb(struct cvmx_wqe_t *work, struct sk_buff *skb)
>  {
>  	int segments = work->word2.s.bufs;
>  	union cvmx_buf_ptr segment_ptr = work->packet_ptr;
> @@ -215,7 +215,7 @@ static int cvm_oct_poll(struct oct_rx_group *rx_group, int budget)
>  		struct sk_buff *skb = NULL;
>  		struct sk_buff **pskb = NULL;
>  		int skb_in_hw;
> -		cvmx_wqe_t *work;
> +		struct cvmx_wqe_t *work;
>  		int port;
>
>  		if (USE_ASYNC_IOBDMA && did_work_request)
> diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
> index c64728fc21f2..7ececfac0701 100644
> --- a/drivers/staging/octeon/ethernet-tx.c
> +++ b/drivers/staging/octeon/ethernet-tx.c
> @@ -515,7 +515,7 @@ int cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
>  	void *copy_location;
>
>  	/* Get a work queue entry */
> -	cvmx_wqe_t *work = cvmx_fpa_alloc(CVMX_FPA_WQE_POOL);
> +	struct cvmx_wqe_t *work = cvmx_fpa_alloc(CVMX_FPA_WQE_POOL);
>
>  	if (unlikely(!work)) {
>  		printk_ratelimited("%s: Failed to allocate a work queue entry\n",
> diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
> index cf8e9a23ebf9..3de209b7d0ec 100644
> --- a/drivers/staging/octeon/ethernet.c
> +++ b/drivers/staging/octeon/ethernet.c
> @@ -172,7 +172,7 @@ static void cvm_oct_configure_common_hw(void)
>   */
>  int cvm_oct_free_work(void *work_queue_entry)
>  {
> -	cvmx_wqe_t *work = work_queue_entry;
> +	struct cvmx_wqe_t *work = work_queue_entry;
>
>  	int segments = work->word2.s.bufs;
>  	union cvmx_buf_ptr segment_ptr = work->packet_ptr;
> diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> index b2e3c72205dd..fd7522f70f7e 100644
> --- a/drivers/staging/octeon/octeon-stubs.h
> +++ b/drivers/staging/octeon/octeon-stubs.h
> @@ -183,13 +183,13 @@ union cvmx_buf_ptr {
>  	} s;
>  };
>
> -typedef struct {
> +struct cvmx_wqe_t {
>  	union cvmx_wqe_word0 word0;
>  	union cvmx_wqe_word1 word1;
>  	union cvmx_pip_wqe_word2 word2;
>  	union cvmx_buf_ptr packet_ptr;
>  	uint8_t packet_data[96];
> -} cvmx_wqe_t;
> +};
>
>  typedef union {
>  	uint64_t u64;
> @@ -1198,7 +1198,7 @@ static inline uint64_t cvmx_scratch_read64(uint64_t address)
>  static inline void cvmx_scratch_write64(uint64_t address, uint64_t value)
>  { }
>
> -static inline int cvmx_wqe_get_grp(cvmx_wqe_t *work)
> +static inline int cvmx_wqe_get_grp(struct cvmx_wqe_t *work)
>  {
>  	return 0;
>  }
> @@ -1345,14 +1345,14 @@ static inline void cvmx_pow_work_request_async(int scr_addr,
>  						       cvmx_pow_wait_t wait)
>  { }
>
> -static inline cvmx_wqe_t *cvmx_pow_work_response_async(int scr_addr)
> +static inline struct cvmx_wqe_t *cvmx_pow_work_response_async(int scr_addr)
>  {
> -	cvmx_wqe_t *wqe = (void *)(unsigned long)scr_addr;
> +	struct cvmx_wqe_t *wqe = (void *)(unsigned long)scr_addr;
>
>  	return wqe;
>  }
>
> -static inline cvmx_wqe_t *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
> +static inline struct cvmx_wqe_t *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
>  {
>  	return (void *)(unsigned long)wait;
>  }
> @@ -1390,21 +1390,21 @@ static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
>  	return ret;
>  }
>
> -static inline void cvmx_wqe_set_port(cvmx_wqe_t *work, int port)
> +static inline void cvmx_wqe_set_port(struct cvmx_wqe_t *work, int port)
>  { }
>
> -static inline void cvmx_wqe_set_qos(cvmx_wqe_t *work, int qos)
> +static inline void cvmx_wqe_set_qos(struct cvmx_wqe_t *work, int qos)
>  { }
>
> -static inline int cvmx_wqe_get_qos(cvmx_wqe_t *work)
> +static inline int cvmx_wqe_get_qos(struct cvmx_wqe_t *work)
>  {
>  	return 0;
>  }
>
> -static inline void cvmx_wqe_set_grp(cvmx_wqe_t *work, int grp)
> +static inline void cvmx_wqe_set_grp(struct cvmx_wqe_t *work, int grp)
>  { }
>
> -static inline void cvmx_pow_work_submit(cvmx_wqe_t *wqp, uint32_t tag,
> +static inline void cvmx_pow_work_submit(struct cvmx_wqe_t *wqp, uint32_t tag,
>  					enum cvmx_pow_tag_type tag_type,
>  					uint64_t qos, uint64_t grp)
>  { }
> --
> 2.23.0
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1b16bc880fee5711f96ed82741f8268e4dac1ae6.1570773209.git.wambui.karugax%40gmail.com.
>
