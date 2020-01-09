Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6174AC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303DE20656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgAILFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:05:19 -0500
Received: from foss.arm.com ([217.140.110.172]:57118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbgAILFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:05:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8891331B;
        Thu,  9 Jan 2020 03:05:17 -0800 (PST)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CCEE3F703;
        Thu,  9 Jan 2020 03:05:16 -0800 (PST)
Date:   Thu, 9 Jan 2020 11:05:14 +0000
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
Message-ID: <20200109110514.GC10914@e105550-lin.cambridge.arm.com>
References: <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
 <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
 <7b375d79-2d3c-422b-27a6-68972fbcbeaf@arm.com>
 <66943c82-2cfd-351b-7f36-5aefdb196a03@arm.com>
 <c0e82c31-8ed6-4739-6b01-2594c58df95a@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340B3203@dggemm526-mbx.china.huawei.com>
 <51a7d543-e35f-6492-fa51-02828832c154@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51a7d543-e35f-6492-fa51-02828832c154@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 03:31:24PM +0100, Dietmar Eggemann wrote:
> Your issue is related to the 'numa mask check for scheduler MC
> selection' functionality.  It was introduced by commit 37c3ec2d810f and
> re-introduced by commit e67ecf647020 later. I don't know why we need
> this functionality?

That functionality is to ensure that we don't break the sched_domain
hierarchy for numa-in-cluster systems. We have to be sure that the MC
domain is always smaller or equal to the NUMA node span.

Morten
