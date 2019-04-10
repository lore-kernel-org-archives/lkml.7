Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27557C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA58A20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="doLvJwUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbfDJNuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:50:12 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42690 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728553AbfDJNuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:50:12 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ADlBRr016857;
        Wed, 10 Apr 2019 15:49:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=lkjD/0Y6Zf/be/vUlQgpeAMLQ/MRF2EaFo2BVopTVNQ=;
 b=doLvJwUonfpSZ7/HRY2Dce/QhcJXdtIZ/Yn8a8dXGyc96LrJfSK/ArKsnfZAKJjLsvQo
 yHn4EXiYaq+zRP/QRYpOV8JoYP+yc6lRfAFH9azRsb+1MI3L0RtKzLMvVyUJ/q1dq60I
 3SXmSkgiMv9cOlbUkxvFZ0GCTNMhKAhJmtDXZW3NsJB4Le4kfWYebI6Frm/Y32OvlZrq
 aXirFnCWvyJSczohs8SsjaXTCsB3r33yZ1O5z6QQe+HRuLK4KTs843wiFoUbNH2e8q/P
 wqpVEEkCFjA2OEIp06SFKybuBNzoydBkWGMPrvKwD/SeCdyYmSF+NTvo6EDqNVL9HQM8 kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rpr7wrey8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 15:49:55 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE4F934;
        Wed, 10 Apr 2019 13:49:53 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 86727146D;
        Wed, 10 Apr 2019 13:49:53 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Apr
 2019 15:49:52 +0200
Subject: Re: [PATCH v1 0/5] Add supply property for DSI controller
To:     =?UTF-8?Q?Yannick_Fertr=c3=a9?= <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1554279389-27377-1-git-send-email-yannick.fertre@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <315b59d5-893a-607a-01e4-cf83fe1cfd86@st.com>
Date:   Wed, 10 Apr 2019 15:48:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554279389-27377-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick

On 4/3/19 10:16 AM, Yannick Fertré wrote:
> The DSI controller needs a new property that powers its physical layer.
> Binding has been updated to documented this property.
> Device tree of stm32mp157c soc.
> Move reg18 & reg11 to stm32mp157c device tree file.
> Remove property phy-dsi-supply property to stm32mp157c-dk2.dts file.
> 
> Yannick Fertré (5):

...

>    ARM: dts: stm32: add phy-dsi-supply property on stm32mp157c
>    ARM: dts: stm32: move fixe regulators reg11 & reg18
>    ARM: dts: stm32: remove phy-dsi-supply property on stm32mp157c-dk2
>      board
> 

For ARM part:

Another series is currently under review: "Add support for STM32MP1 
power regulators" (https://lkml.org/lkml/2019/4/8/614).

As soon I'll merge it I'll take your patches without patch
"ARM: dts: stm32: move fixe regulators reg11 & reg18" as it will be no 
longer relevant.

regards
Alexandre


>   .../devicetree/bindings/display/st,stm32-ltdc.txt    |  3 +++
>   arch/arm/boot/dts/stm32mp157c-dk2.dts                |  9 ---------
>   arch/arm/boot/dts/stm32mp157c-ed1.dts                | 16 ----------------
>   arch/arm/boot/dts/stm32mp157c.dtsi                   | 17 +++++++++++++++++
>   drivers/gpu/drm/stm/dw_mipi_dsi-stm.c                | 20 ++++++++++++++++++++
>   5 files changed, 40 insertions(+), 25 deletions(-)
> 
