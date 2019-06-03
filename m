Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF51C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFCF273C4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OQe3dlwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfFCQkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:40:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfFCQkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Tjyhgy2fgeHHPnpoqtNQPAm53pWhbWbj3ulml192Dyk=; b=OQe3dlwtD7AjT43Hir+bEmntv
        h/UiBgIn/xIsXSkDNUE/Fs8lzhUahXAGEBmByXKmOv0y0nHoa3T7Q+TgNb6kQYJY8KQF1KLZTpjDT
        RqkoVsGcsOn4R8ILir3fcdP5xFGTWWanJkLWnQWPq9lu1+5VHtV4jrFBKQMSC1sK4BznZamw2u2+a
        KYK1HR0fIF1CepFnvTP8GMevU+IECw/M02uo+q4hd29HuTrSuRtI8XDDnv77hN7Vjcry6elFGznK7
        jTkkvCWwMTR4qCZC/4FCGB4FmRx/oZ/eefAHTzB489pfzsBvFCfEiFc+9VnBRjaayQYk1ATEZMDaC
        YzRA4o3Kg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hXq0K-0002MX-OR; Mon, 03 Jun 2019 16:40:12 +0000
Date:   Mon, 3 Jun 2019 09:40:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] ARC: build: Try to guess CROSS_COMPILE with
 cc-cross-prefix
Message-ID: <20190603164012.GA29719@infradead.org>
References: <20190603063119.36544-1-abrodkin@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603063119.36544-1-abrodkin@synopsys.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wish we could just set CROSS_COMPILE and ARCH in .config.  That would
make everyones life compile testing on multiple architectures so much
easier.
