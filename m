Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088BDC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C1C2189E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="A80Z3weP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfFSPF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:05:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38821 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfFSPF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:05:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id b11so12413794lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rLIkqlGn9cUlPf38s8MiT2bIRqxvXG+Su9LV/bpHzd0=;
        b=A80Z3wePQk+3ikueP3DX3ZYZi5GH6ORG5QlDkVy+ZFzIpC7UJEN2CEyfM87XGy2Kml
         UMB7BDT2oVm8cajDJkV6PAUOakeu+92GVcs/QkoaiNhn/gyGbY1QZCMs1B9TvgOdWxqN
         kR8/cuu487HIgBWxwrnQWUUEwU8bLwivUxGncg0azOcql7GuF8DDnk2ML030xCGds8uG
         jIdqharE+JH/Fw1qdVwPBC2R4uFcaSsIHy+nmcqynRMdH5ro5KP8E/ITzF2H4yDnD1A5
         nuY6r5xUO9S09bTcjrPtGb66vRplTzhfcWwTa5rLXbmBJ2/P0VLWpkbh5axjvezbhd0c
         EIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rLIkqlGn9cUlPf38s8MiT2bIRqxvXG+Su9LV/bpHzd0=;
        b=oum8wrNECzPZmDIalDf4cf2Fn7p5BrCKY+x/+ywNOvVVb6UbntuqmaB68zk9MxepQ7
         WFx07s0MrjKeql3QtZSWY9S1Fy6qLke0sQ+vCb+pY2HD115LkRGBEx/KAZaymI2ygDa7
         v/2+BMYAi9/SxmcUbY4T+WvKYAnjSodndWMc+hEzkFQPxvXXAVcvEGdW/lAhiblUCbRJ
         2P/bAhV59pDTQYMnIsxCX14h4yvNDG4wsedEQuDECPi3aYudeTdU57bFtPF9CbGQ1PxS
         vb2tciefwUsVr7GdqwgzCYNXCJzL7ZlTpawFDDC5QgYUGLljhVIQl8Am0p+Ha+y1tqns
         J+uw==
X-Gm-Message-State: APjAAAVURUjl/hhx33Mmc8XB1p2KfeA/YiH4v7zhNk5447q2Gm7LSHnA
        v+hTPmIR/kd0TPEC7wOZamSyYw==
X-Google-Smtp-Source: APXvYqxmdNV7xq5YR13Vg4a3/65Jiq4IWvBSJdIVrPquKzCKn0zJgudmzb7b2ZjN0LydNtOJs2ajbA==
X-Received: by 2002:a19:710b:: with SMTP id m11mr56799598lfc.135.1560956753593;
        Wed, 19 Jun 2019 08:05:53 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id y18sm3123964ljh.1.2019.06.19.08.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 08:05:52 -0700 (PDT)
Date:   Wed, 19 Jun 2019 07:03:51 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] arm64: configs: Remove useless UEVENT_HELPER_PATH
Message-ID: <20190619140351.okscbbzudzwv5gup@localhost>
References: <1559634748-19546-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559634748-19546-1-git-send-email-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 09:52:28AM +0200, Krzysztof Kozlowski wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.


-Olof
