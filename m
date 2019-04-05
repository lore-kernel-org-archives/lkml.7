Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21671C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E438B21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554481281;
	bh=Z3tviJih0+15O1Nb6US4Iyl03qQjNm32YQmCCZxfLlA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YcmcVgEvhvU6sY3A2+BgF6aOmzfGe7bD2/D2btnlIcPIlHLnW12kIhhhOcQkmQer5
	 ZxVRbhjvLD4RxDoKgKHe2oRAzB5MtKFF8hkBjdn3O0pbS7gKRuzmt7dwB4bt60639o
	 jHGM7ytccKWr1TNWWGFTv2XDFzNo+tVrBXr2D0pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbfDEQVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:21:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40562 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDEQVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:21:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id a28so4795698lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 09:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdetWNEnisWQAQYmIJGyWPDqSKAMlwQ2iqzDQXP0p+8=;
        b=OMV+xg5lSItr4wLh0Je8qw5ygAbEwUKu/ynLo/l085HP2U14GhMb/TGB+zuQkXYNJ/
         djSrrkUB+7wZDJnaHIAT1X1HdKANsLlrLDuy/A9KmSodkz0rezcErFLnqKFxOW7olOXI
         NrEJypYeTTsyF5GrlopQHDqYh3E53Fou+94X0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdetWNEnisWQAQYmIJGyWPDqSKAMlwQ2iqzDQXP0p+8=;
        b=iuWCWclssd2I/KtUU59LkS4fwFBPhYXVRH0wANKAh+b2lc6/gEzHWS2Gr76zJv0OX3
         T+sI1HnyGZLUyZzXAn6DiDAnbANTlZA2a/qKMjXQ+nvYnps5kLGHNGMYs7Y/avwunn++
         MsjKmohLZ89rJ97wpHg5So+jwRfhQYiM4ZJvg3METlp9HKE4pmEjjj+YI7pZdVe2X7mo
         AROwts+6D7NBRcGI0HVyYCfzkiME77L5eZmgsd55EILHiV/9Qm5h56szNLqF3xAI4FTy
         +jU0HRpSwvqDmZcGm9KmfzWMHCLFl+f+R0VsA9+z8l03eRdLqIPiP/3dFVLawDjwjcV2
         kNkA==
X-Gm-Message-State: APjAAAWfW32HGAnOSBeK/C6WFljlzhA5QaCNiR3NKhLTF0vXqQ52j8z3
        m1lB21IRX4dODd9YSLA6PHtUSI2SQGA=
X-Google-Smtp-Source: APXvYqwRno7Skh663JFG4qKkBiMevhmm9ynXwLRWlCIwhsGoF0EtRlrgk+oDLAqvBu+2PUHlde0prg==
X-Received: by 2002:a19:974f:: with SMTP id z76mr7101316lfd.89.1554481276498;
        Fri, 05 Apr 2019 09:21:16 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id o12sm1326320lfl.66.2019.04.05.09.21.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 09:21:16 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id v14so4863407lfi.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 09:21:16 -0700 (PDT)
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr6977387lfm.14.1554480928669;
 Fri, 05 Apr 2019 09:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190405135936.7266-1-will.deacon@arm.com> <CAHk-=wiarqZVH52VuKDiPk7Jqf1H-znf-NMoGkKnM7H08VN5fg@mail.gmail.com>
 <20190405160919.GA7857@fuggles.cambridge.arm.com>
In-Reply-To: <20190405160919.GA7857@fuggles.cambridge.arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Apr 2019 06:15:12 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiBQwAL5hoLD9-EmCAf1N9CUmUkuj_jJhUCsboNLy-uLw@mail.gmail.com>
Message-ID: <CAHk-=wiBQwAL5hoLD9-EmCAf1N9CUmUkuj_jJhUCsboNLy-uLw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Remove Mysterious Macro Intended to Obscure
 Weird Behaviours (mmiowb())
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 6:09 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > Or did I miss something? I think the ia64() mb/rmb/wmb stuff only
> > works on normal memory on ia64.
>
> I was worried about RISC-V, but actually their wmb() is "fence ow,ow"
> which I think is stronger than their mmiowb() "fence o,w" implementation.

Also with smp_store_release -> smp_load_acquire kind of ordering?

Again, this is not at all a NAK - I think we should do this - just
perhaps a request to add a note to the commit and make people aware of
the issue.

I suspect very few drivers use non-locking serialization to begin with.

                 Linus
