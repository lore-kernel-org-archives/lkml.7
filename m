Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF20C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B1C21783
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UnwowhF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfFSOy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:54:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35938 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSOyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:54:25 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5JEsI3u106573;
        Wed, 19 Jun 2019 09:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560956058;
        bh=Meb5QHv2YsjyRqvieBsOFA71QIU21ZFFqwC9XOZFqYI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UnwowhF+dQ8U1Jd425nGUZ+ZmbwI/4OxR1QB03gZDmkKvvidKiYh7OTxAup3w5KyH
         PfLjgP1vO8qt6CXPo5l97PokmrWq2YNNdzeWcDdk8bOLT5LkOwvztPnglIcoGYILY3
         8/rhf4nt6BolLSW09QNqWnzABMfNB4KBDBWhvMkw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5JEsIp1010399
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Jun 2019 09:54:18 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 19
 Jun 2019 09:54:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 19 Jun 2019 09:54:18 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5JEsFiT055184;
        Wed, 19 Jun 2019 09:54:16 -0500
Subject: Re: [PATCH] [RESEND] ARM: davinci: fix sleep.S build error on ARMv4
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190619131148.1743339-1-arnd@arndb.de>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <af35b098-217e-e09d-d44a-2885ad498907@ti.com>
Date:   Wed, 19 Jun 2019 20:24:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619131148.1743339-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 19/06/19 6:41 PM, Arnd Bergmann wrote:
> When building a multiplatform kernel that includes armv4 support,
> the default target CPU does not support the blx instruction,
> which leads to a build failure:
> 
> arch/arm/mach-davinci/sleep.S: Assembler messages:
> arch/arm/mach-davinci/sleep.S:56: Error: selected processor does not support `blx ip' in ARM mode
> 
> Add a .arch statement in the sources to make this file build.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested on OMAP-L138 LCDK board with suspend-resume.

Assuming you will pick this directly:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Regards,
Sekhar
