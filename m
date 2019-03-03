Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E188FC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 03:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44B320835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 03:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1bjee5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfCCDep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 22:34:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42250 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfCCDeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 22:34:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id v11so865139plg.9;
        Sat, 02 Mar 2019 19:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=FiNLB4MSlMbU79uzU9NcVokWXT1msFREHso0/X4GZWo=;
        b=F1bjee5rNg7+aEt7hCX1oRiY9hhRov9XEXL1ka/uFLIVc05VnQuHboL31xbGviJUjb
         9xtmZpNQ/5F5lVdFMPbHZmxfDQnTkHp1YlSIwKQgVXbMtLyG+blRJaWWode5ULMsEU4f
         qdNf3To7Kudziu2I971u9geGVphyuj2Gd4EMvsW7eZrsIIMn1M0wG6UHZmKxI1CTDLDa
         6+25muWvV12/6tqrA1fvItrKB0HnBs10GqTq2hLAhEq7RFaaATien/01qZLdCYK0cj1O
         PXJkQMzhbvQ7S0sGtS+J0tWGq5kjebJjoo9rnB+ya5c5HXPnNtdw4/GEJ5FzlnEPkFM3
         MxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=FiNLB4MSlMbU79uzU9NcVokWXT1msFREHso0/X4GZWo=;
        b=OovoT1/kVy8j++8SGdbX/e+rHiub387anigv/g7tWiPrclzDcXLHeUFGFPCd4ZBZEB
         GLIaZ/TDc3Sys/upbYD/RPMok/ePAu0cdd+c/QJZbXULkro1hZlv4aFHKqy3vHNrgzrx
         nln1uHVVSFGcFlPpJyHfl8ERJ8Lr4EOsozVutQNZIKyQ0XRmN1/jNOIDub060nmC35sP
         uIx8YLAoAV9RB55gQ4RvIT5JMMB+oQhdK9nY3pq0ahLGOMyAPdHsfNpP907DVL3Njl6R
         mLuGUwgqQ0BPcx6qq01GbE3585nrXMZ7DAtDt36Usk/iRpjPjytYRiRTP7aXx5UrGLTG
         rBBQ==
X-Gm-Message-State: APjAAAW9hVi8hQHmbzqBTdyTceqC1Naqrzug4wyhH9grF/6rAfhokWhb
        7XbZam6SXII1kJnDE36Vp9Q=
X-Google-Smtp-Source: APXvYqy0dyCPOs9+pZMK558ehgTg6OqYDik1AIRNT9KjbxiNTEvg5WEn2GO1zYW7LiaUPzguOfAhlA==
X-Received: by 2002:a17:902:9307:: with SMTP id bc7mr13459270plb.234.1551584083735;
        Sat, 02 Mar 2019 19:34:43 -0800 (PST)
Received: from localhost (193-116-74-175.tpgi.com.au. [193.116.74.175])
        by smtp.gmail.com with ESMTPSA id u28sm3571864pgn.32.2019.03.02.19.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 19:34:42 -0800 (PST)
Date:   Sun, 03 Mar 2019 13:34:36 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20190301140348.25175-1-will.deacon@arm.com>
        <20190301140348.25175-2-will.deacon@arm.com>
        <1551575210.6lwpiqtg5k.astroid@bobo.none>
        <CAHk-=whxaYGTmHyoWeegL=ihHMDW_FJehUJVN_nP++Su=foL+g@mail.gmail.com>
In-Reply-To: <CAHk-=whxaYGTmHyoWeegL=ihHMDW_FJehUJVN_nP++Su=foL+g@mail.gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1551583190.duzqnmfnvg.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds's on March 3, 2019 12:18 pm:
> On Sat, Mar 2, 2019 at 5:43 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> Is there a reason to call this "mmiowb"? We already have wmb that
>> orders cacheable stores vs mmio stores don't we?
>=20
> Sadly no it doesn't. Not on ia64, and people tried to make that the
> new rule because of the platform breakage on what some people thought
> would be a major platform.

Let me try this again, because I was babbling a train of thought=20
continuing from my past mails on the subject.

  Kill mmiowb with fire.

It was added for a niche platform that hasn't been produced for 10
years for a CPU ISA that is no longer being developed. Let's make mb/wmb
great again (aka actually possible for normal people to understand).

If something comes along again that reorders mmios from different CPUs=20
in the IO controller like the Altix did, they implement wmb the slow and=20
correct way. They can add a new faster primitive for the few devices=20
they care about in the couple of perf critical places that matter.

It doesn't have to be done all at once with this series, obviously this=20
is a big improvement on its own. But why perpetuate the nomenclature
and concept for new code added now?=20

Thanks,
Nick

=
