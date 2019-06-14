Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D386C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59431217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa7gt+b8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfFNRtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:49:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33558 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfFNRtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:49:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id q186so2600797oia.0;
        Fri, 14 Jun 2019 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uh1+3KE9gKm4KZIs9/7l9hj6y2A3Yj0OqTt1Km3GXMs=;
        b=aa7gt+b8zR4jxbR9c2UZw6J4tbU+lb/BhEjrQD0CmSJBnoF5/pNziAjID/YERMzFqf
         YZxwLG/BZdusHJoNP6+vXBvhFqKU7eZEhIiCLpvZ7IqMkdr3eT8b9W2IFnz8NT/r1J6D
         tjT+TS4vHQRaGWMRKyER+AyVqy1tKI1BZlYq5KMwEkyTl0QdaFmhIToK3KZMAJqMlHz+
         UdHL4uSbIadCvpvaStgByhS3VDyZ0TPa+hwp1IFqH2gYI0wnbkwjSuW6smzPF/FXu77M
         VsdMG2+WYI6/PGrLYuYyf4p6HfaIcYS/ThOHaP4RDknHTjm3RpEKOLz+HIb01xVxxgUM
         zOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uh1+3KE9gKm4KZIs9/7l9hj6y2A3Yj0OqTt1Km3GXMs=;
        b=HCfiwBE90Kxf16si8Ax7KBxSRHyPDsoSg/U0x3+nlFLWBZvOo3OdQbNzpAJVZ1Ecqv
         kgh/g4qcojZcAbPwk7XwfgeMKMKnYRcU4Wnszve26q0nWqAsyoNGxFau6yX/uqXid5DA
         YMTDWKPFEP/JWXXoMoWc5cmRnIfK2DDbi9chzvvq9M1DsMlIAdD4sJtRxTQvDq8PbGG0
         XfRUbrBTpXsVSVXdi8NOuHjLa1lMUVsdFmjnEQY8FsLyNYnlANuwBciul4jyPi2dlk8A
         Hjdht0gbhV1bbM6Eib23kT8QwhiSOp1WASqso+guvfM5mYD2vWctddQC9AeTKIDnxapQ
         6RZw==
X-Gm-Message-State: APjAAAV13IG/4RUGA4YYnAcv6hERkWP/sO4zOvzRWHnDTzVpHIwapS9Z
        tr70N0gN+2xJvxpFG+mk/pHmpsYxUvlHxTRobjQ=
X-Google-Smtp-Source: APXvYqxunKhwmijCoQipaI1GgNoN0vpKKYvcN5gYQvFSlbeJgKA/nHbHtAMOvE2FPjeQNVET09mDDJWQ8foH0AaY6sA=
X-Received: by 2002:aca:d552:: with SMTP id m79mr2589545oig.3.1560534546580;
 Fri, 14 Jun 2019 10:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190612221549.28399-1-prsriva02@gmail.com> <20190612221549.28399-2-prsriva02@gmail.com>
 <1560453720.4805.46.camel@linux.ibm.com>
In-Reply-To: <1560453720.4805.46.camel@linux.ibm.com>
From:   prakhar srivastava <prsriva02@gmail.com>
Date:   Fri, 14 Jun 2019 10:48:55 -0700
Message-ID: <CAEFn8qJS7MHN5o0kRjr-0_aqy0xkpCttFEzrh_8+9qqBmK3MdA@mail.gmail.com>
Subject: Re: [PATCH V8 1/3] Define a new IMA hook to measure the boot command
 line arguments
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>, vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 12:22 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Prakhar,
>
> Patches titles in the subject line need to be prefixed with the
> subsystem, in this case "ima: ".
>
> On Wed, 2019-06-12 at 15:15 -0700, Prakhar Srivastava wrote:
> > This patch adds support in ima to measure kexec cmdline args
> > during soft reboot(kexec_file_load).
>
> Based on the patch title, the word "ima" is redundant.  Patch
> descriptions are suppose to be written in the third person. "This
> patch adds" is unnecessary.  Please review section 3 "Describe your
> changes" in Documentation/process/submitting-patches.rst.
>
> >
> > - A new ima hook ima_kexec_cmdline is defined to be called by the
> > kexec code.
> > - A new function process_buffer_measurement is defined to measure
> > the buffer hash into the ima log.
> > - A new func policy KEXEC_CMDLINE is defined to control the
> >  measurement.[Suggested by Mimi]
> >
> > Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
>
>
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index fd9b01881d17..98e351e13557 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -292,6 +292,13 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
> >  {
> >       int i;
> >
> > +     /* only incase of KEXEC_CMDLINE, inode is NULL */
> > +     if (func == KEXEC_CMDLINE) {
> > +             if ((rule->flags & IMA_FUNC) &&
> > +                     (rule->func == func) && (!inode))
>
> Thank you for fixing the other formatting issues.  Here's another one.
>  Is checking !inode needed?
Since i am adding a new type(buffer) for measurement, and only
one (file or buffer) can be passed in, this is guarding against passing
the func as KEXEC_CMDLINE for a file.
I will remove it, since the check will still return true/false, if the
rule doesn't
exist.

and fix other formatting issues.
Thanks,
- Prakhar Srivastava
> Mimi
>
> > +                     return true;
> > +             return false;
> > +     }
> >       if ((rule->flags & IMA_FUNC) &&
> >           (rule->func != func && func != POST_SETATTR))
> >               return false;
> >
>
