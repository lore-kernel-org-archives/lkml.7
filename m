Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E248C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D9920656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfFTS12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:27:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:56248 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfFTSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:05:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 11:05:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,397,1557212400"; 
   d="scan'208";a="243714870"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2019 11:05:01 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 9ABAE300FFA; Thu, 20 Jun 2019 11:05:01 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     ehankland@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kvm@vger.kernel.org
Subject: Re: [PATCH v1] KVM: x86: PMU Whitelist
References: <CAOyeoRWfPNmaWY6Lifdkdj3KPPM654vzDO+s3oduEMCJP+Asow@mail.gmail.com>
Date:   Thu, 20 Jun 2019 11:05:01 -0700
In-Reply-To: <CAOyeoRWfPNmaWY6Lifdkdj3KPPM654vzDO+s3oduEMCJP+Asow@mail.gmail.com>
        (Eric Hankland's message of "Wed, 22 May 2019 15:23:00 -0700")
Message-ID: <877e9g9lpu.fsf@firstfloor.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Hankland <ehankland@google.com> writes:
>
> +int kvm_vcpu_ioctl_set_pmu_whitelist(struct kvm_vcpu *vcpu,
> +                                    struct kvm_pmu_whitelist __user *whtlst)
> +{
> +       struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +       struct kvm_pmu_whitelist *old = pmu->whitelist;
> +       struct kvm_pmu_whitelist *new = NULL;
> +       struct kvm_pmu_whitelist tmp;
> +       int r;
> +       size_t size;
> +
> +       r = -EFAULT;
> +       if (copy_from_user(&tmp, whtlst, sizeof(struct kvm_pmu_whitelist)))
> +               goto err;
> +
> +       size = sizeof(tmp) + sizeof(tmp.events[0]) * tmp.num_events;
> +       new = kvzalloc(size, GFP_KERNEL_ACCOUNT);

Consider what happens when tmp.num_events is large enough to wrap size.
I suspect that's a kernel exploit as written.

Also don't you need to copy tmp to new?

-Andi

