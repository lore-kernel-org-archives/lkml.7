Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CE3C606D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A230214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SagoGHLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfGIEvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:51:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38025 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGIEvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:51:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id z75so8785621pgz.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 21:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NHGXxZKoUC+etV5J4TA2pzGAE32N1lUMWS0xtU10i5g=;
        b=SagoGHLwdhyzez71wGl/CWUd7JfpmwBlosfeoAMty1PvK2lxm4NEetTyojTrzhwaud
         Ts1+0xOhHRFwpsMA3AASevOpJhCQpHPI498ZcCp2Qj9585GB+tRmt389Z+LWTJKx/y7s
         mH1FVgB0X1hwFpGEC/wHgqIXjB8rWZKfMla1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NHGXxZKoUC+etV5J4TA2pzGAE32N1lUMWS0xtU10i5g=;
        b=H+PAnm0QGf8Yj5eXbf9wx45Ue5SleysCDmEczjUZiEF75Ib3XGv7NCHNwUJNYBHfnP
         Al78hVqtSVvDiBaiUdvJl1gVCun/VnN0cBuMRRGdYT/YPR3ojFzr86geQAeGID+CcwEU
         gsWvtERo+T58p+oeDQnP+je1gQ+7A9WLgC/T5W3Unsh9P55+jVDa5OS9G0bZqCV9i2Sg
         oBwVua05upVbIywbByaafOpfPjRKbhYoqvdjnzxYb27IQs5XoBNlmCy9QhQi0DsEVmqW
         KNU+9IywwJ1bdC6ypWYlED18UvwVIyqzgUKMQdM01MzoRZwa4BFbOBembfyVuuE/YQhd
         pLRw==
X-Gm-Message-State: APjAAAWnAXAUbUknivVsUXxCBggzhX27w7sHYUg4W12hlg26I0zwTMS/
        ZCuiDljeIrklT7mwVuxWFinQ5A==
X-Google-Smtp-Source: APXvYqyra4dBr6pwAJEejOYr3AfqsfOhUfKQCLpljKcJwOvohsdTUY/A0C/0JPVAWBLwSN9mXPaIsg==
X-Received: by 2002:a63:7a5b:: with SMTP id j27mr28067294pgn.242.1562647873177;
        Mon, 08 Jul 2019 21:51:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n7sm23797582pff.59.2019.07.08.21.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 21:51:12 -0700 (PDT)
Date:   Mon, 8 Jul 2019 21:51:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jann Horn <jannh@google.com>, PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH v5 06/12] S.A.R.A.: WX protection
Message-ID: <201907082140.51E0B9E2@keescook>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
 <1562410493-8661-7-git-send-email-s.mesoraca16@gmail.com>
 <20190706192852.GO17978@ZenIV.linux.org.uk>
 <CAJHCu1+JYWN7mEHprmCc+osP=K4qGA9xB3Jxg53_K4kwo4J6dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHCu1+JYWN7mEHprmCc+osP=K4qGA9xB3Jxg53_K4kwo4J6dA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2019 at 05:49:35PM +0200, Salvatore Mesoraca wrote:
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Sat, Jul 06, 2019 at 12:54:47PM +0200, Salvatore Mesoraca wrote:
> >
> > > +#define sara_warn_or_return(err, msg) do {           \
> > > +     if ((sara_wxp_flags & SARA_WXP_VERBOSE))        \
> > > +             pr_wxp(msg);                            \
> > > +     if (!(sara_wxp_flags & SARA_WXP_COMPLAIN))      \
> > > +             return -err;                            \
> > > +} while (0)
> > > +
> > > +#define sara_warn_or_goto(label, msg) do {           \
> > > +     if ((sara_wxp_flags & SARA_WXP_VERBOSE))        \
> > > +             pr_wxp(msg);                            \
> > > +     if (!(sara_wxp_flags & SARA_WXP_COMPLAIN))      \
> > > +             goto label;                             \
> > > +} while (0)
> >
> > No.  This kind of "style" has no place in the kernel.
> >
> > Don't hide control flow.  It's nasty enough to reviewers,
> > but it's pure hell on anyone who strays into your code while
> > chasing a bug or doing general code audit.  In effect, you
> > are creating your oh-so-private C dialect and assuming that
> > everyone who ever looks at your code will start with learning
> > that *AND* incorporating it into their mental C parser.
> > I'm sorry, but you are not that important.
> >
> > If it looks like a function call, a casual reader will assume
> > that this is exactly what it is.  And when one is scanning
> > through a function (e.g. to tell if handling of some kind
> > of refcounts is correct, with twentieth grep through the
> > tree having brought something in your code into the view),
> > the last thing one wants is to switch between the area-specific
> > C dialects.  Simply because looking at yours is sandwiched
> > between digging through some crap in drivers/target/ and that
> > weird thing in kernel/tracing/, hopefully staying limited
> > to 20 seconds of glancing through several functions in your
> > code.
> >
> > Don't Do That.  Really.
> 
> I understand your concerns.
> The first version of SARA didn't use these macros,
> they were added because I was asked[1] to do so.
> 
> I have absolutely no problems in reverting this change.
> I just want to make sure that there is agreement on this matter.
> Maybe Kees can clarify his stance.
> 
> Thank you for your suggestions.
> 
> [1] https://lkml.kernel.org/r/CAGXu5jJuQx2qOt_aDqDQDcqGOZ5kmr5rQ9Zjv=MRRCJ65ERfGw@mail.gmail.com

I just didn't like how difficult it was to review the repeated checking.
I thought then (and still think now) it's worth the unusual style to
improve the immediate readability. Obviously Al disagrees. I'm not
against dropping my suggestion; it's just a pain to review it and it
seems like an area that would be highly prone to subtle typos. Perhaps
some middle ground:

#define sara_warn(msg)	({				\
		if ((sara_wxp_flags & SARA_WXP_VERBOSE))	\
			pr_wxp(msg);				\
		!(sara_wxp_flags & SARA_WXP_COMPLAIN);		\
	})

...

	if (unlikely(sara_wxp_flags & SARA_WXP_WXORX &&
		     vm_flags & VM_WRITE &&
		     vm_flags & VM_EXEC &&
		     sara_warn("W^X")))
		return -EPERM;

that way the copy/pasting isn't present but the control flow is visible?

-- 
Kees Cook
