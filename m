Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F040CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10082053B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXs+Kf83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfJUPZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:25:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43843 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJUPZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:25:54 -0400
Received: by mail-io1-f67.google.com with SMTP id c11so7308250iom.10;
        Mon, 21 Oct 2019 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CCsbvZ28JC46guXF6O4rYjXW3fCXuWIxBOZSISvE6SU=;
        b=DXs+Kf83VRyzYDoF+84qUhVH6tRXNDr0QO+onaMzRs+jWfWCKba194bx2vNLFKaW23
         22sPLYAevEV+a2VJniEYOih1eiUPqdK97WcmZszjQxL5LdWnj7U5uq3BXo+8HCLCz1F3
         tDnfWc9UbtuyBCh/4+1kVSj09Vf2DJTCUwh2ccctfnGKrBBXRhMX4Lnm6eWFkQyzM6Hu
         XtL7lN4frPNmjMdsNWNhdSk2Nnu4OJTZUBBK6j4UaiKf2rGvsxkUzpLCCWCmmEEId4KE
         ENzpzylEoU18yDIwO0GCugDI/TQexsiI1TiYeUCy0BPV6YE/c4XH3E73H19i7IwyDscK
         r2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CCsbvZ28JC46guXF6O4rYjXW3fCXuWIxBOZSISvE6SU=;
        b=HiCi47xgrrHOahaSzHNcce9eLXdFO0Fly+9XLjnXjI6KFlq4nUwPN/h9DoD7jn3rh/
         XIjy1GeKhPqSmeSjf/2Mj9rogPC/iRdOJe3yB9/2SFbEMgByN9I6cR7OmKckCKNpRKfm
         dJ11xvkLYv+qkOydjCbbKqbHo3XgFfBKqnyxRBm7sVFEwS+HHwriFXKF8stYrdlSs5MB
         NClllg9XorCl6XK8qdS6RKLPG423Uno/2APEkhU8yP5FOqhy0oJELNsrJGuXkiT9l94C
         PgcbkBEKQdXemPX/KAN8Ceh59U0nRVaSGYN0i1m6qzYthIVtViMjtfME/6A7Z3Kdrc77
         FYAw==
X-Gm-Message-State: APjAAAXiLCSYSWWwpo12WHu8rhTKlHI6aZaCnXh1S4zdSDAfaD010DFw
        wRu2MX8Fu6rnW4xTLArkoCnNKNgwmO0ntrvnA+I=
X-Google-Smtp-Source: APXvYqylqhFAt+QkJvYPFTPhVmwmF4yLwcIEkwyyC9O8N4n+Syf/Y9fPxrrern7uh9qkFWpM4NfDPpHAFarXvCDXm+4=
X-Received: by 2002:a5e:9706:: with SMTP id w6mr19915934ioj.252.1571671552835;
 Mon, 21 Oct 2019 08:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191017014619.26708-1-navid.emamdoost@gmail.com>
 <83dcacc2-a820-fe63-a1b9-1809e8f14f2f@web.de> <57b61298-cbeb-f0ff-c6ba-b8f64d5d0287@canonical.com>
In-Reply-To: <57b61298-cbeb-f0ff-c6ba-b8f64d5d0287@canonical.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon, 21 Oct 2019 10:25:41 -0500
Message-ID: <CAEkB2EQgv9_niKU0dagjZH-wRoHc=6+X4O7nGoVbaz9LWPwy6g@mail.gmail.com>
Subject: Re: [PATCH] apparmor: Fix use-after-free in aa_audit_rule_init
To:     John Johansen <john.johansen@canonical.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 1:51 PM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 10/20/19 7:16 AM, Markus Elfring wrote:
> >> =E2=80=A6 But after this release the the return statement
> >> tries to access the label field of the rule which results in
> >> use-after-free. Before releaseing the rule, copy errNo and return it
> >> after releasing rule.
> >
> Navid thanks for finding this, and Markus thanks for the review
>
> > Please avoid a duplicate word and a typo in this change description.
> > My preference would be a v2 version of the patch with the small clean-u=
ps
> that Markus has pointed out.

John and Markus, I updated and submitted v2.

>
> If I don't see a v2 this week I can pull this one in and do the revisions
> myself adding a little fix-up note.
>
> >
> > =E2=80=A6
> >> +++ b/security/apparmor/audit.c
> > =E2=80=A6
> >> @@ -197,8 +198,9 @@ int aa_audit_rule_init(u32 field, u32 op, char *ru=
lestr, void **vrule)
> >>      rule->label =3D aa_label_parse(&root_ns->unconfined->label, rules=
tr,
> >>                                   GFP_KERNEL, true, false);
> >>      if (IS_ERR(rule->label)) {
> >> +            err =3D rule->label;
> >
> > How do you think about to define the added local variable in this if br=
anch directly?
> >
> > +             int err =3D rule->label;
> >
>
> yes, since err isn't defined or in use else where this would be preferabl=
e
>
> >>              aa_audit_rule_free(rule);
> >> -            return PTR_ERR(rule->label);
> >> +            return PTR_ERR(err);
> >>      }
> >>
> >>      *vrule =3D rule;
> >
> >
> > Regards,
> > Markus
> >
>


--=20
Thanks,
Navid.
