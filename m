Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E40BC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8AF21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="fNC/GDfl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dxRN55Fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfD3G1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 02:27:50 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:45611 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbfD3G1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 02:27:49 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9B30214B4A;
        Tue, 30 Apr 2019 02:27:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 Apr 2019 02:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=nqXHKA2oP67rdKxFEU3hjeuptSc
        9ac+htnMbvzAybNA=; b=fNC/GDflRY2oHYhiIFEhSQewdOoq4IAmGg/M9hIMW3K
        gEJ4ITLhf3QkVhW1L1NLn58svhLYQmY/v4Y3eS8iNibY7d6LUe1GlfunT7uhCA25
        aH4X9h4mbJAcNDw4xnhiZhzM3hPG3eTDy3VmULIgYh+e/egc35JnsMyNn+MssCJz
        lZXtgJrih2y91ulyO5yrFRkjI5EoDYryw43wAtT96QPTTE2KpfYtJ4s6+Aq0jO/C
        LVYFzJoYnZPdw3bdxoC00L/ey0/nodY7541KEiHqCrKizhgCZhahDOawNdKUwNuu
        JizAdc9g8wU+bJ7L9pVfhOUG1JcqylJ5LvQsqG6v5rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=nqXHKA
        2oP67rdKxFEU3hjeuptSc9ac+htnMbvzAybNA=; b=dxRN55FmToPitLiF4SnpS2
        dF9DodvNC9TbtCX7I84eragBnbwNsj4Bp38wpjDTvR8MLQ/p0BUlqi8CePbaCeZ3
        LLRlpGej+KG1C71KuRI/xjcmWStUlEQa0pC4qJ414+Q1J8mb1CwdbpNeYLMGiLD3
        ed5Ycw7Q8GNcpzP41S9E7YDmZZeTVCzNmTNYbxvZDs1xy00tGVK3SWYTigPI0jaA
        hrR+t7QDmticJo40Gh5z++RAzVlcwbR33NRwxpRZP2xHpF5vWgLoKRygUo60yu46
        x8ul5LyNWmFLv++Ty9YnwjFd6LI6vrqPbJrCk3Id4aZ7IBdLXP7sPGvDxVeKSmUw
        ==
X-ME-Sender: <xms:4-rHXF4e4sfEPb0pSmxmNgFxECLyOtXpUIDXJv2WrHMyM8BkD8vQTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieefgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvuddr
    geegrddvfedtrddukeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesthhosghinh
    drtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:4-rHXNIU99E5OeejVO0TsNem4G7mny2uJvOwtj6IRmUIKBK7N9_fJg>
    <xmx:4-rHXB4lqU3uff_uF41PhhJvkhG2ympeuLt01hCgXG_gIhwqFpim2Q>
    <xmx:4-rHXEbhpI5yu-K5DoNuZ_-00FONs7K9ipTliZVXHSpk3V_BDqTMyw>
    <xmx:5OrHXNNAca7AdfXJlbzob6CuxmXmwMgsAbN6ZPfElG3e1ZDG4DMsPg>
Received: from localhost (ppp121-44-230-188.bras2.syd2.internode.on.net [121.44.230.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id E59F1E44A1;
        Tue, 30 Apr 2019 02:27:45 -0400 (EDT)
Date:   Tue, 30 Apr 2019 16:27:07 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, tglx@linutronix.de,
        vincent.guittot@linaro.org, peterz@infradead.org,
        rafael.j.wysocki@intel.com, tobin@kernel.org,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/urgent] sched/cpufreq: Fix kobject memleak
Message-ID: <20190430062707.GB32393@eros.localdomain>
References: <20190430001144.24890-1-tobin@kernel.org>
 <tip-8bf7ab9c79f3d1a5f02ebac369f656de9ec0aca8@git.kernel.org>
 <20190430055627.oukh3dq6tk74q3wm@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430055627.oukh3dq6tk74q3wm@vireshk-i7>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 11:26:27AM +0530, Viresh Kumar wrote:
> On 29-04-19, 22:52, tip-bot for Tobin C. Harding wrote:
> > Commit-ID:  8bf7ab9c79f3d1a5f02ebac369f656de9ec0aca8
> > Gitweb:     https://git.kernel.org/tip/8bf7ab9c79f3d1a5f02ebac369f656de9ec0aca8
> > Author:     Tobin C. Harding <tobin@kernel.org>
> > AuthorDate: Tue, 30 Apr 2019 10:11:44 +1000
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Tue, 30 Apr 2019 06:24:09 +0200
> > 
> > sched/cpufreq: Fix kobject memleak
> > 
> > Currently the error return path from kobject_init_and_add() is not
> > followed by a call to kobject_put() - which means we are leaking
> > the kobject.
> > 
> > Fix it by adding a call to kobject_put() in the error path of
> > kobject_init_and_add().
> > 
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > Add call to kobject_put() in error path of kobject_init_and_add().
> 
> This should have been present before the signed-off ?

Thanks.  Some face palm fails on this patch.  Its hard to get good help
:)

	Tobin
