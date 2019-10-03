Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27545C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087F620830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfJCMXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:23:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfJCMXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:23:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A5DE10DCC8F;
        Thu,  3 Oct 2019 12:23:11 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E5C65C3F8;
        Thu,  3 Oct 2019 12:23:05 +0000 (UTC)
Date:   Thu, 3 Oct 2019 14:23:02 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH v5 02/10] KVM: arm/arm64: Factor out hypercall handling
 from PSCI code
Message-ID: <20191003122302.emrmpzntkgzqlc3m@kamzik.brq.redhat.com>
References: <20191002145037.51630-1-steven.price@arm.com>
 <20191002145037.51630-3-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002145037.51630-3-steven.price@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Thu, 03 Oct 2019 12:23:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 03:50:29PM +0100, Steven Price wrote:
> From: Christoffer Dall <christoffer.dall@arm.com>
> 
> We currently intertwine the KVM PSCI implementation with the general
> dispatch of hypercall handling, which makes perfect sense because PSCI
> is the only category of hypercalls we support.
> 
> However, as we are about to support additional hypercalls, factor out
> this functionality into a separate hypercall handler file.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> [steven.price@arm.com: rebased]
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm/kvm/Makefile        |  2 +-
>  arch/arm/kvm/handle_exit.c   |  2 +-
>  arch/arm64/kvm/Makefile      |  1 +
>  arch/arm64/kvm/handle_exit.c |  4 +-
>  include/Kbuild               |  2 +
>  include/kvm/arm_hypercalls.h | 43 ++++++++++++++++++
>  include/kvm/arm_psci.h       |  2 +-
>  virt/kvm/arm/hypercalls.c    | 59 +++++++++++++++++++++++++
>  virt/kvm/arm/psci.c          | 84 +-----------------------------------
>  9 files changed, 112 insertions(+), 87 deletions(-)
>  create mode 100644 include/kvm/arm_hypercalls.h
>  create mode 100644 virt/kvm/arm/hypercalls.c
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
