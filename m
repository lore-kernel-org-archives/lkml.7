Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19116C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43B32467A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576443419;
	bh=P3lfOLQN58AvTesW0ND/Xvyc4RVCSmd/MxkVTZFTRZ4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=RnL2iIbPELYZlvVh+Zd6Uiw+aP4rcMmCzK9lT4FRwqAKRbDrjZVevqVQE+U+f4+l0
	 bT7hpiiEmlHxXVJk84QXF4hktOQOJApGHI+ksYVLnRnHrNTw/r3U4YVWmVI6SSvS9o
	 Ww1N5WhohfqAG6dCsrWkMkE+U+mAme7VruT23Yqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLOU46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 15:56:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfLOU45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 15:56:57 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAD1824673;
        Sun, 15 Dec 2019 20:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576443416;
        bh=P3lfOLQN58AvTesW0ND/Xvyc4RVCSmd/MxkVTZFTRZ4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=u8sU9E7JVDTFYAsBlwTHyn+MZ7IXDLFjixO5cwVR7Nlp3S6inP+ENIQOVhY4+iRcl
         ZASKiPQMYKiOOY+Je5PZsc/imCUlMmT0OB2Sa1JKngqNkeu1obkDohVsENz66fSlHg
         pfvIioaWESCu83R5Dy3b1wZ8+BBe7dR6eaFgWtWM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B2168352274B; Sun, 15 Dec 2019 12:56:56 -0800 (PST)
Date:   Sun, 15 Dec 2019 12:56:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Dexuan-Linux Cui <dexuan.linux@gmail.com>, Qian Cai <cai@lca.pw>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Tejun Heo <tj@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lili Deng <Lili.Deng@microsoft.com>,
        Baihua Lu <Baihua.Lu@microsoft.com>
Subject: Re: "rcu: React to callback overload by aggressively seeking
 quiescent states" hangs on boot
Message-ID: <20191215205656.GO2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191213224646.GH2889@paulmck-ThinkPad-P72>
 <CAA6354A-C747-4BE0-8EDC-C06E3C1D7D08@lca.pw>
 <20191214064048.GI2889@paulmck-ThinkPad-P72>
 <CAA42JLbBFkpYHXRVvyveYO76DnbkE3gyRW-=qmBGZcJTAiB6Uw@mail.gmail.com>
 <20191215202023.GM2889@paulmck-ThinkPad-P72>
 <HK0P153MB01485AF4FC857C8D26F4F471BF560@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0P153MB01485AF4FC857C8D26F4F471BF560@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 08:40:40PM +0000, Dexuan Cui wrote:
> > From: Paul E. McKenney <paulmck@kernel.org>
> > Sent: Sunday, December 15, 2019 12:20 PM
> > 
> > This is consistent with what I saw in Qian Cai's report, FYI.  So I
> > am very interested in learning whether the first patch in my reply [1]
> > helps you.
> > 							Thanx, Paul
> 
> Hi Paul, yes, your first patch (the below) can fix the hang issue:
> 
> commit e8d6182b015bdd8221164477f4ab1c307bd2fbe9
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Sun Dec 15 10:59:06 2019 -0800
> 
>     squash! rcu: React to callback overload by aggressively seeking quiescent states

Thank you!  May I add your Tested-by?

							Thanx, Paul
