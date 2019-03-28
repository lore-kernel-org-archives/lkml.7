Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740B9C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FBC217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9uzCEdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfC1Luh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:50:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34609 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726224AbfC1Luh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:50:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 217BF21CE7;
        Thu, 28 Mar 2019 07:50:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 28 Mar 2019 07:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=CcTuxXyWOS0yjLFti3go8bFBxxJeXJfGM9tjdI39V
        eM=; b=g9uzCEdF7W61j4UC8oGpsglnHI1//g6wM7CpHOGVrdAJPxQBLnpgEq7jz
        iGFEU/gKwoZASsmip9qqMqs5lvxETwaDxIVtLz0xmG+tZ1toEOpq3gUqJ2UoRQWu
        z1uCOsdFwSfe07ghiAzYFj89Hqa8Pi9Fn/sw7BpvNqKQdpvug1aU9mq2w/+jaz5n
        kZLvEAm2Nrqkvu6yRJUDJpKyEtd2rK+Hpzv5gmGpndf+x+2hr9AcIP5shmNDlXxO
        3vtonBKjQbZ04bJGSgLkL2/mk/G4FVF2mQgXWWJwSxRSrqQCrEmUxZkAbT2qjZ8X
        X/hvAMAvpr7j9bdd5LfCwude8K6fw==
X-ME-Sender: <xms:CbWcXDAx6_XrYJ8XJKyHMtEt4zgYNRvYaWOfPUb6e_A1vZ67rPz_2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkeeggdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefrvghkkhgr
    ucfgnhgsvghrghcuoehpvghnsggvrhhgsehikhhirdhfiheqnecukfhppeekledrvdejrd
    effedrudejfeenucfrrghrrghmpehmrghilhhfrhhomhepphgvnhgsvghrghesihhkihdr
    fhhinecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:CbWcXD8gBJkfkAwEoSxiCqpsUlHbjixmccyiiQ_K3KiGVGraPacdSA>
    <xmx:CbWcXFWkqFeKXeIbysLYMKOddL1n-NRlAZB97erQAqIvYgl7JQi0kg>
    <xmx:CbWcXANJYGvSWsn8Jx1w3Hx_aN58rZLtvSpH7mpdVeA3QkaBBvyLUQ>
    <xmx:DLWcXCG2WffXFbdFlAnReQD4gIcRCIBch_q3m9EiurFdAXCu5na9dQ>
Received: from Pekka-MacBook.local (89-27-33-173.bb.dnainternet.fi [89.27.33.173])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2FA65100E5;
        Thu, 28 Mar 2019 07:50:31 -0400 (EDT)
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, cl@linux.com,
        mhocko@kernel.org, willy@infradead.org, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190327005948.24263-1-cai@lca.pw>
 <c49208bf-b658-1d4e-a57e-8ca58c69afb1@iki.fi>
 <20190328103020.GA10283@arrakis.emea.arm.com>
From:   Pekka Enberg <penberg@iki.fi>
Message-ID: <8e88b618-e774-de81-ca99-a8ee89f60b5a@iki.fi>
Date:   Thu, 28 Mar 2019 13:50:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190328103020.GA10283@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 27/03/2019 2.59, Qian Cai wrote:
>>> Unless there is a brave soul to reimplement the kmemleak to embed it's
>>> metadata into the tracked memory itself in a foreseeable future, this
>>> provides a good balance between enabling kmemleak in a low-memory
>>> situation and not introducing too much hackiness into the existing
>>> code for now.

On Thu, Mar 28, 2019 at 08:05:31AM +0200, Pekka Enberg wrote:
>> Unfortunately I am not that brave soul, but I'm wondering what the
>> complication here is? It shouldn't be too hard to teach calculate_sizes() in
>> SLUB about a new SLAB_KMEMLEAK flag that reserves spaces for the metadata.

On 28/03/2019 12.30, Catalin Marinas wrote:> I don't think it's the 
calculate_sizes() that's the hard part. The way
> kmemleak is designed assumes that the metadata has a longer lifespan
> than the slab object it is tracking (and refcounted via
> get_object/put_object()). We'd have to replace some of the
> rcu_read_(un)lock() regions with a full kmemleak_lock together with a
> few more tweaks to allow the release of kmemleak_lock during memory
> scanning (which can take minutes; so it needs to be safe w.r.t. metadata
> freeing, currently relying on a deferred RCU freeing).

Right.

I think SLUB already supports delaying object freeing because of KASAN 
(see the slab_free_freelist_hook() function) so the issue with metadata 
outliving object is solvable (although will consume more memory).

I can't say I remember enough details from kmemleak to comment on the 
locking complications you point out, though.

- Pekka
