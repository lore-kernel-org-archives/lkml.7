Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A8AC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 20:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DCA2075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 20:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="iqBr4WrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfD1UVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 16:21:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37513 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfD1UVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 16:21:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id b12so6282545lji.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 13:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UyBiEAsBxceQfqeC+P9Y3DWLd/6d48WxIgOY6TVRI00=;
        b=iqBr4WrN3UTAFb8EQyzzosOpHyZCl9xifv4DBqSnjh1heA19dXSe900tPqlSeU6maF
         tWZsPfcvbguYXCaWDflspSbo5m4BTDUz//uYZZkygBCh89oM0T2wOJHsmHLHT8jFEYkV
         abDG0L/ALk8bPlj70xHwnQO2ePkBPp2PrYPQWWX5TI6NiIzE1kSwgSqO8yDwaB4y5BF5
         3oq4mWpXjSegtyN9DHoGncgDzWyjTPO/CzzjSMSRZiTQneGtqmHagfWRzP/41xKe8Ctt
         4uARPFiKbsY28YZMXw2BqZFHAVY6AkXCGDG4JAddFzJLyaz1WadZgyMJDAPfRdXBzlTu
         RSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UyBiEAsBxceQfqeC+P9Y3DWLd/6d48WxIgOY6TVRI00=;
        b=bHv/gC3JyW4CBm+VwMsih5wVCPwOu/JUl6ZxTOaXL5LfpVHxAodGMx/KOumyWNgkp0
         JAIyDXiZmcsS8q8DgSa+9Xn5L9J9K+1cSXiXnmx65FTAtQbLeHnOlPpdaO/7WJes4o7F
         LNpSqEHZZI12WH6J9+rcdjXzON+1CfP+eOZ5C/jEYm5hRFamrVHygEcFzqtgQLKcAIUj
         3jZPXmOhhSm6uMsb5Jlw6dyE5KGNNvJnl+YwejC7DOFcW3nJCTxVK0ifkbTrlH5SBSEB
         Ppcer4v4QrY6B83eZQI4vW0b9JVtNgN1PUukrcGV3Av414T37VLjOpMjkqal82WZvS6P
         UQHg==
X-Gm-Message-State: APjAAAVkv15kFJ5sEgFYTn8W42wNp3ATBeE5NuFiZJe19z9708T3f0Cp
        Nmkg1tAQfpphZtDD3QwayVZSPA==
X-Google-Smtp-Source: APXvYqxhhyHvWDscUr1prUOMDp73S2g7Qp6nxpeAOnUVQBZZhA2BXoNNFSBBoHh4wGM7CTP/78s4Ug==
X-Received: by 2002:a2e:3815:: with SMTP id f21mr7688991lja.25.1556482910729;
        Sun, 28 Apr 2019 13:21:50 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id v23sm1639629ljk.14.2019.04.28.13.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 13:21:49 -0700 (PDT)
Date:   Sun, 28 Apr 2019 13:02:58 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 2/2] arm64: dts: exynos: Second round for v5.2
Message-ID: <20190428200258.zt7oizmsxlv7wp2z@localhost>
References: <20190428144221.11187-1-krzk@kernel.org>
 <20190428144221.11187-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428144221.11187-2-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 04:42:21PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> On top of previous pull request.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 77fc46976e0bfcd78d30fb4c9f0169752b4339c9:
> 
>   arm64: dts: exynos: Add SlimSSS to Exynos5433 (2019-03-20 19:29:57 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.2-2
> 
> for you to fetch changes up to f36afdd0f53583759562cef3a8453919e3b86a7c:
> 
>   arm64: dts: exynos: Move fixed-clocks out of soc (2019-04-24 19:57:59 +0200)

Merged, thanks!


-Olof
