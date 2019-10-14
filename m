Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B647C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF1F21928
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o99ZYYOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733249AbfJNPFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:05:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733173AbfJNPFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5I0CZjdT/2pnYNFsgHQmuSO9JIMdOamZSLZFBh5OmRw=; b=o99ZYYOVu1tmiw7Abm9PzOv3P
        Va9JabPCGjikdbIolMWRy/pW42cZP+ZM0EGsWhlC9EWWSQ2xEHJEsHRaRCceD3xwlAr8q5LB0dYt7
        tA3HjseMFc96j7CH8yS07sFe9QNgMOAxK64wSelG8GjP8iCqmRyfBm1KsFtXUVxfT9SvpvJOAQ168
        dML17pRW7isucTPVwXPzK0bvMrmmdNsQ0BDrkbgCvxQfq/bSDneEKjIA4ux9VkKu1ZFSPD/KDY12A
        buIK92g4TXyyeoSXOMsXfZj1Fz/P89yXBay4uJO5eVqr3rTXlmPtuGPFLga7bI1V3eLvt8xE3of2w
        0O6hI4Mrw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iK1uE-0007fP-VL; Mon, 14 Oct 2019 15:05:06 +0000
Date:   Mon, 14 Oct 2019 08:05:06 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH 1/2] kasan: detect negative size in memory operation
 function
Message-ID: <20191014150506.GX32665@bombadil.infradead.org>
References: <20191014103632.17930-1-walter-zh.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014103632.17930-1-walter-zh.wu@mediatek.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 06:36:32PM +0800, Walter Wu wrote:
> @@ -110,8 +111,9 @@ void *memset(void *addr, int c, size_t len)
>  #undef memmove
>  void *memmove(void *dest, const void *src, size_t len)
>  {
> -	check_memory_region((unsigned long)src, len, false, _RET_IP_);
> -	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> +	if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> +	!check_memory_region((unsigned long)dest, len, true, _RET_IP_))

This indentation is wrong.  Should be:
+	if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
+	    !check_memory_region((unsigned long)dest, len, true, _RET_IP_))

(also in one subsequent function)
