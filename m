Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA00C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DAB2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbfCZLxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:53:31 -0400
Received: from ns.iliad.fr ([212.27.33.1]:43520 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729625AbfCZLxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:53:30 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id C807620A98;
        Tue, 26 Mar 2019 12:53:28 +0100 (CET)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id AE77D20A8F;
        Tue, 26 Mar 2019 12:53:28 +0100 (CET)
Subject: Re: [PATCH v1] phy: qcom-qmp: Add msm8998 PCIe QMP PHY support
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <a897277d-23b3-9746-81dc-28f8925a9992@free.fr>
 <136857e7-0fe1-6fc6-729e-2cbf6ea72386@ti.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <e724b6ed-ef04-1b3b-7ae7-579ea770187d@free.fr>
Date:   Tue, 26 Mar 2019 12:53:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <136857e7-0fe1-6fc6-729e-2cbf6ea72386@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Mar 26 12:53:28 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2019 08:45, Kishon Vijay Abraham I wrote:

> On 22/03/19 9:42 PM, Marc Gonzalez wrote:
> 
>> Copy init sequence from downstream:
>> https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm8998-v2.dtsi?h=LE.UM.1.3.r3.25#n372
> 
> Can't we instead have reference to HW manual or datasheet?

I have heard of these legendary beasts, but I have never seen one.

>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>> ---
>>  .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   5 +
>>  drivers/phy/qualcomm/phy-qcom-qmp.c           | 110 ++++++++++++++++++
>>  drivers/phy/qualcomm/phy-qcom-qmp.h           |  12 ++
>>  3 files changed, 127 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> index 5d181fc3cc18..6000ae34b12b 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> @@ -11,6 +11,7 @@ Required properties:
>>  	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
>>  	       "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,
>>  	       "qcom,msm8998-qmp-ufs-phy" for UFS QMP phy on msm8998,
>> +	       "qcom,msm8998-qmp-pcie-phy" for PCIe QMP phy on msm8998,
>>  	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
>>  	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
>>  	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
>> @@ -48,6 +49,8 @@ Required properties:
>>  			"aux", "cfg_ahb", "ref".
>>  		For "qcom,msm8998-qmp-ufs-phy" must contain:
>>  			"ref", "ref_aux".
>> +		For "qcom,msm8998-qmp-pcie-phy" must contain:
>> +			"aux", "cfg_ahb", "ref".
>>  		For "qcom,sdm845-qmp-usb3-phy" must contain:
>>  			"aux", "cfg_ahb", "ref", "com_aux".
>>  		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
>> @@ -70,6 +73,8 @@ Required properties:
>>  		For "qcom,msm8998-qmp-usb3-phy" must contain
>>  			"phy", "common".
>>  		For "qcom,msm8998-qmp-ufs-phy": no resets are listed.
>> +		For "qcom,msm8998-qmp-pcie-phy" must contain:
>> +			"phy", "common", "cfg".
>>  		For "qcom,sdm845-qmp-usb3-phy" must contain:
>>  			"phy", "common".
>>  		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
> 
> Please send the dt binding in a separate patch.

Coming right up.
