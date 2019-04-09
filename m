Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14143C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B5620857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDIAHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 20:07:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47500 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfDIAHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 20:07:44 -0400
Received: from [IPv6:2a02:2450:102f:3e0:845d:198:7d0e:69e8] (unknown [IPv6:2a02:2450:102f:3e0:845d:198:7d0e:69e8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F0E84263AF8;
        Tue,  9 Apr 2019 01:07:41 +0100 (BST)
Subject: Re: [PATCH] ARM: dts: imx6qdl-nitrogen6_max: Disable LVDS channels
To:     Fabio Estevam <festevam@gmail.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190408175319.9106-1-robert.foss@collabora.com>
 <CAOMZO5DAvaibi5r9CXzk8qbE7XHiHJHHvi9rcq_BJdx7aRVgoQ@mail.gmail.com>
From:   Robert Foss <robert.foss@collabora.com>
Message-ID: <4fd506a1-c961-0569-6d39-283758f363d9@collabora.com>
Date:   Tue, 9 Apr 2019 02:07:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAOMZO5DAvaibi5r9CXzk8qbE7XHiHJHHvi9rcq_BJdx7aRVgoQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Fabio,

On 4/8/19 10:37 PM, Fabio Estevam wrote:
> Hi Robert,
> 
> [Adding Gary]
> 
> On Mon, Apr 8, 2019 at 2:54 PM Robert Foss <robert.foss@collabora.com> wrote:
>>
>> If a LVDS device is not connected, having the LVDS channels
>> enabled will prevent imx-ldb from probing correctly even
>> if other CRTCs are connected.
>>
>> Signed-off-by: Robert Foss <robert.foss@collabora.com>
>> ---
>>   arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
>> index 39200e5dc896..5b413cf4c250 100644
>> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
>> @@ -703,7 +703,7 @@
>>          status = "okay";
>>
>>          lvds-channel@0 {
>> -               status = "okay";
>> +               status = "disabled";
>>
>>                  port@4 {
>>                          reg = <4>;
>> @@ -715,7 +715,7 @@
>>          };
>>
>>          lvds-channel@1 {
>> -               status = "okay";
>> +               status = "disabled";
> 
> I am not sure I understood what you are trying to fix.

If CONFIG_DRM_IMX_LDB is enabled, LVDS DT channels are enabled
and no LVDS-panels are connected the imx-ldb driver will
fail to bind.

This is a problem, since it will prevent other actually connected
display output from being used, even if they bind properly.

> 
> Could you please share some logs when imx-ldb fails to probe correctly?


[    2.119563] component_bind_all() trying to bind: ldb
[    2.124600] imx-drm display-subsystem: binding ldb (ops imx_ldb_ops)
[    2.146169] drm_of_find_panel_or_bridge() np->name=lvds-channel  np->type=<NULL>
[    2.153709] drm_of_find_panel_or_bridge() no panel found for remote
[    2.160081] drm_of_find_panel_or_bridge() bridge needed
[    2.162043] drm_of_find_panel_or_bridge() bridge not found
[    2.165331] drm_of_find_panel_or_bridge() failed
[    2.170023] imx-drm display-subsystem: failed to bind ldb (ops imx_ldb_ops): -517

This at the same time as HDMI binds properly:

[    4.458954] dwhdmi-imx 120000.hdmi: Detected HDMI TX controller v1.30a with 
HDCP (DWC HDMI 3D TX PHY)
[    4.469633] imx-drm display-subsystem: bound 120000.hdmi (ops dw_hdmi_imx_ops)

Which in the end causes the IMX driver to not initialize properly
and ignore the HDMI connection that bound properly.
This in turn prevents us from having any graphical output while there
is no LVDS panel connected.


> 
> Is this a regression?
> 

Not as far as I know.

How a Nitrogen6-Max board without a LVDS panel, but using the
imx_v6_v7_defconfig ever started and had displayed graphical
output on other connected displays I don't know though.


Rob.
