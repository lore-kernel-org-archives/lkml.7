Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DFBC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D4B20873
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ZFzM3Avg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfJHXCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 19:02:36 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37754 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfJHXCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:02:35 -0400
Received: by mail-qk1-f194.google.com with SMTP id u184so473806qkd.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=FMMLRXtAe40zCMcCtxvdP8i9kT/PLF62chlFdNDSpa8=;
        b=ZFzM3Avgh1nIZ9kRcYhwKQbctGHGKBEN6jhP8dxhduJ+4EPcJfdb2kEs36EGwPKTgY
         GDu8aQ/hL/5/0pTwv3fuQIb7NEH80mv1qvtHUPcsc7IUlxs5BVnnMg1tTykwNYvNgV8e
         U6cvjWUrJCi32I4kQ9et1ar15nltNXj7yQLsGBAHP5fONJlcWrRWecoAIR0PCwqx/fah
         AohsRSAmEUBkgvOT6hpYM+z0EAqfUnvZowytJBkjh18ZY1GnBTSZJ5Jm4uRphbNrAzgv
         0249cyY1Six4SoTA371Mti6zSmwExvlG7oCD2Xv9qNzjaPKZVK7C7/2o2RoBWuVuYZO7
         CgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=FMMLRXtAe40zCMcCtxvdP8i9kT/PLF62chlFdNDSpa8=;
        b=hhz562IfrMm9YXiq5g0EQOqE040VyDLSLKPCQD7/yaN4qlAG4J6iawML7UH+dfPvbp
         u+xyI5n8vcwL1V2rwzZfeFyMsTP2cdJrTKK7p8oh0Yg85vsi6bw8UCKhrRSDmbYVUeUh
         /bMTEouoOHSGKhrMWUrSThFk+t78bY9VLuKbnMb0fdqDNKYZTyCwLyU4BHKtH6Ai7uSt
         7vQBFx8KK8BoEvO4OHVxfAd/h8mYYBeTDgS6icEkjJarh7nu0yT0wBr9cntczxVavNdt
         VpJaUeiSGrVH4nnfHRaJCUuwzWINmyyyun3d4Ofcd/iUwllBDCzaDeVmzRSvh2b1nvQu
         nKpg==
X-Gm-Message-State: APjAAAW9EhxMDDxysxBRwszBFotWDtwupEnyPrfTBvpsYpkHqnOJlDd4
        NHPvkQysjEoJtrpfMLSU8Gw54w==
X-Google-Smtp-Source: APXvYqxvRqb+z5HpoQj48byKYFHJWFucwPuLS22/dDgDrpAZfGfXzGsk3d6nAPeBA6lls6A278C1Zg==
X-Received: by 2002:a37:a646:: with SMTP id p67mr569346qke.489.1570575754654;
        Tue, 08 Oct 2019 16:02:34 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id a19sm204875qtc.58.2019.10.08.16.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 16:02:34 -0700 (PDT)
Date:   Tue, 8 Oct 2019 16:02:22 -0700
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
Subject: Re: [PATCH net,v2 0/2] Update MT7629 to support PHYLINK API
Message-ID: <20191008160222.0bdb7f47@cakuba.netronome.com>
In-Reply-To: <20191007070844.14212-1-Mark-MC.Lee@mediatek.com>
References: <20191007070844.14212-1-Mark-MC.Lee@mediatek.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 15:08:42 +0800, MarkLee wrote:
> This patch target to update mt7629 eth driver and dts to support PHYLINK

Thanks for the patches Mark. The description of the set should probably
say that it _fixes_ some issues. Right now it sounds a little bit like
you were adding a new feature. Could you rewrite the cover letter to
give us a better idea what issues this patch set is fixing and why
those issues occur?
