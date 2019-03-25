Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE78C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26962075D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfCYUEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:04:11 -0400
Received: from foss.arm.com ([217.140.101.70]:54550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbfCYUEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:04:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB4551596;
        Mon, 25 Mar 2019 13:04:09 -0700 (PDT)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CB833F59C;
        Mon, 25 Mar 2019 13:04:07 -0700 (PDT)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v7 5/10] KVM: arm/arm64: preserve host MDCR_EL2 value
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
References: <1552984243-7689-1-git-send-email-amit.kachhap@arm.com>
 <1552984243-7689-6-git-send-email-amit.kachhap@arm.com>
Message-ID: <19c2bdb3-6917-286e-3f2a-35fd71f69f51@arm.com>
Date:   Mon, 25 Mar 2019 20:04:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552984243-7689-6-git-send-email-amit.kachhap@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 08:30, Amit Daniel Kachhap wrote:
> Save host MDCR_EL2 value during kvm HYP initialisation and restore
> after every switch from host to guest. There should not be any
> change in functionality due to this.
> 
> The value of mdcr_el2 is now stored in struct kvm_cpu_context as
> both host and guest can now use this field in a common way.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu

[...]

>  /**
> - * kvm_arm_init_debug - grab what we need for debug
> - *
> - * Currently the sole task of this function is to retrieve the initial
> - * value of mdcr_el2 so we can preserve MDCR_EL2.HPMN which has
> - * presumably been set-up by some knowledgeable bootcode.
> - *
> - * It is called once per-cpu during CPU hyp initialisation.
> - */
> -
> -void kvm_arm_init_debug(void)
> -{
> -	__this_cpu_write(mdcr_el2, kvm_call_hyp_ret(__kvm_get_mdcr_el2));
> -}

The __kvm_get_mdcr_el2 function is no longer used anywhere, so can also
be removed.

Thanks,
Kristina
