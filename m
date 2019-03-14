Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EDFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA56C217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STgcmYR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfCNH36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:29:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43875 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCNH36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:29:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so3238859pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mej+qpK1ol+d8hBaewotb+fsU3FX4yA74+qtOJVd8zU=;
        b=STgcmYR0qIrv0AOEL9fCQkx9eKkJLIRqU3rS/+8NXZJIUPDxWHmmzwhjiIuV4IEHjz
         Ue1USYBArQqIJzW6ofaBBcY0ErxKBshxYn9g14Fu7+fowkIN1kvd2pMBRnErKWZWc2qT
         ao+qMg0lAyYzm3Yzbbm6CHJF4dRWhSXFBBuOPWtVfMuxYQgZt/rwORVb6eMR+5Ra7xFz
         Gl1/JFfEu4I1ohVlpS0H25icJIspwTIk2q6F7ft8hB+EyTaj2KBP/5VWwfo9fV2FC7/X
         i/GGNqvaTjm81Z0tWXyq/YYol6JsXtNOt/IMB8zYhCOIS4hhVSYK/OgSO90CjoZhzGwh
         vkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mej+qpK1ol+d8hBaewotb+fsU3FX4yA74+qtOJVd8zU=;
        b=k8VWUOU2Eht0uxAGj/TzATBPtfO5AAMjubBsuEusCI4NUk1eduA1856DGz0h7ea7tf
         zgc5wMFTNuZff1ffIp98on7+7WtA39Rlrk6t5CqCkNVOPD+QMJ6RCDWS6XeJbHr/riGn
         U6pxQb+oijwRikK9VgiDwney+KdJW6WY5bO4XoHOqbWRp4nptx4j0CcFcHmsKdZS8S9s
         ylMZV9vwlSOFcNm+fhS4P09aA+Gx1QCqNa7Ribvbw5xUjtFuI7X09W20PtSfY16V20M1
         MkA2/KNHHjHf6ixJvH6Lm/ioHtXO1R+8DtNO/Qg+P3KnVpS51kZzJqX9tPY7FHM5jQlI
         HfsA==
X-Gm-Message-State: APjAAAUJlrizvnnKTMyfwNGgGOQHoaJkCJbTWef3j+g1jdm99pLZrU1M
        K7sHLBt7W+AArcVyU6vvQajM
X-Google-Smtp-Source: APXvYqxuRgpsSLuBzW0OrtfPzdu1lGEZv45cT+N/QsgPL9NkQPB7i6R7lr+0Dqxpry6mIqmTb/wcPg==
X-Received: by 2002:a65:648f:: with SMTP id e15mr29591288pgv.249.1552548597250;
        Thu, 14 Mar 2019 00:29:57 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6312:3b43:a1cb:3793:cc74:dd37])
        by smtp.gmail.com with ESMTPSA id b7sm23397304pfi.36.2019.03.14.00.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 00:29:56 -0700 (PDT)
Date:   Thu, 14 Mar 2019 12:59:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Akash Gajjar <akash@openedev.com>
Cc:     heiko@sntech.de, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        ezequiel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] add gpu node support on rock960 and rockpi4
Message-ID: <20190314072947.GA19182@Mani-XPS-13-9360>
References: <20190314071853.32176-1-akash@openedev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314071853.32176-1-akash@openedev.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 14, 2019 at 12:48:40PM +0530, Akash Gajjar wrote:
> add gpu node support on both rockchip-rk3399 board.
> performance tested with freedesktop.org panfrost mali driver.
> 
> Akash Gajjar (2):
>   arm64: dts: rockchip: add mali gpu support on rockpi4
>   arm64: dts: rockchip: add mali gpu support on rock960
> 

Eze already sent MALI support patches for the above boards and those has
been queued for v5.2.

https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/log/?h=v5.2-armsoc/dts64

Thanks,
Mani

>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts | 5 +++++
>  arch/arm64/boot/dts/rockchip/rk3399-rock960.dts   | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> -- 
> 2.17.1
> 
