Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFDEC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C4F2176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e5Y2B5c0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfK1IUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:20:36 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42154 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfK1IUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:20:36 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAS8KWpb108601;
        Thu, 28 Nov 2019 02:20:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574929232;
        bh=YeiqDx6xy0lLTLKZ4JJ6oMuelrCkWsSmvcEt2fV6Ns4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=e5Y2B5c0YN7+bkDzQrRBfV4wcDP4iPzLh2JtIINqVswslCLf0f7TJgmGCWKvCw2Ms
         pFhKEHW/lhp3+OgtUoNVJrrnLlx9KPdflssR/N+SOCXoMvwtC1cisalSddQJBax9S7
         kbRIYf2MwMS/KUfWgi5Gz6v/t+OokxzFApSXXZW0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAS8KWDr067235
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Nov 2019 02:20:32 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 28
 Nov 2019 02:20:32 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 28 Nov 2019 02:20:32 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAS8KTAH062029;
        Thu, 28 Nov 2019 02:20:30 -0600
Subject: Re: [PATCH] mmc: sdhci: Fix incorrect switch to HS mode
To:     Alan Cooper <alcooperx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20190903115114.33053-1-alcooperx@gmail.com>
 <CAPDyKFqaNBH3Thwy1O+KXkcsgM2gMrm9zNGYWH8vVP+Y2vSLdA@mail.gmail.com>
 <CAOGqxeUJD7eQxRnH1rep=m2+Ga5DDF=uWMsc_j2NZgC+EnZqsg@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <7e495749-1539-9164-d801-305a918318d6@ti.com>
Date:   Thu, 28 Nov 2019 13:51:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOGqxeUJD7eQxRnH1rep=m2+Ga5DDF=uWMsc_j2NZgC+EnZqsg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/09/19 5:27 PM, Alan Cooper wrote:
> This does correct the sequence of switching to HS400 but it might be
> safest to just add this to the latest until it gets a little testing
> to make sure it doesn't expose some bug in existing controllers.
> 
> Thanks
> Al
> 
> On Tue, Sep 3, 2019 at 10:52 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On Tue, 3 Sep 2019 at 13:51, Al Cooper <alcooperx@gmail.com> wrote:
>>>
>>> When switching from any MMC speed mode that requires 1.8v
>>> (HS200, HS400 and HS400ES) to High Speed (HS) mode, the system
>>> ends up configured for SDR12 with a 50MHz clock which is an illegal
>>> mode.
>>>
>>> This happens because the SDHCI_CTRL_VDD_180 bit in the
>>> SDHCI_HOST_CONTROL2 register is left set and when this bit is
>>> set, the speed mode is controlled by the SDHCI_CTRL_UHS field
>>> in the SDHCI_HOST_CONTROL2 register. The SDHCI_CTRL_UHS field
>>> will end up being set to 0 (SDR12) by sdhci_set_uhs_signaling()
>>> because there is no UHS mode being set.
>>>
>>> The fix is to change sdhci_set_uhs_signaling() to set the
>>> SDHCI_CTRL_UHS field to SDR25 (which is the same as HS) for
>>> any switch to HS mode.

This change has broken High speed mode in SD card for me in AM65x-evm. I
guess this change only needs to be done for eMMC. SDR25 is decidedly not
the same as high speed for SD card.

Thanks,
Faiz

