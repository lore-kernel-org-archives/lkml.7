Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7532BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9AC20856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566952270;
	bh=BR0pZLbQIT1rTcthV11Ydo8XbtZWD3t67vobTnuBzu0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sDDdQiefy5HBY1xYoS4jGJev27700N40rwSQeooztn95mlVTgkwWTZ8YPVdEDmIGY
	 2GAcQfa1yBESpF8fj6FEaUwaTBaKG0iBbdSdVZ+wf4TH8Ogfra5uRK12uRf4AJ0l6R
	 9daaaV4H5dv0nrjZydapAWDrn6CNYfUanMPpkoiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfH1AbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 20:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfH1AbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 20:31:09 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A515217F5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566952268;
        bh=BR0pZLbQIT1rTcthV11Ydo8XbtZWD3t67vobTnuBzu0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pj+j/LXJ0tQcVtx3+fCSns1B/tDuOvyTNL03Vgwea46NOP8FvNR56N/O8gNQvGm6s
         LEyRZAW7UwYHiYpzzVC3lYqkiRAq44I8T1ZSgTZoY1dNIqRRcI6VpOGiuHWav5l7bl
         +vn/Vt5j0PSkGUe9VSPrSt174GYkwVFGWlTVJB3M=
Received: by mail-wm1-f43.google.com with SMTP id o184so88270wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 17:31:08 -0700 (PDT)
X-Gm-Message-State: APjAAAVeiZaZLMkUptl7UTT0LJ3fap1TZOcltPyKvIfX6cfs8Syh4MMT
        UsBXJEhmGOrVEa//yNhaeYdJupslZjSj4JyGcygKmg==
X-Google-Smtp-Source: APXvYqx6jri1APx4Odp/h8HwgdNltfyTzxQiffJV8pfyO4S3HL5FXexfoDSQoQi6iRENWzHetOB6M+NOfVcpRE1aTfI=
X-Received: by 2002:a05:600c:22d7:: with SMTP id 23mr1161014wmg.0.1566952266642;
 Tue, 27 Aug 2019 17:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190823225248.15597-1-namit@vmware.com> <20190823225248.15597-3-namit@vmware.com>
 <CALCETrX91RqYsetbTjfrsMHH8LhTW=YMPuatHuo0bdTJeejP=Q@mail.gmail.com> <154B90AD-7EC3-4B86-8061-D737A948A77C@vmware.com>
In-Reply-To: <154B90AD-7EC3-4B86-8061-D737A948A77C@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 27 Aug 2019 17:30:55 -0700
X-Gmail-Original-Message-ID: <CALCETrVTErOur1vkSp-5KDmHRXAdSCRjRmbsvQ44TFpqcx36GA@mail.gmail.com>
Message-ID: <CALCETrVTErOur1vkSp-5KDmHRXAdSCRjRmbsvQ44TFpqcx36GA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] x86/mm/tlb: Defer PTI flushes
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 4:55 PM Nadav Amit <namit@vmware.com> wrote:
>
> > On Aug 27, 2019, at 4:13 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Fri, Aug 23, 2019 at 11:13 PM Nadav Amit <namit@vmware.com> wrote:
> >> INVPCID is considerably slower than INVLPG of a single PTE. Using it to
> >> flush the user page-tables when PTI is enabled therefore introduces
> >> significant overhead.
> >>
> >> Instead, unless page-tables are released, it is possible to defer the
> >> flushing of the user page-tables until the time the code returns to
> >> userspace. These page tables are not in use, so deferring them is not a
> >> security hazard.
> >
> > I agree and, in fact, I argued against ever using INVPCID in the
> > original PTI code.
> >
> > However, I don't see what freeing page tables has to do with this.  If
> > the CPU can actually do speculative page walks based on the contents
> > of non-current-PCID TLB entries, then we have major problems, since we
> > don't actively flush the TLB for non-running mms at all.
>
> That was not my concern.
>
> >
> > I suppose that, if we free a page table, then we can't activate the
> > PCID by writing to CR3 before flushing things.  But we can still defer
> > the flush and just set the flush bit when we write to CR3.
>
> This was my concern. I can change the behavior so the code would flush the
> whole TLB instead. I just tried not to change the existing behavior too
> much.
>

We do this anyway if we don't have INVPCID_SINGLE, so it doesn't seem
so bad to also do it if there's a freed page table.
