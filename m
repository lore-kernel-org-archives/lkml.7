Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52CAC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EAE214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfHTOIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:08:00 -0400
Received: from ns.iliad.fr ([212.27.33.1]:55558 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729988AbfHTOH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:07:57 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 29796205F8;
        Tue, 20 Aug 2019 16:07:55 +0200 (CEST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 14B2620554;
        Tue, 20 Aug 2019 16:07:55 +0200 (CEST)
Subject: Re: [PATCH] phy: qcom-qmp: Correct ready status, again
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
References: <20190806004256.20152-1-bjorn.andersson@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <d455b4b3-0ee6-5612-ead9-b0087e11b22e@free.fr>
Date:   Tue, 20 Aug 2019 16:07:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806004256.20152-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Aug 20 16:07:55 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2019 02:42, Bjorn Andersson wrote:

> Despite extensive testing of 885bd765963b ("phy: qcom-qmp: Correct
> READY_STATUS poll break condition") I failed to conclude that the
> PHYSTATUS bit of the PCS_STATUS register used in PCIe and USB3 falls as
> the PHY gets ready. Similar to the prior bug with UFS the code will
> generally get past the check before the transition and thereby
> "succeed".
> 
> Correct the name of the register used PCIe and USB3 PHYs, replace
> mask_pcs_ready with a constant expression depending on the type of the
> PHY and check for the appropriate ready state.
> 
> Cc: stable@vger.kernel.org
> Cc: Vivek Gautam <vivek.gautam@codeaurora.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Reported-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Fixes: 885bd765963b ("phy: qcom-qmp: Correct READY_STATUS poll break condition")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 33 ++++++++++++++---------------
>  1 file changed, 16 insertions(+), 17 deletions(-)

FWIW, for msm8998:

Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Regards.
