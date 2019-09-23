Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8ECC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D13206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569262720;
	bh=6fekRAv26FkCnF0G3+fezpco7U0wV9PobSEsIbygegI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vawmUjpp7rVouMCaiANkJ3dfWzqKYT2/YL1HV7jv6yKlljFaBrFQVeRotr30q5CV0
	 d24y+E1KkcNof3qt/VUlNKs9UvYS7jDmvCsVkJUhhLQvHQdZ4NiDNNeVCDKTKk32Ip
	 QrKdyxAWJmx5jB+quCEBtFXqGndYQcPsxTq1P8oM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440426AbfIWSSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:18:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33184 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438191AbfIWSSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:18:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so10923357lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MZ2lLvVAj8wl/1PRSv9GS/7a80MR0W+vCbBFmNK2zW8=;
        b=VDL1koFlc/i2eabI5QJ87yDehJLeHLeKc+Wn7KTI1jPvb1B2gKWjVqfgjGVTW1Peh7
         VnINX6uNybuSAl/1cyj4c0YZyplLXMytHuGLTEQQC0nBWS6OH8hsZG20SSbmrUZQUcAJ
         boubqvO7pY8gE8wphkLkqxwCDihobZE7QpTKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MZ2lLvVAj8wl/1PRSv9GS/7a80MR0W+vCbBFmNK2zW8=;
        b=NutH2XSG9wHwgw2GMTI+LQsk2V+KoTftGXbRAcGUEDvjQCizPsRI8qn8zj6/JrKZdb
         PfLAK16K7w04gsHGyWFR4gUQvjosRaHeF1sCWyWK4fslIM7Q/WO3Ol1xINwuGG5LFrBX
         vDxY+Dh806ksAPD774qmLrU1LqRk1+4/Xt2Z7BGi/aQKvf7cz77Tm+RAx4ayzGNlnRhb
         Ip4PVLggi0g4Z2GXdhEet2jIAdQsEXl9rInVqMwagHkdaZCMls4yZkQkGWliOGzoqsxG
         +IO2Hva6VQuCAU1O3McwyqWuUOx1TvQlHSDrTlYpgII2oz7deAKTKqQlttq3CeQD5BgX
         gzdA==
X-Gm-Message-State: APjAAAUoK0XU0rAyztTlHbPXeCd+4LHHKS0v552kYX6asgHZQx4R0l+E
        rwfF2DRSKZaYAO3KPow93iRfaSywZnI=
X-Google-Smtp-Source: APXvYqxyLt1IeTFjDLc2/2hoxNhKTU91jmvcBOJbqoWpIdFJUTjsiSB2yueB+ywTo+qwE/zXWcOxHw==
X-Received: by 2002:a19:4bd7:: with SMTP id y206mr549160lfa.9.1569262717002;
        Mon, 23 Sep 2019 11:18:37 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id n8sm2370295lfk.21.2019.09.23.11.18.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:18:36 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id b20so9309511ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:18:35 -0700 (PDT)
X-Received: by 2002:a2e:8789:: with SMTP id n9mr447393lji.52.1569262715339;
 Mon, 23 Sep 2019 11:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190921231022.kawfomtmka737arq@pburton-laptop>
 <CAHk-=wjmJbF3p9vZTW2nbeD4LkG-JZV+uqv8BnxzojJ5SZsLjw@mail.gmail.com> <20190923180728.flp6jx4jc2bh7cys@pburton-laptop>
In-Reply-To: <20190923180728.flp6jx4jc2bh7cys@pburton-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 11:18:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiC_B8R6th+83vKwGT1H-8vtFrmMg+1mK_P8n3VeWAWRg@mail.gmail.com>
Message-ID: <CAHk-=wiC_B8R6th+83vKwGT1H-8vtFrmMg+1mK_P8n3VeWAWRg@mail.gmail.com>
Subject: Re: [GIT PULL] MIPS changes
To:     Paul Burton <paul.burton@mips.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:07 AM Paul Burton <paul.burton@mips.com> wrote:
>
> Another issue is that there are currently 'expected' warnings dotted
> through the tree for various defconfigs

This is why I refuse to have _any_ warnings at all in my tree during
the merge window.

If you have expected warnings, you will ignore the new and valid ones.
So the only acceptable situation is "no warnings".

In honesty, I actually do have one warning in my tree:

  samples/vfs/test-statx.c:24:15: warning: =E2=80=98struct foo=E2=80=99 dec=
lared
inside parameter list will not be visible outside of this definition
or declaration
     24 | #define statx foo
        |               ^~~

but because it's in the sample code, it pretty much never gets rebuilt
for me unless I basically do a "git clean" to get rid of everything,
so I don't normally see it for any normal pull.

So I've ignored that one warning, although I've actually been tempted
to just remove the sample because of it.

Adding David and Al to the cc just in case they have some simple fixup
for it that is likely to work across different user headers.

I considered just adding a

     struct foo;

declaration, but the whole thing is incredibly ugly.

                  Linus
