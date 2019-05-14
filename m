Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EE4C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3A921707
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV1tdJS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfENLv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 07:51:29 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40323 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENLv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:51:29 -0400
Received: by mail-qt1-f196.google.com with SMTP id k24so13578379qtq.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 04:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1sBX4U4iWmOfOwXqMxC9FR33gHwWEfHbWFFPwCSxOH0=;
        b=FV1tdJS5hniNAk7rB4Z8MfOC/G+QAMbgKkjTkVz5s9UfH7vhoVgRv6wIELfTWlOTyO
         fL51HFuO0Fldhv7LzcGAt0bvgSKLJ2CGUIiKlM4WN80HU+FryQiCm/Eodd6rU5E3nR4b
         4acIeYlchvc3/aM6Te7jvr5GOQf9wuP6hcL8WI08f7rLH6EZ44OgsY5YuPfUvAgvWWe5
         4qPJQpnrNy59Kh2mm+Qan/MWkZ2eLSSP7bHupUtS6P5U4ROa+6pC3GfDNaec9nZpsTsq
         ryEMkD5QXVBu2M9vq+JlnGvVjcAOyetOZsdkL4nr6Divgq20CIkNLi4tIdC10bgWcMNd
         cs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1sBX4U4iWmOfOwXqMxC9FR33gHwWEfHbWFFPwCSxOH0=;
        b=QMb9XXHyFlL2bfikNm2beMrRoD7FwnekX0SD23q+kA3lA0pQi7W56y4zcirFx0TqAD
         D55vEI7Fxp2fPskZwirb57S/RRaiD24di19WHleFYQfhI2bnJVkCaJbT8fYIKSVBMiJJ
         ywGM2++MSHEO5kgDIPsSSu+I8HRBgKHbCFWsp67g9poowyOecgiGYvurHGjPCBl55Mqz
         S4+HsfW5OSuT0IHeTEluAAuOjqTrYSuT2BxMkBWnTWm4cp8oY8Ee+4TyFbD1i3NvrsCa
         oQOT+FrDboBQpw/6SNslN7GFkvHmzqIVC0vUhG4YDURG5nzDR3fg7FKywRz6bs8unAne
         vKWw==
X-Gm-Message-State: APjAAAXrX9nPuNpufNDOka5Vzj2Iehnct4lGqPG+DXK7fLlY4MDDr5qT
        fWGOBxpiwRth7mT+1UPYxvAVJO9kK0I9Ane82D4=
X-Google-Smtp-Source: APXvYqwU1dS7a2bEkgUPhZOh8shaCI2h1nM+YeiPfRj5U5vfk7KhghTSyALYEBmg/PX7AnTe3vJZV5QU/dpaCyRYr0M=
X-Received: by 2002:a0c:b997:: with SMTP id v23mr384083qvf.128.1557834688075;
 Tue, 14 May 2019 04:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190423143258.96706-1-smuchun@gmail.com> <24b0fff3775147c04b006282727d94fea7f408b4.camel@kernel.crashing.org>
 <CAPSr9jHhwASv7=83hU+81mC0JJyuyt2gGxLmyzpCOfmc9vKgGQ@mail.gmail.com>
 <a37e7a49c3e7fa6ece2be2b76798fef3e51ade4e.camel@kernel.crashing.org>
 <CAPSr9jHCVCHNK+AmKkUBgs4dPC0UC5KdYKqMinkauyL3OL6qrQ@mail.gmail.com>
 <79fbc203bc9fa09d88ab2c4bff8635be4c293d49.camel@kernel.crashing.org>
 <CAPSr9jHw9hgAZo2TuDAKdSLEG1c6EtJG005MWxsxfnbsk1AXow@mail.gmail.com>
 <d9495ef6-17bc-dc50-f5fe-fb5ff20edfde@codeaurora.org> <c0166ef7-ef76-56d8-6289-276573e3aea7@codeaurora.org>
In-Reply-To: <c0166ef7-ef76-56d8-6289-276573e3aea7@codeaurora.org>
From:   Muchun Song <smuchun@gmail.com>
Date:   Tue, 14 May 2019 19:51:12 +0800
Message-ID: <CAPSr9jGD3m7Whr+Trd1hmKcDFTAdUqWb4nVPKJy_81cy-nBYaQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Fix use-after-free and double free on glue directory
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     Mukesh Ojha <mojha@codeaurora.org>, gregkh@linuxfoundation.org,
        rafael@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        zhaowuyun@wingtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prateek Sood <prsood@codeaurora.org> =E4=BA=8E2019=E5=B9=B45=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On 5/14/19 4:26 PM, Mukesh Ojha wrote:
