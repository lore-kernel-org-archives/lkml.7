Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E6C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 07:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22DA21D71
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 07:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GOPzJ6Ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbfIIHjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 03:39:05 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42230 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfIIHjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 03:39:04 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x897c5XT064682;
        Mon, 9 Sep 2019 02:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568014685;
        bh=d3WXiAoIHNOPCQY5Nl1J90ozKzsARnBX6JhSEGqGL1I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GOPzJ6FtRI9C9NRAolMibCbql+mDn4YJhAW+wa+J9Cu4DxO3SjhbrnXFqPMPgiJ/1
         ydDPw/cHHGr3j8mS6AFhSds5njIITcN+wSn/TbWSeYceA2BJtOkxnSSYy7jB/s+DQO
         ExjfMz6E6mhperX3qTLjE3ECPvrcSncBf6TVViTo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x897c5V2062592
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Sep 2019 02:38:05 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 9 Sep
 2019 02:38:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 9 Sep 2019 02:38:05 -0500
Received: from [172.24.190.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x897c22Y072294;
        Mon, 9 Sep 2019 02:38:03 -0500
Subject: Re: [PATCH v2 4/5] ARM: davinci: support multiplatform build for ARM
 v5
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190725131257.6142-1-brgl@bgdev.pl>
 <20190725131257.6142-5-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <5fd79cda-59d4-b69b-9902-5d01e1087c62@ti.com>
Date:   Mon, 9 Sep 2019 13:08:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725131257.6142-5-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/19 6:42 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add modifications necessary to make davinci part of the ARM v5
> multiplatform build.
> 
> Move the arch-specific configuration out of arch/arm/Kconfig and
> into mach-davinci/Kconfig. Remove the sub-menu for DaVinci
> implementations (they'll be visible directly under the system type.
> Select all necessary options not already selected by ARCH_MULTI_V5.
> Update davinci_all_defconfig. Explicitly include the mach-specific
> headers in mach-davinci/Makefile.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar

