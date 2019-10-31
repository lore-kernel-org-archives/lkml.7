Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A87CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175412087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572528120;
	bh=d5GVMjWHdmBFZQb6CC+/OkfJlqVkbsbDGygJpji33EM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eyEna0Jbjk5r854VaK8w8rMHGkGC2RWArT8CL6GcWLR4cI7S0vocHQf/4iEXinuqc
	 lH1uVbuJjjW8vFCjCX70MEYkTR37BhNuaH6kbViMgjbSv+KSKbtUsYP5ICe9QoStRf
	 CTBtM6+N0CcZ9qgREL5nDjRhh9mv/yHQK4Md5x2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfJaNV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfJaNV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:21:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E2120873;
        Thu, 31 Oct 2019 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572528118;
        bh=d5GVMjWHdmBFZQb6CC+/OkfJlqVkbsbDGygJpji33EM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1F4El6uIQCICKKWR3TZaZm298EiHiseD2Ube8CF+PE4N7oXJUc2gfXYTSJgb7xqG+
         XtVptZjlKFgl0xmyYacSujyU4ytTEWZjUBY+RbWqDAFVfned0Flk2JBXnutvZ4Nkb5
         xsB2bPLmCy/Now10Gw/PMcpfp60/QxcPdSxX6I9g=
Date:   Thu, 31 Oct 2019 13:21:52 +0000
From:   Will Deacon <will@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Doug Berger <opendmb@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        John Garry <john.garry@huawei.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Qian Cai <cai@lca.pw>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: apply ARM64_ERRATUM_845719 workaround for
 Brahma-B53 core
Message-ID: <20191031132151.GC27196@willie-the-truck>
References: <20191029191623.17839-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029191623.17839-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 12:16:19PM -0700, Florian Fainelli wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> The Broadcom Brahma-B53 core is susceptible to the issue described by
> ARM64_ERRATUM_845719 so this commit enables the workaround to be applied
> when executing on that core.
> 
> Since there are now multiple entries to match, we must convert the
> existing ARM64_ERRATUM_845719 into an erratum list.

Looks fine to me, but I have to ask: are you sure you don't want to select
any of ARM64_ERRATUM_{826319, 827319, 824069, 819472, 843419} ?

Also, please can you update Documentation/arm64/silicon-errata.rst ?

Will
