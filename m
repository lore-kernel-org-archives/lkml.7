Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23286C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81282053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E9Ywe5t3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfEFPQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:16:18 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38171 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEFPQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:16:17 -0400
Received: by mail-vk1-f194.google.com with SMTP id g195so656524vkf.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Zp/AeU4fjyGpBuQi6oX6sXNf0Rq9m6Sj9OTL0ySozg=;
        b=E9Ywe5t3+hUth4UZPK8ov0rGUugML3K0NpXNNJoB0Kt0Pdn/l8bxqfa6eViZVs2yQV
         GXYAj1vL8VWdBeXMhScEy20i9KxKJ/WKVdy3eo8HEsTTrOWu0S4u3llqqK9hKt13Y398
         sz6hwYxw7pmbyan0KZK3obBJEyGPTSkTE0utI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Zp/AeU4fjyGpBuQi6oX6sXNf0Rq9m6Sj9OTL0ySozg=;
        b=QkMTg8r2Mj23da/iDdHb5I+figLGUhfCWTNNAocFVsYzxjfiiUuhCCzy4hRUObyFTH
         pb90F9aOsBVBkukzc5t6HulUHHxMtXx2tkPf9RXMWIcE3K3sAho9EwdBN5paBlZsupPO
         vFsvC7NpB6ZKvceiQCDK14ezaBUcKAErQIXNcS0yk4EcGQ6P+7fO6JGq7i9rcRaDCorv
         TVvhxgUjr5nG0BbdSq02IeR4/qo2o+J5LfBicTt5xyf8nAEKoqmCtHpeMrRIra15B5MO
         LZGA+xLepTS5UTc/8lJY/zEdu+yqYgeM/Ildht4WU9nh3ttdv9gbaXWEgd7Wd4yeBEus
         JUfA==
X-Gm-Message-State: APjAAAWznA8BueMj7B+8E5ZMGJ1j1oZzPyBwygVEQcXns+/BBnFkWjXm
        n9dIXqslMdbA+lYDGgiRa2f0XYRcq3Y=
X-Google-Smtp-Source: APXvYqxf4h08TMUe3gHUWq58glaXSW0Q76fOzWQlOwJ2TSmu8xSShqptP8eBdWvKgUdpsbJyVchi5A==
X-Received: by 2002:a1f:96d3:: with SMTP id y202mr9979068vkd.6.1557155775808;
        Mon, 06 May 2019 08:16:15 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id e6sm12799480vkf.0.2019.05.06.08.16.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:16:14 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id x78so8367297vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 08:16:13 -0700 (PDT)
X-Received: by 2002:a67:af10:: with SMTP id v16mr7669474vsl.149.1557155773308;
 Mon, 06 May 2019 08:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181018185616.14768-1-keescook@chromium.org> <20181018185616.14768-3-keescook@chromium.org>
 <CAM0oz-91yjPQKnxGDjwFThs19U=+iziuUr=9z13NSibr_uRxZQ@mail.gmail.com> <20190505131654.GC25640@kroah.com>
In-Reply-To: <20190505131654.GC25640@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 May 2019 08:16:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UV7x-qJU86MzHxY8bqDV7rcc3XoyotKyy_+1MpMM22bA@mail.gmail.com>
Message-ID: <CAD=FV=UV7x-qJU86MzHxY8bqDV7rcc3XoyotKyy_+1MpMM22bA@mail.gmail.com>
Subject: Re: [PATCH pstore-next v2 2/4] pstore: Allocate compression during late_initcall()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 5, 2019 at 6:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 03, 2019 at 11:37:51AM -0700, Douglas Anderson wrote:
> > Hi,
> >
> > On Thu, Oct 18, 2018 at 11:56 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > >
> > > ramoops's call of pstore_register() was recently moved to run during
> > > late_initcall() because the crypto backend may not have been ready during
> > > postcore_initcall(). This meant early-boot crash dumps were not getting
> > > caught by pstore any more.
> > >
> > > Instead, lets allow calls to pstore_register() earlier, and once crypto
> > > is ready we can initialize the compression.
> > >
> > > Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > Fixes: cb3bee0369bc ("pstore: Use crypto compress API")
> > > [kees: trivial rebase]
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  fs/pstore/platform.c | 10 +++++++++-
> > >  fs/pstore/ram.c      |  2 +-
> > >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > I'd propose that these three patches:
> >
> > 95047b0519c1 pstore: Refactor compression initialization
> > 416031653eb5 pstore: Allocate compression during late_initcall()
> > cb095afd4476 pstore: Centralize init/exit routines
> >
> > Get sent to linux-stable.  Specifically I'll mention that 4.19 needs
> > it.  IMO the regression of pstore not catching early boot crashes is
> > pretty serious IMO.
>
> So just those 3 commits and not this specific patch from Joel?

The middle commit ("pstore: Allocate compression during
late_initcall()") is ${SUBJECT} patch and the one with the "Fixes"
tag.

The first commit ("pstore: Centralize init/exit routines") is needed
to apply the middle commit.

I haven't done lots of analysis but the last commit ("pstore: Refactor
compression initialization") sure looks like it's important if you
have the middle commit.  Specifically the middle commit allocates the
compression earlier and the last commit says that it improves handling
of this situation.


Unless someone thinks otherwise, it seems best to apply all 3?


-Doug
