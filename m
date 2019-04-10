Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F2CC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C4A20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlpkLDrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfDJAZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:25:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45847 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfDJAZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:25:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so255169pfi.12;
        Tue, 09 Apr 2019 17:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=3usq5KjeUgQiAoHSoX5yN+FzJN9TRjXsFOl3RQmWgzw=;
        b=TlpkLDrrFEgwCc9S3ddKYGxOrdXAAzeIGnQ7OkRxXrlUcdxdCTH8mETt3dss13wPWK
         ECEpW/V6yg7Xk7eIupqjG2hgSfLR2zUKe5agM4gCQbSmvRRfaZMPrxKPV9UgmdElmo7M
         at1JOTWLvuEXA6yNbEDxBd4IIB4mEGRFdRGhUZ6WPQGHfLNqiXbpz8dHb+u4qrZGhnfL
         ZNJTx1aTkwamECKH4xQVcwr2eXeyr4Tu2TWCcfNG8bEkF55efCuvP6o+5LYG24QdjpDv
         580qMzqhZpJd5cZuDmSDaxArXA6LbCBBc46VCP/Dma4m+wLAYv4ogOcssasMVRcgcZwD
         JLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=3usq5KjeUgQiAoHSoX5yN+FzJN9TRjXsFOl3RQmWgzw=;
        b=qaIkeo3GLu9afCQiqXUmKeTaRKX2omyxRj/xx9jPazAQMK2upN+wYwbS2RWgG8LCOm
         2YeLkhGyEvDNjebuB7YwEEHSIrw/WTGpFRExLpEDNZWDDqcmRq2vTBZafEPeXrwbTIN0
         LWDWJEBcu176yHX6OBC8kfqaGMbTjqdUsvChowphfO4olUly8aqG7KtWaysFuUoUY/uL
         Vbo8zbFdOpIR7we9xBFdpE04+goEFkctSriVQJBa5AUdjKGcwCK0pNlfpFBRCc5rjwEo
         lwsqlVpWpWwZZxiF5nsMQJ98epsf2kT3/auhcb1Q/heYLFmpujepBwc+COaPxu17tR3G
         L4eQ==
X-Gm-Message-State: APjAAAULfmk8eC9GbSUIcHu0lV/jme42ReZxatirkI06FL+decCvd6A9
        nQ/MVZxKasqby/wAzRpJse2EcRWKbas=
X-Google-Smtp-Source: APXvYqzMuLc7/0KEzpNjHRcfxAoNFPLejoKPoLoxqR/FIR3ra1DU2mMTC8SetXmAIRmF8jk5JIC4Vg==
X-Received: by 2002:a65:51c9:: with SMTP id i9mr37939014pgq.187.1554855929571;
        Tue, 09 Apr 2019 17:25:29 -0700 (PDT)
Received: from localhost ([193.114.109.175])
        by smtp.gmail.com with ESMTPSA id 17sm79301491pfw.65.2019.04.09.17.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 17:25:28 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:25:20 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 17/21] drivers: Remove explicit invocations of mmiowb()
To:     Will Deacon <will.deacon@arm.com>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Luck <tony.luck@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20190405135936.7266-1-will.deacon@arm.com>
        <20190405135936.7266-18-will.deacon@arm.com>
        <CAHk-=wj6ymuXDS1Azr4fFJC7Z77zOfN5vaKZjDzUA4izvULWXg@mail.gmail.com>
        <1554798941.svmfd0sejb.astroid@bobo.none>
        <20190409134616.GD2990@fuggles.cambridge.arm.com>
In-Reply-To: <20190409134616.GD2990@fuggles.cambridge.arm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1554855359.817ryayv8z.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon's on April 9, 2019 11:46 pm:
> Hi Nick,
>=20
> On Tue, Apr 09, 2019 at 07:00:52PM +1000, Nicholas Piggin wrote:
>> Linus Torvalds's on April 6, 2019 1:50 am:
>> > On Fri, Apr 5, 2019 at 4:01 AM Will Deacon <will.deacon@arm.com> wrote=
:
>> >>
>> >> mmiowb() is now implied by spin_unlock() on architectures that requir=
e
>> >> it, so there is no reason to call it from driver code. This patch was
>> >> generated using coccinelle:
>> >>
>> >>         @mmiowb@
>> >>         @@
>> >>         - mmiowb();
>> >=20
>> > So I love the patch series, and think we should just do it, but I do
>> > wonder if some of the drivers involved end up relying on memory
>> > ordering things (store_release -> load_aquire) and IO ordering rather
>> > than using locking...
>>=20
>> Hopefully the convention that smp_ prefix does not work for MMIO
>> ordering helps there. Drivers relying on that would be broken today
>> on powerpc, at least.
>>=20
>> > Wouldn't such use now be broken on ia64 SN platforms? Do we care?
>>=20
>> Hopefully not too much, what changed since last thread? :)
>>=20
>> > So it might be worth noting that a lot of the mmiowb()s here weren't
>> > paired with spin_unlock?
>>=20
>> I repeat myself, but the correct change is for ia64 to #define wmb to
>> mmiowb, then nothing is silently broken, nothing has to be noted, and=20
>> nobody has to care. The ia64/sn2 platform will run a little slower=20
>> that's all.
>=20
> That's certainly something for the ia64 maintainers to consider, if they
> care about this behaviour. I still have hope that we'll drop ia64 in the
> near future :)

Well we don't need to for this reason, at least. Wouldn't cost
architecture independent code anything.

I don't have much opinion about it, but Itaniums of course are still
being sold and the latest chip released in 2017. The last Itanium
Altix seems more than 10 years old though so it might be reasonable=20
to remove sn2 (if it's causing a big headache).

>=20
>> But deliberately breaking sn2 I guess is implicitly acknowledging the=20
>> same end result that I wanted, so fine.
>>=20
>> I think it might be an idea to remove all the mmiowb() that obviously
>> come before spin_unlock in one big patch, but then submit the rest=20
>> individually to driver maintainers. I could do that rather than ask
>> more work from Will, if he and you agree.
>=20
> That's an option, I suppose, but I'd much rather just kill off mmiowb() i=
n
> one fell swoop and be done with it. I've added the following message to
> the commit of the coccinelle patch so any breakage should be easily
> rectified:
>=20
>  | NOTE: mmiowb() has only ever guaranteed ordering in conjunction with
>  | spin_unlock(). However, pairing each mmiowb() removal in this patch
>  | with the corresponding call to spin_unlock() is not at all trivial,
>  | so there is a small chance that this change may regress any drivers
>  | incorrectly relying on mmiowb() to order MMIO writes between CPUs usin=
g
>  | lock-free synchronisation. If you've ended up bisecting to this commit=
,
>  | you can reintroduce the mmiowb() calls using wmb() instead, which shou=
ld
>  | restore the old behaviour on all architectures other than some esoteri=
c
>  | ia64 systems.
>=20
> That way we don't have to worry about the long tail of commits removing
> undocumented, dangling barriers.
>=20
> It's not like we're losing the information about where the mmiowb()s used=
 to
> be, so it should be easy to address any fallout (but I'm not really expec=
ting
> anything significant, to be honest with you).

Well if you feel strongly about it I don't object.

Thanks,
Nick

=
