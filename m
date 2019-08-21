Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8019EC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5342722D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNl2JxK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfHUQji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:39:38 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34036 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfHUQjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:39:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id g128so2102156oib.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sxCC5PNKFq1qlMlDHX2114JmkBHkuOiSN9kijvV45PM=;
        b=bNl2JxK9BfMRTnsM4weeTx56/CjtDoDrOyTngIhjMguPbCGnPkzn/7nZLdVuQwqdnU
         /BoK7QZm4kB21Vjv6YeZVPLzmlWCYj1zWh+OL7Mc2+w/+lQy620mJhfCJaZa5n+LAEJL
         PIQbxTPSyRZKVnkgiKbCS62O+dMvWqbBoDtnmfq5sPqPi09RD9CmDD37K9HqHbgfe97R
         pwzNItpK+lTulH3AJB8BlJjiUNnMa3gLind9oPrEADRSg9ckrLMf0G6J91ncw5nX+EmI
         Fk3I4X+90jSRhqhzD+RGdkFBRFkGXwqPfPX4Xctgb/UIT3319MTqjUsnoUa+6+4rVjgV
         pTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sxCC5PNKFq1qlMlDHX2114JmkBHkuOiSN9kijvV45PM=;
        b=CMg78nsaQvo7ZwfOma3W/pgLrrRhv5jw26osLxGw3fTEY1tEcPkj5MDG7CVPpANMym
         W9Y33vm3c++1PAM5d3gUskNaV8ULJgoDFPIoqqoBoTjzdOGlalxjW3iwR+Mt6hwnVC8j
         5akdWVYFom6/o2ymxAF7l+4URSoQjrYThzNX3jnbC/oAdOXqTnSx27MRFs+g3hjrHMm0
         RfR9f7mg+RGd585rgC4N7v5vYkGetktoFdQ3uxZKD0Q3J4aWNWl4d7U8QIyJqzwxugGk
         3NV5+CcnFKhSNXvUMMAsHWCcTthcMsyN1LLWumH+dr4FsB4j0qfxbwvXQn9v2aKvNhyu
         6fgg==
X-Gm-Message-State: APjAAAVGVC5Vqh1EabZmuHd4PY4eBOUB16snttuZkQhD0Xo3a7eqYHaj
        fEywB0wxWi07Aw56zONug7N8sTn4irYAoLt30/ZMwQZ2IAY=
X-Google-Smtp-Source: APXvYqxHIoe+PIEIlnKGzCMCFlcO6qhjhxZbk8ZDmvMG8MgTWgDKHiZYxnzNVxw78jlsDE9DqcOG70I9ndAioOPJCA4=
X-Received: by 2002:aca:5f45:: with SMTP id t66mr647829oib.111.1566405576805;
 Wed, 21 Aug 2019 09:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190315130035.6a8f16e9@narunkot> <20190316031831.GA2499@kroah.com>
 <20190706200857.22918345@narunkot> <20190707065710.GA5560@kroah.com>
 <20190712083819.GA8862@kroah.com> <20190712092319.wmke4i7zqzr26tly@function>
 <20190713004623.GA9159@gregn.net> <20190725035352.GA7717@gregn.net>
 <875znqhia0.fsf@cmbmachine.messageid.invalid> <m3sgqucs1x.wl-covici@ccs.covici.com>
In-Reply-To: <m3sgqucs1x.wl-covici@ccs.covici.com>
From:   Okash Khawaja <okash.khawaja@gmail.com>
Date:   Wed, 21 Aug 2019 09:39:25 -0700
Message-ID: <CAOtcWM0qynSjnF6TtY_s7a51B7JweDb7jwdxStEmPvB9tJFU4Q@mail.gmail.com>
Subject: Re: [HELP REQUESTED from the community] Was: Staging status of speakup
To:     "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, Gregory Nowak <greg@gregn.net>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simon Dickson <simonhdickson@gmail.com>,
        John Covici <covici@ccs.covici.com>,
        linux-kernel@vger.kernel.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 3:49 AM John Covici <covici@ccs.covici.com> wrote:
>
> I think the program is genmap, I  have it in my init sequence, but I
> am not sure it does anything at this point.
>
> On Thu, 25 Jul 2019 00:04:07 -0400,
> Chris Brannon wrote:
> >
> > Gregory Nowak <greg@gregn.net> writes:
> >
> > > keymap
> > > I believe this is the currently active kernel keymap. I'm not sure of
> > > the format, probably what dumpkeys(1) and showkey(1) use. Echoing
> > > different values here should allow for remapping speakup's review
> > > commands besides remapping the keyboard as a whole.
> >
> > AFAIK the Speakup keymap is just for remapping keys to Speakup
> > functions.  It's a binary format, not related to dumpkeys etc.  You need
> > a special program to compile a textual keymap into something that can be
> > loaded into /sys/accessibility/speakup/keymap.  I may have source for
> > that lying around here somewhere.  This is "here there be dragons"
> > territory.  I think the only specification of the format is in the
> > source code.
> >
> > -- Chris
> > _______________________________________________
> > Speakup mailing list
> > Speakup@linux-speakup.org
> > http://linux-speakup.org/cgi-bin/mailman/listinfo/speakup
>
> --
> Your life is like a penny.  You're going to lose it.  The question is:
> How do
> you spend it?
>
>          John Covici wb2una
>          covici@ccs.covici.com
> _______________________________________________
> Speakup mailing list
> Speakup@linux-speakup.org
> http://linux-speakup.org/cgi-bin/mailman/listinfo/speakup


Hi Greg N,

Would like to send this as a patch as Greg K-H suggested? If not, I
can do that with your email in Authored-by: tag?

Thanks,
Okash
