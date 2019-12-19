Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7666FC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494D3222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576718848;
	bh=mU3/zIAMiL0h3UmehqG15pVxetRZwGFV2HtBa1ALE5A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=J4nqmHFeSwFup38aF1wjKDW2mOJvz/s5yG/fOgrdig98LQQZiD/OAXAd2klVdvrmZ
	 PBMf4cO++8P2tVfVCI5CpPbRDMyQCoLn9kyygabc1OsYAnty8tyuVehdKM/yE4ahoR
	 ViraGwCYvmUrE/f2eok3X+MnxnPUiWelpmOaMJGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLSB11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 20:27:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfLSB11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 20:27:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76DBE21D7D;
        Thu, 19 Dec 2019 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576718846;
        bh=mU3/zIAMiL0h3UmehqG15pVxetRZwGFV2HtBa1ALE5A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r52qEHvlLBcLatVgHCZKOOqK0AcxLuKTsaUxGjioSl7nscawpZj68udC2srCuJkX8
         Vh4IS48rQYNoDnFfyCpAgqwhDZ1RcaZ5F7DxXeN544/nTdVYHlPCsJjKFMC0mjrtLH
         t/hqR36HB+sxiDLyxhTR1me1skXAwX7oYfgLiGG0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 127C23522771; Wed, 18 Dec 2019 17:27:26 -0800 (PST)
Date:   Wed, 18 Dec 2019 17:27:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rcu tree with the tip tree
Message-ID: <20191219012726.GY2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191219115036.4699721c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219115036.4699721c@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 11:50:35AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rcu tree got a conflict in:
> 
>   kernel/cpu.c
> 
> between commit:
> 
>   45178ac0cea8 ("cpu/hotplug, stop_machine: Fix stop_machine vs hotplug order")
> 
> from the tip tree and commit:
> 
>   d62c673f4cfc ("cpu/hotplug, stop_machine: Fix stop_machine vs hotplug order")
> 
> from the rcu tree.
> 
> I fixed it up (I just used the tip tree version) and can carry the fix
> as necessary. This is now fixed as far as linux-next is concerned, but
> any non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

I will pull this one out of the set that I mark for -next.  That way
I can test and you can avoid at least this one conflict.  ;-)

							Thanx, Paul
