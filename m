Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3B1CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E90204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfKDPG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:06:56 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36996 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728346AbfKDPGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:06:55 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA4F6p8P014881
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Nov 2019 10:06:52 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EF8B0420311; Mon,  4 Nov 2019 10:06:48 -0500 (EST)
Date:   Mon, 4 Nov 2019 10:06:48 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Tom Cook <tom.k.cook@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Power management - HP 15-ds0502na
Message-ID: <20191104150648.GG28764@mit.edu>
References: <CAFSh4UxSx7SYT=Ja6TbwFwCJm_yn6VtMapXGv3B=+g2rQcALSA@mail.gmail.com>
 <20191104135111.GF28764@mit.edu>
 <CAFSh4UxquUDSbw+JA1t=VBpe1yn+ar3MjsFbJP9bRo5a3BWAnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFSh4UxquUDSbw+JA1t=VBpe1yn+ar3MjsFbJP9bRo5a3BWAnw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 02:32:30PM +0000, Tom Cook wrote:
> s2idle sort of works - the thing appears to go to sleep and wake up
> okay - but the power savings are not really enough to make it
> worthwhile.  Putting it into s2idle state and putting it in a bag
> results in a very hot laptop - and of course that makes battery life
> not great.  I'm guessing this is the Ryzen 7 CPU idle states not being
> very well supported?

Actually, it's probably because one of the device drives isn't
properly putting that particular device into a low power state.  When
I was trying to make s2idle work on the XPS 13, there was needed patch
to make the SATA AHCI controller go into a lower power state.  This
was a patch which the Dell folks had gotten into their special
"Optimized for Dell laptops" Ubuntu kernel that was running into
resistance upstream.  I *think* that patch finally made it upstream,
but to be honest, I haven't been keeping track since I decided "life
was too short to fight and make s2idle work".

I probably should see if newer kernels have fixed some of these
issues, since the XPS13 is currently my preferred laptop, and I worry
that future models will drop suspend-to-ram, since Windows 10 is using
s2idle, and so the incentive for laptop manufacturers to support
suspend-to-ram is almost non-existent, especially now that Windows XP
and Windows 7 have moved to the great deprecation bitbucket in the
sky....  :-(

      	     	   	       		    - Ted
