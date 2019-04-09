Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E65DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1F520880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4CJUJeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDIJBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:01:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44910 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIJBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:01:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so8915277pgj.11;
        Tue, 09 Apr 2019 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=vsD91g8mDinM6VV7JxJDn3STFQLbWVovEciuqpINWYc=;
        b=E4CJUJeTr0NsTwM+28LRGIWYmjgk/0B/P2+/ykFF2mVZPz052rqvfSAk8O2GcB363z
         zn1hn4i4zKSaEQBkNVheVjFndwrLJtSeAl9xLzs6X9ViKQm2H+hmsbh2dQdH9oAnRDhe
         SuIBYAW3xVdsxqkZt2vos42XWJ9JbOh01BV0pZ87V6pE+j/bCUYAMEdeA8o83tC7seV+
         80LFPZMeqGkrUH0SgXHisFrA0h6uRKfhqdJOX25vRrX8/b0LdHwr/+oT7fUgsCZVs+nI
         PI3TUw5KAuZ11WFPu995fmRDCRGvntp0mD43eQRacaAPmGpVkYmXyGoqvH3f3Xo1QI5B
         y1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=vsD91g8mDinM6VV7JxJDn3STFQLbWVovEciuqpINWYc=;
        b=TvKbHk2DOd+j1Wym9Mno08ZUk2DrvTgmCGRxbXl7690NJ1KXnCfaRQwtEO/2FC7NJD
         Vvko6iM+Qv/rEenpuhooE8t5emMtMWU6oCTPQwQFWu1Mr9p1+DwtLPheSILPumblyUI/
         oRUTCn4eFhR0rT9Vs3TaX/eJ7Y7PoXt6KtIxWYNNDggxOx82XEBigTrT7As59zk8Cu2t
         U4l+9yDpH4M2fWcV9O362+iDQ5TM9FzSt+hoxkl21OwTlIrrb1C7Xptzh3/ZHtVfB9rw
         QS+mtxywFTBsqxcUFNrtd59M5xNFP4FpSt3eZIQI2EYaZGVE+FuSO++jxuiyXkSewci7
         lt7g==
X-Gm-Message-State: APjAAAVd4VFhYF5+YdVUbtzJybrJFcAkenBobcMzMcDNkm5jvyo7e5SV
        ii4UomfgQkWYdYjrcfBygyE=
X-Google-Smtp-Source: APXvYqyfgLwCSjDQ7nrIUfYOpza0EIc82LmOlWWUYirrfJdj6LeN5KGGItHSh3qL17ZRTvzZaKteVQ==
X-Received: by 2002:a62:6985:: with SMTP id e127mr35578138pfc.188.1554800460124;
        Tue, 09 Apr 2019 02:01:00 -0700 (PDT)
Received: from localhost ([58.84.79.14])
        by smtp.gmail.com with ESMTPSA id d11sm35519543pgq.6.2019.04.09.02.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 02:00:59 -0700 (PDT)
Date:   Tue, 09 Apr 2019 19:00:52 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 17/21] drivers: Remove explicit invocations of mmiowb()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>
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
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20190405135936.7266-1-will.deacon@arm.com>
        <20190405135936.7266-18-will.deacon@arm.com>
        <CAHk-=wj6ymuXDS1Azr4fFJC7Z77zOfN5vaKZjDzUA4izvULWXg@mail.gmail.com>
In-Reply-To: <CAHk-=wj6ymuXDS1Azr4fFJC7Z77zOfN5vaKZjDzUA4izvULWXg@mail.gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1554798941.svmfd0sejb.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds's on April 6, 2019 1:50 am:
> On Fri, Apr 5, 2019 at 4:01 AM Will Deacon <will.deacon@arm.com> wrote:
>>
>> mmiowb() is now implied by spin_unlock() on architectures that require
>> it, so there is no reason to call it from driver code. This patch was
>> generated using coccinelle:
>>
>>         @mmiowb@
>>         @@
>>         - mmiowb();
>=20
> So I love the patch series, and think we should just do it, but I do
> wonder if some of the drivers involved end up relying on memory
> ordering things (store_release -> load_aquire) and IO ordering rather
> than using locking...

Hopefully the convention that smp_ prefix does not work for MMIO
ordering helps there. Drivers relying on that would be broken today
on powerpc, at least.

> Wouldn't such use now be broken on ia64 SN platforms? Do we care?

Hopefully not too much, what changed since last thread? :)

> So it might be worth noting that a lot of the mmiowb()s here weren't
> paired with spin_unlock?

I repeat myself, but the correct change is for ia64 to #define wmb to
mmiowb, then nothing is silently broken, nothing has to be noted, and=20
nobody has to care. The ia64/sn2 platform will run a little slower=20
that's all.

But deliberately breaking sn2 I guess is implicitly acknowledging the=20
same end result that I wanted, so fine.

I think it might be an idea to remove all the mmiowb() that obviously
come before spin_unlock in one big patch, but then submit the rest=20
individually to driver maintainers. I could do that rather than ask
more work from Will, if he and you agree.

Thanks,
Nick

=
