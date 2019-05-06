Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B53C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5DB2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CSEZ6Jri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfEFPjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:39:14 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41883 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfEFPjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:39:14 -0400
Received: by mail-yw1-f65.google.com with SMTP id o65so8891852ywd.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QtAJPN/issoSyhS/fgMnZjKOMoByFNd896NEgVmz7Sk=;
        b=CSEZ6JriGjyK0yC7LNrSbJ8jsF+V8BRrTJiBaphVlBHApmR6rkiSmNPdNBjW+QVrt4
         M2VA9VdcrG1TjhjDBoH1LrBuX8uluKdfQqDhJWj1VR6HqGiHFl6GkSeaAlI6o8Tjzw4K
         fTcjSZ0ov9kUnM5JDOJeCeL6Lnwj2BR2MHJdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QtAJPN/issoSyhS/fgMnZjKOMoByFNd896NEgVmz7Sk=;
        b=N0y+EdhFuqIOGygmCUVy55YPIeJnRqLBOoHul1sz6vrnA/LOo7JPSXzxE9WbvrGEVn
         YYn+rUe57QWuWuaoYPA3/zfnTPvarwuJFE+2fU7mWgMOetq/nQbFa6u7wKHoqAsslerL
         tWErShIVK/I0zcbK2XE7yIQh9MLw1mbP2HrL+q/M7dU8/lpoFSgUGH8mWGGW4KpPuZS/
         tvTcl7uomqAQklUv4sqTlcKzTXvBvXwHKbp9/yLCY/MW0uQgrTN0XRI4/ofWmC07NVDb
         +EaRlwn8qbPen9O/F/GAtICVzTMCHIm1pHyAHbAj2h4mDfxu/zcutAF1x04hHT9pqrs4
         q9wA==
X-Gm-Message-State: APjAAAVP8qp28sPZHVBqlsYKQq+iiNlrP8uz5RocxRMxgdBbD3CLvB4a
        NZnrFjkX/Ue6wVdejCojR5qE2K6l0sg=
X-Google-Smtp-Source: APXvYqxxGCF7CN/oDbphnMXpzSxEaqaFX80Am7GsxAOX881NSTn7RZVe2GKun9FyYG8zAPXZHAz+RQ==
X-Received: by 2002:a81:3955:: with SMTP id g82mr18216840ywa.274.1557157152928;
        Mon, 06 May 2019 08:39:12 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id 12sm3034146yww.88.2019.05.06.08.39.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:39:11 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id a130so5066160ywe.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 08:39:11 -0700 (PDT)
X-Received: by 2002:a0d:ca47:: with SMTP id m68mr5699628ywd.229.1557157151272;
 Mon, 06 May 2019 08:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181018185616.14768-1-keescook@chromium.org> <20181018185616.14768-3-keescook@chromium.org>
 <CAM0oz-91yjPQKnxGDjwFThs19U=+iziuUr=9z13NSibr_uRxZQ@mail.gmail.com>
 <20190505131654.GC25640@kroah.com> <CAD=FV=UV7x-qJU86MzHxY8bqDV7rcc3XoyotKyy_+1MpMM22bA@mail.gmail.com>
In-Reply-To: <CAD=FV=UV7x-qJU86MzHxY8bqDV7rcc3XoyotKyy_+1MpMM22bA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 6 May 2019 08:38:57 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKzH0Ttdtp5bXP_EAfp+fA+tEQwLXh=VmZ1r5q6wdpqaw@mail.gmail.com>
Message-ID: <CAGXu5jKzH0Ttdtp5bXP_EAfp+fA+tEQwLXh=VmZ1r5q6wdpqaw@mail.gmail.com>
Subject: Re: [PATCH pstore-next v2 2/4] pstore: Allocate compression during late_initcall()
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
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

On Mon, May 6, 2019 at 8:16 AM Doug Anderson <dianders@chromium.org> wrote:
>
> On Sun, May 5, 2019 at 6:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, May 03, 2019 at 11:37:51AM -0700, Douglas Anderson wrote:
> > >
> > > On Thu, Oct 18, 2018 at 11:56 AM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > >
> > > > ramoops's call of pstore_register() was recently moved to run during
> > > > late_initcall() because the crypto backend may not have been ready during
> > > > postcore_initcall(). This meant early-boot crash dumps were not getting
> > > > caught by pstore any more.
> > > >
> > > > Instead, lets allow calls to pstore_register() earlier, and once crypto
> > > > is ready we can initialize the compression.
> > > >
> > > > Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > > Fixes: cb3bee0369bc ("pstore: Use crypto compress API")
> > > > [kees: trivial rebase]
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  fs/pstore/platform.c | 10 +++++++++-
> > > >  fs/pstore/ram.c      |  2 +-
> > > >  2 files changed, 10 insertions(+), 2 deletions(-)
> > >
> > > I'd propose that these three patches:
> > >
> > > 95047b0519c1 pstore: Refactor compression initialization
> > > 416031653eb5 pstore: Allocate compression during late_initcall()
> > > cb095afd4476 pstore: Centralize init/exit routines
> > >
> > > Get sent to linux-stable.  Specifically I'll mention that 4.19 needs
> > > it.  IMO the regression of pstore not catching early boot crashes is
> > > pretty serious IMO.
> >
> > So just those 3 commits and not this specific patch from Joel?
>
> The middle commit ("pstore: Allocate compression during
> late_initcall()") is ${SUBJECT} patch and the one with the "Fixes"
> tag.
>
> The first commit ("pstore: Centralize init/exit routines") is needed
> to apply the middle commit.
>
> I haven't done lots of analysis but the last commit ("pstore: Refactor
> compression initialization") sure looks like it's important if you
> have the middle commit.  Specifically the middle commit allocates the
> compression earlier and the last commit says that it improves handling
> of this situation.
>
>
> Unless someone thinks otherwise, it seems best to apply all 3?

At first glance, yes, but let me double-check it this morning. There
were some subtle changes that made me not initially want to backport
these, but it should be doable. :)

-- 
Kees Cook
