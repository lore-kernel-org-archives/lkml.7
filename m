Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C50DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E07B207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575973565;
	bh=xWe18eT+618YdbpYdvHkkfMluCmRhQKLX0Iz+qBwf88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wb4Ejqyqk9jBR6M/ZSiwjzfbuJ9mSzZxCwOPR2Xh0lr2dd1CmaiDFwlMyzbYC75zM
	 fAuAt3dk3rIw47G56mEfTXAkP65To2MJhlBI/+cU8s0iyyYZgYBVqyxRvFGpJPdT27
	 aAmfUwCF3HxQ7pQJwcwbN/iErvKGY+RXSlZiXR68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfLJK0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbfLJK0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:26:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 905F42073B;
        Tue, 10 Dec 2019 10:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575973563;
        bh=xWe18eT+618YdbpYdvHkkfMluCmRhQKLX0Iz+qBwf88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kzQv4Nvj9PrG3Xu7fxEtOUzGVST1CmYogzXHxeS1ahhdB3QQVbP3DqoEDUd4tmNWc
         fK2oCkCPQRBfhfsD2t0p5Sx5oCldMrzIPrE9XqdwiN86soTtN7E18GbMCNNUmtiUsr
         z433hU4kKjfwBvqzKP/yZeloc5VoVQLpvrwTW7uA=
Date:   Tue, 10 Dec 2019 11:26:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 8/8] misc: hisi_hikey_usb: Driver to support usb
 functionality of Hikey960
Message-ID: <20191210102600.GC3698263@kroah.com>
References: <20191128051001.18995-1-john.stultz@linaro.org>
 <20191128051001.18995-9-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128051001.18995-9-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 05:10:01AM +0000, John Stultz wrote:
> From: Yu Chen <chenyu56@huawei.com>
> 
> The HiKey960 has a fairly complex USB configuration due to it
> needing to support a USB-C port for host/device mode and multiple
> USB-A ports in host mode using a single USB controller.
> 
> See schematics here:
>   https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
> 
> This driver acts as a usb-role-switch intermediary, intercepting
> the role switch notifications from the tcpm code, and passing
> them on to the dwc3 core.
> 
> In doing so, it also controls the onboard hub and power gpios in
> order to properly route the data lines between the USB-C port
> and the onboard hub to the USB-A ports.
> 
> NOTE: It was noted that controlling the TYPEC_VBUS_POWER_OFF and
> TYPEC_VBUS_POWER_ON values here is not reccomended. I'm looking
> for a way to remove that bit from the logic here, but wanted to
> still get feedback on this approach.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> CC: ShuFan Lee <shufan_lee@richtek.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Yu Chen <chenyu56@huawei.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jun Li <lijun.kernel@gmail.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jack Pham <jackp@codeaurora.org>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> [jstultz: Major rework to make the driver a usb-role-switch
>           intermediary]
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Change-Id: Icf381520abd46d083750d01f91e478321560fbf9

Checkpatch is your friend :)

