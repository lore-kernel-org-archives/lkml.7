Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F210DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E8F206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbfH0IHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:07:33 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:1433 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730471AbfH0IH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:07:29 -0400
IronPort-SDR: okybydZ720+8OTwnjqV7ZPqywGZbnhKb8NRjL2NRQMPXdMcSBwJyoLUqB8v5ZMm4sxpVvvlpFx
 hOfUACiyFH6O8EAks9bxBSd72rCqjZODFF3YyLrDtzw8xpU6sK0/ddpK0tVouK1qzwK+wUFswv
 WREYy70Tr7Zje/3PAirQo+ORfuq9/3sdwKmPQnDL827V2U2PKdGccPFHljqaNYJQ3/KJLfHNne
 VecGmHAFdce0jaVJgYrohFH6mGfaFeQ/MvvJmpf4N+hNp9bzPO+u/pLYrUfouBhpWUGb5kn1E7
 acs=
X-IronPort-AV: E=Sophos;i="5.64,436,1559509200"; 
   d="scan'208";a="229735730"
Subject: Re: [v4] rtc: pcf85363/pcf85263: fix error that failed to run hwclock
 -w
To:     Biwen Li <biwen.li@nxp.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, leoyang.li@nxp.com,
        broonie@kernel.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190827043735.31231-1-biwen.li@nxp.com>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <2b49e282-fc03-ee59-2719-5a3c1ce573ce@vaisala.com>
Date:   Tue, 27 Aug 2019 11:07:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190827043735.31231-1-biwen.li@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Aug 2019 08:07:24.0220 (UTC) FILETIME=[757897C0:01D55CAE]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/19 7:37 AM, Biwen Li wrote:
>   - In drivers/rtc/rtc-pcf85363.c, CTRL_STOP_EN is 0x2e, but DT_100THS
>        is 0, max_regiter is 0x2f, then reg will be equal to 0x30,
>        '0x30 < 0x2f' is false,so regmap_writeable will return false.
> 
>      - The pcf85363/pcf85263 has the capability of address wrapping
>        which means if you access a continuous address range across a
>        certain boundary(max_register of struct regmap_config) the
>        hardware actually wraps the access to a lower address. But the
>        address violation check of regmap rejects such access.

nitpick: This 2 paragraphs could be combined to clear up the issue:

`
The pcf85363/pcf85263 has the capability of address wrapping
which means if you access an address outside the allowed range 
(0x00-0x2f) the hardware actually wraps the access to a lower address. 
The rtc-pf85363 driver will use this feature to configure the time and 
execute 2 actions in the same i2c write operation (stopping the clock 
and configure the time). However the driver has also configured the 
`regmap maxregister` protection mechanism that will block accessing 
addresses outside valid range (0x00-0x2f).
`

nitpick: I would also use separate buffers for this actions. Up to you :)

Otherwise LGTM +1

Nandor
