Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF63C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C712339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="bLaKXsQ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SjyPgHo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfH1PO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:14:57 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:53357 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbfH1PO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:14:57 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 745D15ED;
        Wed, 28 Aug 2019 11:14:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 28 Aug 2019 11:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=UzPHBfLAzVPcvFoQrMGEUfMi0HG
        clZnPUVz97BwDOS4=; b=bLaKXsQ3P0YckRoi/LQCpjASi0hmHRDVgTvSC1s7UVS
        CycfOyz3tdX5PDYhUBTqNES6pCGmhAVF/72BRZ0j2e5I4BjMCrGDKC7dpdn+2O62
        z2Eq/1I/phsRAQvHsgY40NyV3PPLSh0Pu8lsY4xHpB8rLN010CSbb+675BEl8rud
        vl30Q1x//Vyh/HL9J9oilKoIH3WC4FyQaCC5TymJieYSvqz4RTCq6heIsMjf6fZi
        K4MESHIWSTkVrU04Y0a2NeTndm9k377aejnrAlhtpg7iFH4U31/2ymCRpOqSInbA
        R1zQE+rwtmxBKv0EP4NNhffBpQxYBXtxgftjFw+hP0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UzPHBf
        LAzVPcvFoQrMGEUfMi0HGclZnPUVz97BwDOS4=; b=SjyPgHo+Gi5Pu2hpMp/m8/
        YdRZXGWl7Xupb7bIboIqhApeN2xg4UZ1FZMrHPshWxSHNNCn2x/kxu+JTjTxSGO1
        pxEKHvwzl0MEoSoGQ050MAl1pmjlXogOA6MYTrDGxrSu+juZEoi/SHjggYByIft0
        OU8fKq64PP+BXrIUBcmHfMBmB8W3v2W611LUL3uQ/kWx3dZUyH8Yy7GL5+ilvP/U
        EvDyAB0nQ7kUT9GBRsvcTqT9JGUMEhChYlLerw/TuL0tdSVn83wnIuPKkXRalrtm
        YyGViO+OmA4iKIAIr6KDh9gyPLinqjZFpvlv2a57KFR/HQoGG4YwMxdOiR8+xwZw
        ==
X-ME-Sender: <xms:b5pmXYJksW9YqcKJ_B6n8j55BKk1sDp8UXHvJgWhyp81AM_B0SD8Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeitddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucfkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:b5pmXcaM0fPYF_KLc3nA2oPNYUkUcJWaPeDtA91dhop7C4AADTnatg>
    <xmx:b5pmXTvB5VBEgPpAmyW5sxPMASTUv3SfIyvDYlCs2XrKMIIO9Rf7sw>
    <xmx:b5pmXZtR0TiCPBeWmr3c6zncYrxnHz-88sVh-a09Jfi_KQuxxH3iPA>
    <xmx:cJpmXTNgdGDhckdctU3q1L7ZfLrRiFqv88yp1Nso3i2jv8E7pBaMcQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 57461D60063;
        Wed, 28 Aug 2019 11:14:55 -0400 (EDT)
Date:   Wed, 28 Aug 2019 17:14:54 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yu Chen <yu.c.chen@intel.com>, stable-commits@vger.kernel.org
Subject: Re: Patch "x86/pm: Introduce quirk framework to save/restore extra
 MSR registers around suspend/resume" has been added to the 4.4-stable tree
Message-ID: <20190828151454.GB9673@kroah.com>
References: <20190828041240.12F5221883@mail.kernel.org>
 <20190828084351.GC29927@kroah.com>
 <20190828090043.GA7589@chenyu-office.sh.intel.com>
 <20190828091155.GA32011@kroah.com>
 <20190828111323.GA5281@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828111323.GA5281@sasha-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 07:13:23AM -0400, Sasha Levin wrote:
