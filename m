Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD75DC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47C82468B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYd2fiCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfLTDkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 22:40:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28000 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726986AbfLTDka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 22:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576813229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PFBVRMJ+f4l4QVoIfHIgz5QNf+S8Z6WpJRkhA59m9h8=;
        b=WYd2fiCUXDdTrtYe9ERI79EHbU9eT/ulssKy8nvt776HBAmADsfg7NqvgCS/kZC3Xh6fko
        Ogotkq/oezhWz2LNBDOS9KvdZVks8vznrGxqry/vTp7MawF3u0w0am4UrL8TBV33Ac7EcY
        mQluOjniM0C7sIBhXjiEmAyevBMfkkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-aD-4H_m8On2fMRZUaRRUHw-1; Thu, 19 Dec 2019 22:40:25 -0500
X-MC-Unique: aD-4H_m8On2fMRZUaRRUHw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03EEA100551A;
        Fri, 20 Dec 2019 03:40:24 +0000 (UTC)
Received: from [10.72.12.176] (ovpn-12-176.pek2.redhat.com [10.72.12.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F04F5C28F;
        Fri, 20 Dec 2019 03:40:18 +0000 (UTC)
Subject: Re: read_barrier_depends() usage in vhost.c
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        peterz@infradead.org, stern@rowland.harvard.edu
References: <20191218091906.cmzgqnwyekak5dzv@gondor.apana.org.au>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9de4e853-3230-bd2c-c109-07d41b4ff6d6@redhat.com>
Date:   Fri, 20 Dec 2019 11:40:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191218091906.cmzgqnwyekak5dzv@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/12/18 =E4=B8=8B=E5=8D=885:19, Herbert Xu wrote:
> Will Deacon <will@kernel.org> wrote:
>>> --->8
>>>
>>> // drivers/vhost/vhost.c
>>> static int get_indirect(struct vhost_virtqueue *vq,
>>>                        struct iovec iov[], unsigned int iov_size,
>>>                        unsigned int *out_num, unsigned int *in_num,
>>>                        struct vhost_log *log, unsigned int *log_num,
>>>                        struct vring_desc *indirect)
>>> {
>>>        [...]
>>>
>>>        /* We will use the result as an address to read from, so most
>>>         * architectures only need a compiler barrier here. */
>>>        read_barrier_depends();
>>>
>>> --->8
>>>
>>> Unfortunately, although the barrier is commented (hurrah!), it's not
>>> particularly enlightening about the accesses making up the dependency
>>> chain, and I don't understand the supposed need for a compiler barrie=
r
>>> either (read_barrier_depends() doesn't generally provide this).
>>>
>>> Does anybody know which accesses are being ordered here? Usually you'=
d need
>>> a READ_ONCE()/rcu_dereference() beginning the chain, but I haven't ma=
naged
>>> to find one...
> I think what it's trying to separate is using indirect->addr as a
> base and then reading from that through copy_from_iter.
>
> Cheers,


The question is that there's a smp_rmb() before in vhost_get_vq_desc(),=20
isn't it sufficient to do this?

Thanks

