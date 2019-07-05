Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797F6C4649F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DF520856
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="I/9cvSKF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hw+amZCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfGEQDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:03:24 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38929 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbfGEQDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:03:22 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E434F21BF9;
        Fri,  5 Jul 2019 12:03:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 05 Jul 2019 12:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=nxXsrBvSCyfZn7lvsUnCveEU0u1
        qRR/TUCZV5FoBGPw=; b=I/9cvSKFgp4r/1SqBkTpdd3ht7IToDsDIMuw32MM9kf
        x580JDtAMKwkK0T3mmgL0JEhKLa6UouMTedsaxmZTR1K3ch4X+A3vn0q9M/XiYNO
        DDBSwIaDPshSzvOuNtX1T2QQgLFq7440Ppz+sJ4A6vUyHLYoH7OBb4KwbeC7v6b+
        yavdbhrwnEsYhOG4K9Wb2YcpW1VwSdZHrgXSg87m6bDgpgerPCg5hZre7NVcDDy+
        ZIdev1QbGVXtQzCIvYMF0ZpU2JaBD3w4NWTWipFYKyINtBfBrpkG/yA2J4unEX/K
        A0c5eCgOy0n7OpnX0b9Kd+QdLKdcXVt32jsdnEE743w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=nxXsrB
        vSCyfZn7lvsUnCveEU0u1qRR/TUCZV5FoBGPw=; b=Hw+amZCXOUBtTBXNBl8Nm0
        h38hg4kgl4n1+zZ3UXylSlGZzUuziDkwYTr0AFNXbRbs7KXJcpvcQ18OSsb+W6tR
        DY6kfRT67vwn6dC7bmpuekuCpbSa8NFGZMt5qSpOeLSxJgwGlGob/nWx7rzhjTMz
        E0/PDeZA5opQ40vrXjkNx1b5JfIvkMTBjFIIgfZVU4QDn/j+Y9nyvCsUEdrvj60X
        Gk4AL1f6xZ6/iBUu9x9SQouOgdGwbKjgecTQ2L4jHNMlgIj7MaZcAa11mTOHU8WH
        VffW3zzZzIz6uw9JCvLZnwuMaQSEJN13YycYjraHSwkVtorPbBAuuHG9Pyq779fg
        ==
X-ME-Sender: <xms:yHQfXT7Z4_kTN8UqwTFZmfrkg_Tr3iubnc18i-nwgZQtwNDkwe6Ydg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrfeeggdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjfgesthdtre
    dttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:yHQfXdwKK6GcjoaGCRS5n8a83Rm7TUt6qhPdgP780elqnH7sizu4eA>
    <xmx:yHQfXTCQMUlX8_R4_hSmDPw6gTifccnkE0Jk4UZZ8V0P3GZJ5grALw>
    <xmx:yHQfXVbT6BmgthCH2eetW_2EYRpYaW8_aU497nqaayLsSH7ynrykYA>
    <xmx:yHQfXTwDg7E-eQq2P8FQgqJOM9FfN55OlWksKH0M13AxCqTPCVKFCA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1ADCB380074;
        Fri,  5 Jul 2019 12:03:20 -0400 (EDT)
Date:   Fri, 5 Jul 2019 18:03:18 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     gnault@redhat.com, stable-commits@vger.kernel.org
Subject: Re: Patch "netfilter: ipv6: nf_defrag: accept duplicate fragments
 again" has been added to the 4.19-stable tree
Message-ID: <20190705160318.GA632@kroah.com>
References: <20190705140421.28F82218D2@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705140421.28F82218D2@mail.kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 10:04:20AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     netfilter: ipv6: nf_defrag: accept duplicate fragments again
> 
> to the 4.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      netfilter-ipv6-nf_defrag-accept-duplicate-fragments-.patch
> and it can be found in the queue-4.19 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 447d05e723b06f8aa1a9cba0f7b4c0029924663c
> Author: Guillaume Nault <gnault@redhat.com>
> Date:   Thu Jun 6 18:04:00 2019 +0200
> 
>     netfilter: ipv6: nf_defrag: accept duplicate fragments again
>     
>     [ Upstream commit 8a3dca632538c550930ce8bafa8c906b130d35cf ]
>     
>     When fixing the skb leak introduced by the conversion to rbtree, I
>     forgot about the special case of duplicate fragments. The condition
>     under the 'insert_error' label isn't effective anymore as
>     nf_ct_frg6_gather() doesn't override the returned value anymore. So
>     duplicate fragments now get NF_DROP verdict.
>     
>     To accept duplicate fragments again, handle them specially as soon as
>     inet_frag_queue_insert() reports them. Return -EINPROGRESS which will
>     translate to NF_STOLEN verdict, like any accepted fragment. However,
>     such packets don't carry any new information and aren't queued, so we
>     just drop them immediately.
>     
>     Fixes: a0d56cb911ca ("netfilter: ipv6: nf_defrag: fix leakage of unqueued fragments")
>     Signed-off-by: Guillaume Nault <gnault@redhat.com>
>     Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

Why not add this to 5.1.y as well?

thanks,

greg k-h
