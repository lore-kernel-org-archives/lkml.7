Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AE0C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53102189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfGCRqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:46:13 -0400
Received: from foss.arm.com ([217.140.110.172]:54158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfGCRqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:46:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F961344;
        Wed,  3 Jul 2019 10:46:12 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 723E93F718;
        Wed,  3 Jul 2019 10:46:10 -0700 (PDT)
Date:   Wed, 3 Jul 2019 18:46:08 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Cc:     'Viresh Kumar' <viresh.kumar@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Okamoto, Takayuki" <tokamoto@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "Mizuma, Masayoshi" <masayoshi.mizuma@fujitsu.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Indoh, Takao" <indou.takao@fujitsu.com>
Subject: Re: [PATCH V3] KVM: arm64: Implement vq_present() as a macro
Message-ID: <20190703174605.GX2790@e103592.cambridge.arm.com>
References: <be823e68faffc82a6f621c16ce1bd45990d92791.1560160681.git.viresh.kumar@linaro.org>
 <8898674D84E3B24BA3A2D289B872026A78BA95D6@G01JPEXMBKW03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A78BA95D6@G01JPEXMBKW03>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 12:04:11PM +0000, Zhang, Lei wrote:
> Hi guys,
> 
> I can't start up KVM guest os with SVE feature with your patch.
> The error message is 
> qemu-system-aarch64: kvm_init_vcpu failed: Invalid argument.
> 
> My test enviroment.
> kernel  linux-5.2-rc6
> qemu  [Qemu-devel] [PATCH v2 00/14] target/arm/kvm: enable SVE in guests https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04945.html
> KVM start up option
> -machine virt,gic-version=host,accel=kvm \
> -cpu host \
> -machine type=virt \
> -nographic \
> -smp 16 \ -m 4096 \
> -drive if=none,file=/root/image.qcow2,id=hd0,format=qcow2 \
> -device virtio-blk-device,drive=hd0 \
> -netdev user,id=mynet0,restrict=off,hostfwd=tcp::38001-:22 \
> -device virtio-net-device,netdev=mynet0 \
> -bios /root/QEMU_EFI.fd
> 
> sve_vq_available function's return value' type is bool.
> But vq_present is macro, so the value is not only TRUE, FALSE but also some numbers.
> So It failed at 
> if (vq_present(vqs, vq) != sve_vq_available(vq)).
> I think it is nessary to make vq_present macro's value only TRUE and FALSE.
> 
> arch/arm64/kvm/guest.c
> static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> 	for (vq = SVE_VQ_MIN; vq <= max_vq; ++vq)
> 		if (vq_present(vqs, vq) != sve_vq_available(vq))　// It failed at here.
> 			return -EINVAL;
> 
> My patch as follows.
> I have started up KVM guest os successfully with SVE feature with this patch.
> 
> Could you review and merge my patch?

[...]

Thanks for reporting this!  It looks like we didn't realise we dropped
the implicit cast to bool when the result was returned from the original
version of vq_present().

Your fix looks sensible to me.

For the future, see Documentation/process/submitting-patches.rst for
guidance on how to prepare a patch for submission.

However, due to the fact that we're already at -rc7 I've written a
commit message for the patch and reposted [1].  Since the fix is yours,
I'll keep your authorship and S-o-B.

Please retest when you can (though the diff should be the same).

Note, your mail seems to be corrupted, but since the diff is a one-line
fix, I'm pretty confident I decoded it correctly.  If anything looks
wrong, please let me know.

[...]

Cheers
---Dave


[1] [PATCH] KVM: arm64/sve: Fix vq_present() macro to yield a bool
http://lists.infradead.org/pipermail/linux-arm-kernel/2019-July/664745.html
