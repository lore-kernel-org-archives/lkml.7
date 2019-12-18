Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB58C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CCF24650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576705117;
	bh=UdORDKHOG3d6v5x8MPfcWJix8XZwqmjcnOp6XUDV/4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ea5KONTfJo/zUHJmGp7XMywt/7ztxnW7mTHMb33YTvOZ4jPhmABsYOTe8sQO8XpIe
	 vMaIYDty4xtlnXu3FD2UT+MfqlZlsvs1v1r0qK65sXtUGeXES3E+FsKU7RwciR42RT
	 7nfZIzR/qt2YQ/57EhihWcM5lfV/+i0FYUL7tHEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfLRVig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:38:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43055 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRVig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:38:36 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so4219451oth.10;
        Wed, 18 Dec 2019 13:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CThMgyYb2HnX5NohwkeG2dpFbHpKjSmonT0Rqkls07k=;
        b=XWNKE/Y1Px3I8pTCVkXXVcDifLN74rTnDkaDur5/HbZ1zGKPcyYl44PoWxeQ7i2/Uy
         /24MWtVCh5bf97PzAIRfx7H8zwW2sSzfe81W7ZnUIAp+4uyz04sEnbL4vjQdemTWOb/J
         hwCVAlH9W9Zr7ZDDD/2gvQ2DOXO8j6VYIngePF7jmuJX5xxNWOG7gfqlRWOMrPa5ICCC
         AyIEM6qmH8pXGCD9w4TDYBmsyIscbEDauzXMOazQuyhtF84AByp3f7wcjj+KdiHp4Qsk
         7dm9tQeRWh5MlXN+Det+wc7kDlMgl/Vzi3SUbuYLVaXlSJ9ineJk9ZGVniuasyA334j8
         OoOQ==
X-Gm-Message-State: APjAAAXB5FI5k7qErDJZUfSrEU9sNJUoRoOQSjqs0pAaMn7qMSryS5Ch
        RSAwUojBLI37p7EHvne+QA==
X-Google-Smtp-Source: APXvYqwWpZuMh04y4KOGVf0MBo6cIU6JiMjeV6XpwUI31E4EaD+zXg6UWvuBkSQBgYrW/Vmwdi89Ag==
X-Received: by 2002:a9d:600e:: with SMTP id h14mr4732216otj.113.1576705115480;
        Wed, 18 Dec 2019 13:38:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 101sm1284059otj.55.2019.12.18.13.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:38:34 -0800 (PST)
Date:   Wed, 18 Dec 2019 15:38:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, tsahee@annapurnalabs.com,
        antoine.tenart@bootlin.com, hhhawa@amazon.com,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        tglx@linutronix.de, khilman@baylibre.com, chanho.min@lge.com,
        heiko@sntech.de, nm@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        barakw@amazon.com
Subject: Re: [PATCH v2 5/6] dt-bindings: arm: amazon: add Amazon Annapurna
 Labs Alpine V3
Message-ID: <20191218213834.GA662@bogus>
References: <20191209161341.29607-1-hhhawa@amazon.com>
 <20191209161341.29607-6-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209161341.29607-6-hhhawa@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2019 16:13:40 +0000, Hanna Hawa wrote:
> This patch adds DT bindings info for Amazon Annapurna Labs Alpine V3.
> 
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  Documentation/devicetree/bindings/arm/amazon,al.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
