Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7D5C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F6225B65
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kOSaHrM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfEaQdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:33:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfEaQdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WTUY7NBoeWu3HANU6zgkoF6y+9haCI+guBTHb7hiLQ4=; b=kOSaHrM1/+3xoN7VP+2/XAyIb
        e2QtjGyy6cSvbl/o1vYjkLd9UlvTqQ3mm0osfb8rbpd5JocxX/TJ8slNK25rmAkmmpzM7HgwR2+eh
        WhiVeFQoAkEXli0htbkyT8C4xqyupYhtfraT2e/HuM2PihzxLv41Zp/zyI/Twlegfm0D7EkDYyPFc
        Urxd8U+ppSjxaKeq3usHNtKhUFV8ynCvX2UTJrF1qyctEahR+7/X5xVCn33Z77FGT0ffmDGH/67fg
        rnXrVyphgRP2hQou3fjvugCONiaJ4p08WN3boxSUPDHssbhRpPHHGrTaR8l/9CC6dZn1vzu17VZpc
        lgdC359cQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWkTW-00044S-Uo; Fri, 31 May 2019 16:33:50 +0000
Date:   Fri, 31 May 2019 09:33:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Miller <davem@davemloft.net>
Cc:     laurentiu.tudor@nxp.com, madalin.bucur@nxp.com,
        netdev@vger.kernel.org, roy.pledge@nxp.com,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        Joakim.Tjernlund@infinera.com, iommu@lists.linux-foundation.org,
        camelia.groza@nxp.com, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/6] Prerequisites for NXP LS104xA SMMU enablement
Message-ID: <20190531163350.GB8708@infradead.org>
References: <20190530141951.6704-1-laurentiu.tudor@nxp.com>
 <20190530.150844.1826796344374758568.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530.150844.1826796344374758568.davem@davemloft.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 03:08:44PM -0700, David Miller wrote:
> From: laurentiu.tudor@nxp.com
> Date: Thu, 30 May 2019 17:19:45 +0300
> 
> > Depends on this pull request:
> > 
> >  http://lists.infradead.org/pipermail/linux-arm-kernel/2019-May/653554.html
> 
> I'm not sure how you want me to handle this.

The thing needs to be completely redone as it abuses parts of the
iommu API in a completely unacceptable way.
