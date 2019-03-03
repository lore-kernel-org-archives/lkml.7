Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7C1C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 10:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DB020836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 10:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxRrUF4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfCCKIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 05:08:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46378 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCCKH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 05:07:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id c17so1095995plz.13;
        Sun, 03 Mar 2019 02:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=8e/W7PnR4rmEtm15we8NhHHmsnEM8GgTneAnV61w9jQ=;
        b=kxRrUF4IXFc2cNMmBduGygMy8rmgtRgHhq+imLV+74jWxe+4VYA6HHem8DntRSWhY/
         nuDj0gUdUgCvxFowpy9t4erHQ43YCj4Nn20PpYKMbbcRA2SkbUG3DP/6XnmklDYWb6Ng
         RB7QN1yq3ism7WAq73j5OP598FgmVwQfvPOwPAUhWLl8Wbzq+vrWPej13zf3BvAzuwDM
         z/7DG/c2Bg7Bewr+wejRdElUGdH8rH7F9zVN9PXklD5jIH33g08Iny7c2ZFxewKzPz9s
         H+JkKEUjGpk4JccZod1SsCA804me68fuxSs8LaR5xIAi91PUWTucUMQDwjYvX/qZuPrK
         5K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=8e/W7PnR4rmEtm15we8NhHHmsnEM8GgTneAnV61w9jQ=;
        b=ha8TRUIK/OpIw9KI0Y0xt7R6SnNrNpIolkb/+Q5Mw1ZN0eCH3RMr4xwqOIZSbNx+2E
         l5rLNnhUSGmdRdAQxOJ9Aog/uBpvIZCiWyW+PUCQUKFu18iqGOsw1bpU68bLxCwlH1Pp
         wSpgD+YWXwBWasE17uF0vAS66gmEcO0P4ZS69P27SeJFrTAahssIcSrlasFoyvi1aXM5
         mukxJakVQ9PFS9SR12y+6h1172CqvufhMphUosNLLucPO8iVkRe/ZDgLlvq0ea243Ig/
         SeCFNMKMPXx/MjmOmRzZjrEGvvxrxERjhDuS7TdKJltHhFEL43QuLdD+L/tr2m4QJBAs
         qJdw==
X-Gm-Message-State: APjAAAWZU6ih7FWSMyEg498Bhu64/XyLAPV8qOeOtM1qqKkazKo1cl6U
        O4whhTklg0rcu4jUPxQxitegB1wM
X-Google-Smtp-Source: APXvYqz/vxB9wvOkLxojSMK8HfAVW+pGJ8jlxEH3eoiDDrsl2UUx8mcmuAb+LCzEzjSCYTTL+xwZwg==
X-Received: by 2002:a17:902:6b4b:: with SMTP id g11mr14273441plt.92.1551607678901;
        Sun, 03 Mar 2019 02:07:58 -0800 (PST)
Received: from localhost (193-116-74-175.tpgi.com.au. [193.116.74.175])
        by smtp.gmail.com with ESMTPSA id 63sm4859744pfy.110.2019.03.03.02.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 02:07:58 -0800 (PST)
Date:   Sun, 03 Mar 2019 20:07:52 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
To:     linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Luck <tony.luck@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20190301140348.25175-1-will.deacon@arm.com>
        <20190301140348.25175-2-will.deacon@arm.com>
        <1551575210.6lwpiqtg5k.astroid@bobo.none>
        <87tvgkia0k.fsf@concordia.ellerman.id.au>
In-Reply-To: <87tvgkia0k.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1551607531.yk1v9azmym.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman's on March 3, 2019 7:26 pm:
> Nicholas Piggin <npiggin@gmail.com> writes:
>> Will Deacon's on March 2, 2019 12:03 am:
>>> In preparation for removing all explicit mmiowb() calls from driver
>>> code, implement a tracking system in asm-generic based loosely on the
>>> PowerPC implementation. This allows architectures with a non-empty
>>> mmiowb() definition to have the barrier automatically inserted in
>>> spin_unlock() following a critical section containing an I/O write.
>>
>> Is there a reason to call this "mmiowb"? We already have wmb that
>> orders cacheable stores vs mmio stores don't we?
>>
>> Yes ia64 "sn2" is broken in that case, but that can be fixed (if
>> anyone really cares about the platform any more). Maybe that's
>> orthogonal to what you're doing here, I just don't like seeing
>> "mmiowb" spread.
>>
>> This series works for spin locks, but you would want a driver to
>> be able to use wmb() to order locks vs mmio when using a bit lock
>> or a mutex or whatever else. Calling your wmb-if-io-is-pending
>> version io_mb_before_unlock() would kind of match with existing
>> patterns.
>>
>>> +static inline void mmiowb_set_pending(void)
>>> +{
>>> +	struct mmiowb_state *ms =3D __mmiowb_state();
>>> +	ms->mmiowb_pending =3D ms->nesting_count;
>>> +}
>>> +
>>> +static inline void mmiowb_spin_lock(void)
>>> +{
>>> +	struct mmiowb_state *ms =3D __mmiowb_state();
>>> +	ms->nesting_count++;
>>> +}
>>> +
>>> +static inline void mmiowb_spin_unlock(void)
>>> +{
>>> +	struct mmiowb_state *ms =3D __mmiowb_state();
>>> +
>>> +	if (unlikely(ms->mmiowb_pending)) {
>>> +		ms->mmiowb_pending =3D 0;
>>> +		mmiowb();
>>> +	}
>>> +
>>> +	ms->nesting_count--;
>>> +}
>>
>> Humour me for a minute and tell me what this algorithm is doing, or
>> what was broken about the powerpc one, which is basically:
>>
>> static inline void mmiowb_set_pending(void)
>> {
>> 	struct mmiowb_state *ms =3D __mmiowb_state();
>> 	ms->mmiowb_pending =3D 1;
>> }
>>
>> static inline void mmiowb_spin_lock(void)
>> {
>> }
>=20
> The current powerpc code clears io_sync in spin_lock().
>=20
> ie, it would be equivalent to:
>=20
> static inline void mmiowb_spin_lock(void)
> {
>  	ms->mmiowb_pending =3D 0;
> }

Ah okay that's what I missed. How about we just not do that?

Thanks,
Nick
=
