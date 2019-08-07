Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9258FC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68259218FE
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565190693;
	bh=9GdGEX61x8DnV11aor+KNhdLtv4lzeLvQagTYOqrO6c=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=RIabOmE2bTjYh++OrBF1l+DYxDEOubG15tY20rqv6y11vdXolfBof4AXEcHjoTH8o
	 bo0jVkfCINsIuJkf6BrWIrzo2sC+QCzIXiz8wAqLkY83KFRmyCDMUmW+hmgsRjFFhG
	 Ct3ZRnFzgctYhiYQjL0Vs2hR6A9qB786z2bIWbpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388114AbfHGPLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:11:32 -0400
Received: from foss.arm.com ([217.140.110.172]:49984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfHGPLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:11:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF218344;
        Wed,  7 Aug 2019 08:11:29 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFA9E3F706;
        Wed,  7 Aug 2019 08:11:28 -0700 (PDT)
Subject: Re: [PATCH] arm64: KVM: hyp: debug-sr: Mark expected switch
 fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
References: <20190807141857.GA4198@embeddedor>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <b0b04024-9568-7b51-1bef-7030dd66f727@kernel.org>
Date:   Wed, 7 Aug 2019 16:11:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807141857.GA4198@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2019 15:18, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings (Building: allmodconfig arm64):
> 
> arch/arm64/kvm/hyp/debug-sr.c:20:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arm64/kvm/hyp/debug-sr.c:21:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arm64/kvm/hyp/debug-sr.c:22:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arm64/kvm/hyp/debug-sr.c:23:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arm64/kvm/hyp/debug-sr.c:24:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arm64/kvm/hyp/debug-sr.c:25:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arm64/kvm/hyp/debug-sr.c:26:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arm64/kvm/hyp/debug-sr.c:27:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arm64/kvm/hyp/debug-sr.c:28:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arm64/kvm/hyp/debug-sr.c:29:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arm64/kvm/hyp/debug-sr.c:30:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arm64/kvm/hyp/debug-sr.c:31:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arm64/kvm/hyp/debug-sr.c:32:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arm64/kvm/hyp/debug-sr.c:33:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arm64/kvm/hyp/debug-sr.c:34:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Already fixed (together with all the other KVM/arm warnings/bugs), and
pull request sent to Paolo.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
