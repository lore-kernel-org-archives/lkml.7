Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA29C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA8420879
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfCROfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:35:23 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11891 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726868AbfCROfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:35:22 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2IEQ00t005301;
        Mon, 18 Mar 2019 15:35:05 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2r8q5b4jru-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Mar 2019 15:35:05 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E3F0931;
        Mon, 18 Mar 2019 14:35:04 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9062651C9;
        Mon, 18 Mar 2019 14:35:04 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.45) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 18 Mar
 2019 15:35:03 +0100
Subject: Re: [PATCH v5 0/3] Add PM support to STM32 LP Timer drivers
To:     <thierry.reding@gmail.com>
CC:     <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <tduszyns@gmail.com>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1550668068-9661-1-git-send-email-fabrice.gasnier@st.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <b89207ac-d80b-d79f-02cc-095f19b8aecf@st.com>
Date:   Mon, 18 Mar 2019 15:35:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1550668068-9661-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-18_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 2:07 PM, Fabrice Gasnier wrote:
> This patch series adds power management support for STM32 LP Timer:
> - PWM driver
> - Document the pinctrl states for sleep mode
> 
> It also adds device link between the PWM consumer and the PWM provider.
> This allows proper sequencing for suspend/resume (e.g. user will likely
> do a pwm_disable() before the PWM provider suspend executes), see [1].
> 
> [1] https://lkml.org/lkml/2019/2/5/770

Hi Thierry,

Gentle reminder to review changes I've made in v5.

Thanks in advance,
Best Regards,
Fabrice

> 
> ---
> Changes in v5:
> - improve a warning message, fix a style issue.
> 
> Changes in v4:
> - improve error handling when adding the PWM consumer device link.
> 
> Changes in v3:
> - Move the device_link_add() call to of_pwm_get() as discussed with Uwe.
> 
> Changes in v2:
> - Don't disable PWM channel in PWM provider: rather refuse to suspend
>   and report an error as suggested by Uwe and Thierry.
> - Add patch 3/3 to propose device link addition.
> - No updates for STM32 LP Timer IIO driver. Patches can be send separately.
> 
> Fabrice Gasnier (3):
>   dt-bindings: pwm-stm32-lp: document pinctrl sleep state
>   pwm: stm32-lp: Add power management support
>   pwm: core: add consumer device link
> 
>  .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  9 ++--
>  drivers/pwm/core.c                                 | 50 ++++++++++++++++++++--
>  drivers/pwm/pwm-stm32-lp.c                         | 25 +++++++++++
>  include/linux/pwm.h                                |  6 ++-
>  4 files changed, 82 insertions(+), 8 deletions(-)
> 
