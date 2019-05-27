Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB2CC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93932208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfE0RF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 13:05:56 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58542 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726207AbfE0RF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 13:05:56 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4RH5eS1004723
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 May 2019 13:05:40 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0DC62420481; Mon, 27 May 2019 13:05:40 -0400 (EDT)
Date:   Mon, 27 May 2019 13:05:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Naveen Nathan <naveen@lastninja.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Easton <kevin@guarana.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: urandom reads block when CRNG is not initialized.
Message-ID: <20190527170539.GC8585@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Naveen Nathan <naveen@lastninja.net>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Easton <kevin@guarana.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190527122627.GA15618@u>
 <20190527140643.GB8585@mit.edu>
 <CAHmME9qvdKy6zCHQEUp1zp-dL0Sco1Ujtn7jXK=EFde_yDx8wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qvdKy6zCHQEUp1zp-dL0Sco1Ujtn7jXK=EFde_yDx8wA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 05:43:03PM +0200, Jason A. Donenfeld wrote:
> 
> Really, it's a chicken & egg thing. If people who make userspaces
> never have an option to design around the correct behavior, they'll
> continue to rely on the broken behavior. But if we give them a way to
> compile their kernels with the correct behavior, eventually some
> userspaces will run fine with it. "But they should just use
> getrandom()!" you shout. Yes, and maybe the code most userspace
> builders provide does do this. But people like to plug-in plenty of
> third party things into their userspaces, and I think there's some
> value in a userspace being able to say, "we've dealt with the
> /dev/urandom situation, and we now do the right thing, so we can
> enable this option, and now the code you run on our userspace will
> give good randomness."

The challenge is that in some cases, there *is* no good solution.  If
you don't have decent hardware support, there's not a whole lot you
can do as a systems integrator or the distro.  Enabling this feature
will be a support nightmare, so I predict that darned few
distributions will be to enable it.

At the very least, we need to document the reality as it exists today,
which is that systems with systemd and Openwrt (and its derivitives),
*will* hang if this option is selected.  And we need to make sure that
zero-day testing with randconfig doesn't try to select this option
(hiding it behind CONFIG_EXPERIMENTAL should do the trick), since we
won't want to get spammed by the zero-day test bot.  That's how much
this option is guaranteed to break systems --- our continuous
integration testing systems are guaranteed to trip against it.

	    	    	    		   - Ted
