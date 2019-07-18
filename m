Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A55CC76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232A92083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563486498;
	bh=jrMI2qXsDA49eM3DXgQLye0VvuDAzJvqQxjpixhN2aA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PPXuYch3OTFQPPj/5A8fv5s/c7EPczJ/JzH23H2Vo2RJXM+7r9vgohccMI7jyG02D
	 rSCQPULZZta0i8cDi1VXAHZabVzdPtqec1o9RwDuq6voABzpmgFwTiF7vS2fb2FBYe
	 7xqaLXRhpX+Q570iF1B+NikLY5EmUMyZrDpeCHh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfGRVsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:48:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45613 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfGRVsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:48:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so28757220lje.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V90HhcWbibDdV+Hl4DqdmtK6PSYfay5zZUxbiy11qL8=;
        b=AbgndksikCBx58WAsi1ZczhBouPLUfbgjv2sLtcDmsg8pYFCnm2zhxh9h2WQ1oZOAa
         rQmJ9vzofCYprP8eVKn1nAZCuA6rj6P1X+ofHAMx8hqNbSoQpeXpkLPrni4gm2YCoC8t
         ZOy8gHGdwD8Q6udD5ij1jCGNlNuIpsQhmDFo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V90HhcWbibDdV+Hl4DqdmtK6PSYfay5zZUxbiy11qL8=;
        b=uSLMoCm5bTmjquCGqTYIH09QEkaZ4c8NEjd9PcEOH68nKJVMY35rXZf/JmKcEQwi9d
         XveWTN8tMWKwoeqxqR1CxKEMEvZjlbb3e81+aMdDDkV1jovVp8gzYUNWKrKb8M/vZH06
         WdlGs6CHH4AMDWyZE5WZjInUXAdmDaCdWFkyY4aDQYGBwWxbMvHR+TcDtIIQAcYj+uSr
         LorALu3HkBi4sCtba3s/cegHH/uKtsOGrXSYY6Havop1qrDCF8+4PPd+4NB06IhKbvz4
         mLSl1edSxNnp/nQXbAkqDhrDWFrCTCqpY/+fw3Jz/Ss5gRHMJqRUy39sZWXECycXsdIO
         c7LQ==
X-Gm-Message-State: APjAAAWQ7OTVUs3RfgD2bol6O/8fBf7JB6kQKV/V5XgqEJzP7GdHPFhe
        ClF5Y/VlUgOQNPnNg7xaAJGl/wMmBJo=
X-Google-Smtp-Source: APXvYqxYLQwAilzlg60XlmMXQpkw9m5XPb3dUINQoHJRFDMfV9OOnd78iDmPUFCY/dXMA+3G3f2dSg==
X-Received: by 2002:a2e:9ac6:: with SMTP id p6mr8993625ljj.100.1563486494120;
        Thu, 18 Jul 2019 14:48:14 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id r24sm5960422ljb.72.2019.07.18.14.48.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 14:48:13 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id q26so20302644lfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:48:13 -0700 (PDT)
X-Received: by 2002:ac2:5601:: with SMTP id v1mr22485468lfd.106.1563486492738;
 Thu, 18 Jul 2019 14:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <333e896cf5bcadd8547fbe4a06388dd3104ff910.camel@hammerspace.com>
In-Reply-To: <333e896cf5bcadd8547fbe4a06388dd3104ff910.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Jul 2019 14:47:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiLJ3r2t02iqCtMxTufTCpKrPBmQ_L7ePZ4f-MwJ8o6A@mail.gmail.com>
Message-ID: <CAHk-=wiiLJ3r2t02iqCtMxTufTCpKrPBmQ_L7ePZ4f-MwJ8o6A@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS changes for Linux 5.3
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 1:25 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
>   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.3-1

This got a conflict with the debugfs "don't behave differently on
failures" changes in net/sunrpc/debugfs.c.

See commit 0a0762c6c604 ("sunrpc: no need to check return value of
debugfs_create functions") by Greg, but I suspect you were already
aware of this.

I did a hack-and-slash "remove the error handling", and the end result
looks sane. Except I left the "if the snprintf overflows" error
handling in place, even if nothing then cares about the returned
error.

I think my merge resolution makes sense, but I thought I'd mention it
in case you had something else in mind. Honestly, the snprintf()
checks in do_xprt_debugfs() look kind o fpointless, but the comment is
also wrong:

        char link[9]; /* enough for 8 hex digits + NULL */

that comment was copied from the "name[]" array in
rpc_clnt_debugfs_register(), but it's bogus, since you actually use

                len = snprintf(link, sizeof(link), "xprt%d", *nump);

on the thing.

And you know what? If you have so many links that "xprt%d" doesn't fit
in 8 chars plus NUL, maybe you don't really care?

But it's also worth noting that the whole snprintf() overflow check is
*wrong* to begin with. When you do

                if (len > sizeof(link))
                        return -1;

you're testing the wrong thing entirely. The returned "len" is the
length that would have been printed _without_ the ending NUL
character, so you actually had a truncation even if it returns
"sizeof(link)" - because then the NUL character was written instead of
the last character.

So the overflow test *should* have been

                if (len >= sizeof(link))
                        return -1;

but I suspect the correct thing to do is to just say "we don't care"
and remove that error check entirely.  Same goes for the other case
("len > sizeof(name)").

At some point error handling doesn't actually add value, as long as
the error itself isn't fatal. And when the error handling itself is
wrong, it's doubly suspect.

But as mentioned, I did *not* remove this part of the error handling.
I only removed the debugfs parts. The error handling may be wrong, but
it is what it is, and it doesn't really matter.

                  Linus
