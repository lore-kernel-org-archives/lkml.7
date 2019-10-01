Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49123C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124C921924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569921277;
	bh=EcCIg0TA8jmx9Tyu5P/NC+AlX2BQZ7qy/EyyWG6Qyvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lpyUD52vP5KUDA+EzGSSMleErmcpx38r0jHI5cD4GtqOZZZorogA/yJCeX/Ny02k/
	 Vwg8ZIMnmLNV4qJoZIyBrfrje+wuzuFSNe1SQhWBvKebggZfU264kdv0SI9KZC4yRA
	 +pSfVjMtZG5liZuXJyuYMHHuxQ+gVSFAgmQljeZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbfJAJOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbfJAJOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:14:36 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81F3E21920;
        Tue,  1 Oct 2019 09:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569921275;
        bh=EcCIg0TA8jmx9Tyu5P/NC+AlX2BQZ7qy/EyyWG6Qyvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AMhJT4FOcSMBrmjl0QNqetUmRyZdU59IjiFAkHY6/0iJeJUxK1F2pG0HWXqCTImnt
         5D9FVKwa3YtkNvheQ5xAtZ18ujT+VcaNvlL1nAy44hRxrIXf5DsSJxWJfVCWzKfPhv
         DvqGowkZVcgyUkCAUVbXIxCF2GIdUtohNu/heFPI=
Date:   Tue, 1 Oct 2019 10:14:30 +0100
From:   Will Deacon <will@kernel.org>
To:     wangxu <wangxu72@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, rfontana@redhat.com, allison@lohutok.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sample/hw_breakpoint: avoid sample hw_breakpoint
 recursion for arm/arm64
Message-ID: <20191001091430.xaibgeen7zwhr6gh@willie-the-truck>
References: <1569226175-101782-1-git-send-email-wangxu72@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569226175-101782-1-git-send-email-wangxu72@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 04:09:35PM +0800, wangxu wrote:
> From: Wang Xu <wangxu72@huawei.com>
> 
> For x86/ppc, hw_breakpoint is triggered after the instruction is
> executed.
> 
> For arm/arm64, which is triggered before the instruction executed.
> Arm/arm64 skips the instruction by using single step. But it only
> supports default overflow_handler.
> 
> This patch provides a chance to avoid sample hw_breakpoint recursion
> for arm/arm64 by adding 'struct perf_event_attr.bp_step'.

Issues like this come up every so often [1], [2], [3] but I'm still of the
opinion that we should rip out the perf interface to hw_breakpoint on arm64
and implement something better directly for ptrace, which is what GDB cares
about. The current "let's convert to perf and back again" is a wreck, mainly
because we've not been able to abstract the debug trap behaviour across
different architectures. GDB just wants to poke registers, and this all
gets in the way of that.

Will

[1] https://lkml.org/lkml/2018/11/15/205
[2] https://lore.kernel.org/lkml/20160323181348.GA2149@arm.com/
[3] https://lkml.org/lkml/2016/3/21/504
