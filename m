Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7964DC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 16:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDDE21670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566663279;
	bh=nP0Hyrtr3QhEfYDM+zNKHZi1M+mwSZUgnfmmw+pVla8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gEqXlSCWlL60dl6hDssOMTtjJECavZ9rCByN09gfSg2OuvAVw1hkHbOFZ4lRRojoE
	 oKGUAioygrDIFoLfzN6dRi3MqYsiW4sYjPaRj9cdI3wqJJZJaGC/pQKq3EN/u0lvf6
	 7iBJY5kR9EHDobvagrrGcYfy3sIAftVo45WHe96M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfHXQOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 12:14:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45698 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHXQOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 12:14:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id q12so11306818wrj.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xofA0Q+2DhD6aYBYq1PxV+QCF4qL3qO+KVop1PqB7JM=;
        b=AZyuTpXxEq7JH6uYUefbSjthSH8ufi9nAapjtQNJSGxN997/FENHW4s+5huDvRdBnP
         453saShqM7bGeDbxi3rv9tGVncwjAaG7niX40RivDfMBWjeHOESapTp7UO5KiVSaOBDa
         +CLq36LVX3s2RiuMH+hFytP2CvVQ20HRp+x1SrGvbqnu6GtZ9jIGEqFwJ+LafjASaBnV
         XbemaWP2S8MptZrOCg4yInLElWnXmd+O7B0aJSQ+l0DVMxEV8lXdJ8c+yVjs84Ftvobe
         HF6xCEFqUUqNHALjCfVskjRWBe7vsITTQx1YjNvMxMzGIQrokoZ3tlbGz3ixobokEY3/
         Mnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xofA0Q+2DhD6aYBYq1PxV+QCF4qL3qO+KVop1PqB7JM=;
        b=tKoj62zSNQ1ZVU4D8k810fXAR97PigDlhpzCFNVnBnerMG4ixg1727TSj1EPUUHZ+q
         LfHMwUSL6ONpgnPG/oTjwVOcF7nvY2TQmOYNRvPt0VCj+UWDf3KUyY0M50ohB3pUtqGT
         xa7RPe3WkiVTRqk9NXz2fZSdXSmOUbDnOC8q6cb8Zhz9pil3jM+s1kvux3i3BzhcJ7/u
         cdvY3er236WlMa7GHUSZiX6W5hxh7EhpSWHMss+lZIrq73LNc+FiKV4eKDA//B/3OENN
         wQAmDW+lOkTESKPJwLqZlD0NM14TsnYWHpdPCOosmlOkbeFgj4NcLpTgKDzHirhpFeQL
         Vv0Q==
X-Gm-Message-State: APjAAAVpOGMEQnUO8sWl8NkJRT8hjmlztxDzIaL5+fdEbg4pt/cbGE1O
        Cfgrudx028VniE09rRFJjJo=
X-Google-Smtp-Source: APXvYqzVB9TKEfZz2yhKZYOrbQTs8bwXX2qqpU27M2L8iGJhtX4VHq4EpEiy7Ac9blpqDjwv/S1ElA==
X-Received: by 2002:a5d:4d4c:: with SMTP id a12mr12183153wru.343.1566663274582;
        Sat, 24 Aug 2019 09:14:34 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a19sm18583010wra.2.2019.08.24.09.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 09:14:33 -0700 (PDT)
Date:   Sat, 24 Aug 2019 18:14:32 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
Message-ID: <20190824161432.GA25950@gmail.com>
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
 <20190823091636.GA10064@gmail.com>
 <CAHk-=wj=HcHWjrrNRmZ_hxEdBBrvUnPNFCw37EAu8_qJn71saQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj=HcHWjrrNRmZ_hxEdBBrvUnPNFCw37EAu8_qJn71saQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Aug 23, 2019 at 2:16 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > > +      */
