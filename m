Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D0ACA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E792084B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FRnJsusz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392384AbfJXB2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 21:28:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfJXB2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jD3ajuwfKZdk4JSIR8vGZp1pzv/W899TJw8TAPz4bwc=; b=FRnJsusz6bSIUrtKJ6Rs+PrZV
        Rc9FtFgXZBhIBEkKenmtYBEcir5YrbubUFQYHHfE9g3/FDpXB9kOL6/1Qi8+G01C/rQSE9aNme4yY
        MMUmUSJI9YGor3UtogZ2VQcLoi4/y5H1P5oNsd1xDjt91IesmvUN7ADATTlrxwp1MnQEiafDwsv/F
        LNFly8yS18xzdzOqDRwRCYir98guFp+/o/79TgnadysBMIB1udT59a6QXxt800zUNNA2746hL0T3H
        zlkrcgr/f2f6i3eHFi9uPvDkQD/xlBuvSX6NWogmJNaCUZQqy6hFOUK7QAqJowy+BBJYut9znFEQU
        jrUOn0UQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNRvl-0000AW-1o; Thu, 24 Oct 2019 01:28:49 +0000
Date:   Wed, 23 Oct 2019 18:28:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Omer Shpigelman <oshpigelman@habana.ai>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] habanalabs: support kernel memory mapping
Message-ID: <20191024012849.GB32358@infradead.org>
References: <20191022063028.9030-1-oshpigelman@habana.ai>
 <20191023092035.GA12222@infradead.org>
 <AM6PR0202MB3382B554A4C7F0F677A804D7B86B0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR0202MB3382B554A4C7F0F677A804D7B86B0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 01:39:41PM +0000, Omer Shpigelman wrote:
> I'm not sure I understand. Can you please pin point the problematic line?

Every line you touch addr field basically.  If you have a kernel
address please store it in an actual C pointer type, not in a u64
to ensure that the compiler can do proper type checking.
