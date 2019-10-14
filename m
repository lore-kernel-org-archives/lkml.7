Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1C4C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41582084B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbfJNKIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:08:39 -0400
Received: from foss.arm.com ([217.140.110.172]:39444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730880AbfJNKIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:08:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4AF3337;
        Mon, 14 Oct 2019 03:08:38 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDAAC3F718;
        Mon, 14 Oct 2019 03:08:37 -0700 (PDT)
Date:   Mon, 14 Oct 2019 11:07:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        Stefan Agner <stefan.agner@toradex.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drivers: firmware: psci: use kernel restart handler
 functionality
Message-ID: <20191014100756.GA4028@bogus>
References: <20191012214735.1127009-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012214735.1127009-1-stefan@agner.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 11:47:35PM +0200, Stefan Agner wrote:
> From: Stefan Agner <stefan.agner@toradex.com>
> 
> Use the kernels restart handler to register the PSCI system reset
> capability. The restart handler use notifier chains along with
> priorities. This allows to use restart handlers with higher priority
> (in case available) while still supporting PSCI.
> 
> Since the ARM handler had priority over the kernels restart handler
> before this patch, use a slightly elevated priority of 160 to make
> sure PSCI is used before most of the other handlers are called.
> 

There's an attempt(rather pull request[1]) to consolidate these into new
system power/restart handler.

--
Regards,
Sudeep

[1] https://lore.kernel.org/linux-arm-kernel/20191002131228.4085560-1-thierry.reding@gmail.com
