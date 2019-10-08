Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8873BC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B32520815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570530318;
	bh=xvQs2o0EkBO2YHBiV+0D/Vc9/Ghl0Vhxiv3685TLTIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q4VomKHUH8dulAHf3pTde1pR6YZ9x/4WXV+i7YMjZbIVuUdSGLMlNTHnvL+hKSZCu
	 kxIomuWrQZsNDy/A0/hF1ge5BgV7hqIXqQwBcKfvDvrgDru3Qppand5MuBHEsA7IVE
	 aRI4C0FuWjoCdJYvUUs/FqbJYdvJkY6y8A9f0C5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfJHKZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730416AbfJHKZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:25:17 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D277D206BB;
        Tue,  8 Oct 2019 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570530316;
        bh=xvQs2o0EkBO2YHBiV+0D/Vc9/Ghl0Vhxiv3685TLTIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=egWENj8PwMc2WcACRDBMWTlZGkW2pxt0YBJ7nm9KJu66YC/B3eUUpWGJru2vDHShm
         y8GbOMhvNSP5KfEG7Mn2kqQJwJp9SJwvvvQdIjqT0GBG/zr9n9qbrMqb5DU+wnlPMN
         uVv8njYO0qCDjrf5+MVm+HJGhXvh6DjojbuhonbA=
Date:   Tue, 8 Oct 2019 11:25:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, info@metux.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: armv8_deprecated: Checking return value for
 memory allocation
Message-ID: <20191008102511.pmkqcpf7spkogarp@willie-the-truck>
References: <bd558d56-18a9-3607-3db0-ad203ab12aa8@huawei.com>
 <20191007153710.7xpx27kgeewz75kt@willie-the-truck>
 <e58c36f6-23e3-12b2-bd9c-1ef731b5f8fd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e58c36f6-23e3-12b2-bd9c-1ef731b5f8fd@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 10:33:17AM +0800, Yunfeng Ye wrote:
> On 2019/10/7 23:37, Will Deacon wrote:
> > On Mon, Oct 07, 2019 at 06:06:35PM +0800, Yunfeng Ye wrote:
> >> @@ -617,25 +624,47 @@ static int t16_setend_handler(struct pt_regs *regs, u32 instr)
> >>   */
> >>  static int __init armv8_deprecated_init(void)
> >>  {
> >> -	if (IS_ENABLED(CONFIG_SWP_EMULATION))
> >> -		register_insn_emulation(&swp_ops);
> >> +	int ret = 0;
> >> +	int err = 0;
> >> +
> >> +	if (IS_ENABLED(CONFIG_SWP_EMULATION)) {
> >> +		ret = register_insn_emulation(&swp_ops);
> >> +		if (ret) {
> >> +			pr_err("register insn emulation swp: fail\n");
> >> +			err = ret;
> >> +		}
> >> +	}
> > 
> > Is there much point in continuing here? May as well just return ret, I
> > think. I also don't think you need to print anything, since kmalloc
> > should already have shouted.
> > 
> The registration of each instruction simulation is independent. I think
> that one failure does not affect the registration of other instructions.

Dunno, I think that if kmalloc() starts failing then it's time to give up!

> In addition, if return directly, is it need to unregister? Of course,
> the first instruction registration can be directly returned, If the
> following instruction registration fails, is it need unregister operation?
> currently the unregistration of instruction simulation is not be implemented
> yet.

That's an interesting one -- currently there isn't a way to unregister
an emulation hook afaict. We could add unregister_insn_emulation() to
remove the emulation hook from the insn_emulation list and free it, but
I'm actually now starting to prefer your initial patch after all. The only
way these failures will happen are either because the system is doomed
or kmalloc fault injection is being used; so keeping things simple rather
than add rarely executed complexity is probably best.

> The purpose of printing information is to replace the direct return, which
> can distinguish which instruction failed to register. There is no need to print
> information if it returns directly.

What do you expect people to do with that information?

Are you ok with me applying your original patch?

Will
