Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5529AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C88206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FSOOVo6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfC0PhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:37:24 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60390 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfC0PhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:37:24 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2RFaJVQ025552;
        Wed, 27 Mar 2019 10:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553700979;
        bh=8LoYRkETymFEu4Fn9ZiKjmd5Ps+Y22qSukCPHcuFAYM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FSOOVo6PPUZCuUXNgPpDt6Gfn9GOTNl64b8eaNUPNSWOQ57NISnreS/OTh5hb0sQ4
         CopHdCbLfWNso1l84WhEO1kQX1pC/MA/UF0rsY+QFRSTENuPMnwlFMpLo7ubaCerUg
         gdnt9OaKjZs8l+nUBHEmfTCw47RYXkLiG/xK+0sg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2RFaJhd030432
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Mar 2019 10:36:19 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 27
 Mar 2019 10:36:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 27 Mar 2019 10:36:18 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2RFaFgg059723;
        Wed, 27 Mar 2019 10:36:16 -0500
Subject: Re: [PATCH v4 00/11] ARM: davinci: modernize the timer support
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190318121100.28132-1-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <ee3034e0-7037-3055-749c-ca3897078e10@ti.com>
Date:   Wed, 27 Mar 2019 21:06:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318121100.28132-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel, Thomas,

On 18/03/19 5:40 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series removes the legacy timer code from mach-davinci in favor of
> a new clocksource driver it introduces.
> 
> Patch 1 adds a new clocksource driver for davinci.
> 
> Patch 2 enables the new driver for device-tree based systems.
> 
> Patch 3 adds a WARN_ON() to the machine code of all davinci boards
> which is triggered if clk_get() for the timer clock fails. This is needed
> as the new driver expects the clock to be functional and doesn't check it.
> 
> Patches 4-5 and 7-10 switch the board files to using the new
> clocksource driver while patch 6 moves some necessary defines to
> a different place since we'll be removing the file that contains them.
> 
> Patch 11 removes legacy timer code.

The series looks good to me. With your ack on 1/11, I would like to
merge the series through ARM SoC tree.

Thanks,
Sekhar
