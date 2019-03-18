Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE6EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B427D20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfCRNav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:30:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34560 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfCRNau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:30:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 472CEEBD;
        Mon, 18 Mar 2019 06:30:50 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBA293F71A;
        Mon, 18 Mar 2019 06:30:46 -0700 (PDT)
Date:   Mon, 18 Mar 2019 13:30:40 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     <christoffer.dall@arm.com>, <eric.auger@redhat.com>,
        <andre.przywara@arm.com>, <james.morse@arm.com>,
        <julien.thierry@arm.com>, <suzuki.poulose@arm.com>,
        <kvmarm@lists.cs.columbia.edu>, <mst@redhat.com>,
        <pbonzini@redhat.com>, <rkrcmar@redhat.com>, <kvm@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Raslan, KarimAllah" <karahmed@amazon.de>
Subject: Re: [RFC PATCH] KVM: arm/arm64: Enable direct irqfd MSI injection
Message-ID: <20190318133040.1cfad9a4@why.wild-wind.fr.eu.org>
In-Reply-To: <86o969z42z.wl-marc.zyngier@arm.com>
References: <1552833373-19828-1-git-send-email-yuzenghui@huawei.com>
        <86o969z42z.wl-marc.zyngier@arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2019 19:35:48 +0000
Marc Zyngier <marc.zyngier@arm.com> wrote:

[...]

> A first approach would be to keep a small cache of the last few
> successful translations for this ITS, cache that could be looked-up by
> holding a spinlock instead. A hit in this cache could directly be
> injected. Any command that invalidates or changes anything (DISCARD,
> INV, INVALL, MAPC with V=0, MAPD with V=0, MOVALL, MOVI) should nuke
> the cache altogether.

And to explain what I meant with this, I've pushed a branch[1] with a
basic prototype. It is good enough to get a VM to boot, but I wouldn't
trust it for anything serious just yet.

If anyone feels like giving it a go and check whether it has any
benefit performance wise, please do so.

Thanks,

	M.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/its-translation-cache
-- 
Without deviation from the norm, progress is not possible.
