Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7C4C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9022206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfHSBb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 21:31:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfHSBb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 21:31:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F2A1D6AA8E8F112455E8;
        Mon, 19 Aug 2019 09:31:23 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 19 Aug 2019
 09:31:18 +0800
Subject: Re: [PATCH linux-next] qcom: qcs404: remove COMPILE_TEST from
 CONFIG_INTERCONNECT_QCOM_QCS404
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <georgi.djakov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
References: <20190815074848.195806-1-maowenan@huawei.com>
 <20190818010905.7AD602173B@mail.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Message-ID: <314f2762-f3a8-a645-c6b4-511f687fb731@huawei.com>
Date:   Mon, 19 Aug 2019 09:31:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190818010905.7AD602173B@mail.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/18 9:09, Stephen Boyd wrote:
> Quoting Mao Wenan (2019-08-15 00:48:48)
>> There is one compilation error when CONFIG_INTERCONNECT_QCOM_QCS404=y and
>> CONFIG_INTERCONNECT_QCOM_SMD_RPM=y, as well as CONFIG_COMPILE_TEST=y,
>> but CONFIG_QCOM_SMD_RPM is not set, logs as below:
>>
>> drivers/interconnect/qcom/smd-rpm.o: In function `qcom_icc_rpm_smd_send':
>> smd-rpm.c:(.text+0xe4): undefined reference to `qcom_rpm_smd_write'
>> Makefile:1071: recipe for target 'vmlinux' failed
>> make: *** [vmlinux] Error 1
>>
>> This is because
>> INTERCONNECT_QCOM_QCS404 depends on QCOM_SMD_RPM || COMPILE_TEST.
>> Here CONFIG_COMPILE_TEST=y, so CONFIG_INTERCONNECT_QCOM_SMD_RPM
>> is selected. If CONFIG_QCOM_SMD_RPM is not set, then
>> qcom_rpm_smd_write() is not defined, and compilation error happen.
>> Fix this by removing COMPILE_TEST from CONFIG_INTERCONNECT_QCOM_QCS404.
> 
> Can you fix the actual problem with compile testing this driver vs. just
> removing the possibility to compile test. Otherwise it gives up on
> the spirit of the idea of COMPILE_TEST.

yes, I have already tried to move COMPILE_TEST to INTERCONNECT_QCOM,


 config INTERCONNECT_QCOM
        bool "Qualcomm Network-on-Chip interconnect drivers"
-       depends on ARCH_QCOM
+       depends on ARCH_QCOM || COMPILE_TEST
        help
          Support for Qualcomm's Network-on-Chip interconnect hardware.

> 
> 
> .
> 

