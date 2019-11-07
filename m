Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01DCC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F7621D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573156477;
	bh=gZ79QlgmwTrNVhTMflUKKmf3XDqqj/OgstyX6S4H640=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CJWgezQBUraJO7AKYGupyCje3uP5NXD4+gcR6APq7e80EwNUcGc35n143HNuLGGXM
	 JuoVQaMyLQ8H3Yf/ozHPg6Ho4G9UCb1Mpcmv7yFq2C/uBjO6578aVCeBi7RM3COsCe
	 0oprrd7ztMijunL2+neWhLH2Ma3Jka03/A8iQyTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfKGTyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:54:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33244 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKGTyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:54:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id d6so2171217lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 11:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f09xYi4kre4jU/vuVbO7WRxqgZM4qtdhc7Q9mQyA/b8=;
        b=Vxriaxq26/9uuVSPTO0oN0oXS/PWQ0lobhiZjLQmPx3g7HcnMbTkdKtmn+vhoHJAvc
         fVZZaozx51jAKxxQwRJxpN+wWaDp0iPetQNvHSJdAna+NE3bCFMb3S7QK7m6callj2/Y
         A9aKdRHbDjDjksFDQPll4k2E3BWJmTmj/uSDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f09xYi4kre4jU/vuVbO7WRxqgZM4qtdhc7Q9mQyA/b8=;
        b=Cg+91MtBR8ZLIAWGe9NLUzj5Fzet7nZH2FtdIHpwMMSRFhmW2WhimkIqpWhg8NrK0B
         VZULERs5a0iu7HcWA7yIGzpcvCy2inQryZRS6KRf9cqmvjSsrpwwEISyzxSisyM7993P
         i22LRtBkqpKBUfqGR0r4Q+o1RUu/VdIHCsm1ScaTcWU3iMJO92Nb1dXb2CtRtc02vuAx
         EKTgKxCdvWJxTCZ+tRJRaSQfNdnnHF0a+c2b7W/drbFXqwj+KqZHIKgK1UoYUo3cxnD2
         Wr5l/Rp3YQAo8eGEFiT07OkcQIShsOpGTijsupWX0YkEYCalf/LWJ/Vzf/E+SpZoCJ4+
         MKRA==
X-Gm-Message-State: APjAAAVlvTQAEBobj+2RXTMt2ecJjYJb1YtwQGY4GeTtsp1a6iV+uk3v
        G9yDXYt+Cy/tqHwnOmm86WcV4ah4l5Q=
X-Google-Smtp-Source: APXvYqwTu2edGZyB1hQ3VemvZJ8W4cq4hOGjQxXsgRYm2Eg8p+Nnr3QO/Jpvun56hd8xOtRTdBBLTA==
X-Received: by 2002:a19:ec02:: with SMTP id b2mr2743159lfa.121.1573156473368;
        Thu, 07 Nov 2019 11:54:33 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id k19sm1630329ljg.18.2019.11.07.11.54.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 11:54:32 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id g3so3623163ljl.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 11:54:32 -0800 (PST)
X-Received: by 2002:a2e:2c19:: with SMTP id s25mr3777487ljs.26.1573156471860;
 Thu, 07 Nov 2019 11:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20191106193459.581614484@linutronix.de> <20191106202806.241007755@linutronix.de>
 <CAMzpN2juuUyLuQ-tiV7hKZvG4agsHKP=rRAt_V4sZhpZW7cv9g@mail.gmail.com>
In-Reply-To: <CAMzpN2juuUyLuQ-tiV7hKZvG4agsHKP=rRAt_V4sZhpZW7cv9g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Nov 2019 11:54:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGO=+mmEb-sfCsD5mxmL5++gdwkFj_aXcfz1R41MJnEg@mail.gmail.com>
Message-ID: <CAHk-=wiGO=+mmEb-sfCsD5mxmL5++gdwkFj_aXcfz1R41MJnEg@mail.gmail.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage further
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 11:24 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> Here is a different idea:  We already map the TSS virtually in
> cpu_entry_area.  Why not page-align the IO bitmap and remap it to the
> task's bitmap on task switch?  That would avoid all copying on task
> switch.

We map the tss _once_, statically, percpu, without ever changing it,
and then we just (potentially) change a couple of fields in it on
process switch.

Your idea isn't horrible, but it would involve a TLB flush for the
page when the io bitmap changes. Which is almost certainly more
expensive than just copying the bitmap intelligently.

Particularly since I do think that the copy can basically be done
effectively never, assuming there really aren't multiple concurrent
users of ioperm() (and iopl).

               Linus
