Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082FAC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C661D2173E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566648782;
	bh=pgQ5Ieucz1re8Y5x9mZNInXpje3w1mq20odaNn+SSIg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=poGiMpNwVJzuCRGae+fb/0/7xD9ur4eynYmrJGpv7SkviVmtztrIRf1qLEXNVS3ge
	 olton+XdObhYHtOcCiuSTFp9rwkdl77Lca1loYASbkHKT5PPQnaESP9H4+MgyPuDPT
	 CF2ZOZYNMBXkiVFjWuXutKqldAZpGYF1QSvC1DIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfHXMNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbfHXMNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:13:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F0742146E;
        Sat, 24 Aug 2019 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566648780;
        bh=pgQ5Ieucz1re8Y5x9mZNInXpje3w1mq20odaNn+SSIg=;
        h=Date:From:To:Cc:Subject:From;
        b=0sVRhMLveGErFokACfC8K6gIMaNqREenHEwTEMdROoQ9NAr6UvnKr0ys68pi9hVzh
         qG+nnyoD833+wo9ytWfMAkTh1+1dX4+K8eOA5+Z1+4DWvb4PZxlxpy42kX2xf/hzx0
         siwNtoKHGrBEC53KPvI7tHNjUm0OFqXihr0n9wug=
Date:   Sat, 24 Aug 2019 13:12:55 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, marc.zyngier@arm.com, pbonzini@redhat.com,
        rkrcmar@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Subject: [GIT PULL] arm64: Fixes for -rc6
Message-ID: <20190824121255.ojqt7tjlzfp5a3nw@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these two KVM/arm fixes for -rc6. Unusually, we're routing them
via the arm64 tree as per Paolo's request on the list:

  https://lore.kernel.org/kvm/21ae69a2-2546-29d0-bff6-2ea825e3d968@redhat.com/

We don't actually have any other arm64 fixes pending at the moment (touch
wood), so I've pulled from Marc, written a merge commit, tagged the
result and run it through my build/boot/bisect scripts.

Cheers,

Will

--->8

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 087eeea9adcbaef55ae8d68335dcd3820c5b344b:

  Merge tag 'kvmarm-fixes-for-5.3-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into kvm/fixes (2019-08-24 12:46:30 +0100)

----------------------------------------------------------------
arm64 fixes for -rc6

- Two KVM fixes for MMIO emulation and UBSAN

----------------------------------------------------------------
Andre Przywara (1):
      KVM: arm/arm64: VGIC: Properly initialise private IRQ affinity

Andrew Jones (1):
      KVM: arm/arm64: Only skip MMIO insn once

Will Deacon (1):
      Merge tag 'kvmarm-fixes-for-5.3-3' of git://git.kernel.org/.../kvmarm/kvmarm into kvm/fixes

 virt/kvm/arm/mmio.c           |  7 +++++++
 virt/kvm/arm/vgic/vgic-init.c | 30 ++++++++++++++++++++----------
 2 files changed, 27 insertions(+), 10 deletions(-)
