Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203E5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B6120880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfDAPks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:40:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:14501 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfDAPks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:40:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 08:40:47 -0700
X-IronPort-AV: E=Sophos;i="5.60,297,1549958400"; 
   d="scan'208";a="219511740"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2019 08:40:47 -0700
Message-ID: <5beb631cf0dcc03d5afad3a29671677bdbc7b931.camel@linux.intel.com>
Subject: Re: [RFC 1/4] net/ipv4/fib: Remove run-time check in tnode_alloc()
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
Date:   Mon, 01 Apr 2019 08:40:47 -0700
In-Reply-To: <20190326153026.24493-2-dima@arista.com>
References: <20190326153026.24493-1-dima@arista.com>
         <20190326153026.24493-2-dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 15:30 +0000, Dmitry Safonov wrote:
> TNODE_KMALLOC_MAX is not used anywhere, while TNODE_VMALLOC_MAX check in
> tnode_alloc() only adds additional cmp/jmp instructions to tnode
> allocation. During rebalancing of the trie the function can be called
> thousands of times. Runtime check takes cache line and predictor entry.
> Futhermore, this check is always false on 64-bit platfroms and ipv4 has
> only 4 byte address range and bits are limited by KEYLENGTH (32).
> 
> Move the check under unlikely() and change comparison to BITS_PER_LONG,
> optimizing allocation of tnode during rebalancing (and removing it
> complitely for platforms with BITS_PER_LONG > KEYLENGTH).
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  net/ipv4/fib_trie.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index a573e37e0615..ad7d56c421cb 100644
> --- a/net/ipv4/fib_trie.c
> +++ b/net/ipv4/fib_trie.c
> @@ -312,11 +312,6 @@ static inline void alias_free_mem_rcu(struct fib_alias *fa)
>  	call_rcu(&fa->rcu, __alias_free_mem);
>  }
>  
> -#define TNODE_KMALLOC_MAX \
> -	ilog2((PAGE_SIZE - TNODE_SIZE(0)) / sizeof(struct key_vector *))
> -#define TNODE_VMALLOC_MAX \
> -	ilog2((SIZE_MAX - TNODE_SIZE(0)) / sizeof(struct key_vector *))
> -
>  static void __node_free_rcu(struct rcu_head *head)
>  {
>  	struct tnode *n = container_of(head, struct tnode, rcu);
> @@ -333,8 +328,7 @@ static struct tnode *tnode_alloc(int bits)
>  {
>  	size_t size;
>  
> -	/* verify bits is within bounds */
> -	if (bits > TNODE_VMALLOC_MAX)
> +	if ((BITS_PER_LONG <= KEYLENGTH) && unlikely(bits >= BITS_PER_LONG))
>  		return NULL;
>  
>  	/* determine size and verify it is non-zero and didn't overflow */

I think it would be better if we left TNODE_VMALLOC_MAX instead of
replacing it with BITS_PER_LONG. This way we know that we are limited
by the size of the node on 32b systems, and by the KEYLENGTH on 64b
systems. The basic idea is to maintain the logic as to why we are doing
it this way instead of just burying things by using built in constants
that are close enough to work.

So for example I believe TNODE_VMALLOC_MAX is 31 on a 32b system. The
main reason for that is because we have to subtract the TNODE_SIZE from
the upper limit for size. By replacing TNODE_VMALLOC_MAX with
BITS_PER_LONG that becomes abstracted away and it becomes more likely
that somebody will mishandle it later.

- Alex

