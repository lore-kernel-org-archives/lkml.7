Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFEECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456B92089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571650407;
	bh=Ic33NsiY5PhmNhC9qohdkoS2YMou4rOZtpGb9RxHICw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XDY54Ja03fx2/MqqFqrl16VVCW2Duhk1Dd+gwPHCIta2QsTLGPoyzHKdOhNjGLu7t
	 IfeD3ZHM2QD8Mq5y8+ZsVitxiyBrRPisEOKU43S+JYGPA9rsLO4uF4FU4PgAtcm4Q7
	 mmKevglYaUZgLU6dan48d20LyqdC19CJKiKhguEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfJUJdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:33:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38351 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfJUJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:33:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so12012246wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KNp9/6Fc8QVEU83S7ncGj8CBqk2rcFyU35oR9K4OPTw=;
        b=nvEGyDl5C2CloKqjCcXdBO+fRb9fvRz5H9Ws7Yd2LWvJtym/V+1dMN7lcgEHKqBoYh
         i24oHdb5xVvtE97Z6KxqSt/P9m4qcXyyHn+FRPgntkjfWm5f1fooF2o9hY7C2XMqNJaX
         AFcKfTTYAaX7dICWAtwC2KxAlMsjWofFBOuVh004AZjBXqekjAszSr/0CnIXTXew4TnH
         hb0gYTC0Dxna3F1sCwAvpVEIevaAMdMq51v84+OCDgnMayxn8Q8eHViW4WgCDT8yK96o
         kXtl/unbb0YadyncZdK7Kb2ppiZKg7NS+Do1mtlKL6np0Eb/yhQ6KyRrcdpTOdONjKUV
         HHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KNp9/6Fc8QVEU83S7ncGj8CBqk2rcFyU35oR9K4OPTw=;
        b=WSD8LfqP2Zo1l+JRaVdtE+Z18dDSInCwJU4aouM3y3Es1Mt9TSHzkCxSnPLAPCyCm8
         0goDq+0Lf3Jbtr/VEmlSfYzuF2X76me5cxMnP3MOxStQBUUMy6Tx9ylDbYqydG8PLzRw
         /JN/18DYZxXv68z+F8uHnnGfAK5U3sJ+J2QTpYpkunOk+OlcN4Ajl98b0S0c+hhvj2QC
         Z9OszDDrLD2yv4g90ALdTG9fHexs7OZdFzSLvNWR87/cIg/hepDlmM9NS9UnlU1/XG5t
         KbUFaksRHeIdhfthdUKA1nXGYyDCI4F6AwzgKkMoQulsxgW8IXHO2pEVw8w8NurSy5/d
         y9Zg==
X-Gm-Message-State: APjAAAUBo25D9nHwzis3Njx8ihTuasxQWwhn/MDmcz0y6vMQC+i00cWw
        vJb0OQCYh4aLVyE8zBq27nc=
X-Google-Smtp-Source: APXvYqxiOUCHKi5i5o6nCa/+WD6fgVyPyntQOi3UmfmY7hFpFhcveFs2ECVtO+XNd7WYKeQRhrqN4g==
X-Received: by 2002:a1c:f401:: with SMTP id z1mr17836153wma.66.1571650403024;
        Mon, 21 Oct 2019 02:33:23 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id y186sm17942653wmb.41.2019.10.21.02.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:33:22 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:33:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 10/16] x86/alternative: Shrink text_poke_loc
Message-ID: <20191021093319.GA34106@gmail.com>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.514629541@infradead.org>
 <20191021090104.GB102207@gmail.com>
 <20191021092559.GB1800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021092559.GB1800@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Oct 21, 2019 at 11:01:04AM +0200, Ingo Molnar wrote:
> > 
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Employ the fact that all text must be within a s32 displacement of one
> > > another to shrink the text_poke_loc::addr field. Make it relative to
> > > _stext.
> > > 
> > > This then shrinks struct text_poke_loc to 16 bytes, and consequently
> > > increases TP_VEC_MAX from 170 to 256.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  arch/x86/kernel/alternative.c |   23 ++++++++++++++---------
> > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > > 
> > > --- a/arch/x86/kernel/alternative.c
> > > +++ b/arch/x86/kernel/alternative.c
> > > @@ -937,7 +937,7 @@ static void do_sync_core(void *info)
> > >  }
> > >  
> > >  struct text_poke_loc {
> > > -	void *addr;
> > > +	s32 rel_addr; /* addr := _stext + rel_addr */
> > >  	s32 rel32;
> > >  	u8 opcode;
> > >  	const u8 text[POKE_MAX_OPCODE_SIZE];
> > > @@ -948,13 +948,18 @@ static struct bp_patching_desc {
> > >  	int nr_entries;
> > >  } bp_patching;
> > >  
> > > +static inline void *text_poke_addr(struct text_poke_loc *tp)
> > > +{
> > > +	return _stext + tp->rel_addr;
> > > +}
> > 
> > So won't this complicate the life of the big-address-space gcc model 
> > build patches that for purposes of module randomization are spreading the 
> > kernel and modules all across the 64-bit address space, where they might 
> > not necessarily end up within a ~2GB window?
> > 
> > Nothing upstream yet, but I remember such patches ...
> 
> IIRC what they were doing was allow moving the 2G range further out 
> into the address space, such that absolute addresses no longer fit in 
> u32 (as they do now), but they keep the relative displacement in s32. 
> Otherwise we'll end up with PLT entries all over the place. That is, if 
> we break the s32 displacement, CALL/JMP.d32 will not longer be able to 
> reach any other code and we need intermediate trampolines to help them 
> along, which is pretty shit.

Ok, indeed, that's fair enough.

Thanks,

	Ingo
