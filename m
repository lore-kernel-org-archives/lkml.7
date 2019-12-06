Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B414DC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB2320706
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575652173;
	bh=DOKcdfMtvfBI/330wiscQwL1UqKdSNfpjzKwQ6EWdTk=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=zYqlCZBJy1YZZsWevu7AS0do+BMRGlvxp/GTqK5CBrBwJNCuLPa/oLOldjysrV6WZ
	 0UsDqx5cLhqDcPioQ67gI/QdoRgJPHVcgYJwxxtbet9UsNZtVKYPT6aZFRe+L6379n
	 pXzUDSPeeO4f3RyI+Vno3/j3UZmIO9WzuiqrIahw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLFRJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:09:32 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44289 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfLFRJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:09:32 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so5781346lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 09:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7EbNmyL2KBbFhAf+WiEp2SlV2yCcET3pLh6OrmQkbQk=;
        b=Usv+fNnnCb+9+t8soSUIa534OoCYo0jCIPfkhJ5fpyMtj7KNU8ABV2MUp6O+CW516U
         eeRzaucwrImDjco1O4HE9VvR8Aa5vs9mbqFaUseSt8JFxFRf972YBIqqxL+SN+SMXw9e
         p5kFppqcReC4TI2kp1OGprlBQ3hrwerx5g4oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7EbNmyL2KBbFhAf+WiEp2SlV2yCcET3pLh6OrmQkbQk=;
        b=OzcV0HxuB+S7997nD6VhAApZBe8rbwk0obZNKoLqQsWGxPiElhDK5bE9m6DE2PiALG
         cVjPK0n0dUt9KCRwrVLSgSkbp7JAZEAgHM3D0rNf3D0vxynimvXb0IXvwn5WHkPbXTGi
         6Ly4x8YKvVaSmqPxS2c/GJbDivGuJPD5/hVacXOmeeT26DjHk581RNGo/9cB1ZO7BWF6
         AGr0pDjEMnZepFzRRSaJkDu91SNHTgu1Bwmj8molS/243OjHIv9DzHH/DkhG/qiquuvi
         2EquKta4p/oAsZ08Uni/xpKzHaAsGRvO+MbL/qdMGI6WXTYKZN64NmHW127/S/STY/l1
         0n5A==
X-Gm-Message-State: APjAAAWINZaIDi80CvhnwVE5j/2xz6TZYLNxaKJnbDVGaYEUSI6HbC7p
        yVUO9zvyitKM1LZ7L2X+ii4KjOt9QWI=
X-Google-Smtp-Source: APXvYqxHo+wCtUK4p4Fh6Pl8ZOHGA9KMNF3Ls5b2npvsLfZ0LAgoAu8HYwMr8ZHuybUuQRCbR0L9gA==
X-Received: by 2002:ac2:4a78:: with SMTP id q24mr8686028lfp.87.1575652168705;
        Fri, 06 Dec 2019 09:09:28 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id a15sm2727452lfi.60.2019.12.06.09.09.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 09:09:27 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id e28so8387309ljo.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 09:09:27 -0800 (PST)
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr6932025ljg.82.1575652166847;
 Fri, 06 Dec 2019 09:09:26 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz>
In-Reply-To: <20191206135604.GB2734@twin.jikos.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 09:09:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj42ROD+dj1Nix=X7Raa9YjLfXykFczy0BkMqAXsFeLVA@mail.gmail.com>
Message-ID: <CAHk-=wj42ROD+dj1Nix=X7Raa9YjLfXykFczy0BkMqAXsFeLVA@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 5:56 AM David Sterba <dsterba@suse.cz> wrote:
>
> For reference, I've retested current master (b0d4beaa5a4b7d), that
> incldes the 2 pipe fixes, the test still hangs.

Yeah, they are the same fixes that you already tested, just slightly
reworded (and with a WARN_ON actually removed, but you never hit that
one).

Does the btrfs test that fails actually require a btrfs filesystem?

               Linus
