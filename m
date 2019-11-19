Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFFCC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED21922318
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574137850;
	bh=T37bxWVhJKKhbkDEGYOqyIok1+0lbyLc5krYCRyZ/rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CmlCG5nTdnOko43XLu62+1r6YWcKkpZFoTxGVBqrni3AXUOKNsRWo/RKdBe5vbIOt
	 I7JTFaUbVFMNDQPxwsnz9kKUByaR8MC9lNRtAXd8AlD2ISGi1tJdZe+weA+1AGL9xf
	 T5ov0/NG/HhCpt7XsoGWZTyP6S0rDFI7HzXujXfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfKSEat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 23:30:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfKSEas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 23:30:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CB6922316;
        Tue, 19 Nov 2019 04:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574137846;
        bh=T37bxWVhJKKhbkDEGYOqyIok1+0lbyLc5krYCRyZ/rQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lWq0fdyNOB73+P+FwU+ZXEW0zXXHJHTf+oJe0KRum+B/NFZ+zcVHeXDFUEXoOQ6mN
         AJpegyTyXrHPmLxUV2c7NgN3Dp195roY3XdCr4d6d4kKJimLcMw09RlgfmFdDyRImC
         T5w1vNN0wPXniGL0ttZZqRoUpbWuuNl1eO8fCvyQ=
Date:   Tue, 19 Nov 2019 05:30:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] coresight: funnel: Fix missing spin_lock_init()
Message-ID: <20191119043044.GB1446085@kroah.com>
References: <20191118185207.30441-1-mathieu.poirier@linaro.org>
 <20191118185207.30441-2-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118185207.30441-2-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 11:52:06AM -0700, Mathieu Poirier wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> The driver allocates the spinlock but not initialize it.
> Use spin_lock_init() on it to initialize it correctly.
> 
> This is detected by Coccinelle semantic patch.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Tested-by: Yabin Cui <yabinc@google.com>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-funnel.c | 1 +
>  1 file changed, 1 insertion(+)

Is this, and the 2/2 patch here, needed for stable releases?

thanks,

greg k-h
