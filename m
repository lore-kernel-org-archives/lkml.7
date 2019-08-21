Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A9EC3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDFD22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566348228;
	bh=ixO8W6tHdlsC5b8RkGPUlAFOekLRyLURH8iLpJEw/8Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FOgx15zV0gPfI3Q9SnW8E7bYUrLJd4NU28knoVrNoarMQs9o8u34XvcxZ/K7NJtEa
	 6egQoF0oAZh0x8y489xHkLRMRH8KsJO2PjLr1V0DP1qh/gxRRYTlP2io0e7/wBt2Za
	 +Syzy46vPUImn82pDBSSwl8TADzA7zHftozsNyDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfHUAnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:43:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35936 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfHUAnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:43:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id u15so499242ljl.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 17:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FajnE/5GS1R2x5f3KG7EhW3STXyEPWL5jLH+s75xMBQ=;
        b=OgGbnwzdMlBAxLB0nXPGR8lubUdwdOMnk2GEOoXr3ylU9Q4sYetMQAd0uyU6IRIorM
         6UooosusQb98US54SL+QLtui7+wSkw1J+s0FbmhwlQnB3R+SnqoFoBEwQDU+caRSgP7i
         oQM5/7n/2VIdCOuSgZodegRcjr5fApTWthAQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FajnE/5GS1R2x5f3KG7EhW3STXyEPWL5jLH+s75xMBQ=;
        b=Gj3WIAkZfnEsP+ZGqxYsXV9x5bU4E9wmprxaHvBF55iQmQj7ls/kUs87M9ct33sZt6
         H6If5P5+/9kugmkzY5gKmhnwHZ1olaEnhmzTJTldF+nnefF2msCsR3CmKmXGATqbBo2X
         TusblRPA6Iszkzx2s3SzoQIpwNbKOpwrk5umndIxEihcgrS7nobUabx5NWXejrrWWpFp
         R52SHldVYwo+PggA9qpubFjyY3MhafJJy0dfjWlXVWFTQEbr2h0VoZuE6xsQvHXqD+4p
         /NCJB9MEGbccUK5Lt1JJXmSRsj/ZkDi1XNqP4BAbpfWQvupKtZkaS7FZadNenKYQvpaH
         RZXQ==
X-Gm-Message-State: APjAAAVM+1WInpUxhNVZhKbwWBhCTVjzlAu2otCGtHSn7JMDHxM9Keqf
        AXnRz0nn5RzzS4pCKzwwZoPyDPowNZ4=
X-Google-Smtp-Source: APXvYqwfJAxtWlK19MS8brHPmPL9NypzLU6waFXJ79P4fATuYVIyqEOhBE9rns8+58FCz8Pt9H1UNA==
X-Received: by 2002:a2e:8ec6:: with SMTP id e6mr16632438ljl.192.1566348224758;
        Tue, 20 Aug 2019 17:43:44 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id z25sm3050014lfi.51.2019.08.20.17.43.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 17:43:44 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id j17so457638lfp.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 17:43:43 -0700 (PDT)
X-Received: by 2002:a19:c20b:: with SMTP id l11mr16880592lfc.106.1566348223500;
 Tue, 20 Aug 2019 17:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
 <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
 <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
 <6a5f470c1375289908c37632572c4aa60d6486fa.camel@perches.com>
 <4398924f28a58fca296d101dae11e7accce80656.camel@perches.com>
 <ad42da450ccafcb571cca9289dcf52840dbb53d3.camel@perches.com>
 <20190820092451.791c85e5@canb.auug.org.au> <14723fccc2c3362cc045df17fc8554f37c8a8529.camel@perches.com>
 <CAHk-=wgqQKoAnhmhGE-2PBFt7oQs9LLAATKbYa573UO=DPBE0Q@mail.gmail.com> <edd8efd53fadd07992f804cc595c6ae5fdb60e73.camel@perches.com>
In-Reply-To: <edd8efd53fadd07992f804cc595c6ae5fdb60e73.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Aug 2019 17:43:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8vLmmwTGhXM51NpSWJW8RFEAKoXxG0Hu_Q9Uwbjj8kw@mail.gmail.com>
Message-ID: <CAHk-=wg8vLmmwTGhXM51NpSWJW8RFEAKoXxG0Hu_Q9Uwbjj8kw@mail.gmail.com>
Subject: Re: rfc: treewide scripted patch mechanism? (was: Re: [PATCH]
 Makefile: Convert -Wimplicit-fallthrough=3 to just -Wimplicit-fallthrough for clang)QUILT
To:     Joe Perches <joe@perches.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 5:20 PM Joe Perches <joe@perches.com> wrote:
>
> Umm, btw: have you actually looked at stracpy?

Yes, Joe, I have.

What part of "there are now so many of them that no human being can
keep track of them" didn't you see as a problem?

How many broken string functions are we going to do, adding yet
another one when you notice that the _last_ one wasn't great?

We never seem to remove the broken ones. We just add yet another one,
and have a never-ending jumble of random letters.

I would seriously suggest doing something like

   copy_string( dst, dstsize, src, srcsize, FLAGS );

where FLAGS migth be "pad" or whatever. Make it return the size of the
resulting string, because while it can be convenient to pass 'dst" on,
it's not useful.

And then maybe just add the helper macro that turns an array into a
"pointer, size" combination, rather than yet another letter jumble.

            Linus
