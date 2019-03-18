Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE82C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB782133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jmgxWp87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfCRV4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:56:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45986 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfCRV4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:56:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so3101261pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SVuhiGy52/2ZlNVtnb+OWNbx6I5Gr7rOvksWn0tgavs=;
        b=jmgxWp87d4oE2VkG4tgsuH78UtqOXjxn45IcunvggxWHy6eGTEqXl9pva8dpNSgRFn
         e7V4Mz4HQJ8f8CqWNo2+byvwp1rvx/mrEp8WD1uoM2LCYjnuq+qTJjv7pfl0Ypn6FFsk
         woObhp5mHwbOTeYc1pVzTkzdi0aY4oefV5U9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SVuhiGy52/2ZlNVtnb+OWNbx6I5Gr7rOvksWn0tgavs=;
        b=qJ0uhf/BdbqoxPf9VYM/H0+0iRMLVaGu0CJuhIS7gLwApnN4/bVpL25wv2uvLXPYZT
         gXRBu25FOIVbWHoX4ZOkBiVRpInZ7mAX0wVvJErRdwx3Uuo7ViTbr12NV05pl3iRV12K
         plu9Lgd5yO2qFCRuLpp6aBeiT5DYFk5WLoZFW8HWWG9augikTtJpfxXQybrTcRREbsVh
         +/m7uzDTCPuL5gMDm8eKcfjaatHsEIEZ52+jAafOTW8UaiyX/QqtNrE7SlzKE44p2sjE
         +5NMNSKxLKFzQDV9P/fwE2Q75yGIcu1cqqJak5W1e+YTr+JAoknn5IF4r/NSde3JNJcf
         1yTA==
X-Gm-Message-State: APjAAAUnFVSE4F82IE6qB0bytJqc3M725Vl9qGl1yjJZ7bnkiRxqqLiJ
        qWJsoWO6+RnSBRdhcLU0b2DETg==
X-Google-Smtp-Source: APXvYqxW0p5y+NJ9tlDJC9oN6NJ8R7JF5KKD6OkLHpOBQz+57Sud8JxYSq2p3paA+ypZ+KFr5unvIQ==
X-Received: by 2002:a17:902:b698:: with SMTP id c24mr13687389pls.221.1552946166471;
        Mon, 18 Mar 2019 14:56:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f192sm26041669pfc.180.2019.03.18.14.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 14:56:05 -0700 (PDT)
Date:   Mon, 18 Mar 2019 14:56:05 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Behan Webster <behanw@converseincode.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] Revert "kbuild: use -Oz instead of -Os when using clang"
Message-ID: <20190318215605.GJ112750@google.com>
References: <CAG5bF+RvumzKK0E-GAT223jnBvkRe1RN_0J9cGpfPOqCBvfWyw@mail.gmail.com>
 <CAKwvOdnms16AC3jPcc_7MXD7QF43dKvHsi+aqmsz0wX-u1GTpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnms16AC3jPcc_7MXD7QF43dKvHsi+aqmsz0wX-u1GTpA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 02:47:13PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> On Mon, Mar 18, 2019 at 2:10 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > The clang option -Oz enables *aggressive* optimization for size,
> > which doesn't necessarily result in smaller images, but can have
> > negative impact on performance. Switch back to the less aggressive
> > -Os.
> >
> > This reverts commit 6748cb3c299de1ffbe56733647b01dbcc398c419.
> 
> Does scripts/checkpatch.pl complain about this format (full sha, no
> title)?

Nope, for reverts checkpatch is happy with it, I suppose because by
default the subject of the reverted patch is part of the revert's
subject.

> Not sure that necessitates a v2, but if so would be good to
> mention that Clang generates excessive calls into libgcc/compiler-rt
> at -Oz.  Thanks for the patch and the discussion/sanity check.

I can send a v2 if 'needed'.

> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks!

Matthias

> >
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 9ef547fc7ffe..191f3ce3cb5e 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -667,7 +667,7 @@ KBUILD_CFLAGS       += $(call cc-disable-warning, format-overflow)
> >  KBUILD_CFLAGS  += $(call cc-disable-warning, int-in-bool-context)
> >
> >  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> > -KBUILD_CFLAGS  += $(call cc-option,-Oz,-Os)
> > +KBUILD_CFLAGS  += -Os
> >  else
> >  KBUILD_CFLAGS   += -O2
> >  endif
> 
> 
> 
