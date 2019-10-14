Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B60ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D55621848
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571073623;
	bh=hkLS6pIEJOymLaQm6M1YTkn73x3Gm/aR5hXN6MZ0gqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l/Q94kBWLPL3QVa6HYOiZg19jOMObu5ESUGsPTGlIUHY+VxbiO6jY3cpHxzISwMnD
	 OoFkuSlEtuT/L9BmRlo3lnLr8KOU8Kqd0/M4rJrA+XMM/DZy5Zb0xU+liNvg6rpsBz
	 W/H1oGzGwEk+vo/PpigIdspmFa95AeJoUK3LQvBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbfJNRUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731347AbfJNRUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:20:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4047D20663;
        Mon, 14 Oct 2019 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571073621;
        bh=hkLS6pIEJOymLaQm6M1YTkn73x3Gm/aR5hXN6MZ0gqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LHS9o0O/7DnMmqHq5NBiQO2MAayUUPsi8/PQdQkhhrCS5OCtFlxwOmxHKp0bbEdpF
         +dI49R9vFcQPGqj4HJfSjOBAimHrsYg9JN9sVcSfCtCcNz+fdBXsXjDNDnGuTMpvBf
         vf6QjZMBJxE1/Ss2wlEKcfCMqJG0OM69gmDUuqVo=
Date:   Mon, 14 Oct 2019 18:20:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Julien Grall <julien.grall@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, Dave.Martin@arm.com
Subject: Re: [PATCH] arm64: cpufeature: Don't expose ZFR0 to userspace when
 SVE is not enabled
Message-ID: <20191014172016.w6ehilts4nl5tfva@willie-the-truck>
References: <20191014102113.16546-1-julien.grall@arm.com>
 <20191014164313.hu2dnf5rokntzhhp@willie-the-truck>
 <223c22d0-cfe3-4aed-6a8f-b80e44cb6548@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <223c22d0-cfe3-4aed-6a8f-b80e44cb6548@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 05:57:46PM +0100, Suzuki K Poulose wrote:
> On 14/10/2019 17:43, Will Deacon wrote:
> > On Mon, Oct 14, 2019 at 11:21:13AM +0100, Julien Grall wrote:
> > > The kernel may not support SVE if CONFIG_ARM64_SVE is not set and
> > > will hide the feature from the from userspace.
> > 
> > I don't understand this sentence.
> > 
> > > Unfortunately, the fields of ID_AA64ZFR0_EL1 are still exposed and could
> > > lead to undefined behavior in userspace.
> > 
> > Undefined in what way? Generally, we can't stop exposing things that
> > we've exposed previously in case somebody has started relying on them, so
> > this needs better justification.
> 
> We still expose them with this patch, but zero them out, if the SVE is not
> supported. When SVE is enabled, we expose them as usual.

Sure, but if userspace was relying on the non-zero values, it's now broken.

What's missing from the patch description is the fact that this register is
RAZ is SVE is not supported. Given that we get both the SVE HWCAP and
PFR0.SVE field correct when the CONFIG option is disabled, then it's only
very dodgy userspace which would parse the information in ZFR0 for this
configuration and I think we can make this change as a bug fix. I'll try to
write something sensible.

Will
