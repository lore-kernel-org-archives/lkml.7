Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0272C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 00:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5562085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 00:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgACAWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 19:22:50 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55190 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgACAWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 19:22:50 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A56D3157204A1;
        Thu,  2 Jan 2020 16:22:49 -0800 (PST)
Date:   Thu, 02 Jan 2020 16:22:49 -0800 (PST)
Message-Id: <20200102.162249.948673283541180133.davem@davemloft.net>
To:     wgong@codeaurora.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH] net: qrtr: fix len of skb_put_padto in
 qrtr_node_enqueue
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191231093242.6320-1-wgong@codeaurora.org>
References: <20191231093242.6320-1-wgong@codeaurora.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 02 Jan 2020 16:22:49 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>
Date: Tue, 31 Dec 2019 17:32:42 +0800

> From: Carl Huang <cjhuang@codeaurora.org>
> 
> The len used for skb_put_padto is wrong, it need to add len of hdr.
> 
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
 ...
> @@ -196,7 +196,7 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>  	hdr->size = cpu_to_le32(len);
>  	hdr->confirm_rx = 0;
>  
> -	skb_put_padto(skb, ALIGN(len, 4));
> +	skb_put_padto(skb, ALIGN(len, 4) + sizeof(*hdr));

I don't think this is correct.

The 'hdr' was already "pushed" earlier in this file.

Here we are padding the area after the header, which is being "put".

I'm not applying this.  If you still think it is correct, you must explain
in detail why it is and add that description to the commit log message.

Thank you.

