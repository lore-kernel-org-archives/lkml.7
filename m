Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880D6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA3920651
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfC2OAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:00:02 -0400
Received: from ns.iliad.fr ([212.27.33.1]:35738 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfC2OAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:00:02 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 711A0207AE;
        Fri, 29 Mar 2019 15:00:00 +0100 (CET)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 5A3211FF15;
        Fri, 29 Mar 2019 15:00:00 +0100 (CET)
Subject: Re: [PATCH] phy: qcom: qmp: Add SDM845 PCIe QMP PHY support
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <20190226065919.22218-1-bjorn.andersson@linaro.org>
 <513163ea-78fe-2910-2e82-a7014bda82e8@free.fr>
Message-ID: <6ec3dc39-ea9b-db3b-25d1-822601d06391@free.fr>
Date:   Fri, 29 Mar 2019 15:00:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <513163ea-78fe-2910-2e82-a7014bda82e8@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Fri Mar 29 15:00:00 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2019 14:42, Marc Gonzalez wrote:

> On 26/02/2019 07:59, Bjorn Andersson wrote:
> 
>> @@ -1384,6 +1536,11 @@ static int qcom_qmp_phy_init(struct phy *phy)
>>  
>>  	qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
>>  
>> +	if (cfg->pcs_misc_tbl) {
>> +		qcom_qmp_phy_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl,
>> +				       cfg->pcs_misc_tbl_num);
>> +	}
>> +
>>  	/*
>>  	 * UFS PHY requires the deassert of software reset before serdes start.
>>  	 * For UFS PHYs that do not have software reset control bits, defer
> 
> I think it would be better to configure pcs_misc *before* pcs.
> That would be closer to what downstream does (for 835 and 845 at least).
> 
> Also you don't need to test for NULL as that is already done in
> qcom_qmp_phy_configure() -- and in fact even that test is redundant,
> since the array is not dereferenced when count is 0.
> 
> When are you planning on sending a v2 of your PCIe series?

I split my comments across 3 messages. Have you seen them all?
(And taken them into account?)

Note: I folded the drivers/phy/qualcomm/phy-qcom-qmp.h definitions within
[PATCH v3 1/2] phy: qcom-qmp: Add msm8998 PCIe QMP PHY support

Regards.
