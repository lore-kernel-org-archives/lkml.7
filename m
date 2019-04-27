Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4D7C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231D521655
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556373255;
	bh=lJsqHSv7mbUunBcPqQKHgHokFLrEvLy8HZpkazORPD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bcrPEckWiYN1dJlMnvofk3Wguw9TkT/lIRoFUKHcxG0fQ1QgKFia7pbVMy7G3GCYu
	 khr6vl84cVQyoMsLPANmu0hBnahXKaLJtDAWjmbKn2Avkxz2O//Cjh0lliI7tWhdkH
	 5ygv9FGSsiJI6vdN/cYMME71LxNOsRa87WMipVzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfD0NyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfD0NyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 09:54:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BFBD2087F;
        Sat, 27 Apr 2019 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556373253;
        bh=lJsqHSv7mbUunBcPqQKHgHokFLrEvLy8HZpkazORPD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsUHAGeITpwJkaOVGH/zpyWuVYSAdx6u+1wgeTyR5iyZRVsJqOp1AHqyfiMrL9FG6
         PkesPUjQlBoShZ06zuefKy5fKixVGCm8OsWFxTMIDSM7BakIk3FcSW1ydXoPTxaO0P
         D+VNV/s1gbkc0FCucogEKRJ5dDvvLEi+CcX/XlTw=
Date:   Sat, 27 Apr 2019 15:54:10 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "andi.kleen@intel.com" <andi.kleen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "astrachan@google.com" <astrachan@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH 4.14 09/69] x86: vdso: Use $LD instead of $CC to link
Message-ID: <20190427135410.GA26744@kroah.com>
References: <20190415183726.036654568@linuxfoundation.org>
 <20190415183728.632579553@linuxfoundation.org>
 <c9fc2241bb6687e6bfab50e329d81601ff6bc6bf.camel@nokia.com>
 <20190426124804.GA23970@archlinux-i9>
 <0dbe840a89d279be2b66d6c612d25eba4cc4c2e2.camel@nokia.com>
 <20190426133422.GA8796@archlinux-i9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426133422.GA8796@archlinux-i9>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 06:34:22AM -0700, Nathan Chancellor wrote:
> On Fri, Apr 26, 2019 at 01:23:17PM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> > On Fri, 2019-04-26 at 05:48 -0700, Nathan Chancellor wrote:
> > > On Fri, Apr 26, 2019 at 11:41:30AM +0000, Rantala, Tommi T. (Nokia -
> > > FI/Espoo) wrote:
> > > > On Mon, 2019-04-15 at 20:58 +0200, Greg Kroah-Hartman wrote:
> > > > > commit 379d98ddf41344273d9718556f761420f4dc80b3 upstream.
> > > > > 
> > > > 
> > > > Hi,
> > > > 
> > > > With this patch in 4.14.112 build-id is now missing in vdso32.so:
> > > > 
> > > > $ file arch/x86/entry/vdso/vdso*so*
> > > > arch/x86/entry/vdso/vdso32.so:     ELF 32-bit LSB pie executable,
> > > > Intel
> > > > 80386, version 1 (SYSV), dynamically linked, stripped
> > > > arch/x86/entry/vdso/vdso32.so.dbg: ELF 32-bit LSB pie executable,
> > > > Intel
> > > > 80386, version 1 (SYSV), dynamically linked, with debug_info, not
> > > > stripped
> > > > arch/x86/entry/vdso/vdso64.so:     ELF 64-bit LSB pie executable,
> > > > x86-
> > > > 64, version 1 (SYSV), dynamically linked,
> > > > BuildID[sha1]=d80730a5b561a3161e488a369d1c76c250b584b4, stripped
> > > > arch/x86/entry/vdso/vdso64.so.dbg: ELF 64-bit LSB pie executable,
> > > > x86-
> > > > 64, version 1 (SYSV), dynamically linked,
> > > > BuildID[sha1]=d80730a5b561a3161e488a369d1c76c250b584b4, with
> > > > debug_info, not stripped
> > > > 
> > > > 
> > > > Based on quick check, "$(call ld-option, --build-id)" fails due to
> > > > some
> > > > 32/64 bit mismatch, so the --build-id linker flag is not used when
> > > > linking vdso32.so
> > > > 
> > > > Perhaps scripts/Kbuild.include is missing some change in 4.14.y to
> > > > make
> > > > this work properly.
> > > > 
> > > 
> > > Hi Tommi,
> > > 
> > > This appears to be fixed by commit 0294e6f4a000 ("kbuild: simplify
> > > ld-option implementation") upstream. Could you test the attached
> > > backport and make sure everything works on your end? Assuming that it
> > > does, I will test the other stable releases and see if this is needed
> > > and send those backports along.
> > 
> > Yes this patch fixes it. Many thanks!
> 
> Thanks for verifying!
> 
> Greg, attached are backports for that commit for 4.4, 4.9, and 4.14. It
> appeared in 4.16 so it is not needed with a newer version.

Now queued up, thanks!

greg k-h
