Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAACC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9ED22CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FJTvHrbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfICIqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:46:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfICIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b70sepwhN8q1iqLMO3aK0ToUTreTjvrdLY0yLnuLs1s=; b=FJTvHrbiUE5UkVsFYMAHXOD2I
        sCg2YlKoLGXVGsfFYYG0Jn5K9fgTDd4GB7Up7EM82M9wTLdBskzVnHkmVTT7Uv6eyYP8vU2o1lbcK
        BXVE97NOqNi/on8BQTU3FivWew6c9b/vJHjwovZh7U0hMMnweK4r4KbCuFs2MMDx2NEWJ3fPQqyM5
        ac+3uIhJROXdxr2uzo/9G7sdY1R1PVG1AkkVV9tmRtF53BssRlwSdGuheiBXCm7cZKmhgE9eSqz0p
        q5Ss89/LkA6f+pl1QkKmE3dARRBd9dtO1654xqflNqs7M73zhXSZqZ2g4W2D1qcrgcP+CodmHP6CJ
        /82hasdnQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i54SA-0003qm-UH; Tue, 03 Sep 2019 08:46:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: usb dma_mask fixups
Date:   Tue,  3 Sep 2019 10:46:09 +0200
Message-Id: <20190903084615.19161-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the first patch fixes the ohci-sm501 regression that Guenther reported
due to the platform device dma_mask changes.  The second one ports that
fix to another driver that works the same way.  The rest cleans up
various loose ends left over from the dma related usb changes in the
last two merge windows.
