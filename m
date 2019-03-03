Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ADDC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 02:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E660820857
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 02:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551580030;
	bh=qY7W1k8ZgdAXDviIqWc5a61NAaydIgWRt9uhjpXOHi0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eRprDdhZ7TjViF726E0LyCK2YDgjL+g9ZhJbYNgNuUVarrggk+yrTm7F0+aKS8Fwt
	 /h6/LrQG7TWZgvDMnJ5I2hPyqV9lMZtpY0UIALz6rZ+JGEpZ+hddyWrhVqCKzksRTZ
	 Y+AezwZMnJymz1PyzxuZrsGasHG80duHoqRsMSjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfCCC1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 21:27:02 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40084 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfCCC1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 21:27:02 -0500
Received: by mail-lf1-f68.google.com with SMTP id a8so1109198lfi.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 18:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiITGj4XkaGGub/d7Ug1l1Bi8lGdm44D8AckuOPQOMo=;
        b=dB4OeNN3+manUdRTA/60lSelHQ52ofnXbc4bwQfvy9zI/HGMe7krmTUFm11KWf8C+S
         4lWKpoEBCxPEs/Rd4w+zKcPzVCdSI9mDE/ccCnUpBxI0RJExNif7L1tfxpqNvIo2pGmT
         fQuX/3Z+csNCLTW51GOUyhgQWE5XVogGfR4vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiITGj4XkaGGub/d7Ug1l1Bi8lGdm44D8AckuOPQOMo=;
        b=M4UDrApLubWMEU2SphSpzma0T1ZwQKsEhJiIpnF3K5pJjfwkeQNmrCJTcrsbHxS+eR
         XWOiNbw/zkQKQQ9HWDvTZ+CbY5GprfFgMle5Jz8XHmWaRZjcvbveWJnq4j4j8bTP4h89
         qqpwryslF5qa0++jQyQflC2sdXmiSah2ckZqQTSecDtm2kgKQ7JsssahEGGcrC4lGo/l
         4/YYZVthSrjizpmCSd0gKIDLnPAerGY6mckZlMfl6dQTUF0qZxPcvidVoUWJY5TYK/x/
         vTNSVDIyU+rVJvunyScM5yaMx5MnUtyyJ9B2jiiplVdEBr0vfrfoVUsOl+tRpZXFyh2L
         KATw==
X-Gm-Message-State: APjAAAWN5o/x5/GAbKVoe57D+SiSH85fwGnjQ7a3flzNV/3E9HLQ0Aej
        TIHRM3CJNhlwG1TZVDoN86AFzSBcPhQ=
X-Google-Smtp-Source: APXvYqyd8J/ImqMK0+dOrNDd5wCAjSfKRprhDt6xorC88bw5nMEVo/vkdLsJfUDT1wtCBd6MtqgPPQ==
X-Received: by 2002:a19:384a:: with SMTP id d10mr6695797lfj.111.1551580019595;
        Sat, 02 Mar 2019 18:26:59 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id t12-v6sm570899ljd.47.2019.03.02.18.26.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 18:26:59 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id f16so1100903lfk.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 18:26:59 -0800 (PST)
X-Received: by 2002:a19:c744:: with SMTP id x65mr6853470lff.148.1551579546740;
 Sat, 02 Mar 2019 18:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20190301140348.25175-1-will.deacon@arm.com> <20190301140348.25175-2-will.deacon@arm.com>
 <1551575210.6lwpiqtg5k.astroid@bobo.none>
In-Reply-To: <1551575210.6lwpiqtg5k.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Mar 2019 18:18:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxaYGTmHyoWeegL=ihHMDW_FJehUJVN_nP++Su=foL+g@mail.gmail.com>
Message-ID: <CAHk-=whxaYGTmHyoWeegL=ihHMDW_FJehUJVN_nP++Su=foL+g@mail.gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
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
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 5:43 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Is there a reason to call this "mmiowb"? We already have wmb that
> orders cacheable stores vs mmio stores don't we?

Sadly no it doesn't. Not on ia64, and people tried to make that the
new rule because of the platform breakage on what some people thought
would be a major platform.

Plain wmb() was only guaranteed to order regular memory against each
other (mostly useful for dma) on some of these platforms, because they
had such broken IO synchronization.

So mmiowb() is not a new name. It's been around for a while, and the
people who wanted it have happily become irrelevant. Will is making it
go away, but the name remains for historical reasons, even if Will's
new acronym explanation for the name is much better ;)

                Linus
