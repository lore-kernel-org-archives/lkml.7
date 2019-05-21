Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE13EC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95683217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yWkDv5Pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfEUTPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 15:15:02 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42596 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEUTPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 15:15:02 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4LJF1Q9023935;
        Tue, 21 May 2019 14:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558466101;
        bh=3WysA2VpJ32YviVM2gWhIYoGciz0aznDNykj2COnt3k=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=yWkDv5PzlXiE3eGkM+4Y1pOOLcwUP0LjtJp09S34CWHEkW5ppUjjGryhwah4W4E5Y
         fd/RKVpmUm6or8d8aeed8XwgLqSoaYajq7Ar4uzl4t6axZCKAw1xb8DT4NUBf0KIJo
         V11DPljVVWiwBJb3sLxYYRbadPTqjUilOPgkoNoQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4LJF19o081898
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 May 2019 14:15:01 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 21
 May 2019 14:15:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 21 May 2019 14:15:01 -0500
Received: from [10.8.44.208] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4LJF11R004869;
        Tue, 21 May 2019 14:15:01 -0500
Subject: Re: Generic PHY "unload" crash
To:     Alan Cooper <alcooperx@gmail.com>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <CAOGqxeWTh0NJ177cH5a4ph-W49pFehjdEcVv+SLm__TiHJc_aQ@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9f0becda-4ee1-1330-91c4-df919507cb2c@ti.com>
Date:   Tue, 21 May 2019 14:15:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAOGqxeWTh0NJ177cH5a4ph-W49pFehjdEcVv+SLm__TiHJc_aQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 21/05/19 1:40 PM, Alan Cooper wrote:
> I'm seeing an issue on a system where I have a generic PHY that is
> used by a USB XHCI driver. The XHCI driver does the phy_init() in
> probe and the phy_exit() in remove. The problem happens when I use
> sysfs to "unload" the PHY driver before doing an unload of the XHCI
> driver. This is a result of the XHCI driver calling into the PHY
> driver's phy_exit routine after it's been removed. It seems like this
> issue will exist for other PHY provider/user pairs and I don't see an
> easy solution. I was wondering if anyone had any suggestions on how to
> solve this problem.

Can you share the crash dump please?

Thanks
Kishon
