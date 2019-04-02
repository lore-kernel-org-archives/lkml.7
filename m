Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C210C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553E221738
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H9dsrtV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfDBL06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:26:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBL05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YxIQd0UrH8O9EYTD4F5l3+7Mbk+tK6paTxHr+FkZ/qk=; b=H9dsrtV3ayKtR4GhPwIXU85l+
        R1Z5x0HkUofktDxYlno5zDJCNSdCrdVxr7eIZf837srzTCfJYQNhR+rVhXO7poFVzPiLBm3QcZziL
        3zIOeZvumBptrQPofHmtb3IQSvM0Di/MtXtmmtMyFHrOVzE/OMkJiRRHZg/Z/VhJhYVVYbCMQ3fwC
        xUpOe+naJVev8euou/E9qFOrJhjTZHt6zwCTnV6MA5pC3/HgTLRSqHqLW5Ghzge9ck3m+b8WRujTa
        zo7jJSB+b8A5QloFPD7DV3jNsDZwa0MJn4moWG9P8vwK59lvOamRafUSX1cw1c3kcXigqIq8LlSBm
        7ouhjMFJA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBHZA-0006OV-Br; Tue, 02 Apr 2019 11:26:56 +0000
Date:   Tue, 2 Apr 2019 04:26:56 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Qiang Yu <yuq825@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20190402112656.GE22763@bombadil.infradead.org>
References: <20190402105006.48f93e53@canb.auug.org.au>
 <CAKGbVbvj9cZnJuey_ra7U+xm-JhoB17bpTgcXKiKaHWbjB9Sxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKGbVbvj9cZnJuey_ra7U+xm-JhoB17bpTgcXKiKaHWbjB9Sxw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 01:55:03PM +0800, Qiang Yu wrote:
> Thanks, patch is:
> Reviewed-by: Qiang Yu <yuq825@gmail.com>

This looks like a fairly naive conversion from the old IDR API to the
XArray API.  You should be able to remove mgr->lock entirely, relying on
the xa_lock for synchronising free and get.  If you think it's worth it,
you could even use kfree_rcu() to free the ctx and kref_get_unless_zero()
and then your get path would be lock-free.
