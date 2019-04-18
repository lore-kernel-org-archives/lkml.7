Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B287C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFF0217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbfDRMZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:25:28 -0400
Received: from mail2.sp2max.com.br ([138.185.4.9]:42668 "EHLO
        mail2.sp2max.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRMZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:25:27 -0400
Received: from [172.17.0.2] (unknown [186.137.130.251])
        (Authenticated sender: pablo@fliagreco.com.ar)
        by mail2.sp2max.com.br (Postfix) with ESMTPA id D45527B09F9;
        Thu, 18 Apr 2019 09:25:20 -0300 (-03)
Subject: Re: [linux-sunxi] Re: [PATCH v3 1/7] ARM: dts: sun8i: r40:
 bananapi-m2-ultra: Tie GMAC regulators to the PIO
To:     maxime.ripard@bootlin.com
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1555492863-88860-1-git-send-email-pgreco@centosproject.org>
 <1555492863-88860-2-git-send-email-pgreco@centosproject.org>
 <20190417101757.traviffiulwnzr6x@flea>
From:   =?UTF-8?Q?Pablo_Sebasti=c3=a1n_Greco?= <pgreco@centosproject.org>
Message-ID: <666caeac-4297-17b0-065e-00b7fd9623b4@centosproject.org>
Date:   Thu, 18 Apr 2019 09:25:19 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417101757.traviffiulwnzr6x@flea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: D45527B09F9.A02CE
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
        escore=-1.386, requerido 6, ALL_TRUSTED -1.00, BAYES_00 -1.90,
        URIBL_RHS_DOB 1.51)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


El 17/4/19 a las 07:17, Maxime Ripard escribió:
> Hi,
>
> On Wed, Apr 17, 2019 at 06:20:56AM -0300, Pablo Greco wrote:
>> When the GMAC support was added to the bananapi-m2-ultra, regulators
>> weren't tied to the pinctrl. Fix that.
>>
>> Signed-off-by: Pablo Greco <pgreco@centosproject.org>
>> ---
>>   arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
>> index c488aaa..3da3598 100644
>> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
>> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
>> @@ -201,6 +201,8 @@
>>   &pio {
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&clk_out_a_pin>;
>> +	vcc-pa-supply = <&reg_aldo2>;
> You should list all the regulators that are needed for all the pin
> banks to operate properly, not just PA
Ok, I "think" I finally understand what you mean, so according to 
schematics in 
https://drive.google.com/file/d/0B4PAo2nW2KfndFpmZG1OOWJ5NEU/view, it 
should look like this
diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts 
b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index c488aaa..699579d 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -201,6 +201,12 @@
  &pio {
      pinctrl-names = "default";
      pinctrl-0 = <&clk_out_a_pin>;
+    vcc-pa-supply = <&reg_aldo2>;
+    vcc-pc-supply = <&reg_dcdc1>;
+    vcc-pd-supply = <&reg_dcdc1>;
+    vcc-pe-supply = <&reg_eldo1>;
+    vcc-pf-supply = <&reg_dcdc1>;
+    vcc-pg-supply = <&reg_dldo1>;
  };

  &reg_aldo2 {
-- 

I couldn't find vcc-pb, vcc-ph or vcc-pi.
If this is ok, I'll generate a v4 based on v2, and throw v3 in the trash 
where it belongs
>> +	vcc-gmac-phy-supply = <&reg_dc1sw>;
> I'm not sure what that is supposed to do?
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
Pablo.
