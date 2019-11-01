Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6152CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9B420650
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572640255;
	bh=Zg8gISgSEvOYo022K9/te3uoCnQvjpRPcW4kXlCV4ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rlJKeBDUe8Z2XSkrc0c0ULX3N3B9DcI2zaJOrGgTk7dXRZhNs7V9b741aWIvxN11J
	 FGv5lwo10Zgt8iy51HsobvQsxurMipw73aAiH55d+2FvQQKVY5CzGK9MLW0vCt6Ikw
	 mfQGC3Xh9aQvf3UhBNrXjntm61R1GGpDTTtcszro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfKAUay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 16:30:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40882 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfKAUay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 16:30:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id o28so10759732wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XpcjwJNnMcDniC3w5UY49pgimdkjdtr/lVC5Nw3pN5s=;
        b=tJ/c3zXaZSslXk9j3Z94c82LS6tryL4EtbI/pl1QzY5zxnqqKKdXbOHX/EryP6hfuJ
         G23v6IMFkK1cvwi2kcmPBBnO24/+gkskCFmEX/P6RIdBxpBFMgmx9MlJ8dHFsfqZy3le
         oalJ5m4D6jO7+xISLz3k3r6SxrXCnbzpfyCOWBIKgAWoK4L+WwsWtTuclqR3hRt9hDfg
         RmxWVkRoknD2oSVienJEumo3DLQhL+KDDbwPQdTXV12G5zXAE2Xtx72MqfXmMOPMSJjw
         A0ZkTe8PxKbpdiQj41Y/UY51BT44ublmbZrT7AhYPFNfjnM7MrvAbGICD91GPKVlsa8g
         2oDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XpcjwJNnMcDniC3w5UY49pgimdkjdtr/lVC5Nw3pN5s=;
        b=GODdVx0pMwL4LWlP53R5CORDIO/0ZWotj4NICRKH174+FEKQlAmhW5qB+HxXdBjlw6
         1McFfXu7hJAJ3T3zDtOJcs6AJU8AORg9SCTflhl5ojgrbObw0VF6Xc/1Vkz7+whgtzRl
         rz7/4BJqPJKluN33kFsUqvoJG59lw3YdA8yiJEvWNdSTIxvkY2w0WUuGz3RrKOSqVbnI
         BxbalCXv99WF6zSMCvdfs1qj18zaDV1kWWmzo/UU0+TTseoP37n7zQ1npn9hO4edPv6V
         u7pDDC/rm2Q3yl/079M0e0wgCx/kWEuoXGnes8o1qo64z39baiVtS3UCa2vFb+pwqjv8
         mujQ==
X-Gm-Message-State: APjAAAXKxSVPo4E/gQwwKRaxOTYXUJhhJBR2I2rnYLI7SByX6GfKIHI8
        F4n36lppMoCdKBdeGJPX5/o=
X-Google-Smtp-Source: APXvYqxc5CSOgZl3K1VSUKnU5dNtQnwyYlt6G7lqULinR1FL/d7g1u72yMgyXuS4uEGTr4sc5egwKA==
X-Received: by 2002:adf:9f08:: with SMTP id l8mr11634395wrf.325.1572640251224;
        Fri, 01 Nov 2019 13:30:51 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x5sm7024285wmk.16.2019.11.01.13.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 13:30:50 -0700 (PDT)
Date:   Fri, 1 Nov 2019 21:30:48 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] perf fixes
Message-ID: <20191101203048.GA6622@gmail.com>
References: <20191101174840.GA81963@gmail.com>
 <CAHk-=wi_VHc=Q2JsPbVmCgpKekNJwnbBiYrmvnSSW8aiAkg7nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_VHc=Q2JsPbVmCgpKekNJwnbBiYrmvnSSW8aiAkg7nQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Nov 1, 2019 at 10:48 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Alexander Shishkin (1):
> >       perf/core: Start rejecting the syscall with attr.__reserved_2 set
> 
> This seems to quite possibly break existing apps. Is there any reason 
> to believe that existing users have actually cleared that field?

Yes, there's good reason to believe that the field ends up being zero 
within the kernel even if old user-space uses the old, smaller structure:

> It's suspect for another reason too: the commit that added that field
> just added it to the end of the structure, with the argument that
> "aux_watermark will only matter for new AUX-aware code, so the old
> code should still be fine".
> 
> So by *definition* those old kinds of users would never have cleared
> that field, because that field didn't exist.