> On Wed, Aug 28, 2019 at 11:11:55AM +0200, Greg KH wrote:
> > On Wed, Aug 28, 2019 at 05:00:44PM +0800, Yu Chen wrote:
> > > On Wed, Aug 28, 2019 at 10:43:51AM +0200, Greg KH wrote:
> > > > On Wed, Aug 28, 2019 at 12:12:39AM -0400, Sasha Levin wrote:
> > > > > This is a note to let you know that I've just added the patch titled
> > > > >
> > > > >     x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume
> > > > >
> > > > > to the 4.4-stable tree which can be found at:
> > > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > > >
> > > > > The filename of the patch is:
> > > > >      x86-pm-introduce-quirk-framework-to-save-restore-ext.patch
> > > > > and it can be found in the queue-4.4 subdirectory.
> > > > >
> > > > > If you, or anyone else, feels it should not be added to the stable tree,
> > > > > please let <stable@vger.kernel.org> know about it.
> > > > >
> > > > >
> > > > >
> > > > > commit d63273440aa0fdebc30d0c931f15f79beb213134
> > > > > Author: Chen Yu <yu.c.chen@intel.com>
> > > > > Date:   Wed Nov 25 01:03:41 2015 +0800
> > > > >
> > > > >     x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume
> > > > >
> > > > >     A bug was reported that on certain Broadwell platforms, after
> > > > >     resuming from S3, the CPU is running at an anomalously low
> > > > >     speed.
> > > > >
> > > > >     It turns out that the BIOS has modified the value of the
> > > > >     THERM_CONTROL register during S3, and changed it from 0 to 0x10,
> > > > >     thus enabled clock modulation(bit4), but with undefined CPU Duty
> > > > >     Cycle(bit1:3) - which causes the problem.
> > > > >
> > > > >     Here is a simple scenario to reproduce the issue:
> > > > >
> > > > >      1. Boot up the system
> > > > >      2. Get MSR 0x19a, it should be 0
> > > > >      3. Put the system into sleep, then wake it up
> > > > >      4. Get MSR 0x19a, it shows 0x10, while it should be 0
> > > > >
> > > > >     Although some BIOSen want to change the CPU Duty Cycle during
> > > > >     S3, in our case we don't want the BIOS to do any modification.
> > > > >
> > > > >     Fix this issue by introducing a more generic x86 framework to
> > > > >     save/restore specified MSR registers(THERM_CONTROL in this case)
> > > > >     for suspend/resume. This allows us to fix similar bugs in a much
> > > > >     simpler way in the future.
> > > > >
> > > > >     When the kernel wants to protect certain MSRs during suspending,
> > > > >     we simply add a quirk entry in msr_save_dmi_table, and customize
> > > > >     the MSR registers inside the quirk callback, for example:
> > > > >
> > > > >       u32 msr_id_need_to_save[] = {MSR_ID0, MSR_ID1, MSR_ID2...};
> > > > >
> > > > >     and the quirk mechanism ensures that, once resumed from suspend,
> > > > >     the MSRs indicated by these IDs will be restored to their
> > > > >     original, pre-suspend values.
> > > > >
> > > > >     Since both 64-bit and 32-bit kernels are affected, this patch
> > > > >     covers the common 64/32-bit suspend/resume code path. And
> > > > >     because the MSRs specified by the user might not be available or
> > > > >     readable in any situation, we use rdmsrl_safe() to safely save
> > > > >     these MSRs.
> > > > >
> > > > >     Reported-and-tested-by: Marcin Kaszewski <marcin.kaszewski@intel.com>
> > > > >     Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > >     Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >     Acked-by: Pavel Machek <pavel@ucw.cz>
> > > > >     Cc: Andy Lutomirski <luto@amacapital.net>
> > > > >     Cc: Borislav Petkov <bp@alien8.de>
> > > > >     Cc: Brian Gerst <brgerst@gmail.com>
> > > > >     Cc: Denys Vlasenko <dvlasenk@redhat.com>
> > > > >     Cc: H. Peter Anvin <hpa@zytor.com>
> > > > >     Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > > >     Cc: Peter Zijlstra <peterz@infradead.org>
> > > > >     Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > >     Cc: bp@suse.de
> > > > >     Cc: len.brown@intel.com
> > > > >     Cc: linux@horizon.com
> > > > >     Cc: luto@kernel.org
> > > > >     Cc: rjw@rjwysocki.net
> > > > >     Link: http://lkml.kernel.org/r/c9abdcbc173dd2f57e8990e304376f19287e92ba.1448382971.git.yu.c.chen@intel.com
> > > > >     [ More edits to the naming of data structures. ]
> > > > >     Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > > >
> > > > No git id of the patch in Linus's tree, or your signed-off-by?
> > > >
> > > I think the commit id in Linus'tree should be 7a9c2dd08eadd5c6943115dbbec040c38d2e0822
> > 
> > Ah, and Sasha added it because a later patch needed it :(
> > 
> > Sasha, can you fix this patch's headers up to be in the "proper" format?
> 
> Yes, I brought it in as a dependency but cherry picked instead of using
> my scripts by mistake. I'll fix up the patch in the queue.

I think you forgot to push your changes to kernel.org :)
