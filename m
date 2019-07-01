Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD63C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E145B2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oLkEnK10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfGAOlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:41:45 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49690 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfGAOlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:41:45 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x61Eel75075389;
        Mon, 1 Jul 2019 09:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561992047;
        bh=v09DKmxdyp0eEsvf+kyn4y4hnlTkeSpL6c6F1V4f4FA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oLkEnK10lOzZSr8kWXvyIEzwRTGPy9yC0AqouKKQ5P0FswISZynDNwYfWMhmiESnO
         And5l8d/dgLdTP0j/yDzwkkEYIZZXxsL2/pm9cog/7jNYxFgiEpeHFw0/VSWgS6ceC
         gC3uk1kSLls9pkjZPE1FSx5VuIP5L7DrnYuD+2Ps=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x61EelNv091078
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Jul 2019 09:40:47 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Jul
 2019 09:40:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Jul 2019 09:40:47 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x61Eegav086236;
        Mon, 1 Jul 2019 09:40:44 -0500
Subject: Re: [PATCH 00/12] ARM: davinci: da850-evm: remove more legacy GPIO
 calls
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190625163434.13620-1-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <fe42c0e1-2bfb-2b1c-2c38-0e176e88ec6e@ti.com>
Date:   Mon, 1 Jul 2019 20:10:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625163434.13620-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee, Daniel, Jingoo,

On 25/06/19 10:04 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This is another small step on the path to liberating davinci from legacy
> GPIO API calls and shrinking the davinci GPIO driver by not having to
> support the base GPIO number anymore.
> 
> This time we're removing the legacy calls used indirectly by the LCDC
> fbdev driver.
> 
> The first three patches modify the GPIO backlight driver. The first
> of them adds the necessary functionality, the other two are just
> tweaks and cleanups.

Can you take the first three patches for v5.3 - if its not too late? I
think that will make it easy for rest of patches to make into subsequent
kernel releases.

> 
> Next two patches enable the GPIO backlight driver in
> davinci_all_defconfig.
> 
> Patch 6/12 models the backlight GPIO as an actual GPIO backlight device.
> 
> Patches 7-9 extend the fbdev driver with regulator support and convert
> the da850-evm board file to using it.
> 
> Last three patches are improvements to the da8xx fbdev driver since
> we're already touching it in this series.

Thanks,
Sekhar

