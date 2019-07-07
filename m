Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E09C48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 20:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E26220663
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 20:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfGGUHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 16:07:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41974 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfGGUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 16:07:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 604121527D7F4;
        Sun,  7 Jul 2019 13:07:52 -0700 (PDT)
Date:   Sun, 07 Jul 2019 13:07:51 -0700 (PDT)
Message-Id: <20190707.130751.259550761475180.davem@davemloft.net>
To:     albin_yang@163.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH net] nfc: fix potential illegal memory access
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1562506660-15853-1-git-send-email-albin_yang@163.com>
References: <1562506660-15853-1-git-send-email-albin_yang@163.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 07 Jul 2019 13:07:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Wei <albin_yang@163.com>
Date: Sun,  7 Jul 2019 21:37:40 +0800

> The frags_q is used before __skb_queue_head_init when conn_info is
> NULL. It may result in illegal memory access.
> 
> Signed-off-by: Yang Wei <albin_yang@163.com>
> ---
>  net/nfc/nci/data.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
> index 0a0c265..b5f16cb 100644
> --- a/net/nfc/nci/data.c
> +++ b/net/nfc/nci/data.c
> @@ -104,14 +104,14 @@ static int nci_queue_tx_data_frags(struct nci_dev *ndev,
>  
>  	pr_debug("conn_id 0x%x, total_len %d\n", conn_id, total_len);
>  
> +	__skb_queue_head_init(&frags_q);
> +
>  	conn_info = nci_get_conn_info_by_conn_id(ndev, conn_id);
>  	if (!conn_info) {
>  		rc = -EPROTO;
>  		goto free_exit;
>  	}
>  
> -	__skb_queue_head_init(&frags_q);
> -

Just change the goto into "goto exit;", much simpler one-line fix.
