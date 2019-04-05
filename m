Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9A4C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C0A2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554479758;
	bh=GuaWJlDNN7rZkiSlVh62PpMDS+k2sbuA4o9EVrToluI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TLj6JQErYD/d8YgE4KGQzhxOnNHSeHcom9Mf1pX2ndvXla3Gm0QaEZ8EpATgVrxMO
	 8WdnNxvQUSLiDQ4KMP0AMlLGmbw0QAwJWkLydIPwqnngxmhQ7UdW7OIQqMnKoJPlvv
	 XUN7Oe198nUGBvHKF2BATpC86jXYjAU103SpZTq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbfDEPz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:55:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38584 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDEPz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:55:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id a6so4751341lfl.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 08:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0sgV1Ta6KW4gkaKnRgdnFjKpa8TUf28pD3hX5iYNyDk=;
        b=evFMsQXvE5hgzMkoq0/fkUyWeJ7JqUTvigqv1wPcfg9bkAAsjCZs3lOnlWgDuNGiZ+
         TXcHSv4tHFKX+Q4HTVL/sYfm0R4u0nlL0RfIGwPCgjqGq+4qDQTC6IG6tdd7sqYaWCrX
         K2vC4abe+sp0I40q9nQeTIfrt8ZSiMjL+xRTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0sgV1Ta6KW4gkaKnRgdnFjKpa8TUf28pD3hX5iYNyDk=;
        b=W176pTqsEidNBZ3rfRMJbaCC5GsSsAjdEpJZSni+hEHGypemx1tLIN5guuK3R6+3+J
         PfzW14yBVUUH+3mRumS7cgyH7J584/zrmHhBcIBXEWc88BndjTg2UU/jkuc4r2pcoM5F
         zyMvJLZBQUq2orrSaAbUsmgdujmgwsDyZFZ6TOL5f4CxKDB3FQA6y3KyxK/xqruGhdRq
         3HLGRnE5kzbGFEIUa/audvTRtkYi4ScASBMqj0ItWPtnRajlUbU1j9HK2uYyOdHbcIeT
         EEOdH3gQnanIMM1c7kQomabHLC33lt1YJqTZh8CDQWfqwpv3JA/lhUOAzCddeL2o2eb3
         ktlA==
X-Gm-Message-State: APjAAAXxvqu+XCTCgBf1gCPMkbbWi1cUfP9HfESPTkUBrCXW1wnIWOmC
        RimSLJCPmSKHbJjyzBI6RucOGMs4GqI=
X-Google-Smtp-Source: APXvYqzzet3R24lh4xSxHF26ijLDAM1iEu2E31GHp+l/zrcDS63VQRWd7MixJl4nQLw5roljcP+vyg==
X-Received: by 2002:ac2:44c2:: with SMTP id d2mr1118668lfm.64.1554479754405;
        Fri, 05 Apr 2019 08:55:54 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id k129sm344806lfg.21.2019.04.05.08.55.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 08:55:54 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id t4so5719968ljc.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 08:55:53 -0700 (PDT)
X-Received: by 2002:a2e:8108:: with SMTP id d8mr7368902ljg.57.1554479753278;
 Fri, 05 Apr 2019 08:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190405135936.7266-1-will.deacon@arm.com>
In-Reply-To: <20190405135936.7266-1-will.deacon@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Apr 2019 05:55:37 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiarqZVH52VuKDiPk7Jqf1H-znf-NMoGkKnM7H08VN5fg@mail.gmail.com>
Message-ID: <CAHk-=wiarqZVH52VuKDiPk7Jqf1H-znf-NMoGkKnM7H08VN5fg@mail.gmail.com>
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

On Fri, Apr 5, 2019 at 3:59 AM Will Deacon <will.deacon@arm.com> wrote:
>
> I've also pushed this series out here:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/mmiowb
>
> and I would like to get it into -next once the first patch has been acked.

Ack on it all.

With the afore-mentioned slight worry about non-spinlocked IO
ordering, but I _think_ it's purely limited to ia64 and wmb() and
friends should work elsewhere?

Or did I miss something? I think the ia64() mb/rmb/wmb stuff only
works on normal memory on ia64.

      Linus
