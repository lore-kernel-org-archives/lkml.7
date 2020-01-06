Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201D1C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA73C207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578326305;
	bh=I7AvbF0PAjywRwJPOtCae2PtkWDpsy0v/FtN2McmenQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zYaA+tijy6AwRD3kGVpqHV0dPQM8QdSJDvxnG/Nig127dKI0i1yyhGkV1SzCFd9bQ
	 DS6UXcyKQplJO0EK5ZgBkrWR5xzljZYn7bNwCgmFDlYIMTliIkQmcefibzDVtWmLjP
	 ZOQPpaz0q4FodcZU0uNc90924WP4yEU3YFUf4hJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgAFP6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:58:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:60564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgAFP6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:58:23 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E5120707;
        Mon,  6 Jan 2020 15:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326302;
        bh=I7AvbF0PAjywRwJPOtCae2PtkWDpsy0v/FtN2McmenQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b6aCwXSgvkHKTGhyYAwolmwX9oXWuAQRD/xE6SB1mEQHMUZWOWY7e2NDr/30UImcC
         tiqQ78hDQMQHzWrlyrpZaRp2mkYGK6GqJ7o5tbS0MKu026aKvUI3xSOj+hA39O4yt4
         v2gcreS7MFPKSOSVwtA5GlAl/JAE2HAIAs/7ZZWA=
Date:   Mon, 6 Jan 2020 16:58:20 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 0/2] x86/context-tracking: Remove last remaining calls to
 exception_enter/exception_exit()
Message-ID: <20200106155819.GC26097@lenoir>
References: <20191227163612.10039-1-frederic@kernel.org>
 <20200106150546.GS2810@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106150546.GS2810@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 04:05:46PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 27, 2019 at 05:36:10PM +0100, Frederic Weisbecker wrote:
> > Thanks to the cleanups from Andy Lutomirski over the years, those calls
> > can now be removed. This will allow for nice things in the future for
> > x86 support on full nohz:
> > 
> > * Remove TIF_NOHZ and use a per-cpu switch to enable, disable context
> >   tracking.
> > 
> > * Avoid context tracking on housekeepers.
> > 
> > * Dynamically enable/disable context tracking on CPU on runtime and
> >   therefore allow runtime enable/disable of nohz_full
> > 
> > * Make nohz_full a property of cpuset.
> > 
> > Frederic Weisbecker (2):
> >   x86/context-tracking: Remove exception_enter/exit() from
> >     do_page_fault()
> >   x86/context-tracking: Remove exception_enter/exit() from
> >     KVM_PV_REASON_PAGE_NOT_PRESENT async page fault
> 
> Thanks, these look good to me.
> 
> Did I tell you about my 'TODO' item vs text_poke_sync() ? Basically, we
> can avoid sending the IPI to NOHZ_FULL user CPUs, provided we make their
> enter_from_user_mode() do the sync_core().

Yeah I believe I saw some email about that somewhere. I hope I didn't miss
a patch about that. Anyway, whether past or future patch, I'll happily review that :-)
