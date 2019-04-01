Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A76CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0515120883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfDASU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:20:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:2122 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728670AbfDASU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:20:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 11:20:26 -0700
X-IronPort-AV: E=Sophos;i="5.60,297,1549958400"; 
   d="scan'208";a="287784534"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2019 11:20:26 -0700
Message-ID: <cbbdf9e2cf6a64e749ec889cc946e2a10c793ba2.camel@linux.intel.com>
Subject: Re: [RFC 3/4] net/fib: Check budget before should_{inflate,halve}()
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
Date:   Mon, 01 Apr 2019 11:20:26 -0700
In-Reply-To: <20190326153026.24493-4-dima@arista.com>
References: <20190326153026.24493-1-dima@arista.com>
         <20190326153026.24493-4-dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 15:30 +0000, Dmitry Safonov wrote:
> Those functions are compute-costly, if we're out of budget - better
> omit additional computations.
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  net/ipv4/fib_trie.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index d90cf9dfd443..2ce2739e7693 100644
> --- a/net/ipv4/fib_trie.c
> +++ b/net/ipv4/fib_trie.c
> @@ -868,7 +868,7 @@ static struct key_vector *resize(struct trie *t, struct key_vector *tn,
>  	/* Double as long as the resulting node has a number of
>  	 * nonempty nodes that are above the threshold.
>  	 */
> -	while (should_inflate(tp, tn) && *budget) {
> +	while (*budget && should_inflate(tp, tn)) {
>  		tp = inflate(t, tn, budget);
>  		if (!tp) {
>  #ifdef CONFIG_IP_FIB_TRIE_STATS
> @@ -894,7 +894,7 @@ static struct key_vector *resize(struct trie *t, struct key_vector *tn,
>  	/* Halve as long as the number of empty children in this
>  	 * node is above threshold.
>  	 */
> -	while (should_halve(tp, tn) && *budget) {
> +	while (*budget && should_halve(tp, tn)) {
>  		tp = halve(t, tn, budget);
>  		if (!tp) {
>  #ifdef CONFIG_IP_FIB_TRIE_STATS

Based on my comments in the other patches I would say this is a bad
idea.

Really the budget should allow at least 1 pass through the trie to
attempt to either inflate or deflate the node and all children. This
logic is optimizing for the case where *budget is 0 and that should not
occur that often.

