Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A95C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A8C216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557865647;
	bh=DzocNwMVi5SAbWmRTGaV0IjOHUG4WEPp/2+M4ioUzgA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W6WZfA15giDYKzOB1vQGNDBe6h7kPbve32815oYhkCKhyp8hlgvq2ymVvl1/k2OX8
	 //rXvSfaLGEvoEcy8IvYXGZTuYZnOI36X44ZldhWOX6o/AdEsErG4x95f+X2a6YXYs
	 b5CX4zEvBpfrv8x1RpbbbEVdbWIpnOAUdtmlge4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfENU10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:27:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfENU1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:27:25 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86FD62184C
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 20:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557865644;
        bh=DzocNwMVi5SAbWmRTGaV0IjOHUG4WEPp/2+M4ioUzgA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H7eAox2hSzIAWyeZKe5RK68sRQU/pkz/MU1gJXfJmQJwc8b9Y2i+bnIi6WWU9vdvc
         FSSl9o0Ds5GeA/th5W2//Zn9ZeQyIyYwOhETDLySSfAJFdoU9sT0kQQWo4hIcLuOnO
         JwlV8WuVYZF14qijOoItC6HIVEGbP7RGFDKPU0Uw=
Received: by mail-wm1-f46.google.com with SMTP id j187so3170558wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 13:27:24 -0700 (PDT)
X-Gm-Message-State: APjAAAXs0jfdnYXQUCOEqoCSwm+APzEeYEqR62wy+TH8XqEi7Qd4jrtB
        kJMyRQ9baK14OhVOrngeyyqQ0Wry++FtmXFCmPTNCQ==
X-Google-Smtp-Source: APXvYqylF1zWRPSScsXn1HT0hufRGNU6xmts2UUV+2BP0SCGJO/kSUqZv0VIS1G4vkVbMaznNIUpjuvdLJlKdGXqL9Y=
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr21736258wmh.32.1557865643024;
 Tue, 14 May 2019 13:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <1557758315-12667-1-git-send-email-alexandre.chartre@oracle.com>
 <1557758315-12667-19-git-send-email-alexandre.chartre@oracle.com>
 <CALCETrWUKZv=wdcnYjLrHDakamMBrJv48wp2XBxZsEmzuearRQ@mail.gmail.com>
 <20190514070941.GE2589@hirez.programming.kicks-ass.net> <b8487de1-83a8-2761-f4a6-26c583eba083@oracle.com>
 <B447B6E8-8CEF-46FF-9967-DFB2E00E55DB@amacapital.net> <4e7d52d7-d4d2-3008-b967-c40676ed15d2@oracle.com>
 <CALCETrXtwksWniEjiWKgZWZAyYLDipuq+sQ449OvDKehJ3D-fg@mail.gmail.com>
 <e5fedad9-4607-0aa4-297e-398c0e34ae2b@oracle.com> <20190514170522.GW2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190514170522.GW2623@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 14 May 2019 13:27:11 -0700
X-Gmail-Original-Message-ID: <CALCETrVRBC6DY9QXwksqLYP+LWD1PDw8nQyE03PbytDQ4+=LXQ@mail.gmail.com>
Message-ID: <CALCETrVRBC6DY9QXwksqLYP+LWD1PDw8nQyE03PbytDQ4+=LXQ@mail.gmail.com>
Subject: Re: [RFC KVM 18/27] kvm/isolation: function to copy page table
 entries for percpu buffer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kvm list <kvm@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Jonathan Adams <jwadams@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 10:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, May 14, 2019 at 06:24:48PM +0200, Alexandre Chartre wrote:
> > On 5/14/19 5:23 PM, Andy Lutomirski wrote:
>
> > > How important is the ability to enable IRQs while running with the KVM
> > > page tables?
> > >
> >
> > I can't say, I would need to check but we probably need IRQs at least for
> > some timers. Sounds like you would really prefer IRQs to be disabled.
> >
>
> I think what amluto is getting at, is:
>
> again:
>         local_irq_disable();
>         switch_to_kvm_mm();
>         /* do very little -- (A) */
>         VMEnter()
>
>                 /* runs as guest */
>
>         /* IRQ happens */
>         WMExit()
>         /* inspect exit raisin */
>         if (/* IRQ pending */) {
>                 switch_from_kvm_mm();
>                 local_irq_restore();
>                 goto again;
>         }
>

What I'm getting at is that running the kernel without mapping the
whole kernel is a horrible, horrible thing to do.  The less code we
can run like that, the better.
