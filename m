Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A26C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE85E223D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574239673;
	bh=HT77a05SGzBXzjNW3SSpNiDG5j5REw2H7dE6GC1vlqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EWpObNg7GdE6ofxWJIVfSgR47pD/uisxIiq0cAkPWowxwr1gXao+HLu4RHMGLDWxx
	 uqkCF49yJcLk2DmELTzJt3HKEvYbwODul3JGaD67ZDPW1KexCpFk8ljvh6e4XBRvft
	 YXln6ks2tI9fAC+9QnfvuWy83iwmM6N8FijmB3lE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfKTIrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:47:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfKTIrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:47:51 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5348B2235D;
        Wed, 20 Nov 2019 08:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574239670;
        bh=HT77a05SGzBXzjNW3SSpNiDG5j5REw2H7dE6GC1vlqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ttwn80sr1LeO/JKisG3eqvjFBlcAPyy3jeFEd5ZKd5rahRFdeqK8H0MWc75ptXkd4
         eGoAmSpbSK8i3/9CA52Wj/QgozmiPb3I0s/D8vS3t8HWxsAVgIi2E+bduTOZNwqYep
         IRUywIci9tg+K9eZ82tVjNNcVNlXOwgDCMz10lFI=
Date:   Wed, 20 Nov 2019 08:47:44 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, mark.rutland@arm.com,
        tangnianyao@huawei.com, xiexiangyou@huawei.com,
        linux-kernel@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linuxarm <linuxarm@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: Re: [RFC PATCH v2] arm64: cpufeatures: add support for tlbi range
 instructions
Message-ID: <20191120084743.GA20119@willie-the-truck>
References: <5DC960EB.9050503@huawei.com>
 <20191111132716.GA9394@willie-the-truck>
 <5DC96660.8040505@huawei.com>
 <d4542758f83b3df3ab391341499fecfb@www.loen.fr>
 <c9dfb341-9d14-1a62-0c34-6ec8bd9b4c55@huawei.com>
 <e6d2ad1c5392c2c3503ed8bb7560e04f@www.loen.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6d2ad1c5392c2c3503ed8bb7560e04f@www.loen.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 10:03:34AM +0000, Marc Zyngier wrote:
> On 2019-11-19 01:13, Hanjun Guo wrote:
> > I'm thinking of how to add a firmware description for it, how about
> > this:
> > 
> > Adding a system level flag to indicate the supporting of TIBi by range,
> > which means adding a binding name for example "tlbi-by-range" at system
> > level in the dts file, or a tlbi by range flag in ACPI FADT table, then
> > we use the ID register per-cpu and the system level flag as
> > 
> > if (cpus_have_const_cap(ARM64_HAS_TLBI_BY_RANGE) &&
> > system_level_tlbi_by_range)
> > 	flush_tlb_by_range()
> > else
> > 	flush_tlb_range()
> > 
> > And this seems work for heterogeneous system (olny parts of the CPU
> > support
> > TLBi by range) as well, correct me if anything wrong.
> 
> It could work, but it needs to come with the strongest guarantees that
> all the DVM agents in the system understand this type of invalidation,
> specially as we move into the SVM territory. It may also need to cope
> with non-compliant agents being hot-plugged, or at least discovered late.
> 
> I also wonder if the ARMv8.4-TTL extension (which I have patches for in
> the nested virt series) requires the same kind of treatment (after all,
> it has an implicit range based on the base granule size and level).

It would be good to get confirmation from Arm about this, since the TTL
extension doesn't have the dangerous 'Note' that the range ops do and it
wouldn't be difficult to ignore those bits in hardware where the system
doesn't support the hint for all agents (in comparison to upgrading range
ops to ALL, which may be unpalatable).

Will
