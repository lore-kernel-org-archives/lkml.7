Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71E5C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 01:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCAC2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 01:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="C9fUgKAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfIUBLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 21:11:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34458 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfIUBLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 21:11:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id q203so9230141qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 18:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=wScDWZ1k3aPENhb3eEVkRi/0sjaCyiUXHzXtGguOYj4=;
        b=C9fUgKAKLuFZ5eYdFogOcuLYgGoPE6fBHeCy3fhnBwQuOjFIAgb7Q/8mjeTNpaSRPa
         3YGZO6X8hSRN/TZYDJd+85WwGdD1wEVrdDSe1ChdSI/sHLhfzhDU/K9bjWhaYUxX1MiU
         E7qRRNuqEhPr2B6qK/WqqDQCSCgZkHiKhs0QTMqjNFpCPvtS3l4gzZB0hRxE0EIqqmzY
         /5BkuJGyMNjibVreiqGXg7vMCF91V4mgy+YMv6Fz6C2giLOBrBt2lon0x3bSwDKN4YI4
         asbEbHkCwFcJfGu/+9alnZ8ssyY4Qa4gjn0b4PTf4d0STZSxw+HVC7sY+HfkBi8Fb+hj
         BMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=wScDWZ1k3aPENhb3eEVkRi/0sjaCyiUXHzXtGguOYj4=;
        b=LIBOfd4jTvGez/11IL6NcGcb768IXwRa/nlbFbehmwornz+OPAmhKUN8eRjAMvIWX4
         s7loJ5AD+AEHrg8Qw214U7MmwNW1hwycGLJGtilTSrzIkYa0It14pN8GwcikGUsrSuWU
         QORihiZTSJvNNacXUamqTT3/8S1HGPDdPXm7rdGvTfQPqu7WEKAAU9mF+khaPCUKrHh0
         ee85Bex1llZmAoBU3FZSRSglDm0YDotyj2GlL4nZEB4/NOKD7+7G2DLanLjOdmkj1M36
         2hTbJ9b9BDeIOWLpRsUy63DLw0aBlI4TrFaXdmo7CEnvUOwfakFuROLsoopiedcpgWuh
         N+2w==
X-Gm-Message-State: APjAAAUs9Cqqwq94H9wWCNYCdMhxr0oKocdM4GLbdjyNioJnezSovRu2
        roLi6yULy92a/1JpJsiUQLEAZw==
X-Google-Smtp-Source: APXvYqzPzAoyhVSr2yw7qD8UFqINaJlHLTqpF4q2nC0TaLGgX2csgV8CNN97qn6WuIocY/suiVN8CA==
X-Received: by 2002:a37:4a0c:: with SMTP id x12mr6315388qka.23.1569028306086;
        Fri, 20 Sep 2019 18:11:46 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id c26sm2233930qtk.93.2019.09.20.18.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 18:11:45 -0700 (PDT)
Date:   Fri, 20 Sep 2019 18:11:41 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <davem@davemloft.net>,
        <robh+dt@kernel.org>, <peppe.cavallaro@st.com>,
        <alexandre.torgue@st.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>
Subject: Re: [PATCH] dt-bindings: net: dwmac: fix 'mac-mode' type
Message-ID: <20190920181141.52cfee67@cakuba.netronome.com>
In-Reply-To: <20190917103052.13456-1-alexandru.ardelean@analog.com>
References: <20190917103052.13456-1-alexandru.ardelean@analog.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019 13:30:52 +0300, Alexandru Ardelean wrote:
> The 'mac-mode' property is similar to 'phy-mode' and 'phy-connection-type',
> which are enums of mode strings.
> 
> The 'dwmac' driver supports almost all modes declared in the 'phy-mode'
> enum (except for 1 or 2). But in general, there may be a case where
> 'mac-mode' becomes more generic and is moved as part of phylib or netdev.
> 
> In any case, the 'mac-mode' field should be made an enum, and it also makes
> sense to just reference the 'phy-connection-type' from
> 'ethernet-controller.yaml'. That will also make it more future-proof for new
> modes.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied, thank you!

FWIW I had to add the Fixes tag by hand, either ozlabs patchwork or my
git-pw doesn't have the automagic handling there, yet.
