Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B78C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1F920700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ef2r/5nV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfC0Lhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:37:37 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41942 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfC0Lhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:37:37 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2RBbTC2125940;
        Wed, 27 Mar 2019 06:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553686649;
        bh=YM0oB4FplgXR+sCLF0VNM1snwLb5RkA+/UJwPyNDyEI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ef2r/5nVP2dRl6cBz1Zw1RDNjEeSVgHhNmPNSmqfepsgUL52JkjofQHc6D0e0/aFx
         impAmNKhwgnveVH90LB0QpgJb7KA/58xVpqe0sYOu3Y72U1y9cgJJSVI6Y9+flcf1o
         W3xGBHALjRZoR3zkVSbHk0V2iuSGTVXxmaJfIi9Y=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2RBbTbg032080
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Mar 2019 06:37:29 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 27
 Mar 2019 06:37:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 27 Mar 2019 06:37:29 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2RBbQhD056452;
        Wed, 27 Mar 2019 06:37:27 -0500
Subject: Re: [PATCH 0/3] ARM: davinci: ohci-da8xx: model the vbus GPIO as a
 fixed regulator
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190326155728.5432-1-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <712540aa-6927-9141-4f0c-740193d26f33@ti.com>
Date:   Wed, 27 Mar 2019 17:07:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326155728.5432-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 26/03/19 9:27 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Adding the vbus GPIO support to the ohci-da8xx driver isn't really the
> optimal solution. Rather: it should be modeled as a fixed regulator
> in which case the driver already has support.

Can you clarify "driver already has support"? You are introducing
support to use the VBUS gpio as regulator as part of 3/3.

I do see other instances of VBUS regulator being used in USB tree. But
we just converted the driver to use VBUS and over-current GPIOs in v5.1.
So this is a bit of "churn".

Can you document why the current solution is not optimal? Is it to make
future device-tree conversion for these boards easier? Or?

> 
> This series adds necessary fixups to the board files and removes the
> vbus GPIO from the ohci driver.

Thanks,
Sekhar
