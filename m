Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD26C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFF4227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfLRJTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:19:21 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:38702 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfLRJTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:19:18 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ihVU7-0005vy-3b; Wed, 18 Dec 2019 17:19:11 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ihVU3-00028K-0i; Wed, 18 Dec 2019 17:19:07 +0800
Date:   Wed, 18 Dec 2019 17:19:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Will Deacon <will@kernel.org>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: read_barrier_depends() usage in vhost.c
Message-ID: <20191218091906.cmzgqnwyekak5dzv@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016233602.i2afxb5mb465laq6@willie-the-truck>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.virtualization
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon <will@kernel.org> wrote:
>
>> --->8
>> 
>> // drivers/vhost/vhost.c
>> static int get_indirect(struct vhost_virtqueue *vq,
>>                       struct iovec iov[], unsigned int iov_size,
>>                       unsigned int *out_num, unsigned int *in_num,
>>                       struct vhost_log *log, unsigned int *log_num,
>>                       struct vring_desc *indirect)
>> {
>>       [...]
>> 
>>       /* We will use the result as an address to read from, so most
>>        * architectures only need a compiler barrier here. */
>>       read_barrier_depends();
>> 
>> --->8
>> 
>> Unfortunately, although the barrier is commented (hurrah!), it's not
>> particularly enlightening about the accesses making up the dependency
>> chain, and I don't understand the supposed need for a compiler barrier
>> either (read_barrier_depends() doesn't generally provide this).
>> 
>> Does anybody know which accesses are being ordered here? Usually you'd need
>> a READ_ONCE()/rcu_dereference() beginning the chain, but I haven't managed
>> to find one...

I think what it's trying to separate is using indirect->addr as a
base and then reading from that through copy_from_iter.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
