Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBEEC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51561208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567814931;
	bh=GD4bGcriyKCg+nBooZQfeTc0V4fPhWhSJdg5AUiydl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OHIFWy8mfMjdO1Qq4Qr8c5vN1Gi39em0fS/jDtPtAeMntW2YCv7qexpl2f9nMhCTh
	 xGaU1Oqm7HO2TMZAMiIhIePIOgylQz6roADCIkp8Y7Zv7192T/pO6HfUGNk/qGa48e
	 0bBlw+kEMdl/ejqeZgNmU7IiI8/TjbKWoWs8rLvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405666AbfIGAIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 20:08:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39062 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfIGAIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 20:08:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id l11so6396170lfk.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 17:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eAMeeh2ajLaE6wSXOFxaPWJvGDvfcqC6Z0U9oU04ZII=;
        b=P/foX4HSetlf3fjQMjNTNXZMAKWu2zbrBhyQXudqQGxR53x101VP5cj1yLV94U/MgM
         AwNrQ+SDpP7y/B/EBiVWiRgtkBowxyies1aZeadWd/zhBg8MjxQXX+NoRmsFtP7kwvlX
         oFfs0lO0j6U4vXvstPWrqxIE3ia+dlkeWDP4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAMeeh2ajLaE6wSXOFxaPWJvGDvfcqC6Z0U9oU04ZII=;
        b=f+uKjJZpoohYIwE6U+/TZ1aa1E2ikW5iDA1pH6Y+akzJdlSUEhfovW+O++f/XCeIlz
         3pGmeiMhXDqpxsSfA9+lByFm7I3V8iXtJSTI7svwSHtdnF0xM8QrHbF6x+DaBj9Cxy38
         oBZy2zITyaGsQWWdJ7fiIoFfqvOpUyFXeTfWH6veisuvj8ko9sMu7a/H/+5bI29E4s2q
         HCWKCWIxjsEPLCYUNzmbH7LbslzAP24ANMCgDkuzgEgrOvuoF5DGmW1cqKZpPsJWt19g
         Xmwye4Hycfu4yQ7aN6ptw05uQzSX8oyfH9o+qSdVnohfR96GTNSyjQG6Ij6gEtlyzqnm
         2+Pw==
X-Gm-Message-State: APjAAAVLz051ocdQISa2Vz9QBniM9xZkJA6AnbQ3UdZXjbb28bSY4NKf
        50qmsBTlnkFypwucKZVhs3BE8LBXTEs=
X-Google-Smtp-Source: APXvYqx/5mCAlwFN2MnL3Lix3vNeiLY9nVutrYc8C1fhQ4Jt8WO6qLpIaEK3DUIMdEMjsD8LWVfgDQ==
X-Received: by 2002:ac2:4d04:: with SMTP id r4mr8078209lfi.57.1567814927102;
        Fri, 06 Sep 2019 17:08:47 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id y4sm500993ljd.82.2019.09.06.17.08.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 17:08:46 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id w67so6389355lff.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 17:08:46 -0700 (PDT)
X-Received: by 2002:a19:741a:: with SMTP id v26mr8245815lfe.79.1567814925720;
 Fri, 06 Sep 2019 17:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com> <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
 <CANiq72mXLbaefVBqZzz1vSREi0=HiBUgR1KU3iRjOCum7rvfrw@mail.gmail.com>
 <CAHk-=wiNksYaQ5zRFgTdY4TMHkxRi3aOcTC2zMMS6+aVSx+yeQ@mail.gmail.com>
 <CANiq72kyk6uzxS3LRvcOs9zgYYh7V7V2yPtAFkDwpHmyYcsz_Q@mail.gmail.com>
 <CAKwvOdkodVFxUr_Xc-qeUHnpxEmofENDhNdvCuiRzcGXQ54QkQ@mail.gmail.com>
 <CAHk-=wg+PD-+FEdKJuRVrrsgnFFLoAgU4Uz7tnohq_TgsEcNig@mail.gmail.com> <CAKwvOdmCBgKMLkXt29=vgvws_ek4XY3urMdfBUzbREH8Bj3uYA@mail.gmail.com>
In-Reply-To: <CAKwvOdmCBgKMLkXt29=vgvws_ek4XY3urMdfBUzbREH8Bj3uYA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Sep 2019 17:08:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZ-ac4jm9zt=805xWsXaDAFWn2Bwn2PNtOBVx1vUmVvQ@mail.gmail.com>
Message-ID: <CAHk-=whZ-ac4jm9zt=805xWsXaDAFWn2Bwn2PNtOBVx1vUmVvQ@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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

On Fri, Sep 6, 2019 at 5:07 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> So then Miguel should maybe split off a new branch, rebase to keep
> just the relevant patch
> (https://github.com/ojeda/linux/commit/c97e82b97f4bba00304905fe7965f923abd2d755),
> and send a PR to you for inclusion in 5.3?

Yes. With the appropriate test cycle, particularly obviously clang
(which I don't test in my own minor tests).

                    Linus
