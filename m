Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5261CC2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CEB2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575916397;
	bh=PzahWwtA6K6WkU342K07lvpv8VhPjHQjg5sJaUv03vk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=yPcr8N7Spc9Udmium1krIVXp9M41ruiOs43HEFqFMXcyt3Gbh3K2/Cv+t+j3gRUb0
	 5o2/XFUMSp7olznyg6XoFauPtKQ4GbmqiQ3258s3Y8plB3Koo60zUYS68JmzzHgyCw
	 r2wvMKM+3KKZ3SiCzL+qzZ71+1Jyre4K7h5NVFag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfLISdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:33:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfLISdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:33:14 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB4742077B;
        Mon,  9 Dec 2019 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575916393;
        bh=PzahWwtA6K6WkU342K07lvpv8VhPjHQjg5sJaUv03vk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ysYVaXkQCshut8JuLNzNQJ9tT7W/P39aAhGL2xDQd8zB5xnMDtfNmSWWJK1ber59S
         qaseNdO03e+O5jyuijIF3Vvj9xFcgXFbrao+2sjlOBXfkfRNlqlvmz1aQtt5fJepal
         IZcv9jE+9Wsn+N4+1m3Qfp9/+TZPAch3LGqZQ6hI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 62AD43522769; Mon,  9 Dec 2019 10:33:13 -0800 (PST)
Date:   Mon, 9 Dec 2019 10:33:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] rculist.h: Add list_tail_rcu()
Message-ID: <20191209183313.GL2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191209075043.17947-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209075043.17947-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 01:20:43PM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> This patch adds the macro list_tail_rcu() and document it.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Queued with slight edits, thank you very much!

							Thanx, Paul

> ---
>  include/linux/rculist.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index 4b7ae1bf50b3..9f21efa525ab 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -40,6 +40,16 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
>   */
>  #define list_next_rcu(list)	(*((struct list_head __rcu **)(&(list)->next)))
>  
> +/**
> + * list_tail_rcu - returns the prev pointer of the head of the list
> + * @head: the head of the list
> + *
> + * Note: This should only be used with the list header,
> + * but only if list_del() and similar primitives are not
> + * also used on the list header.
> + */
> +#define list_tail_rcu(head)	(*((struct list_head __rcu **)(&(head)->prev)))
> +
>  /*
>   * Check during list traversal that we are within an RCU reader
>   */
> -- 
> 2.17.1
> 