> > > +     if (fatal_signal_pending(current)) {
> > > +             if (!(error_code & X86_PF_USER))
> > > +                     no_context(regs, error_code, address, 0, 0);
> >
> > Since the 'signal' parameter to no_context() is 0, will there be another
> > signal generated? I don't think so - so the comment looks wrong to me,
> > unless I'm missing something.
> 
> The old case only handled the kernel case - which never added a signal
> at all, it just failed the access (and results in EFAULT or similar,
> but nobody cares since the whole point is that the process is going to
> be killed).
> 
> The *changed* case handles user space accesses too - by just returning
> without any new signal being generated. The old case would fall
> through to the "generate SIGSEGV", which seems pointless and wrong
> (and also possibly generates misleading messages in the kernel logs).

Indeed!

> > Other than that, what we are skipping here if a KILL signal is pending is
> > the printout of oops information if the fault is a kernel one.
> >
> > Not sure that's a good idea in general: carefully timing a KILL signal
> > would allow the 'stealth probing' of otherwise oops generating addresses?
> 
> That sounds really like a non-issue to me. Plus the old code ALREADY
> did that exact thing. The only _new_ case is that it does is silently
> for user page faults.
> 
> > I.e. I'm not sure this hunk is necessary or even a good idea.
> 
> As mentioned, the new code doesn't change the case you are talking about at all.
> 
> The new code only changes the case of this happening from user space,
> when it doesn't generate a pointless signal and a pointless possible
> show_signal_msg() garbage for a user mode access that was denied due
> to the new
> 
> > > +     if (flags & FAULT_FLAG_KILLABLE) {
> > > +             if (fatal_signal_pending(current))
> > > +                     return VM_FAULT_SIGSEGV;
> > > +     }
> 
> code in handle_mm_fault().
> 
> And you said that new code looks fine to you, but you didn't seem to
> realize that it causes stupid incorrect kernel messages to be printed
> ("segfault at xyz" etc) that are completely wrong.
> 
> Because it's not a "real" SIGSEGV. It gets repressed by the fact that
> there's a fatal signal pending.
> 
> Otherwise we'd have to add a whole new case of VM_FAULT_xyz..

Indeed :-/

At least I can report that I was able to reproduce a probable variant of 
the bug Tetsuo reported on a regular PC as well, with this command:

  dd if=/dev/mem of=/dev/null status=progress conv=noerror bs=100M

The 'noerror' is needed to skip unreadable holes early in the memory map.

What I noticed is that while reading regular RAM is reasonably fast even 
in very large chunks, accesses become very slow once they hit iomem - and 
delays even longer than the reported 145 seconds become possible if 
bs=100M is increased to say bs=1000M.

With your patch applied these large read chunks are still possible and 
not interruptible within read_mem(), and because the source of the 
slowdown is the iomem access and memcpy()s, not the paging overhead, the 
new page fault code doesn't even trigger and the delays remain.

I.e. this hypothesis is not true, on my testbox at least - and with my 
different testcase:

> > > Also, if it takes minutes to delay killing things, that implies 
> > > that we're probably still faulting in pages for the read_mem(). 
> > > Which points to another possible thing we could do in general: just 
> > > don't bother to handle page faults when a fatal signal is pending.

With Tetsuo's approach the delays are fixed, because the fatal signal is 
noticed within the 4K chunks of read_mem() immediately:

[pid  1674] 1566662105.052485 write(1, "ZZZZ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 104857600) = 104857600 <0.000008>
[pid  1674] 1566662105.052512 read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 104857600) = 104857600 <17.006740>
[pid  1674] 1566662122.059306 write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 104857600) = 104857600 <0.000009>
) = 1 <0.000010>662122.059334 write(2, "\r", 1
[pid  1674] 1566662122.059372 write(2, "3145728000 bytes (3.1 GB) copied", 323145728000 bytes (3.1 GB) copied) = 32 <0.000009>
[pid  1674] 1566662122.059411 write(2, ", 18.214699 s, 173 MB/s", 23, 18.214699 s, 173 MB/s) = 23 <0.000008>
[pid  1674] 1566662122.059433 read(0,  <unfinished ...>
[pid  1674] 1566662123.082491 +++ killed by SIGKILL +++

Note how the first 100MB chunk took 17 seconds, the second chunk was 
interrupted within ~2 seconds after I sent a SIGKILL.

Find below a variant of Tetsuo's patch, that uses a more regular signal 
return pattern that you suggested in your other mail:

> (Ok, in this case I think it wants
>
>         err = -EINTR;
>         if (fatal_signal_pending(current))
>                 break;
>
> instead, but the point is to make it look like signal handling, just
> with the special "fatal signals can sometimes be handled even when
> regular signals might not make it through".

Except that I think the regular pattern here is not 'break' but 'goto 
failed' - 'break' would just result in a partial read and 'err' gets 
ignored.

I also agree that we should probably allow regular interrupts to 
interrupt /dev/mem accesses - while the 'dd' process is killable, it's 
not Ctrl-C-able.

If I change the fatal_signal_pending() to signal_pending() it all behaves 
much better IMHO - assuming that no utility learned rely on 
non-interruptibility ...

The second patch is attached below the first one.

Independently of this I also agree with Tetsuo that a cond_resched() 
might be in order to break up this loop on non-preempt kernels. The third 
patch below implements this variant.

Is this closer to what you had in mind?

Thanks,

	Ingo

---
 drivers/char/mem.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux/drivers/char/mem.c
===================================================================
--- linux.orig/drivers/char/mem.c
+++ linux/drivers/char/mem.c
@@ -175,6 +175,15 @@ static ssize_t read_mem(struct file *fil
 		p += sz;
 		count -= sz;
 		read += sz;
+
+		/*
+		 * Reading from iomem areas of /dev/mem can be slow,
+		 * depending on the hardware, so allow such read()s
+		 * to be interrupted via fatal signals (SIGKILL):
+		 */
+		err = -EINTR;
+		if (fatal_signal_pending(current))
+			goto failed;
 	}
 	kfree(bounce);
 
 
 drivers/char/mem.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux/drivers/char/mem.c
===================================================================
--- linux.orig/drivers/char/mem.c
+++ linux/drivers/char/mem.c
@@ -175,6 +175,15 @@ static ssize_t read_mem(struct file *fil
 		p += sz;
 		count -= sz;
 		read += sz;
+
+		/*
+		 * Reading from iomem areas of /dev/mem can be slow,
+		 * depending on the hardware, so allow such read()s
+		 * to be interruptible:
+		 */
+		err = -EINTR;
+		if (signal_pending(current))
+			goto failed;
 	}
 	kfree(bounce);
 
Index: linux/drivers/char/mem.c
===================================================================
--- linux.orig/drivers/char/mem.c
+++ linux/drivers/char/mem.c
@@ -175,6 +175,18 @@ static ssize_t read_mem(struct file *fil
 		p += sz;
 		count -= sz;
 		read += sz;
+
+		/*
+		 * Reading from iomem areas of /dev/mem can be slow,
+		 * depending on the hardware, so allow such read()s
+		 * to be interruptible and preemptible:
+		 */
+		err = -EINTR;
+		if (signal_pending(current))
+			goto failed;
+
+		if (need_resched())
+			cond_resched();
 	}
 	kfree(bounce);
 
