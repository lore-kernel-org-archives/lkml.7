Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B7FC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150492082E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpU80jrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfK3WJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 17:09:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33094 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfK3WJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 17:09:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id 21so3962274ljr.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 14:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=eTOcRHKLVTIf/hNSsAJQhSFwzv7HtDnGOEZ53CiqypY=;
        b=cpU80jrNhhow8HKxdTrfNuv1XhrQc4cvkYn4J6NoK+jQeD+QRvFP3WyiURUOam6fOh
         chNctwfWENtXdT5/+QQKF4vjhHiwpaxhJt4yqy1xM0JS3uqKFMcLN0bw4x8gsYhq7aS+
         k5NfX1yDzxb+UG2IIs9b+G4Xsd/yvejGwxE2R3OePUrUFQf2rEyvRLXqkZ5GRov/g3mj
         sF9TiPW41BX6Ak5T9xrId2add38+Ze05aHaK2YJO5JUIvtutbuB9WnKztrYJi6kJFIHY
         OlO353l8PGuMf6Vj5uKNZKIDarxEJANtdA4tMTwSqDG9/lml5CGMwm16pV6Ai7teHa/Z
         ST1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=eTOcRHKLVTIf/hNSsAJQhSFwzv7HtDnGOEZ53CiqypY=;
        b=PBZ2AYz+i8f9hdfibjIIwHs0OSAjOERFR2mxZd6ESX8//eTnnggiUyEuM0SlJhspDj
         I7DXfguT6F43R265argKpsZWly4qz+ayIhFIKZAgnCsGu4qvd+VAX8Od9A9ygK0I61Vo
         bZdm/kC2uFhOfAfwu6htIx7nAktIFey/KxxK2VB52AdQil1wHJhUWWY+2Onu6U2zCm2N
         5733NLsfEqhmVdcEZWfs/dz43QS/zIOwyWNo4RME7gPS68AFbP4XAOowW+D4GMhDlXjn
         ox//2e2ydD559M18MulfJkeKnkVxrM2GOlotF46P+6HPIj6j3j6c+AgMI/yH5r+apub4
         20UA==
X-Gm-Message-State: APjAAAXynjgrIEF7PDigEzBEw+LC/Sj5IaX0cpkTpD25mfeglExHTkY3
        q/qAdLvGSyIhpiCO9ls4RsnRCf5ugQ8DLnhOGrA=
X-Google-Smtp-Source: APXvYqwCi5CkQOvdqgCAQ3/XlZ82eQwC2emCCCR73r5ABq4ncfxbXpq7/NQKej6udtxXJPd1B2I8jkdhFM3tjOXv2kk=
X-Received: by 2002:a2e:9ec4:: with SMTP id h4mr4028621ljk.77.1575151747219;
 Sat, 30 Nov 2019 14:09:07 -0800 (PST)
MIME-Version: 1.0
References: <20191127005312.GD20422@shao2-debian> <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com>
 <20191130212729.ykxstm5kj2p5ir6q@linux-p48b>
In-Reply-To: <20191130212729.ykxstm5kj2p5ir6q@linux-p48b>
Reply-To: mceier@gmail.com
From:   Mariusz Ceier <mceier@gmail.com>
Date:   Sat, 30 Nov 2019 22:08:56 +0000
Message-ID: <CAJTyqKOp+mV1CfpasschSDO4vEDbshE4GPCB6+aX4rJOYSF=7A@mail.gmail.com>
Subject: Re: [x86/mm/pat] 8d04a5f97a: phoronix-test-suite.glmark2.0.score
 -23.7% regression
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contents of /sys/kernel/debug/x86/pat_memtype_list on master
(32ef9553635ab1236c33951a8bd9b5af1c3b1646) where performance is
degraded:

