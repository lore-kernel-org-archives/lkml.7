Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E44C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74F82073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573812488;
	bh=BFr6sfgftn7D5M3CP9D0BScSwOSILOwPQFmycV5i4H8=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=2EDEPDG76UzN4y0cCTc+TeXURKX+g27aFmAHZE7d0o75ij5PmwJsRk85SPnylgagP
	 MqeejHrCeqICq0s3tCUpqE0GO4gJExxvqqgI5/knCdd8hOrtt1ENJz5re2xELBs2Nn
	 YncltphCXIeo4hXy/AzUuSGv3wWxwb13w3n9lNUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfKOKII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:08:08 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:52323 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727036AbfKOKIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:08:07 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iVYWJ-0002SV-Ha; Fri, 15 Nov 2019 11:08:03 +0100
To:     Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH 00/12] Support wakeup capable GPIOs
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 15 Nov 2019 10:08:03 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <swboyd@chromium.org>, <linus.walleij@linaro.org>,
        <bjorn.andersson@linaro.org>, <evgreen@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mkshah@codeaurora.org>, <linux-gpio@vger.kernel.org>,
        <agross@kernel.org>, <dianders@chromium.org>
In-Reply-To: <1573756521-27373-1-git-send-email-ilina@codeaurora.org>
References: <1573756521-27373-1-git-send-email-ilina@codeaurora.org>
Message-ID: <54da99976d9bd2d543d2341ad9eb982e@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: ilina@codeaurora.org, swboyd@chromium.org, linus.walleij@linaro.org, bjorn.andersson@linaro.org, evgreen@chromium.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org, linux-gpio@vger.kernel.org, agross@kernel.org, dianders@chromium.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lina,

On 2019-11-14 18:35, Lina Iyer wrote:
> Hi all,
>
> Thanks for all the reviews.
>
> Here is the next spin of the wakeup capable GPIO support. In order to
> facilitate basic support available in the kernel, I have dropped the 
> SPI
> register configuration. The feature was added when this series was
> restarted based on new hierarchy support in gpiolib. But, the SPI
> configuration can be done in the firmware. This would avoid a whole 
> lot
> of code in linux that serve little to no purpose. Users of GPIO never
> have the need to change the trigger type (level edge and vice-versa) 
> and
> the basic configuration can be set in the firmware before boot.
>
> Changes in v1:
> 	- Address review comments
> 	- Add Reviewed-by tags
> 	- Drop SPI config patches
> 	- Rebase on top of Rajendra's PDC changes [6]
>
> Changes in RFC v2[5]:
>         - Address review comments #3, #4, #6, #7, #8, #9, #10
>         - Rebased on top of linux-next GPIO latest patches 
> [1],[3],[4]
>         - Increase PDC max irqs in #2 (avoid merge conflicts with
>           downstream)
>         - Add Reviewed-by #5
>
> Please consider reviewing these patches.

It has been a long time coming, and I'm minded to take the first 9
patches into the irqchip tree. Anyone objects? The last 3 patches
can go via the platform maintainer tree.

         M.
-- 
Jazz is not dead. It just smells funny...