Firstly, non-existent fields are initialized to zero by default in the 
perf ABI: *even if user-space was built well before that new field was 
introduced in the kernel*.

This is done in perf_copy_attr():

        /* Zero the full structure, so that a short copy will be nice. */
        memset(attr, 0, sizeof(*attr));

The user-space structure that is passed in ('uattr' within that function) 
might indeed be short and not contain the new field - but we handle this 
via uattr->size, which is set by user-space - for example 'perf' sets it 
in event_attr_init() in tools/perf/util/util.c:

        /* to capture ABI version */
        attr->size = sizeof(*attr);

Second, the kernel syscall then checks this size against the kernel's 
size of attr:

 - if uattr->size < kattr_size: then old ABI user-space binary is 
   running on new kernel, and we zero out residual fields.

 - if uattr->size = kattr_size, this is the normal case of matching ABI (sizes)

 - if uattr->size > kattr_size, then new ABI user-space binary is running 
   on an old kernel - in this case the kernel copies in a shortened 
   structure from the new tool and ignores the remaining fields. To not 
   surprise new user-space the kernel copies back the recognized size to 
   uattr->size and user-space can decide whether they want to run on this 
   kernel or not:

             put_user(sizeof(*attr), &uattr->size);

This way the perf ABI is *both* backwards and forward compatible, even 
across multiple ABI changes. We seemingly didn't "care" about the zeroing 
of the new field in old binaries in that changelog, because it's 
guaranteed by the syscall implementation.

[ Note that there *is* still potential for more subtle ABI breakage, see 
  further below. ]

This actually works fine in practice. I just tried out a brand new kernel 
with really old perf tooling in the v3.19 kernel, from 4.5 years ago:

  $ git checkout v3.19
  $ cd tools/perf/
  $ make install WERROR=0

  $ perf version
  perf version 3.19.gbfa76d49

  $ perf top

This ancient version of 'perf top', 'perf record', 'perf report' works 
just fine on the new kernel, despite passing in a smaller 'attr':

  [  558.408907] perf kABI size: 112
  [  558.412855] perf uABI size: 104

when running new tooling on a new kernel the two sizes match:

[  331.598089] perf kABI size: 112
[  331.602050] perf uABI size: 112

and everything works as usual.

> And the people involved should stop claiming this "fixes" anything,
> and should look hard at their random ABI expansions and "fixes".
> 
> The original code that said "old users would not be impacted" is
> correct. But this "fix" is very very very questionable indeed, and I
> get the feeling that somebody doesn't understand what ABI is, when
> they claim that this "fixes" anything.

So if your primary worry is about old user-space that didn't know about 
the new field passing in the new field with some random value, then if 
the perf ABI handling logic I outlined above is implemented correctly 
(and I believe it's correct), then this should not happen.

But arguably there's still a more subtle ABI breakage that this change 
might trigger: if due to some bug user-space *does* initialize this 
reserved field to non-zero, and the kernel ignored that non-zero field 
for 4 years and new kernels suddenly start rejecting these syscalls, 
that's an ABI bug and grounds for an immediate revert.

I don't expect this to happen though, due to the combination of how 
user-space and kernel-space handles the extension of the perf ABI - but 
if it happens then it's an insta-revert.

I'd also argue that because we didn't check this field for years, the 
next ABI extension should probably not use the __reserved_2 field - which 
is a good idea anyway as it has an unnatural __u16 size.

> Honestly, this all shows a worrying complete disregard for backwards
> compatibility. Calling this a "fix" is questionable, when it is much
> more likely to break some old user.
> 
> I've pulled it, but I need people to be aware that this is utter
> garbage, and that if anybody ever reports it, this needs to be
> immediately reverted.

In light of the above logic I'd like to push back against this 
characterization: this kind of ABI compatibility is actually one of the 
most important aspects of the perf ABI, and we very much take it 
seriously.

In fact we are proud of it: the perf ABI is one of the most iterated, yet 
also one of the most compatible and tooling-friendly ABIs in the kernel. :-)

The reason it wasn't even mentioned in the changelog is because we tried 
to design out this kind of mishap from the ABI, and all the main perf 
developers are aware of that design. Will try to include a more careful 
explanation next time.

Thanks,

	Ingo
