Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC03C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E6E21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Yf1PnrqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfJHXG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 19:06:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35230 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJHXG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:06:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id m15so692194qtq.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 16:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=atsmqMocA5CyL6gwgsiLT5GHB2fp+M6rgJRLl0QguUI=;
        b=Yf1PnrqJhvtoylbafl92Bfw8ux3dLraYowqxbyDrdbEwmrb/Foqz5TlOsshmV0Dmtg
         eWdp9Ap/S27I1mPrqK6kCp3hFGr9kR/inLVgnQFRqJzjSdQKagRKhz9TqP5rjUyZKts4
         YvbQaD/6PuXN9wVWjluEGRnxy3nEbI9/RROkQ7hkF+J4IKdS7Txg3eNz2CBKTvLvb6im
         0NPb7qDBIn1959sX1s1XGAYXkgxH4CcDaEj19c54dw84PbhgslpexIDawjhjDwwXaIkU
         Xrhc0g55tOtHLW3GeWPrOzB1IQwv3bHit1hVr/EeyLrLwXYc/9xd63ti23ss0gRZQTQb
         iAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=atsmqMocA5CyL6gwgsiLT5GHB2fp+M6rgJRLl0QguUI=;
        b=qbKaC/eBDMhryWZ0xBG1VRgKln1+0hpWkIz+lk2rOv2spsqCQIms/GwZytxAxoAH6a
         ypFPaZlMp3CuRph9/JpRXsBcrmEVvI0bocfoBILmeEdvLdZqt9Lj2nVl+OABr0nXYEMN
         3atVahJob6Yik/KgJQXawQVYPgdIzevnjgh2ymFtZ25Zc1zcX4/D7HeN1BJJLnkXrZ7u
         Ep3b2xPOt0+yK3IQYZLGBuA8WMebyHmBvW3Lz7oFdIsQS5LxMXpvqSv2Y4r6kA+N5OZs
         dGmdqayAok6RxEW59OoyKv9pVqJGLj3T2qooK50Lwj1pzD9hM52sC0+pxOXD6odEdwYk
         WedQ==
X-Gm-Message-State: APjAAAUwBnpazdfY+H92t4iFQ6mHs9t2PsoasMD4BI36lq8vduaXT+bw
        rSnpXIHYtK+98PQZwfkcQdG91g==
X-Google-Smtp-Source: APXvYqx/64qjNyPamHObAX+fZWZqmEP0Vy13opmS7WjDT+nYyQ/NnL33mmrlR73uH81IkMFcAKV8/g==
X-Received: by 2002:ac8:4a84:: with SMTP id l4mr463525qtq.118.1570576015229;
        Tue, 08 Oct 2019 16:06:55 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id t73sm93418qke.113.2019.10.08.16.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 16:06:55 -0700 (PDT)
Date:   Tue, 8 Oct 2019 16:06:43 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     MarkLee <Mark-MC.Lee@mediatek.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sean Wang <sean.wang@mediatek.com>,
        John Crispin <john@phrozen.org>,
        Nelson Chang <nelson.chang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rene van Dorst <opensource@vdorst.com>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net,v2 1/2] net: ethernet: mediatek: Fix MT7629 missing
 GMII mode support
Message-ID: <20191008160643.1c1d31ff@cakuba.netronome.com>
In-Reply-To: <20191007070844.14212-2-Mark-MC.Lee@mediatek.com>
References: <20191007070844.14212-1-Mark-MC.Lee@mediatek.com>
        <20191007070844.14212-2-Mark-MC.Lee@mediatek.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 15:08:43 +0800, MarkLee wrote:
> Add missing configuration for mt7629 gmii mode support
> 
> Fixes: 7e538372694b ("net: ethernet: mediatek: Re-add support SGMII")

Thank you for adding the Fixes tag. It seem, however, that the patch in
question did not change the ge_mode setting. Is it because GMII now
makes a call to mtk_gmac_gephy_path_setup() that the different setting
is required? The Fixes tag should point to the commit which introduced
the wrong behaviour, it may be the initial commit of the driver if the
behaviour was always there.

Could you add more information to the patch description and perhaps
update Fixes tag if 7e538372694b didn't introduce the problem?
