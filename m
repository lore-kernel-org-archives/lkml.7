Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9F7C31E41
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724242173E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ENZtCi9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391385AbfFJQA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:00:58 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:50639 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389356AbfFJQA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:00:57 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5AFpjoA009189;
        Mon, 10 Jun 2019 18:00:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=hL5doPAk7gz0oURE8Qq+x0YUW9RAa/CHoF+4B6z8r2k=;
 b=ENZtCi9dMus0j1k6iHnZpCQ1RX+RtshUvGAffIQ9bro55dGz1QKditKnTUFiuWS0zw8h
 JX6hS18qOmYCUfcopHomtLXHOQeMOQqY57MJ5RH/6w1rW6zRFhLRsMeHVCP9oG2V4f/Z
 LMvh1q8dwxlCthe780b4xdGec8F4Am5dUaBGNol1Xc+KZ5aAJaykZQrtv3wVL85A5Bbm
 C0p5IGHLiZc46sw+L0Gq3sj5cj6TVQGfpbUYL23tDdTC4MeosEjC8HxMUe7brT/ecanB
 GPznEItkcwq2tMWlFGO285T7SY2Pma8heSyluzp7Q7uZfU5kQNMeK4Cxg17UBJft1Dk1 0Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t02st9vxe-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 10 Jun 2019 18:00:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C44BB31;
        Mon, 10 Jun 2019 16:00:38 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9BD9A4F5B;
        Mon, 10 Jun 2019 16:00:38 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 10 Jun
 2019 18:00:38 +0200
Subject: Re: [PATCH 00/10] STM32 usart power improvements
To:     Erwan Le Ray <erwan.leray@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <1559638519-6128-1-git-send-email-erwan.leray@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e6fecf4c-cb07-4cf7-099a-201b14e90a00@st.com>
Date:   Mon, 10 Jun 2019 18:00:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559638519-6128-1-git-send-email-erwan.leray@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-10_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erwan,

On 6/4/19 10:55 AM, Erwan Le Ray wrote:
> This series delivers power improvements for stm32-usart driver.
> 
> Bich Hemon (4):
>    dt-bindings: serial: add optional pinctrl states
>    serial: stm32: select pinctrl state in each suspend/resume function
>    ARM: dts: stm32: Update pin states for uart4 on stm32mp157c-ed1
>    ARM: dts: stm32: Update UART4 pin states on stm32mp157a-dk1
> 
> Erwan Le Ray (6):
>    dt-bindings: serial: stm32: add wakeup option
>    serial: stm32: add pm_runtime support
>    serial: stm32: Use __maybe_unused instead of #if CONFIG_PM_SLEEP
>    serial: stm32: add support for no_console_suspend
>    ARM: dts: stm32: update uart4 pin configurations for low power
>    ARM: dts: stm32: add wakeup capability on each usart/uart on
>      stm32mp157c
> 
>   .../devicetree/bindings/serial/st,stm32-usart.txt  | 19 ++++-
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          | 17 +++++
>   arch/arm/boot/dts/stm32mp157a-dk1.dts              |  5 +-
>   arch/arm/boot/dts/stm32mp157c-ed1.dts              |  5 +-
>   arch/arm/boot/dts/stm32mp157c.dtsi                 | 40 ++++++++--
>   drivers/tty/serial/stm32-usart.c                   | 88 ++++++++++++++++++++--
>   drivers/tty/serial/stm32-usart.h                   |  1 +
>   7 files changed, 155 insertions(+), 20 deletions(-)
> 

I'll merge device tree part into stm32-next branch when binding part 
will be accepted.

regards
Alex
