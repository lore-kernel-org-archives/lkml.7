Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1E8ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8236D206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="futuOGUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbfJIN5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:57:00 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:26506 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJIN5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:57:00 -0400
Date:   Wed, 09 Oct 2019 13:56:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1570629417;
        bh=+Bb+b0Zx5h9afFwEFcIv0ox7LasYliXQisN/7bsXczU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=futuOGUy03/9hafXdFdEGzPPdU4uJL86TAfPvM2UBJ6f+5O2ohJ07NSKrRr+6B0Sl
         Oyh95IejmHcAJ25vdKDF8e4xpGsPEO8k92ynkQe3KqRzqCsjevxZ7jFRE+g8SDyQ8N
         t/lPuDiLb6NuNDd0xAsjFxxi2qW23CM3eamcZwxk=
To:     Dmitry Goldin <dgoldin@protonmail.ch>
From:   Dmitry Goldin <dgoldin@protonmail.ch>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel\\\\\\\\\\\\\\\\@vger.kernel.org" 
        <linux-kernel@vger.kernel.org>,
        "joel\\\\\\\\\\\\\\\\@joelfernandes.org" <joel@joelfernandes.org>,
        Ben Hutchings <ben@decadent.org.uk>
Reply-To: Dmitry Goldin <dgoldin@protonmail.ch>
Subject: Re: [PATCH] kheaders: substituting --sort in archive creation
Message-ID: <JhK61rXiXRkJbVJqHH9kRlLM_zO-J6fPM-NCa2P1eKSIfXzpunRtwJNMS4fliDWqMBhQKqp5t3fmUmKLhuSAeqTS6nVogdqnVyxagsH2z9M=@protonmail.ch>
In-Reply-To: <oZ31wh8h96sDGJ_uQWJbvFDzh4-ByMMeoyOhTLmfdf5B5T0KWgLhhNbC49J6EM_Nlgo_zH-bUScrWxYTgP9eNNMF1D5AbpcbIHbBuzbS_44=@protonmail.ch>
References: <oZ31wh8h96sDGJ_uQWJbvFDzh4-ByMMeoyOhTLmfdf5B5T0KWgLhhNbC49J6EM_Nlgo_zH-bUScrWxYTgP9eNNMF1D5AbpcbIHbBuzbS_44=@protonmail.ch>
Feedback-ID: Z14zYPZ70AFJyYagXjx-jk2Vw9RTvF5p9C9xp4Pq6DJAMFg9PDsfB7GoMmtR_dfa0BaFgToZb9Q4V0UiY2YiMQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

Sorry for the delay, I'm currently traveling and only have access to a
rather weak machine so compiles took ages.

A few remarks regarding this patch;

This version is not fully identical to the previous invocation, as the
sort order differs a little, but I tried to get it as close to the
original as I was able to. Unfortunately no sort flag seems to quite
replicate tars sorting.

Some noteworthy details in this version are `./` in the find format string,=
 LC_ALL
for sort and --no-recursion;

The format string is in place to replicate the exact behaviour of the previ=
ous
invocation, which included a leading `./`. I don't mind dropping this,
if anyone feels strongly about it, but initially I set out to reproduce
the result as closely as possible.

LC_ALL=3DC is required as locale can impact sort order.

--no-recursion is required to prevent duplication in the resulting archive,
because both, folders and files, are already supplied from find and sort.

I checked this part of the script on an old debian lenny (5.0.10) system an=
d it
behaves as expected, except for xz support not being available in
the shipped gnu tar (v1.20).

As far as other testing goes, I have compiled 5.3.5 on NixOS with kheaders =
as a
module where both runs produced identical results.

Because of the limited computational power available to me right now, I
did not have time yet to try the baked-in version or any additional
compile runs. I would appreciate if reviewers could do a few runs too.

Andreas: Could you give this patch a try and see if this works for you?

--
Thanks and best regards,
    Dmitry
