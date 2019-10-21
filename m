Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9D4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB70820679
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfJULVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:21:53 -0400
Received: from [217.140.110.172] ([217.140.110.172]:49738 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfJULVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:21:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77069EBD;
        Mon, 21 Oct 2019 04:21:18 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F10E3F718;
        Mon, 21 Oct 2019 04:21:16 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:21:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        lorenzo.pieralisi@arm.com, tglx@linutronix.de,
        David.Laight@ACULAB.COM, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hushiyuan@huawei.com, wuyun.wu@huawei.com, linfeilong@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5] arm64: psci: Reduce the waiting time for
 cpu_psci_cpu_kill()
Message-ID: <20191021112114.GC21581@bogus>
References: <710429cc-4d88-b7c3-b068-5459cf8133b5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710429cc-4d88-b7c3-b068-5459cf8133b5@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 06:52:16PM +0800, Yunfeng Ye wrote:
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
> output to the the successful message.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
