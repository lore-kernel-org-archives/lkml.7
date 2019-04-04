Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F386BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06422171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554388012;
	bh=dk2qmWgiNkfkIYYpu5YpBCLOctMDW7iggp7CnVaxsy0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hUixEqRDTie8LmOrevr5QO4AWmSFvWrjsyC3weM8vd09nZPZvGc7WbuidvE66BEhS
	 grc5Yvx73gdjVAOp+jHU7ZmssvyhkmMH+LGgzFUi4UDgulE8+P/rYf6S3ZtBnwJv1D
	 ddOWs9tTW99wD7VaNuZveX4fuhT3hxCAwNU3hyAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfDDO0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfDDO0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:26:51 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B12232171F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2019 14:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554388011;
        bh=dk2qmWgiNkfkIYYpu5YpBCLOctMDW7iggp7CnVaxsy0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n5k37WOkQbrTMs0odRQZ1tQoz9QBmn0f0rcXfEF6cVWZs2OgDiQ6Tf+l9MJ6Z/ZtM
         CD2N4sjqR3hpSPf+8ed1/d1KzvJW+oULY0nYNDI6te4qLnAfpbKvsEeutx4J9lhfz0
         KFgXN8+d3T8ctf4gExApZH4m26rWqUxRBAmhnWVM=
Received: by mail-wr1-f49.google.com with SMTP id t17so4002360wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 07:26:50 -0700 (PDT)
X-Gm-Message-State: APjAAAXWnj9mkSXE1rokdNZ9kyrmIPVfbcXyCi5rvfGxlPJhxaGXLmII
        hIFRsn7TEsUK7oyqPdKeh1bYf6+FYxar/4YRrbcpMA==
X-Google-Smtp-Source: APXvYqzreHuPNdd6Y0Dp2oqbPEHW9nHxGgSU/Mx9KGrvD6HEEnzsPwNv67AzasQ8yW+CkOt/jCFYe6cBPn7Vlt6bn+M=
X-Received: by 2002:a5d:4606:: with SMTP id t6mr4321997wrq.43.1554388009315;
 Thu, 04 Apr 2019 07:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190403164156.19645-1-bigeasy@linutronix.de> <c4af28470a4347f5aa222a99471c939a@AcuMS.aculab.com>
 <20190404141409.upfk5z4re3pyvxzn@linutronix.de>
In-Reply-To: <20190404141409.upfk5z4re3pyvxzn@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 4 Apr 2019 07:26:37 -0700
X-Gmail-Original-Message-ID: <CALCETrU4hSC20sExsgPnhkUOfS+kd-hMHK7_amq_C5duNw33cg@mail.gmail.com>
Message-ID: <CALCETrU4hSC20sExsgPnhkUOfS+kd-hMHK7_amq_C5duNw33cg@mail.gmail.com>
Subject: Re: [PATCH v9 00/27] x86: load FPU registers on return to userland
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 7:14 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2019-04-04 14:01:43 [+0000], David Laight wrote:
> > From: Sebastian Andrzej Siewior
> > > Sent: 03 April 2019 17:41
> > ...
> > > To access the FPU registers in kernel we need:
> > > - disable preemption to avoid that the scheduler switches tasks. By
> > >   doing so it would set TIF_NEED_FPU_LOAD and the FPU registers would be
> > >   not valid.
> > > - disable BH because the softirq might use kernel_fpu_begin() and then
> > >   set TIF_NEED_FPU_LOAD instead loading the FPU registers on completion.
> >
> > Is there a possible optimisation here for kernel threads?
> > Since there is no 'user FP state' the 'kernel FP state' can
> > be saved by a task switch or softirq.
>
> There is no such thing as "kernel FP state" that is saved.
>

I think that David was asking whether we could make kernel_fpu_begin()
regions sometimes be preemptible.  The answer is presumably yes, but I
think that should be a separate effort, and it should be justified
with improved performance above and beyond what we get with Jason's
simd_get() stuff.
