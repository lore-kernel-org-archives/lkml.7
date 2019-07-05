Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F44C4649E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891B4216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="i9sFNsbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfGEQRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:17:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40964 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbfGEQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:17:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so1155497pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0I5KUts4VK47WZ4vJqCHUl93jM/IRvCySns2OuZKj5U=;
        b=i9sFNsbbwhBUwn2kzFjOMQ+J1FA1ixrVIsSqUR9F2AMXvy/w7lOnNtn1pmqqoGOZeO
         SrI8U9d39OKR9lfF/YPcxiFPKsbro8D0ADO65DeQLBgTlFlfm6UTL1hFWKLfDTo82FUw
         TF7g56Vg+GhvFl4PXBkWrikkcteMF9BUbPPdkD7KxJs0NlPfsEJZFyBwN7AAl0XSMRns
         3SCA6vdJG67WWpfjvkA5b6eE9t/anTl/9VcwavLMXODs9WUmCjKCmtZRRoHTckM12DE9
         Lzre8a3OFvyS8KgEvyn4Pgf75nPTewY9xe+5hX72QvZNf/1BxuEx4XtGMmkfu4Pi1gXD
         zxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0I5KUts4VK47WZ4vJqCHUl93jM/IRvCySns2OuZKj5U=;
        b=h3KBA6vDNIVJpMTJGlkG7NeisPohJ9qV7T/CYGLnjaQG9lXtyRipIK+nL+kE7QGCny
         Kz+2O6c3lSPLK6/3LqDj4HgVMsVCToYAstBcNCxpclytQtgXB5+xFiZAmzN+uLHGDwrU
         ePfNqugMIjs9yo5U7cAwSntvOuViU/NIwDfsXSBKf2QvnQi2iubZ/3vO0v408HuM0EdP
         kWMQ8kHSMxbBu/ijObWOnI4jsNnTnahfY7DOM8tCrYN5tE/cu5D0pJt7TfrSNaD5w1ze
         B4Xdca42YPdHWwjI1H7BtEpHwOEVgWnsiUVNDGGOj9Mdc7Q8NzV21MWWr3XjUJx96UFn
         KFHg==
X-Gm-Message-State: APjAAAVimdNm/hX3zjxoocU3GG8Vk8Aa86oWSobg/Teiiklcn3JnmWzb
        KL8PyNonEXBbjc/wapsI/YEX5A==
X-Google-Smtp-Source: APXvYqzxEuhVW3KDLiQAp3uXNeKs3THT2g+AY1h90RyNz5d71niFsZLZg/AxNcJenf7+oIBrLlnpPA==
X-Received: by 2002:a17:902:8f93:: with SMTP id z19mr6355312plo.97.1562343472095;
        Fri, 05 Jul 2019 09:17:52 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id h6sm10118921pfb.20.2019.07.05.09.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 09:17:50 -0700 (PDT)
Subject: Re: [PATCH v3] drivers: ata: ahci_sunxi: Increased SATA/AHCI DMA
 TX/RX FIFOs
To:     Uenal Mutlu <um@mutluit.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Pablo Greco <pgreco@centosproject.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Schinagl <oliver@schinagl.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        FUKAUMI Naoki <naobsd@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>
References: <20190513142410.9299-1-um@mutluit.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <95b399ff-86ef-134b-7c55-d4205cbe9eed@kernel.dk>
Date:   Fri, 5 Jul 2019 10:17:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190513142410.9299-1-um@mutluit.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/19 8:24 AM, Uenal Mutlu wrote:
> Increasing the SATA/AHCI DMA TX/RX FIFOs (P0DMACR.TXTS and .RXTS, ie.
> TX_TRANSACTION_SIZE and RX_TRANSACTION_SIZE) from default 0x0 each
> to 0x3 each, gives a write performance boost of 120 MiB/s to 132 MiB/s
> from lame 36 MiB/s to 45 MiB/s previously.
> Read performance is above 200 MiB/s.
> [tested on SSD using dd bs=4K/8K/12K/16K/20K/24K/32K: peak-perf at 12K]
> 
> Tested on the SBCs Banana Pi R1 (aka Lamobo R1) and Banana Pi M1 which
> are based on the Allwinner A20 32bit-SoC (ARMv7-a / arm-linux-gnueabihf).
> These devices are RaspberryPi-like small devices.
> 
> This problem of slow SATA write-speed with these small devices lasts
> for about 7 years now (beginning with the A10 SoC). Many commentators
> throughout the years wrongly assumed the slow write speed was a
> hardware limitation. This patch finally solves the problem, which
> in fact was just a hard-to-find software problem due to lack of
> SATA/AHCI documentation by the SoC-maker Allwinner Technology.
> 
> Lists of the affected sunxi and other boards and SoCs with SATA using
> the ahci_sunxi driver:
>    $ grep -i -e "^&ahci" arch/arm/boot/dts/sun*dts
>    and http://linux-sunxi.org/SATA#Devices_with_SATA_ports
>    See also http://linux-sunxi.org/Category:Devices_with_SATA_port

Applied for 5.3, thanks.

-- 
Jens Axboe