PAT memtype list:
write-back @ 0x55ba4000-0x55ba5000
write-back @ 0x5e88c000-0x5e8b5000
write-back @ 0x5e8b4000-0x5e8b5000
write-back @ 0x5e8b4000-0x5e8b8000
write-back @ 0x5e8b7000-0x5e8bb000
write-back @ 0x5e8ba000-0x5e8bc000
write-back @ 0x5e8bb000-0x5e8be000
write-back @ 0x5e8bd000-0x5e8bf000
write-back @ 0x5e8be000-0x5e8c2000
write-back @ 0x5ef3c000-0x5ef3d000
write-back @ 0x5ef6c000-0x5ef6d000
write-back @ 0x5ef6f000-0x5ef70000
write-back @ 0x5ef72000-0x5ef73000
write-back @ 0x5f5b3000-0x5f5b5000
uncached-minus @ 0xe3f00000-0xe3f10000
uncached-minus @ 0xec000000-0xec040000
uncached-minus @ 0xec002000-0xec003000
uncached-minus @ 0xec110000-0xec111000
uncached-minus @ 0xec200000-0xec240000
uncached-minus @ 0xec260000-0xec264000
uncached-minus @ 0xec300000-0xec320000
uncached-minus @ 0xec326000-0xec327000
uncached-minus @ 0xf0000000-0xf8000000
uncached-minus @ 0xf0000000-0xf0001000
uncached-minus @ 0xfdc43000-0xfdc44000
uncached-minus @ 0xfe000000-0xfe001000
uncached-minus @ 0xfed00000-0xfed01000
uncached-minus @ 0xfed10000-0xfed16000
uncached-minus @ 0xfed90000-0xfed91000
uncached-minus @ 0x2000000000-0x2100000000
uncached-minus @ 0x2000000000-0x2100000000
uncached-minus @ 0x2100000000-0x2100001000
uncached-minus @ 0x2100001000-0x2100002000
uncached-minus @ 0x2ffff10000-0x2ffff20000
uncached-minus @ 0x2ffff20000-0x2ffff24000

Contents of /sys/kernel/debug/x86/pat_memtype_list after reverting
7f264dab5b60, 511aaca834fe, 6a9930b1c50d, 8d04a5f97a5f (in that order)
which restores the performance:

PAT memtype list:
write-back @ 0x55ba4000-0x55ba5000
write-back @ 0x5e88c000-0x5e8b5000
write-back @ 0x5e8b4000-0x5e8b8000
write-back @ 0x5e8b4000-0x5e8b5000
write-back @ 0x5e8b7000-0x5e8bb000
write-back @ 0x5e8ba000-0x5e8bc000
write-back @ 0x5e8bb000-0x5e8be000
write-back @ 0x5e8bd000-0x5e8bf000
write-back @ 0x5e8be000-0x5e8c2000
write-back @ 0x5ef3c000-0x5ef3d000
write-back @ 0x5ef6c000-0x5ef6d000
write-back @ 0x5ef6f000-0x5ef70000
write-back @ 0x5ef72000-0x5ef73000
write-back @ 0x5f5b3000-0x5f5b5000
uncached-minus @ 0xe3f00000-0xe3f10000
uncached-minus @ 0xec000000-0xec040000
uncached-minus @ 0xec002000-0xec003000
uncached-minus @ 0xec110000-0xec111000
uncached-minus @ 0xec200000-0xec240000
uncached-minus @ 0xec260000-0xec264000
uncached-minus @ 0xec300000-0xec320000
uncached-minus @ 0xec326000-0xec327000
uncached-minus @ 0xf0000000-0xf0001000
uncached-minus @ 0xf0000000-0xf8000000
uncached-minus @ 0xfdc43000-0xfdc44000
uncached-minus @ 0xfe000000-0xfe001000
uncached-minus @ 0xfed00000-0xfed01000
uncached-minus @ 0xfed10000-0xfed16000
uncached-minus @ 0xfed90000-0xfed91000
write-combining @ 0x2000000000-0x2100000000
write-combining @ 0x2000000000-0x2100000000
uncached-minus @ 0x2100000000-0x2100001000
uncached-minus @ 0x2100001000-0x2100002000
uncached-minus @ 0x2ffff10000-0x2ffff20000
uncached-minus @ 0x2ffff20000-0x2ffff24000

Hope this helps (if you need the contents from commits exactly
8d04a5f97a5f and 8d04a5f97a5f~1, I can provide it, but it will take
more time).

Best regards,
Mariusz Ceier

On Sat, 30 Nov 2019 at 21:31, Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Sat, 30 Nov 2019, Mariusz Ceier wrote:
>
> >I can also confirm this - just bisected framebuffer rendering
> >performance regression on amdgpu and
> >8d04a5f97a5fa9d7afdf46eda3a5ceaa973a1bcc is the first bad commit
> >(leading to drop from around 260-300fps to about 60fps in CS:GO on
> >Fury X).
>
> This is a third report now. Could you please provide the contents
> of the following file, before and after the offending commit.
>
>         /sys/kernel/debug/x86/pat_memtype_list
>
> This will show any attribute differences in the tree, which is likely
> the culprit.
>
> Thanks,
> Davidlohr
