Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC1EC28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3402632A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559259728;
	bh=7YYCFKd7B2wsWdoExXGWhul/2UFex3PfcEkHVhp7QmM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=SQ7GmLpnlKs+GwhSJfSyic5ckDwMbBuNFtC+opVQM1jgoE5aiz/b2O5mqZJfNzuhR
	 jyw2s/jocqavRZ4ZmEnqprr6rOqljE+FHcHKD6bbTKJsqejNuuYIcvis0NTFSWgw3X
	 //fq2gtAv/wKgqhNkyFhrP0nj8SaJMxm8DMWkDoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfE3XmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 19:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfE3XmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 19:42:07 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1D1D26326;
        Thu, 30 May 2019 23:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559259726;
        bh=7YYCFKd7B2wsWdoExXGWhul/2UFex3PfcEkHVhp7QmM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=iCCQvAeEk4ar0WlA2Eh6zNCuaHx2ypdtJd5QMrpKQVCvc4tNANhzTCjVF166QH0H3
         h0cCWQrsc1YOgFu/flWMGFw981pZMu2iNpAW/Ztokzs6c8zqqh4N2fgKxEwzu+vSTs
         n6slvQREgUtD+Lzlz4+yT58HOQa43deSSdrE+iJA=
Date:   Fri, 31 May 2019 01:42:02 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
In-Reply-To: <20190530233804.syv4brpe3ndslyvo@treble>
Message-ID: <nycvar.YFH.7.76.1905310139380.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <nycvar.YFH.7.76.1905300007470.1962@cbobk.fhfr.pm> <CAJZ5v0ja5sQ73zMvUtV+w79LC_d+g6UdomL36rV-EpVDxEzbhA@mail.gmail.com> <alpine.DEB.2.21.1905301425330.2265@nanos.tec.linutronix.de>
 <CAJZ5v0go1g9KhE=mc19VCFrBuEERzFZCoRD4xt=tF=EnMjfH=A@mail.gmail.com> <20190530233804.syv4brpe3ndslyvo@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019, Josh Poimboeuf wrote:

> > >     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > 
> > Yes, it is, thanks!
> 
> I still think changing monitor/mwait to use a fixmap address would be a
> much cleaner way to fix this.  I can try to work up a patch tomorrow.

I disagree with that from the backwards compatibility point of view.

I personally am quite frequently using differnet combinations of 
resumer/resumee kernels, and I've never been biten by it so far. I'd guess 
I am not the only one.
Fixmap sort of breaks that invariant.

Thanks,

-- 
Jiri Kosina
SUSE Labs

