Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02996C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5E9206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567716814;
	bh=v2kKcs1MqHq75K/qAtNF3JwBs6GsGB2FeWF6sjq6GwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AnexppTFLRUH4W4s0Os+y71q5RgnOf0wi7Syk6jv5/LUakBT4iJRv3N6cbJ1zayXt
	 wiQaXUnJwjwXLA1HJ65YG0iHZWO2bAyy0TsUNp6MV4EmwhEdc4PZY5540gxu4tH/OD
	 DYRp/CAaohVlCtYCwHmqkmxQbQseLUl2HRpirCV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbfIEUxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:53:33 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43972 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfIEUxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:53:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id d5so3910675lja.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPEZjEgURFMOpZcOpmz6NV2rlqMAKb/Tvj6hXKO9NUc=;
        b=Tru6iuAtxJ4Nbpda4z7UjfkFGHF0OYfFwBtmVZhCqXZ/9ppwjshhlmflUcapGH+Vkc
         fo2foyLXPY7Zp8XV7b3hMsVwIvua7ZIFWz2leYihFOzUrbTAf8kYutdZ2eo3/tHakM6Q
         BQit8+/lAms0l/Pks0MDXDhD8Frh3JqCk1FSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPEZjEgURFMOpZcOpmz6NV2rlqMAKb/Tvj6hXKO9NUc=;
        b=g/PAZi4SwAMm2b4cRDNFoCZri13Q3dY8ybwJ7iXEM2WcOcAXMlDQKTZ8c2rzHHy8q1
         GKRN/BAYRjQdCVYJ9/4T12ON5rlMmtFT/TZLJKz/wTa1026b6PrLqTPETXXBcPp9DkWm
         hTBCoYlmq7t8H19yIB34IlJxXTXvtOyC2ZxOgSHAIlwPQWJc5NjeqnQXn0kS46q3AFGj
         gLS+uNitIt+1XoQbSPos+3gCmrIAq9M7gGPOSbY7a/aTGAp/YgdJVnnQT/5o7Lb0CP8x
         ckGBWgw0VTG+CUCXX5BusmEKPnUoRQlT4ff1lfuvwaNYTrQTTnwd7kWmkGwepw6g68nQ
         qXog==
X-Gm-Message-State: APjAAAWNHvztiIskfgxPmi5/097VqU91A9Br7IclDYMwoYO5I8VE8Pzq
        8BJZZ4vxUhGPxwrZ3lCsANbtGIB+6Dg=
X-Google-Smtp-Source: APXvYqxPeCuNiCz3S06ENCLMdxTi/hEtxa6biatl3KYlckrhfoZCtQkjNac9I9rePsC/H9szvwA5CA==
X-Received: by 2002:a2e:9bc1:: with SMTP id w1mr3485227ljj.168.1567716810004;
        Thu, 05 Sep 2019 13:53:30 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id u8sm650563lfq.61.2019.09.05.13.53.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 13:53:29 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id u13so3161905lfm.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 13:53:28 -0700 (PDT)
X-Received: by 2002:a19:741a:: with SMTP id v26mr3835623lfe.79.1567716808552;
 Thu, 05 Sep 2019 13:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com> <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
 <CANiq72mXLbaefVBqZzz1vSREi0=HiBUgR1KU3iRjOCum7rvfrw@mail.gmail.com>
In-Reply-To: <CANiq72mXLbaefVBqZzz1vSREi0=HiBUgR1KU3iRjOCum7rvfrw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Sep 2019 13:53:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNksYaQ5zRFgTdY4TMHkxRi3aOcTC2zMMS6+aVSx+yeQ@mail.gmail.com>
Message-ID: <CAHk-=wiNksYaQ5zRFgTdY4TMHkxRi3aOcTC2zMMS6+aVSx+yeQ@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 12:41 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Nick, Linus: shouldn't we just simply go for no stringifying at all,
> i.e. changing it to:
>
>     #define __section(S)   __attribute__((__section__(S)))

That's probably what we should have done originally, avoiding all the
issues with "what if we have multi-part strings" etc.

But it's not what we did, probably because it looked slightly simpler
to do the stringification in the macro for the usual case.

So now we have (according to a quick grep) eight users that have a
constant string, and about one hundred users that use the unquoted
section name and expect the automatic stringification. I say "about",
because I didn't check if any of them might be doing tricks, I really
just did a stupid grep.

And we have that _one_ insane KENTRY thing that was apparently never
actually used.

So I think the minimal fix is to just accept that it's what it is,
remove the unnecessary quotes from the 8 existing users, and _if_
somebody wants to build the string  by hand (like the KENTRY code
did), then just use "__attribute__((section(x)))" for that.

But yeah, we could just remove the stringification and make the users do it.

But for the current late rc (and presumably -stable?), I definitely
want the absolute minimal thing that fixes the oops.

                     Linus
