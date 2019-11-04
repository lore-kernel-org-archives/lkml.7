Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F9ACA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA8E21744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfKDNvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:51:17 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46229 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727663AbfKDNvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:51:17 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA4DpDoC017133
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Nov 2019 08:51:14 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6E649420311; Mon,  4 Nov 2019 08:51:11 -0500 (EST)
Date:   Mon, 4 Nov 2019 08:51:11 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Tom Cook <tom.k.cook@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Power management - HP 15-ds0502na
Message-ID: <20191104135111.GF28764@mit.edu>
References: <CAFSh4UxSx7SYT=Ja6TbwFwCJm_yn6VtMapXGv3B=+g2rQcALSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFSh4UxSx7SYT=Ja6TbwFwCJm_yn6VtMapXGv3B=+g2rQcALSA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 11:21:24AM +0000, Tom Cook wrote:
> * Power management doesn't work very well.  The most obvious symptom
> of this is that /sys/power/mem_sleep contains only "[s2idle]" and so
> there is no suspend-to-RAM available.  Setting
> "mem_sleep_default=deep" on the command line doesn't change this.

This is actually the laptop's ACPI and/or EC not supporting
suspend-to-ram at all.  Suspend to idle is the new hotness, because it
gives the OS much more control (but also gives the OS much more
opportunity to screw up).  The Dell XPS 13 (models 9370 and 9380)
supports both s2idle and s2ram, but s2idle doesn't work well at all on
Linux.  (Well, at least not the upstream kernels; the official Dell
Ubuntu kernel and userspace apparently has enough tweaks that it works
well.)

I tried for a bit to see if I could get s2idle working well on the
upstream Dell XPS 13, but bits of hardware would randomly fail to come
back from a s2idle resume --- or in some cases, the laptop wouldn't
come back at all, that I decided, "life's too short", and gave up on
it.  Hopefully Dell or other folks will get s2idle working well on the
XPS 13... at least before suspend2ram gets dropped entirely.  :-/


> * There are a few devices that appear to be on I2C buses and declared
> in the ACPI tables (eg the fingerprint sensor) which don't show up
> under Linux.  They did under Windows, until I blew the Windows
> installation away to install Linux, and I'm assuming that Windows
> found them through the ACPI DSDT.  Now thinking it may have been handy
> to keep Windows around for debugging, but that's regrets for you.

Even if they showed up, it's unclear the device driver would exist for
Linux.  Most fingerprint readers have proprietary interfaces and
aren't well supported by Linux in general.

> Is this the right place to raise this?  If there's some other place
> that Linux ACPI issues are dealt with, please point me there as I've
> not had any luck googling.

There is the linux-acpi@vger.kernel.org mailing list and the
linux-pm@vger.kernel.org (pm --> "power management") where you might
try asking about the s2idle.  A lot of the issues with s2idle appear
to be very device driver specific, and not about the power management
core, so it's unclear folks on those lists will be able to help.  But
it's worth a try...

					- Ted
