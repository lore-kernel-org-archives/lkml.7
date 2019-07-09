Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C04DC73C50
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5851D2080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562682091;
	bh=2JwpfJPEApfJG2HtwdZTN1RdfT7jYGryKNu8LYmSXA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oLzfUM/Vp5E1B1rd4XYAg/FlSBR6G9qJNHBzvvhrQzK59+GBEzdheeLYuEb0fEyyD
	 1cPaKabgqvyGKZsTb3nsZHrcgMrxTMtz9TJTG1yNNsHVA0P6bLdjCbt6A7B+XN6BeQ
	 TeUjbXQaT0l4r9hDXsaRDeVUVSsEE2//G61pKQqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfGIOVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:21:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40608 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGIOVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:21:30 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so35287592iom.7;
        Tue, 09 Jul 2019 07:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f+ADFttYA/V+/O077+27AshpU1PxQ349Mul0CkZ+ZM8=;
        b=YX5qqxiAxnDWZPShm1KGvkgNyAh1xFkXeRTh5KwBsoJeP/jptZRriLHHDQ9VNMyhSO
         9LS/y1RnECrkb/AFfde3H4jzaHLp7E/HoPPJ96twH31Y2WO7K7UiRKfx/MTo+Z09OEwL
         fZ3CYC+uglODj7EPLGq22Kobj4xvBa0/guGnFKPS4pDBpmqtTIr+Jmsrbu3Q5S/17OA7
         MXUlpF9wwG5ldHtjLCAbOsb/beGKnesIDG+beesN/Ce4j89dbxemOEtgN0vHZbuctem5
         JfbwMz3t5LW/4Nd7XGXl2njcwPUyxwX3Fqe3rXZCalADSIkXae2JeqcT19mDb1o6uh1e
         PXLA==
X-Gm-Message-State: APjAAAXn4qs+kKCEoVMb/8EXul795iS2hFf5NezuIQ3VQKRkm5/epkx/
        mHSHeIClUd32mSPoKsrbmw==
X-Google-Smtp-Source: APXvYqzbsid7dTL3N+pWXFiO0kKMIqliSgYTpkA/OGN2Sn45du3OpebITY3EKGINiVg4qHcN9Zad3Q==
X-Received: by 2002:a6b:fd10:: with SMTP id c16mr24143731ioi.217.1562682089211;
        Tue, 09 Jul 2019 07:21:29 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id v3sm11643441iom.53.2019.07.09.07.21.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 07:21:28 -0700 (PDT)
Date:   Tue, 9 Jul 2019 08:21:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jumin Li <jumin.li@mediatek.com>
Subject: Re: [PATCH 2/5] dt-bindings: usb: mtu3: support force_vbus mode
Message-ID: <20190709142127.GA11737@bogus>
References: <5e06482a0be15476c7b5825f155accf98275afa8.1560246390.git.chunfeng.yun@mediatek.com>
 <65f025186332b2b44f7b27f58af893217df1adb5.1560246390.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f025186332b2b44f7b27f58af893217df1adb5.1560246390.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 13:55:18 +0800, Chunfeng Yun wrote:
> Add a new property to indicate that the controller doesn't support Vbus
> detection due to non-exist Vbus PIN, and the driver should set force_vbus
> state for device mode
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtu3.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
