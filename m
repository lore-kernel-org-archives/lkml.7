Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEAEC432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 10:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D38F20725
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 10:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575197199;
	bh=A+Rcr/pb0FA/XAvi8P4JsBjLhPn/5yCAibyT/b6FZgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eAktAY4Hr7OrxtmsSjvrDn67qEAZRRUHs3zae3LtNxqihTSzPgcIRc1kY9Gm33TjW
	 mvxsWhDcQ5HzAP4a4PWcZ/eJbUaYcSWesT3LwiSxm0Vi9Qs4GSio1TEA7ry3afdma3
	 Roq1qXs4XHTYg4bksHhmkvb7uAhYycpUjHLEVUu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfLAKqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 05:46:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33253 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfLAKqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 05:46:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so10872628wrq.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 02:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P0S0aNiZhUDcMgsUFhIruZb/8EnKELSIe5M3uXc7iyE=;
        b=d1dp5FbskpIiq/Iltcoldq8H3LtOaBqEO5V50+j6IizbaQMBp8g66124ITLnJ6LIBG
         NAvP+MMt7VLRJiN4So2jLc0DyRQ6r95TV6LrbEcndeVfjmb6bZ1w3kbY3aGIhiyJSI73
         0CZEx72oCIrIEYOHpF2SW9fNS4Vn5uhgjbl5juzDKYmeXzB0DJhgaVxQSIszNmNddocR
         HXIpDjK9lGKInTK7AAjEVfDZhUpUShRr4dOsM16yKiFITbiq6PAG1PTX6cCHchctm0k4
         YfYfJW3MBZCK2BQlHZqy/WEYktws5nuJBlFYvD4J3PyILgchjdNjJH3ZaKSKxG/Ee+Mk
         Jj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P0S0aNiZhUDcMgsUFhIruZb/8EnKELSIe5M3uXc7iyE=;
        b=ESY4Mh6Bp5fNYKCBVSVNx8yawkY7O6u0ZWQ6xVlbrrn0LyY9AT5MhLtdyjjAQC//Ms
         hqUiVdq7ZrCSizvBclnG1a46LkGG+PUMBGxKbEe2aBZZTS2oLXsw9tQbygRjsgwpLkpD
         HZSRqBltFlKQYuTuIBnSOTBiH6OsdnvEdcC+LrbRAntOm+qfiRKyfqq7CWt752YCECma
         PJNQ3Vk3DGUFxz09onysj6I1Wvu9DiXA+BvWCqIAufW4jcwwN56MwiDZFAVjiXNSuqcO
         jg2DEU9w2Q6lTAq1D1n9x88VCbLa5OppQOL7n1Vt5KL/+g9t+HIhB+61TK1j7AK2l+A8
         o2kQ==
X-Gm-Message-State: APjAAAVQdiLRSBjYwlEt/XsZdZnp6NUGl9oK1b9RHaRcRc6Kespd2DM+
        EPCQZwYdwy8F43mTArn+W2I=
X-Google-Smtp-Source: APXvYqwgEwT2ws2iRHV1Mr6XLxunS2zC48v22OMkwGX+4VrB9qUX8E4SU8m9DjU3oRAJ8RDJPp7QwQ==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr3574256wrm.284.1575197187829;
        Sun, 01 Dec 2019 02:46:27 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q5sm19624126wmc.27.2019.12.01.02.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 02:46:26 -0800 (PST)
Date:   Sun, 1 Dec 2019 11:46:24 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mceier@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        kernel test robot <rong.a.chen@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: [x86/mm/pat] 8d04a5f97a: phoronix-test-suite.glmark2.0.score
 -23.7% regression
Message-ID: <20191201104624.GA51279@gmail.com>
References: <20191127005312.GD20422@shao2-debian>
 <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com>
 <20191130212729.ykxstm5kj2p5ir6q@linux-p48b>
 <CAJTyqKOp+mV1CfpasschSDO4vEDbshE4GPCB6+aX4rJOYSF=7A@mail.gmail.com>
 <CAHk-=wh--xwpatv_Rcp3WtCPQtg-RVoXYQj8O+1TSw8os7Jtvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh--xwpatv_Rcp3WtCPQtg-RVoXYQj8O+1TSw8os7Jtvw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Nov 30, 2019 at 2:09 PM Mariusz Ceier <mceier@gmail.com> wrote:
> >
> > Contents of /sys/kernel/debug/x86/pat_memtype_list on master
> > (32ef9553635ab1236c33951a8bd9b5af1c3b1646) where performance is
> > degraded:
> 
> Diff between good and bad case:
> 
>     @@ -1,8 +1,8 @@
>      PAT memtype list:
>      write-back @ 0x55ba4000-0x55ba5000
>      write-back @ 0x5e88c000-0x5e8b5000
>     -write-back @ 0x5e8b4000-0x5e8b8000
>      write-back @ 0x5e8b4000-0x5e8b5000
>     +write-back @ 0x5e8b4000-0x5e8b8000
>      write-back @ 0x5e8b7000-0x5e8bb000
>      write-back @ 0x5e8ba000-0x5e8bc000
>      write-back @ 0x5e8bb000-0x5e8be000
>     @@ -21,15 +21,15 @@
>      uncached-minus @ 0xec260000-0xec264000
>      uncached-minus @ 0xec300000-0xec320000
>      uncached-minus @ 0xec326000-0xec327000
>     -uncached-minus @ 0xf0000000-0xf0001000
>      uncached-minus @ 0xf0000000-0xf8000000
>     +uncached-minus @ 0xf0000000-0xf0001000
>      uncached-minus @ 0xfdc43000-0xfdc44000
>      uncached-minus @ 0xfe000000-0xfe001000
>      uncached-minus @ 0xfed00000-0xfed01000
>      uncached-minus @ 0xfed10000-0xfed16000
>      uncached-minus @ 0xfed90000-0xfed91000
>     -write-combining @ 0x2000000000-0x2100000000
>     -write-combining @ 0x2000000000-0x2100000000
>     +uncached-minus @ 0x2000000000-0x2100000000
>     +uncached-minus @ 0x2000000000-0x2100000000
>      uncached-minus @ 0x2100000000-0x2100001000
>      uncached-minus @ 0x2100001000-0x2100002000
>      uncached-minus @ 0x2ffff10000-0x2ffff20000
> 
> the first two differences are just trivial ordering differences for
> overlapping ranges (starting at 0x5e8b4000 and 0xf0000000)
> respectively.
> 
> But the final difference is a real difference where it used to be WC,
> and is now UC-:
> 
>     -write-combining @ 0x2000000000-0x2100000000
>     -write-combining @ 0x2000000000-0x2100000000
>     +uncached-minus @ 0x2000000000-0x2100000000
>     +uncached-minus @ 0x2000000000-0x2100000000
> 
> which certainly could easily explain the huge performance degradation.

Indeed, as two days ago I speculated to Kenneth R. Crudup who reported a 
similar slowdown on i915:

> * Ingo Molnar <mingo@kernel.org> wrote:
> > > * Kenneth R. Crudup <kenny@panix.com> wrote:
> > >
> > > > As soon as the i915 driver module is loaded, it takes over the 
> > > > EFI framebuffer on my machine (HP Spectre X360 with Intel UHD620 
> > > > Graphics) and the subsequent text (as well as any VTs) is 
> > > > rendered much more slowly. I don't know if the i915/DRM guys need 
> > > > to do anything to their code to take advantage of this change to 
> > > > the PATs, but reverting this change (after the associated 
> > > > subseqent commits) has fixed that issue for me.
> > > >
> > > > Let me know if you need any further info.
> > >
> > > This is almost certainly the PAT bits being wrong in the 
> > > pagetables, i.e. an x86 bug, not a GPU driver bug.
> > >
> > >
> > > Davidlohr, any idea what's going on? The interval tree conversion went
> > > bad. The slowdown symptoms are consistent with perhaps the framebuffer
> > > not getting WC mapped, but uncacheable mapped:
> > >
> > >                ptr = io_mapping_map_wc(&i915_vm_to_ggtt(vma->vm)->iomap,
> > >                                         vma->node.start,
> > >                                         vma->node.size);
> > > 
> > > Which is a wrapper around ioremap_wc().
> > > 
> > > To debug this it would be useful to do a before/after comparison of the
> > > kernel pagetables:
> > > 
> > >  - before: git checkout 8d04a5f97a^1
> > >  - after:  git checkout 8d04a5f97a

And yesterday:

> [...]
>
> There's another similar bugreport of a -20% GL performance drop, from 
> the ktest automated benchmark suite:
>
>     https://lkml.kernel.org/r/20191127005312.GD20422@shao2-debian
>
> My shot-in-the-dark hypothesis is that perhaps we somehow fail to find 
> a newly mapped memtype and leave a key ioremap_wc() area uncached, 
> instead of write-combining?
>
> The order of magnitude of the slowdown would be roughly consistent with 
> that, in GPU limited workloads - it would be more marked in 3D scenes 
> with a lot of vertices or perhaps a lot of texture changes.
>
> But this is really just a random guess.

It's not an unconditional regression, as both Boris and me tried to 
reproduce it on different systems that do ioremap_wc() as well and didn't 
measure a slowdown, but something about the memory layout probably 
triggers the tree management bug.

Thanks,

	Ingo
