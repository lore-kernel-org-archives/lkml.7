Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA18C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F78C208CB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567443199;
	bh=9eTh7eh9eZN723z905iCfEz0rjnI/DVGes7CLo1oNrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y0OS1C77I69srA6Gz2XYmzSZT9Bh5m3g+Ck3B07RRA7a17NqD1FUeDSeTld3ioSPK
	 gMxXx0lGETB6Ow1bw6A4IIjPIioT2fIIX+slmwpaVfs/t3IDYmQL47UWGhMXJRRlWT
	 hlcR4leHrQUsBVazxn2fgOzQCtl7EcXE3Ic4gfyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfIBQxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:53:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37112 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfIBQxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:53:17 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so10843531lff.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 09:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S0sB4uJ2RkWUY64omGBSg0LTZlyK7j9RYhxymEA8xlA=;
        b=NFAIaXSr6l5y8gVKCoFwZRdr4P8irrfci/CQRScyPHsMH4QHudio483JZryYXz/ou5
         LtHuBaJXE/j5vobcpWloKkFG4FAkIgch+8VibdXif2QDfMQ/RGstRGPi5AxBQbg4RcHn
         n4xLmCW4Q9i++ObIkph4wmXkym65pjuj2Qyuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0sB4uJ2RkWUY64omGBSg0LTZlyK7j9RYhxymEA8xlA=;
        b=Pggsm7vJQXvI5mSEpZfRjRITgHu13fuz7ayWcGziZDPTrHN/Vy7QVlApjkOGCDmOOX
         nneAvZ+yA9bOga1nA/88BlwJS90uk6jZN5CHxVpLCt6LLGhfpoFGg03XX3hrjjV/QIAL
         srb6EN4H4JqvS5Vfef4ZnyzuhP9CPuOq1tX8ft+llIKRKp4LmtrboLAV1Z/+3+Ae3DZZ
         d96msOj+JnSx76iFSwwu5YQWuh0CduO/Gma33vZyK5toBpdgrZwIj+G1P9iQTeRZn0ZY
         zdV2Vg4VrrcKY/bLxOiDfjW73AI0yBw34/OdIyhMxOKghvD64tj3qbPybrTOBSfM7qO8
         KJ5Q==
X-Gm-Message-State: APjAAAWHiShlpp9boalXVwbtJ5UQgNwaDMj6BqDblj2HiAw7YOz0Q6dh
        ZnYqInw1cqKUFKt4zGIJXaIo0YblveY=
X-Google-Smtp-Source: APXvYqy3BPwsIpfAL+oOr9ebv7VWm4QqyfZY8kE5DwzMbNjsbEw0NostwUfdF36/cEi0R5EQ9S9NcQ==
X-Received: by 2002:ac2:520d:: with SMTP id a13mr7024309lfl.101.1567443195485;
        Mon, 02 Sep 2019 09:53:15 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id h25sm1279493lfj.81.2019.09.02.09.53.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2019 09:53:14 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id n19so10806168lfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 09:53:14 -0700 (PDT)
X-Received: by 2002:a05:6512:512:: with SMTP id o18mr12184962lfb.170.1567443194206;
 Mon, 02 Sep 2019 09:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <5a3e440f-4ec5-65d7-b2a4-c57fec0df973@infradead.org>
 <CAHk-=wg4mE8pSEdWViqJBC9Teh8h1c9LrqqP6=_g8ud5hvkfmA@mail.gmail.com>
 <CAHk-=whH+Wzj+h0WzgdLMu+xtFddokoVy8dWWvEJqJRGA_HLmw@mail.gmail.com>
 <6184ffdd-30bf-668a-cdee-88cc8eb2ead7@infradead.org> <98c83922-6ab1-98ca-7682-7796ae1facf4@infradead.org>
 <CAHk-=wg7BwJ7jFXxj5ZOU5VOw4Eg74TpTzip4P+LEJTYbZVhng@mail.gmail.com> <89c8b8a1-8398-7432-8ad9-599bf1c18f56@monstr.eu>
In-Reply-To: <89c8b8a1-8398-7432-8ad9-599bf1c18f56@monstr.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Sep 2019 09:52:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_6wpDHrFZEH=ra4k___apjndVfPaOMdyFxd--b5ot8g@mail.gmail.com>
Message-ID: <CAHk-=wh_6wpDHrFZEH=ra4k___apjndVfPaOMdyFxd--b5ot8g@mail.gmail.com>
Subject: Re: [PATCH v3] arch/microblaze: add support for get_user() of size 8 bytes
To:     Michal Simek <monstr@monstr.eu>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 6:17 AM Michal Simek <monstr@monstr.eu> wrote:
>
> Randy/Linus: Are you going create regular patch from this?

Since I can't even test it, and Randy did most of the work (and that
last patch worked for him too), I'd suggest he just send it in as his.

You can add my acked-by or sign-of depending on how you want to do it
(but I really don't need authorship credit, it might as well go to
Randy).

              Linus
