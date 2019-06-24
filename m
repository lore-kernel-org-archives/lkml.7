Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E48DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9FC208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BohYL1cB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfFXHEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:04:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50038 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfFXHEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OoUthh4K4QVJptThzzsksGKju8VbXnICnnIphBGevoY=; b=BohYL1cB9GVEVEEB/AQ+8Wjp+
        b9vzWf/zdBChO5/Yxc6ATgd75pIyE2sUBr9MEVSXGU/iabRj+A7a/YiVSO98Mhva/KDGjks8AulSq
        XyqeR6U2u1kwW76TBuewbiVFdJsBNtOgafjIeXWZEbYEG6mEyfDQkyWmtRoU8RE3FRIYHOzHuk5vf
        JRh0putoHM099rGuVjmQHkDrQ6wcOUyyFof//B/CD6vJiszBlSqCvk5ikDiHNXBHO4EmpcRrlSVAE
        YEirofTW1iSPhXf11n+fiEqcpqvkNDItmurm7DbKV7yv4/QvyVisvbi/clmel2U/YLe5Riq9USF2z
        BDkMd0B9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hfJ1R-0007yG-74; Mon, 24 Jun 2019 07:04:13 +0000
Date:   Mon, 24 Jun 2019 00:04:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] gpu: host1x: Remove implicit IOMMU backing on
 client's registration
Message-ID: <20190624070413.GA23846@infradead.org>
References: <20190623173743.24088-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623173743.24088-1-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't we have a device tree problem here if there is a domain covering
them?  I though we should only pick up an IOMMU for a given device
if DT explicitly asked for that?
