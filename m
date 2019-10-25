Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B56CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7893220679
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440750AbfJYP1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:27:43 -0400
Received: from foss.arm.com ([217.140.110.172]:42164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731226AbfJYP1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:27:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2665C328;
        Fri, 25 Oct 2019 08:27:41 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 596103F71A;
        Fri, 25 Oct 2019 08:27:39 -0700 (PDT)
Date:   Fri, 25 Oct 2019 16:27:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     will@kernel.org, kstewart@linuxfoundation.org,
        sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        lorenzo.pieralisi@arm.com, tglx@linutronix.de,
        David.Laight@ACULAB.COM, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hushiyuan@huawei.com, wuyun.wu@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH v6] arm64: psci: Reduce the waiting time for
 cpu_psci_cpu_kill()
Message-ID: <20191025152737.GN3328@arrakis.emea.arm.com>
References: <0842431c-fa15-2ba1-ae6d-c1fea157941f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0842431c-fa15-2ba1-ae6d-c1fea157941f@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 07:31:21PM +0800, Yunfeng Ye wrote:
> In cases like suspend-to-disk and suspend-to-ram, a large number of CPU
> cores need to be shut down. At present, the CPU hotplug operation is
> serialised, and the CPU cores can only be shut down one by one. In this
> process, if PSCI affinity_info() does not return LEVEL_OFF quickly,
> cpu_psci_cpu_kill() needs to wait for 10ms. If hundreds of CPU cores
> need to be shut down, it will take a long time.
> 
> Normally, there is no need to wait 10ms in cpu_psci_cpu_kill(). So
> change the wait interval from 10 ms to max 1 ms and use usleep_range()
> instead of msleep() for more accurate timer.
> 
> In addition, reducing the time interval will increase the messages
> output, so remove the "Retry ..." message, instead, track time and
> output to the the sucessful message.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Queued for 5.5. Thanks.

-- 
Catalin
