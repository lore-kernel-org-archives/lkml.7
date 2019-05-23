Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7638EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488E520856
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558624267;
	bh=umzeLEHMThKHn+62SsHwRO/gv0Slj+YoyhqoPrudmjo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pvmlgts6l4tETRTOHFSTW7vzhXLnnNIGI9LP1WsAuOOR0Nwl2ybb4ODXyOc0u7V9E
	 +9YXBmATNcYYhp5d/csakpzsRX9U25ROL5y8XmYkWw/TnoDqfCDMDFurR/Hqw36mJT
	 Nqppjy1fjhAnbZELMJQZsX4nt39U7qrSNLfLPtZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfEWPLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:11:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34292 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731009AbfEWPLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:11:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id j24so5839122ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XRLAU6oU5E0/8gW3lY2rtdeODZlzcPWAFZA13HWTCU=;
        b=A87Rf4qG4wn9ePdBXWK4S6A+i4fN/l2BHBriTyA/NV7md909J0ajFqoql7nafgIWFX
         zNeMu8SMtxpeDziW/96Gcai5LoSeFlFor/iwm8XXRysAwkMkqUmZRyYrQAC88L1pZlXU
         ZQKZDUd8/qaGGjTkJPmRfmYpeswXlH3T1V2Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XRLAU6oU5E0/8gW3lY2rtdeODZlzcPWAFZA13HWTCU=;
        b=g1ME4vproLsJAGQu+m18+6QerInQxw6i62wRMGAxjdfpHYnPNIjZ1eSCGjP+BrCQaD
         mYTE56amW10zuQ4j/pFUnLD8vw19IqhuNWH9IwJhS0bg2ByWswADovApBIkra0GUdRX2
         Al3UFGMviB/C4dZ2N0O8gZ8zuEM5t+LonCgLO832F087EUVmNVGblrEhZO7pFXVChPl4
         ngnzjmCS9EY1RNvtFw38g7hz1gj/aqipIFNf8AsREfK+PYBKDXatc24953RDANnLDfLA
         dBvjExjOTNrDhGmFXFqDdG2ek7kNdQbfgjuE+kPRw2zEcxC4Ic4/3S14sAPOukZe/t4z
         t8Tg==
X-Gm-Message-State: APjAAAUvE1JW5UgQFbF6moMVApNwMj2bb7PK0HlpsA8nu9ALomS09e1V
        sRhAlGfY6biQ/nXpdB26xHC4NRbNK5c=
X-Google-Smtp-Source: APXvYqxaqCjyOEHCxc9MQXgkXopn6HZcwV603IGTSMeYKncmqSVra4/Id1PFDeZPU5c2+5QyAU6wCw==
X-Received: by 2002:a2e:9d09:: with SMTP id t9mr16250773lji.151.1558624261471;
        Thu, 23 May 2019 08:11:01 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id n10sm251492lfk.39.2019.05.23.08.11.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 08:11:00 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id e13so5792457ljl.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 08:11:00 -0700 (PDT)
X-Received: by 2002:a2e:9b0c:: with SMTP id u12mr18999482lji.189.1558624260065;
 Thu, 23 May 2019 08:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190523100013.52a8d2a6@gandalf.local.home>
In-Reply-To: <20190523100013.52a8d2a6@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 May 2019 08:10:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5HqJ2Kfgpub+tCWQ2_FiFwEW9H1Rm+an-BLGaGvDDXw@mail.gmail.com>
Message-ID: <CAHk-=wg5HqJ2Kfgpub+tCWQ2_FiFwEW9H1Rm+an-BLGaGvDDXw@mail.gmail.com>
Subject: Re: [RFC][PATCH] kernel.h: Add generic roundup_64() macro
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau@lists.freedesktop.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 7:00 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> +# define roundup_64(x, y) (                            \
> +{                                                      \
> +       typeof(y) __y = y;                              \
> +       typeof(x) __x = (x) + (__y - 1);                \
> +       do_div(__x, __y);                               \
> +       __x * __y;                                      \
> +}                                                      \

The thing about this is that it absolutely sucks for power-of-two arguments.

The regular roundup() that uses division has the compiler at least
optimize them to shifts - at least for constant cases. But do_div() is
meant for "we already know it's not a power of two", and the compiler
doesn't have any understanding of the internals.

And it looks to me like the use case you want this for is very much
probably a power of two. In which case division is all kinds of just
stupid.

And we already have a power-of-two round up function that works on
u64. It's called "round_up()".

I wish we had a better visual warning about the differences between
"round_up()" (limited to powers-of-two, but efficient, and works with
any size) and "roundup()" (generic, potentially horribly slow, and
doesn't work for 64-bit on 32-bit).

Side note: "round_up()" has the problem that it uses "x" twice.

End result: somebody should look at this, but I really don't like the
"force division" case that is likely horribly slow and nasty.

                  Linus
