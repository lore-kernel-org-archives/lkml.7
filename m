Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89172CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E5520848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfKDPpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:45:33 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47185 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727891AbfKDPpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:45:32 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA4FjPF3032066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Nov 2019 10:45:26 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 33FD0420311; Mon,  4 Nov 2019 10:45:23 -0500 (EST)
Date:   Mon, 4 Nov 2019 10:45:23 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Tom Cook <tom.k.cook@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Power management - HP 15-ds0502na
Message-ID: <20191104154523.GH28764@mit.edu>
References: <CAFSh4UxSx7SYT=Ja6TbwFwCJm_yn6VtMapXGv3B=+g2rQcALSA@mail.gmail.com>
 <20191104135111.GF28764@mit.edu>
 <CAFSh4UxquUDSbw+JA1t=VBpe1yn+ar3MjsFbJP9bRo5a3BWAnw@mail.gmail.com>
 <20191104150648.GG28764@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104150648.GG28764@mit.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:06:48AM -0500, Theodore Y. Ts'o wrote:
> Actually, it's probably because one of the device drives isn't
> properly putting that particular device into a low power state.  When
> I was trying to make s2idle work on the XPS 13, there was needed patch
> to make the SATA AHCI controller go into a lower power state.  This
> was a patch which the Dell folks had gotten into their special
> "Optimized for Dell laptops" Ubuntu kernel that was running into
> resistance upstream.  I *think* that patch finally made it upstream,
> but to be honest, I haven't been keeping track since I decided "life
> was too short to fight and make s2idle work".

Oh, and I forgot; the other thing I had to do to get s2idle's power
consumption down to suspend-2-ram was to unload the SD card reader;
apparently that device driver didn't know how to do the low power
saving thing under OS control.  So I ultimately was able to get the
power while suspended of s2idle down to that of s2ram.  What I wasn't
able to solve for my laptop was the reliability of resuming after the
suspend....

						- Ted
