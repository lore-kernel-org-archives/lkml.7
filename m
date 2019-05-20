Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14592C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE22A20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UeIkx01r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfETIYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:24:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43806 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730599AbfETIYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:24:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so13462215wro.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=epPY5Bbf3jlQHQ1elX7ZxYDeWhZe1GoHoXz/CRgYZZ8=;
        b=UeIkx01rJ4VcMxjz2Y21og3CU6MQuV+e/9nd4BL7tIqeGspEPmEpMzsvEZCmVxmBYD
         pT6eLSfPeDuAszsUTKRBXkvIEoz3tb/lXJJvTN7driv+BmqW2lEtyOodsWYV0dkbRzzw
         si+YpgBkA0Ew9TU0CgweAsaRquS06okMruObO22qq4EheRLqL/WOHKC4om9bkIfO3PVX
         SOnLiruvRU4dHAu0vXSFhr/Tp3fKDvOjZ2IoS/1TlcvFVz6Ab97IObJog9Qgw4EiXP/3
         FflLqU9gl8whIY89OfMWg/Fdv/DtmA+a2yczaC7fxusYOsHFFg81/w9U88T/RniTD++S
         z8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=epPY5Bbf3jlQHQ1elX7ZxYDeWhZe1GoHoXz/CRgYZZ8=;
        b=F/pDVr1oBUX4HgLt7PRxWQz6sBtsaV4mO7kZjYDznbmjdPSJtRTKAd6A6AxxfnFK2d
         V8f4p/4slU0/OIC5SLYnOUpB6uCl7809STlLv+paU3CtpPYUBQVWQViEl1mHTTVRq+ha
         oJOqY1pT7bza6bcZabGdBfFpfrV1iIHqYXBcDjLKkAX3xsH0N4NJ9M/u+he01gw0MNL8
         WfDklXra6di8Jl2JsAlaJHQiDPbLayUTw0LJ9jeyYBZX/9aG6CMFUmzzh/tMZOl9lVln
         ZCgzenWbmOrldA84EV09FRDCxt+sNKCVz0AsWvwkB10ETlCSbxIb76CzStuW10CVhrzj
         zXPA==
X-Gm-Message-State: APjAAAUC/3Fwo1IA48ES/04KFvVfRhHanmpur/30NTDJTivAtLN12GF0
        25NcA9zzQemlHEjO3Izch5QSPw==
X-Google-Smtp-Source: APXvYqw/gIHVanPpxFReieBgDWd8P/6U0dd79m/FYrPzXXxpVg9BPS+jlYTDR327JeSD694qD/k5Qg==
X-Received: by 2002:adf:c601:: with SMTP id n1mr39963038wrg.49.1558340668405;
        Mon, 20 May 2019 01:24:28 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id x64sm24928913wmg.17.2019.05.20.01.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 01:24:09 -0700 (PDT)
Date:   Mon, 20 May 2019 09:24:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: Variable to signed to check return code
Message-ID: <20190520082402.GZ4319@dell>
References: <AM0PR07MB4417C1C3A4E55EFE47027CA2FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
 <20190517102506.GU4319@dell>
 <20190517202810.GA21961@mit.edu>
 <20190518063834.GX4319@dell>
 <20190518195424.GC14277@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190518195424.GC14277@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2019, Theodore Ts'o wrote:

> On Sat, May 18, 2019 at 07:38:34AM +0100, Lee Jones wrote:
> >   "- Acked-by: indicates an agreement by another developer (often a
> >      maintainer of the relevant code) that the patch is appropriate for
> >      inclusion into the kernel."
> > 
> > And I, as a developer (and not a Maintainer in this case) do indicate
> > that this patch is appropriate for inclusion into the kernel.
> > 
> > Reviewed-by has stronger connotations and implies I have in-depth
> > knowledge of the subsystem/driver AND agree to the Reviewer's
> > Statement.  I use Acked-by in this case as a weaker agreement after a
> > shallow review of the patch based on its merits alone.
> 
> Note the "often a maintainer of the relevant code" bit.  And

Exactly, with the *often* (but not always, right!) being the operative
word in that sentence.  As much as I understand the meaning when used
by a Maintainer when commenting on their own subsystem (I use it in
this way a lot too), it doesn't always mean "it's okay for you to take
this patch which usually comes under my jurisdiction".

I think you're missing and if () statement in your understanding:

if (maintainer_of_patches'_subsystem)
   apply_patch_with_supplied_ack();
else
   /* Where 'n' is the regard you hold for the ack supplier. */
   add_n_units_to_patch_credibility(n);

> "appropriate for inclusion into the kernel" means to me that you've
> done the same level of review as Reviewed-by.  So I have very

Actually it doesn't, or else the documentation text for Acked-by would
be just as intense as it is for Reviewed-by.  Reviewed-by IMHO has a
much stronger standing than an Acked-by (caveat: when not provided by
a maintainer of the appropriate subsystem).

> different understanding of how Acked-by and Reviewed-by than you do.

Yes, this is seemingly the case.  It's apparent that the documentation
is not a clear as perhaps it should be, else we wouldn't be having
this conversation.  Maybe this is something which should be discussed
a Kernel Summit.  The result being a patch or two which firms up the
wording/explanation somewhat.

> That being said, no offence to you, but any kind of Acked-by or
> Reviewed-by from you is not going to have as much weight as say, a
> Reviewed-by: from someone like Jan Kara.

Seeing as Jan is a filesystem maintainer, this kind of goes without
saying.  In fact, the only reason a person might have to take the time
to write something like this is to attempt to belittle and cause
offence.  I could be wrong, but probably not. :)

> That's just because I don't have a good sense to your technical
> ability

I guess you could always use Git to gain a reasonable sense of my
technical ability.  The 4,000 committed contributions and many more
thousands of reviews on the mailing list(s), should give you a brief
glimpse.

> and so I'd be doing a full review myself

I'd think a great deal less of you if you didn't.

> and not rely on your review at all....

"at all" - wow!  What kind of message do you think this gives to first
time contributors (like Philippe here), or would-be reviewers?  That
there isn't any point in attempting to review patches, since
Maintainers are unlikely to take it into consideration "at all"?  I
know that when I come to review a patch, if *any* contributor has
taken the time to review a patch, it always plays an important role.

> P.S.  And if I find a problem in the patch, and someone had attached
> their Acked-by or Reviewed-by to it, it would have the same negative
> hit to their reputation either way.  Not a big deal if it happens only
> once, or it's an esepcially tricky issue, but it if happens more than
> once or is really blatent, I as the maintainer definitely do remember.

Again, not really sure of your intentions when you write this out, or
what it has to do with this patch submission or the review there
after, but IMHO this is sending the wrong message to new and would-be
contributors.  As a community we're supposed to be providing a
supportive, encouraging atmosphere.  This paragraph is likely to do
nothing more than scare off people who would otherwise be willing
to have a go [at submitting or reviewing a patch].

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
