Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCC6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7492133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l/Cyl8vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfCHOMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:12:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfCHOMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aQc0SyowOdTmxrkU2xp2xFOofpRQZkuv8UFO0ktx/Gw=; b=l/Cyl8vyTvDwqSnNGu+5hMY12
        7QQ4o+sc3edmPS09IezABK15wlZW6k9rwF3gFP+7/jqA5V7RHy5tzk1qtzM8Sndq08YlArFd9CD1Q
        spSIjJhhR6pcrx90oxnbZBy355+sSdWeMoXu9ObKhzB+bVN0CQaQJhw1I5E8NsutG72MPa5twt1Su
        cGXv9XQE9XF/lpzlYXjNCJDb3/2462UGi5AyXHq+iSCs+WlNmZowjcaL8sllXycDVE06H2QknUzS2
        NSARjQDBHU0ii6zLqLbBouH1vpo+82oU3YYOjM3BaiaW3nITV6H8+e3bdTaIVQx7uP8t2oCVMKvdA
        BZun3Zvuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2GEW-0006nZ-PD; Fri, 08 Mar 2019 14:12:20 +0000
Date:   Fri, 8 Mar 2019 06:12:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, aarcange@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
Message-ID: <20190308141220.GA21082@infradead.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 02:18:07AM -0500, Jason Wang wrote:
> This series tries to access virtqueue metadata through kernel virtual
> address instead of copy_user() friends since they had too much
> overheads like checks, spec barriers or even hardware feature
> toggling. This is done through setup kernel address through vmap() and
> resigter MMU notifier for invalidation.
> 
> Test shows about 24% improvement on TX PPS. TCP_STREAM doesn't see
> obvious improvement.

How is this going to work for CPUs with virtually tagged caches?
