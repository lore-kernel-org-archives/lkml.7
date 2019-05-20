Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142E8C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF034214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NHqq3GHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392997AbfETRft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:35:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387560AbfETRfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CsywoW2o9YLJ9jNz4GPRvKpa5ukQ3xRtuV6BLonYynA=; b=NHqq3GHEI2/OOEZKX18l+tkn1
        e3rnjH1uM68rWoVn71z0EZyHPciGMMKLu78t+vx3/z6SDv1J/T6zODYL3dYkURh4g52GtL2p775zY
        BTn+1XF/8uzEGJiYFUjyz/pKuwyLwdrKAtAypr8/YcAUYTObVqsH6Osdc1QNOQ5QNtjK8YVaGIBD2
        rduLKlJ/iJBrd1nhLVr3WkJLmvU6J3U81uE96zMQSdAHi6rauC1lWWlL01OLVeWqv8h+G0jnqL2Ck
        c81G+Z/8pSX3tslABXBPnEF9lL7iIacISnPg/c7uKLwFLNXhUdMBJfYCxv7W7pFsrdGKl/MXqIOzX
        NDMX0E5Cw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSmCM-0007tV-0l; Mon, 20 May 2019 17:35:42 +0000
Date:   Mon, 20 May 2019 10:35:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alex Elder <elder@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 12/18] soc: qcom: ipa: immediate commands
Message-ID: <20190520173541.GA30280@infradead.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-13-elder@linaro.org>
 <CAK8P3a3v2fzSBmYk1vG7sKJ9jnAWGt_u91EuLC7f5jq_PqrKXQ@mail.gmail.com>
 <f92bfb59-07bb-e8c0-c307-cd69da7ccd8a@linaro.org>
 <5d948d74-f739-0cfa-8fae-b15c20fbe7ec@linaro.org>
 <CAK8P3a3161Oc3ALB74LTuDny-aO9E4VGYpmqQSNoDNbj6PhRsQ@mail.gmail.com>
 <d29335f3-75f3-00f6-8ae9-690ef3bffa96@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d29335f3-75f3-00f6-8ae9-690ef3bffa96@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 09:55:42AM -0500, Alex Elder wrote:
> On 5/20/19 9:50 AM, Arnd Bergmann wrote:
> > Ok, that sounds reasonable, yes. I'm not sure if
> > dma_alloc_coherent() guarantees zero-initialization
> > though, so if that is required, you may have to
> > add a memset().
> I had dma_zalloc_coherent() originally but I think
> Christoph Hellwig posted something recently that
> removed that function, because dma_alloc_coherent()
> always zeroes the underlying memory.
> 
> +Christoph, who might be able to explain or confirm

dma_alloc_coherent always zeroes the returned memory, which
is why dma_zalloc_coherent has been removed.
