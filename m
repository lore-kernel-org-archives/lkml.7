Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC16C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7911218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gebH+18d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfDLKkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:40:37 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49388 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfDLKkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:40:37 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3CAeVbp054332;
        Fri, 12 Apr 2019 05:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555065631;
        bh=oZ4ZoW4ZAvA3g6KKowu4oAMoXHLHUnoPE9vYBuX02v0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gebH+18diZdoqKt9YG/CsXyNMxo/QDbiWweIzTy6a5pzFr4/ohGwmy7cuPrI+z5ax
         VK0zEYRWEQ+ZL90vNRBq8P1jNw4K3EGSVr+QgGUEGSw+IMsr+ZjkMyuOf5Ys3BcAm2
         goRYipzAlkt0Ok82/WjsUsyD9H2PWWLFn5btNSsY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3CAeVxF110831
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Apr 2019 05:40:31 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 05:40:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Apr 2019 05:40:31 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3CAeQLC049351;
        Fri, 12 Apr 2019 05:40:27 -0500
Subject: Re: [PATCH v4 0/6] ARM: davinci: ohci-da8xx: model the vbus GPIO as a
 fixed regulator
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190411093024.23555-1-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <8b0f357c-5ec9-baab-761f-226bfb704564@ti.com>
Date:   Fri, 12 Apr 2019 16:10:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411093024.23555-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/19 3:00 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Historically the power supply management in this driver has been handled
> in two separate places in parallel. Device-tree users simply defined an
> appropriate regulator, while two boards with no DT support (da830-evm and
> omapl138-hawk) passed functions defined in their respective board files
> over platform data. These functions simply used legacy GPIO calls to
> watch the oc GPIO for interrupts and disable the vbus GPIO when the irq
> fires.
> 
> Commit d193abf1c913 ("usb: ohci-da8xx: add vbus and overcurrent gpios")
> updated these GPIO calls to the modern API and moved them inside the
> driver.
> 
> This however is not the optimal solution for the vbus GPIO as it
> duplicates code. Instead we should model the GPIO as a fixed regulator
> that can be controlled with a GPIO.
> 
> This series adds fixed regulators for all users of vbus GPIO, adds
> overcurrent protection using the existing vbus regulator in the USB
> driver and removes the vbus GPIO calls once they're no longer used.
> 
> Tested on da830-evm with the module both built-in and loadable.

Looks good to me except some minor issues pointed out. If you can spin
the next version quickly, I would try merging for v5.2

Thanks,
Sekhar
