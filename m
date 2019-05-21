Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB8FC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE13217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HPSi78pG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfEUSBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 14:01:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39784 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbfEUSBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:01:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so8960373pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 11:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=wfNC/NYy0BskrQ/DkTSlCao3lZYzBhPki8kG+5l93Q0=;
        b=HPSi78pGI79hPLxeVu+FPg0TVmzHtILVm1cB89VfjMUPZUr8Z9vk1C1qzJ9xdFjk5e
         ijoMPkQz8AN5V5AgDGw3838yHVhhfy0NOfm3Dk970+yncc9lvviEjIQ6pKCZNJjd5EjI
         ecbXjaExaMOtUL97VjhUIcjB/Jw/94ZsCCqQnLWK/nN0LqCLLCtJNxwfgjPP4Ar9PX9z
         FoP8K3RpVkjmQpfkVhejk0+POrUBOGkGMiGh1XKKkXhcyUsz236ij7W/paKuTrpkD4Ly
         h6X3DmwzMfmy6SYjyPjKjj4hBIQeZJlrojttCnBeXg8Lq/CaBC8N1IG1lQ0FP2FPfkor
         /rKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wfNC/NYy0BskrQ/DkTSlCao3lZYzBhPki8kG+5l93Q0=;
        b=lN0iX/DaHCMoaltsNXl5hoEZLfpW2AMoHo356GIO2PF78HRGqZtPJEJ/43D5BIGCxJ
         uQnBcUQJZLxjM/t8FQKTEm+OJmDI62uBATecq/tTSuFYiyPwve6hqDZIqZ+X88S8Wrp5
         Pk1YL63YQT10N3uOdX14KDVrtaTznigcMfNx5w6XXu7i56p1rygfYdGOsPfRkvjKd+W3
         cyKbuZhfBK0vaQnIFzNT+9bB653ewHURfj08cMjAMfxjrRr1u9v+W3RKCU2dbr3t1fw+
         t2tYobQnYOChOsCPtFOAPiL1yBVLxsu8B8U4YrKaAeMZNNHkPEPtwZ2Lk1yjeSiGEX5O
         K+6g==
X-Gm-Message-State: APjAAAVx5NeHivuXiuiuPVa4kGJfXpNp/n3oE4itAVXslnqED9YrV0vF
        +Wp12Oit3zz/uTDuQ76cUtt0Og==
X-Google-Smtp-Source: APXvYqzV452vOvimAjVBDph0HeRrnJrZRkvgN3WuialU5BfF5U6r7mhxn5+jLHCsQqm6YkVT7RXR/w==
X-Received: by 2002:a63:6a42:: with SMTP id f63mr84295608pgc.377.1558461676934;
        Tue, 21 May 2019 11:01:16 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:b1ca:3800:3284:d770])
        by smtp.googlemail.com with ESMTPSA id 194sm19462422pgd.33.2019.05.21.11.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 11:01:16 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Carlo Caione <carlo@caione.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the amlogic tree
In-Reply-To: <20190521153649.0f44f3c8@canb.auug.org.au>
References: <20190521153649.0f44f3c8@canb.auug.org.au>
Date:   Tue, 21 May 2019 11:01:15 -0700
Message-ID: <7hh89n7klw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Commit
>
>   5d32a77c6e2e ("arm64: dts: meson-g12a: Add PWM nodes")
>
> is missing a Signed-off-by from its committer.

Thanks, fixed.

Kevin
