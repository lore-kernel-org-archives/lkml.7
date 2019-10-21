Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFD1CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF60205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stHJW1+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfJUQG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:06:58 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:34195 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUQG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:06:58 -0400
Received: by mail-il1-f194.google.com with SMTP id c12so12548906ilm.1;
        Mon, 21 Oct 2019 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l4jp1v93/2FgQkHywpHT6u/4Wamz/29ge5dqIlchhaE=;
        b=stHJW1+p6Va080aV9Fi+Gwh8Gzw08WrV6ddm4xTzyiRuCgMv83nknJG/2laRPfq3ua
         uXUqNJSt9jQd9wB2srqvzRVXZAh/rB50qqOqY8s4jFZJSCa/GKxydMI05hO2WbfvUrMC
         KkR3P8brBlhohd5S1f5SzFjW5cMyuT+Z50tvxjMCn2rVMrtUX0GT1W8VXSmI1ueGKGp9
         pFEXVUCzPBHc2qHhpCschbHLEkp8VvYoNbWZWNKtRfzqzN3k/5lWTOPGtoXUyS9yovnf
         NADpWYrpgFGyFQtviTh+GKAl7mcagZMomWORSMgMwp9D2cpbEJ4hTaPKhq9ognlYcFyR
         QRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4jp1v93/2FgQkHywpHT6u/4Wamz/29ge5dqIlchhaE=;
        b=tQeJjXwgPdTJKNsPgDRv04IWy7xQkroZGDkewd/nFYnzKSldHudCR5BgXMJBIeNigV
         ed+wXW8LuP0tB+jJoiTi8hpeZx7f+L2z+sryKvtCk12l5OtbsEI7emoeAfEiqQmGWtIC
         pDYg0V0Ahx47HBhuUa8ChI4Ay/IrT6bViCMoo1uqpPdB1D969lrN2S+UWYh+vkTAI0oq
         xVhJ5cKjbvfh7GYF3QMROtp7QZO2C1G8mwuUjhq99zcPOHI7/buYvJK0N6x4eWCNS1Zy
         msHs0v47vtduyDT061S7xwcDQXI3szuuQz2YkUK4fNp7RHBSLsYBe0TDUdDIo5Ve7h9C
         ir2A==
X-Gm-Message-State: APjAAAVZlhHKYcRiFzENF6KGuGxDxXje+wbBMyXvAMkPg5DN2Skot73t
        D6oDjz9/z7fZNf67gcbRT5FIDSw1aqPymOJ4YP8=
X-Google-Smtp-Source: APXvYqxsuyVfOICQ7gWiVy7H633gCGFYS47qfxYVhiZchd2nlRmjovISrhA5hgWsXlAJlOg1FSEJAXErrKhpKlyUh/g=
X-Received: by 2002:a92:4144:: with SMTP id o65mr26124347ila.172.1571674017046;
 Mon, 21 Oct 2019 09:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <57b61298-cbeb-f0ff-c6ba-b8f64d5d0287@canonical.com>
 <20191021152348.3906-1-navid.emamdoost@gmail.com> <20191021154533.GB12140@elm>
In-Reply-To: <20191021154533.GB12140@elm>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon, 21 Oct 2019 11:06:46 -0500
Message-ID: <CAEkB2ETn48r_BaXZ+q0X8-h=zi31C0MN5b51rYuciStTvLoceA@mail.gmail.com>
Subject: Re: [PATCH v2] apparmor: Fix use-after-free in aa_audit_rule_init
To:     Tyler Hicks <tyhicks@canonical.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 10:45 AM Tyler Hicks <tyhicks@canonical.com> wrote:
>
> On 2019-10-21 10:23:47, Navid Emamdoost wrote:
> > In the implementation of aa_audit_rule_init(), when aa_label_parse()
> > fails the allocated memory for rule is released using
> > aa_audit_rule_free(). But after this release, the return statement
> > tries to access the label field of the rule which results in
> > use-after-free. Before releasing the rule, copy errNo and return it
> > after release.
> >
> > Fixes: 52e8c38001d8 ("apparmor: Fix memory leak of rule on error exit path")
>
> Ugh! I'm not sure what I was thinking when I authored that patch. :/
>
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> > Changes in v2:
> >       -- Fix typo in description
> >       -- move err definition inside the if statement.
> >
> >  security/apparmor/audit.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
> > index 5a98661a8b46..334065302fb6 100644
> > --- a/security/apparmor/audit.c
> > +++ b/security/apparmor/audit.c
> > @@ -197,8 +197,9 @@ int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
> >       rule->label = aa_label_parse(&root_ns->unconfined->label, rulestr,
> >                                    GFP_KERNEL, true, false);
> >       if (IS_ERR(rule->label)) {
> > +             int err = rule->label;
>
> Since rule->label is a pointer, I'd like to see this:
>
>  int err = PTR_ERR(rule->label);
>
> >               aa_audit_rule_free(rule);
> > -             return PTR_ERR(rule->label);
> > +             return PTR_ERR(err);
>
> This line would change to:
>
>  return err;
>
Tyler, I made the changes and sent v3.

>
> Tyler
>
> >       }
> >
> >       *vrule = rule;
> > --
> > 2.17.1
> >



-- 
Navid.
