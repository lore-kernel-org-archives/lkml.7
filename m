Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3059C3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767E520644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOAKvEhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfHPObw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:31:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33015 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfHPObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:31:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id p77so3314925wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2KH9X7wXKLaNgHTDRuB2BCoTUIbuMO+ioBBw7HzU1JY=;
        b=aOAKvEhf4eJTxcKSld4tT+33ybgVN17T/bYorvBedFN3143JLOiZGmSFFZmUYjnl2R
         ZmjW7kD/tqSTxSJekD045oAnsHHGE/wzxd3ibBgHSbBD4G7ailmdun7QlU0roREL2N42
         puNiR5ETw9wQOVpe6Mqo+x1oUp13MVT9P6m1jnGzwcPxVoe/dl2ds8g+wH5hhvtdRPid
         6OPErwSecc0kXng21CIP03S6DK1Hw73vanv14N8c4S3nZ+j9DR7q/0QqTBczWN0MsIhz
         x4vLhJPhZtg6XPzAQB5+8f8EtApLxjhTH7R06QpYALGd6QyBD3lQpkcUSmLWFu3Jzd3K
         Mx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2KH9X7wXKLaNgHTDRuB2BCoTUIbuMO+ioBBw7HzU1JY=;
        b=MIanDNjr/fRgH3dfQBgYrBSvr0522GKN81TaJVZSXlQtxrD2RgUCsUdysieiORMe0t
         gTdFJhPjG4h1Gd5TteLKM9LYfB3laXsiZuNPBDNsMZhQ3PfqunIE7O7hw6sMlgMb5dcH
         wVrurLERvs4Rt3UMnbfisynf4ND5DAjZthHpUiGzR6r9hlTFGwPTS/NBp7JpNHDWLFaN
         6J+P2xq7CUZFui5beJq41tP2NHCSILyQd8vA3l4ofUS4K262uBMEgaSVPBXOH9+/TUaQ
         F8x8NoeJpShlG4n6ecqNse+fCzJJ0eFPA4XB141ky9HqxTkb9xJ7mOs35+McnXL1gL8c
         2O1w==
X-Gm-Message-State: APjAAAUOjfgrq/UIOXtIiqYSf1bzWHRAejINBOZT5mQRRRzFbR+NTDDF
        mUtr+P+teuuluAu9ccEqMh0=
X-Google-Smtp-Source: APXvYqwUeQsO1Tir1acCeUF+pqGoRTuIizGwVTqI59KMXv4bOZjBPRpPwKZbNL/kgP0dRGGiI+zGDQ==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr7978852wmc.6.1565965909230;
        Fri, 16 Aug 2019 07:31:49 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id k124sm10940860wmk.47.2019.08.16.07.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 07:31:48 -0700 (PDT)
Date:   Fri, 16 Aug 2019 16:31:46 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     bskeggs@redhat.com, airlied@linux.ie, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: DMA-API: cacheline tracking ENOMEM, dma-debug disabled due to
 nouveau ?
Message-ID: <20190816143146.GB30445@Red>
References: <20190814145033.GA11190@Red>
 <20190814174927.GT7444@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814174927.GT7444@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 07:49:27PM +0200, Daniel Vetter wrote:
> On Wed, Aug 14, 2019 at 04:50:33PM +0200, Corentin Labbe wrote:
> > Hello
> > 
> > Since lot of release (at least since 4.19), I hit the following error message:
> > DMA-API: cacheline tracking ENOMEM, dma-debug disabled
> > 
> > After hitting that, I try to check who is creating so many DMA mapping and see:
> > cat /sys/kernel/debug/dma-api/dump | cut -d' ' -f2 | sort | uniq -c
> >       6 ahci
> >     257 e1000e
> >       6 ehci-pci
> >    5891 nouveau
> >      24 uhci_hcd
> > 
> > Does nouveau having this high number of DMA mapping is normal ?
> 
> Yeah seems perfectly fine for a gpu.

Note that it never go down and when I terminate my X session, it stays the same.
So without any "real" GPU work, does it is still normal to have so many active mapping ?

For example, when doing some transfer, the ahci mapping number changes and then always go down to 6.
