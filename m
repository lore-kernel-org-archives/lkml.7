Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC80C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D78208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgAFSmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:42:10 -0500
Received: from foss.arm.com ([217.140.110.172]:48002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbgAFSmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:42:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F9EA328;
        Mon,  6 Jan 2020 10:42:09 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2161C3F534;
        Mon,  6 Jan 2020 10:42:08 -0800 (PST)
Subject: Re: [PATCH] cpu-topology: Skip the exist but not possible cpu nodes
To:     Zeng Tao <prime.zeng@hisilicon.com>, sudeep.holla@arm.com
Cc:     linuxarm@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1577935489-25245-1-git-send-email-prime.zeng@hisilicon.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <14a39167-5704-f406-614d-4d25b8fe8c68@arm.com>
Date:   Mon, 6 Jan 2020 19:42:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577935489-25245-1-git-send-email-prime.zeng@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2020 04:24, Zeng Tao wrote:
> When CONFIG_NR_CPUS is smaller than the cpu nodes defined in the device
> tree, the cpu node parsing will fail. And this is not reasonable for a
> legal device tree configs.
> In this patch, skip such cpu nodes rather than return an error.

Is this extra code really necessary?

Currently you get warnings indicating that CONFIG_NR_CPUS is too small
so you could correct the setup issue easily.

Example: Arm64 Juno board

$ grep "cpu@" ./arch/arm64/boot/dts/arm/juno.dts
		A57_0: cpu@0 {
		A57_1: cpu@1 {
		A53_0: cpu@100 {
		A53_1: cpu@101 {
		A53_2: cpu@102 {
		A53_3: cpu@103 {

root@juno:~# uname -r
5.5.0-rc5

root@juno:~# zcat /proc/config.gz | grep CONFIG_NR_CPUS
CONFIG_NR_CPUS=4

root@juno:~# cat /proc/cpuinfo | grep ^proc
processor       : 0
processor       : 1
processor       : 2
processor       : 3

root@juno:~# dmesg | grep "Unable\|Can't"
[    0.085089] Unable to find CPU node for /cpus/cpu@102
[    0.090179] /cpus/cpu-map/cluster1/core2: Can't get CPU for leaf core

[...]