> > ++
> >
> > On 5/4/2019 8:17 PM, Muchun Song wrote:
> >> Benjamin Herrenschmidt <benh@kernel.crashing.org> =E4=BA=8E2019=E5=B9=
=B45=E6=9C=882=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=882:25=E5=86=99=
=E9=81=93=EF=BC=9A
> >>
> >>>>> The basic idea yes, the whole bool *locked is horrid though.
> >>>>> Wouldn't it
> >>>>> work to have a get_device_parent_locked that always returns with
> >>>>> the mutex held,
> >>>>> or just move the mutex to the caller or something simpler like this
> >>>>> ?
> >>>>>
> >>>> Greg and Rafael, do you have any suggestions for this? Or you also
> >>>> agree with Ben?
> >>> Ping guys ? This is worth fixing...
> >> I also agree with you. But Greg and Rafael seem to be high latency rig=
ht now.
> >>
> >>  From your suggestions, I think introduce get_device_parent_locked() m=
ay easy
> >> to fix. So, do you agree with the fix of the following code snippet
> >> (You can also
> >> view attachments)?
> >>
> >> I introduce a new function named get_device_parent_locked_if_glue_dir(=
) which
> >> always returns with the mutex held only when we live in glue dir. We s=
hould call
> >> unlock_if_glue_dir() to release the mutex. The
> >> get_device_parent_locked_if_glue_dir()
> >> and unlock_if_glue_dir() should be called in pairs.
> >>
> >> ---
> >> drivers/base/core.c | 44 ++++++++++++++++++++++++++++++++++++--------
> >> 1 file changed, 36 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/base/core.c b/drivers/base/core.c
> >> index 4aeaa0c92bda..5112755c43fa 100644
> >> --- a/drivers/base/core.c
> >> +++ b/drivers/base/core.c
> >> @@ -1739,8 +1739,9 @@ class_dir_create_and_add(struct class *class,
> >> struct kobject *parent_kobj)
> >> static DEFINE_MUTEX(gdp_mutex);
> >> -static struct kobject *get_device_parent(struct device *dev,
> >> -                    struct device *parent)
> >> +static struct kobject *__get_device_parent(struct device *dev,
> >> +                    struct device *parent,
> >> +                    bool lock)
> >> {
> >>     if (dev->class) {
> >>         struct kobject *kobj =3D NULL;
> >> @@ -1779,14 +1780,16 @@ static struct kobject
> >> *get_device_parent(struct device *dev,
> >>             }
> >>         spin_unlock(&dev->class->p->glue_dirs.list_lock);
> >>         if (kobj) {
> >> -           mutex_unlock(&gdp_mutex);
> >> +           if (!lock)
> >> +               mutex_unlock(&gdp_mutex);
> >>             return kobj;
> >>         }
> >>         /* or create a new class-directory at the parent device */
> >>         k =3D class_dir_create_and_add(dev->class, parent_kobj);
> >>         /* do not emit an uevent for this simple "glue" directory */
> >> -       mutex_unlock(&gdp_mutex);
> >> +       if (!lock)
> >> +           mutex_unlock(&gdp_mutex);
> >>         return k;
> >>     }
> >> @@ -1799,6 +1802,19 @@ static struct kobject *get_device_parent(struct
> >> device *dev,
> >>     return NULL;
> >> }
> >> +static inline struct kobject *get_device_parent(struct device *dev,
> >> +                       struct device *parent)
> >> +{
> >> +   return __get_device_parent(dev, parent, false);
> >> +}
> >> +
> >> +static inline struct kobject *
> >> +get_device_parent_locked_if_glue_dir(struct device *dev,
> >> +                struct device *parent)
> >> +{
> >> +   return __get_device_parent(dev, parent, true);
> >> +}
> >> +
> >> static inline bool live_in_glue_dir(struct kobject *kobj,
> >>                  struct device *dev)
> >> {
> >> @@ -1831,6 +1847,16 @@ static void cleanup_glue_dir(struct device
> >> *dev, struct kobject *glue_dir)
> >>     mutex_unlock(&gdp_mutex);
> >> }
> >> +static inline void unlock_if_glue_dir(struct device *dev,
> >> +                struct kobject *glue_dir)
> >> +{
> >> +   /* see if we live in a "glue" directory */
> >> +   if (!live_in_glue_dir(glue_dir, dev))
> >> +       return;
> >> +
> >> +   mutex_unlock(&gdp_mutex);
> >> +}
> >> +
> >> static int device_add_class_symlinks(struct device *dev)
> >> {
> >>     struct device_node *of_node =3D dev_of_node(dev);
> >> @@ -2040,7 +2066,7 @@ int device_add(struct device *dev)
> >>     pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
> >>     parent =3D get_device(dev->parent);
> >> -   kobj =3D get_device_parent(dev, parent);
> >> +   kobj =3D get_device_parent_locked_if_glue_dir(dev, parent);
> >>     if (IS_ERR(kobj)) {
> >>         error =3D PTR_ERR(kobj);
> >>         goto parent_error;
> >> @@ -2055,10 +2081,12 @@ int device_add(struct device *dev)
> >>     /* first, register with generic layer. */
> >>     /* we require the name to be set before, and pass NULL */
> >>     error =3D kobject_add(&dev->kobj, dev->kobj.parent, NULL);
> >> -   if (error) {
> >> -       glue_dir =3D get_glue_dir(dev);
> >> +
> >> +   glue_dir =3D get_glue_dir(dev);
> >> +   unlock_if_glue_dir(dev, glue_dir);
> >> +
> >> +   if (error)
> >>         goto Error;
> >> -   }
> >>     /* notify platform of device entry */
> >>     error =3D device_platform_notify(dev, KOBJ_ADD);
> >> --
>
> This change has been done in device_add(). AFAICT, locked
> version of get_device_parent should be used in device_move()
> also.
>

Yeah, I agree with you. I will send the v2 patch later to fix it also.
Thanks.

Yours,
Muchun
