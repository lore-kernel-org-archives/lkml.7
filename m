Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46321C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033C2208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ML9qV6DA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390897AbfITWMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 18:12:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40760 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730664AbfITWMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 18:12:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id y144so8852918qkb.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 15:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=TtaAswzBjSF6wMxWcKerHux6S0skNQfq1v3qgj+qOLQ=;
        b=ML9qV6DApv40vs30j5Ww1BpxaY8zUWpmqEyORE2J9aLqb0mrbwCpr/8zFP3E8FfIx+
         jnZc1q7FUdGqLUxaBz8/dsHBSPhb3728aS6lh82qf6o3iBevW8mKnnrCJtpjAD1GW/oj
         grgi1xYz7WM5qcdXXKMfBQGYbeXuc4f5+VkiHrviGYC+SRXdbP4/N/I4xPzMvzgNGXBK
         QN888PHGKRg/WrbEpXd1zfy7XNIBnN/QrafR5bS3AmU44imk87pkz9LtteWywi0xGvE2
         2HyIiwCOJAKIvaPpgq7Q3eHV24IBnr4A113RSUyoR+EWyXeAMQLd47deHgBYl78GP6v7
         qheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=TtaAswzBjSF6wMxWcKerHux6S0skNQfq1v3qgj+qOLQ=;
        b=mZ+SBqQ51ohSKD0Uje0aC/CmSlb85aPjAa34NBBuvFpzsp4fFHijnWKqalIdnsI82R
         Z1Fc/zRg7wZk32rYQACa+qFseTMndA/HuDI2htwFDU2V+SiWsMF6xXRAOJvJNIQCaShu
         vRZ3HDF5vpv/FJ28rdw8xuO5eTmYgBq2FVvRkqcyCMahiGLXKvUxJBeu6cSPDD2d9804
         hfKRIkIKv8bfZn7pWqBvoMtzIpqbZ8HDMFrI58FaVSdVHFSm2nfQgEoilFiN+jl9DgCQ
         JUtUQ1/DAct5DDx/A4KFfufJaaY+M7WnxghOjx7/EQK2bDx3Wu9zMFX2MxokvNXZRpe7
         ZFBA==
X-Gm-Message-State: APjAAAVFEti6nxnMGScJcqMjeAn8qEPOFIwYB6R6i6maVd0csO29uHOo
        40YtSGN740qXLzmCIkjU2UvtvQ==
X-Google-Smtp-Source: APXvYqxms1fcAkfl9iLj4czO+Se7cJWT+kkC0zfbS+28Uy5w7H0l/qQW3uiupibrEmDv0CvxJGe2nw==
X-Received: by 2002:a37:68d0:: with SMTP id d199mr6142641qkc.174.1569017556585;
        Fri, 20 Sep 2019 15:12:36 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id n192sm1841500qke.9.2019.09.20.15.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 15:12:36 -0700 (PDT)
Date:   Fri, 20 Sep 2019 15:12:30 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Pawel Dembicki <paweldembicki@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [0/2] net: dsa: vsc73xx: Adjustments for
 vsc73xx_platform_probe()
Message-ID: <20190920151230.0d290654@cakuba.netronome.com>
In-Reply-To: <5d068275-796d-7d76-ba33-6eb03fb1d7cc@gmail.com>
References: <98fee5f4-1e45-a0c6-2a38-9201b201c6eb@web.de>
        <20190920150924.GG3530@lunn.ch>
        <4a220bc4-0340-d54a-70bd-7bea62257b81@web.de>
        <5d068275-796d-7d76-ba33-6eb03fb1d7cc@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 09:36:57 -0700, Florian Fainelli wrote:
> On 9/20/19 8:30 AM, Markus Elfring wrote:
> >> netdev is closed at the moment for patch.  
> > 
> > I wonder about this information.  
> 
> This is covered here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/netdev-FAQ.rst#n40
> 
> and you can skip the reading and check this URL:
> 
> http://vger.kernel.org/~davem/net-next.html

Indeed, looks like we have a mix of clean ups of varying clarity here.
I will just drop all, including the devm_platform_ioremap_resource()
conversion patches from patchwork for now. 

Markus, please repost them all once net-next opens. 
Sorry for inconvenience.
