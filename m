Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1D4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E73A22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brMKH/ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfH1Vvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:51:41 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:37471 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfH1Vve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:51:34 -0400
Received: by mail-pf1-f181.google.com with SMTP id y9so631664pfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 14:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PrzYg7JXc84NUm75qwtYToh12xfjeZszRpCSWoICFTU=;
        b=brMKH/tswEBw/9zq7fE2Y/B++LJ/F0+REWIGmLdmoFh5cmcaXKybpri7zEqjsNGZyg
         xK2O4wM72IP8dBD805nbCqHlxAMeGd5PWmFlGYYV/0UWt6856sS45d+egiPourYvjRWY
         oJesqE5HBV0J71cqBBc9iLuL2TG+cqpk33ciC1uB7NzdnS7b1MZoGS8Du1F1ASASzlZY
         edhb4v9mO3dQa+mq8X0xwysiubTUHhW/ImnK3b6AdvjIBSOLAbbNaA765nyhUkfvnrM2
         zoGyP4Vjlv8QoV/4KQ1sI0w3xOcQQIPYSxaLLcLjUsWgfhBr/BX0A0xex/V+w2Eg4zrh
         4eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrzYg7JXc84NUm75qwtYToh12xfjeZszRpCSWoICFTU=;
        b=ZJS838fmtagvPphxAg8nAW9kgNFmLg1B9RO2aTvQ63wgRyR5VzmE4KuxQf9CCcP5DA
         yYh4rDUbS6Nfebq/3MNTsN10QhQ9TCKk+OWLPGb6hWk6VxZFt25SZr9ZwKPnWJy4h3bB
         XQTSpcjDBXVMf+/N3Mq4gxDaBATRkGry0LOvLbF+XS+ErCY6s/J5lQkNEYaVIANJ9+f2
         UOCxk9o4b2zRCdtHTzejHd4B7RL8imY82bfXTjGamo4lO/LhhFN6Lwbs2Dxkxdhp7dKc
         a4617W+sNgeqSf6Z/5De1HgQTP9BDwnD04fu26yFJKKIfOUb8GuNXF3EfjJOo3EmINOU
         +P+w==
X-Gm-Message-State: APjAAAXWrb43Z0pS5tx49QHVgYvSYU/xsxXCsjzwVwaMguwJ5ced8iCG
        xqbCA7kTzinUhh9RV72UahdWHxc/gbKMdUNiPTfHRQ==
X-Google-Smtp-Source: APXvYqya7yVQVpmy2ZPUictRvb/eeOwP4HO+1fG9LCVQaMT4ZtzN2SN8p3ADZxGLdBCTsF5nVW/1YOJo6UGJ4rtUzpc=
X-Received: by 2002:a17:90a:3ae7:: with SMTP id b94mr6452243pjc.73.1567029092473;
 Wed, 28 Aug 2019 14:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190828194226.GA29967@swahl-linux>
In-Reply-To: <20190828194226.GA29967@swahl-linux>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Aug 2019 14:51:21 -0700
Message-ID: <CAKwvOdn0=7YabPD-5EUwkSoJgWjdYHY2mirM2LUz0TxZTBOf_Q@mail.gmail.com>
Subject: Re: Purgatory compile flag changes apparently causing Kexec
 relocation overflows
To:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 12:42 PM Steve Wahl <steve.wahl@hpe.com> wrote:
>
> Please CC me on responses to this.
>
> I normally would do more diligence on this, but the timing is such
> that I think it's better to get this out sooner.
>
> With the tip of the tree from https://github.com/torvalds/linux.git (a
> few days old, most recent commit fetched is
> bb7ba8069de933d69cb45dd0a5806b61033796a3), I'm seeing "kexec: Overflow
> in relocation type 11 value 0x11fffd000" when I try to load a crash
> kernel with kdump. This seems to be caused by commit
> 059f801a937d164e03b33c1848bb3dca67c0b04, which changed the compiler
> flags used to compile purgatory.ro, apparently creating 32 bit
> relocations for things that aren't necessarily reachable with a 32 bit
> reference.  My guess is this only occurs when the crash kernel is
> located outside 32-bit addressable physical space.
>
> I have so far verified that the problem occurs with that commit, and
> does not occur with the previous commit.  For this commit, Thomas
> Gleixner mentioned a few of the changed flags should have been looked
> at twice.  I have not gone so far as to figure out which flags cause
> the problem.
>
> The hardware in use is a HPE Superdome Flex with 48 * 32GiB dimms
> (total 1536 GiB).
>
> One example of the exact error messages seen:
>
> 019-08-28T13:42:39.308110-05:00 uv4test14 kernel: [   45.137743] kexec: Overflow in relocation type 11 value 0x17f7affd000
> 2019-08-28T13:42:39.308123-05:00 uv4test14 kernel: [   45.137749] kexec-bzImage64: Loading purgatory failed

Thanks for the report and sorry for the breakage.  Can you please send
me more information for how to precisely reproduce the issue?  I'm
happy to look into fixing it.

Let me go dig up the different listed flags.  Steve, it may be fastest
for you to test re-adding them in your setup to see which one is
important.

Tglx, if you want to revert the above patches, I'm ok with that.  It's
important that we fix the issue eventually that my patches were meant
to address, but precisely *when* it's solved isn't critical; our
kernels can carry out of tree patches for now until the issue is
completely resolved worst case.
-- 
Thanks,
~Nick Desaulniers
