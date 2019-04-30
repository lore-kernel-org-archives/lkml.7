Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0049C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6324121670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="hDMWL/Jz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Po303dIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfD3FQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 01:16:31 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42487 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbfD3FQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 01:16:30 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7862B27CE8;
        Tue, 30 Apr 2019 01:16:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 30 Apr 2019 01:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=DUYD7xRlE61Rnxv7xoYW7Ssfsx5
        LnGk2D3PkL/WJ8Ik=; b=hDMWL/JzlkFybHuKb0MoXkqVAJkasMpnqEirHt4VObt
        kwYj3tWdgRv9P+roD9UIUfrr3j0xSICayLEk8e73AuaiVaWFVA2E5kCqnwE3INpE
        zYxQpz3t58Y/Kkir7XVcQ4+XzhSiaZKiUtL0ZeBmwIQV0Hvkh0AgLm/1rPSf9YEq
        K3bkgHyJVWT6+FXAlluCe4cVJfVAd0b98xsHk+FxO/enJNHO4ud88akbM0KMliJ2
        kE7/KpQIjUz5KfqpRk5az+OJJcW1q3bsv2FZi3GIzYZmZNLF2TsSH+a0BmNSC9cd
        IVQOO/XVnwAXiPanEKkWWPdwmkwot5xejveBH0CYp6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DUYD7x
        RlE61Rnxv7xoYW7Ssfsx5LnGk2D3PkL/WJ8Ik=; b=Po303dIKhLf++y10KwKR2b
        19s96KvZ5tCil9B5fdw/n/y8LO2K1zQyJ4RMkz7wLAOSiEW+ZmNzW+IJZSd7Gaej
        oy/XBRfzJtTer3IPaREI7Sinu7Fwx3qyX0gEIQI/SFYWc/cdQJvP+gQJyfK8cebx
        jVA5dne+aZ9v+45RYs4E5LyVkJtAMW4dB4dt/8wqGbS5TT0PPe8RXhK3Ywv3zFsK
        MgcdGZJjeUUSYqSsQ7sWui3xvYhKWw4HnLP2L+F5/U+Prj2kZd2NRFu3QB5G05yQ
        zFIXZliIR7jwRpRyf2/Ys0RFA9QWrJXgpybcPYpPxqkhGyHVCZgHbJOjUAZm7fNA
        ==
X-ME-Sender: <xms:LdrHXGAaqcq5iB83EdllyF12agGKTFb5imHvkLiGJOJkbijMd51Ysw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieefgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvuddrgeegrddvfedtrddukeeknecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:LdrHXOFWdrPJ4yvRdKW6uHuf5rAAZJ7_-rIVUn9GvttwI0xs7AV2BA>
    <xmx:LdrHXACSjH8_Z847B-_1zJ6MDT3_yFrx2aqqEtkaxamuI1j33qJ60A>
    <xmx:LdrHXGX-unkxBBH-f0pmQiK9_qqq75mRId0BY8FmU919GCWbn_wQ4A>
    <xmx:LdrHXBerXOvl2QnclXWXjhjHTiOOIxLtKQQGYiHUsUIcVnb5BnSFgA>
Received: from localhost (ppp121-44-230-188.bras2.syd2.internode.on.net [121.44.230.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id 539E7103C9;
        Tue, 30 Apr 2019 01:16:28 -0400 (EDT)
Date:   Tue, 30 Apr 2019 15:15:45 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] sched/cpufreq: Fix kobject memleak
Message-ID: <20190430051545.GB30100@eros.localdomain>
References: <20190430001717.26533-1-tobin@kernel.org>
 <20190430042443.GB73609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430042443.GB73609@gmail.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 06:24:43AM +0200, Ingo Molnar wrote:
> 
> * Tobin C. Harding <tobin@kernel.org> wrote:
> 
> > Currently error return from kobject_init_and_add() is not followed by a
> > call to kobject_put().  This means there is a memory leak.
> > 
> > Add call to kobject_put() in error path of kobject_init_and_add().
> > 
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> > 
> > Resend with SOB tag.
> 
> Please ignore my previous mail :-)

Cheers Ingo, caught myself not checkpatching :(

thanks,
Tobin.

