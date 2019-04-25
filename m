Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CA5C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E10A2088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqh9FRre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfDYPoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:44:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36822 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfDYPoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:44:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id c35so622622qtk.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 08:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2E9W7oTH/iN84BNoNRhpXZPqpqKBdUlhu4ojiw1m7OA=;
        b=Dqh9FRrew0QtPU8reAGDm9gc/6Ox+rCYhI0zLPkgXd6pQOJ6j1feMvUMSqap5Bjb2+
         vRgY9Ya+gEuR9poRLhTTnZZ/rjDsqUcxYoSqt3kKrc6xk4RdlowZV95KDUJtPFlwdh/D
         1LrIcOQI5zmd2qmprUTBfL5Sta6hW1ivy7ik6fn9xwWKaXmrORzNZbs8Vit5Igh7t/Ai
         LHGkHCE36V7YBOSQNPnSsOHyfPM2D20CrJRijXO5e3QLM4K+B0nYRoPpjQnVOEyXXV1c
         CH3NIn0f0bRjELePUkxDwUuvu8yQBnYU/uE33enhY6UaNzDTGZFpSNDNkxDFE54YIa5u
         dcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2E9W7oTH/iN84BNoNRhpXZPqpqKBdUlhu4ojiw1m7OA=;
        b=J6DOpkOc6ZpYAdO6UylkeB1C95IphcCuJyMdhmqw+F+wS928kheoPgLhFgRHklzOZl
         Ybd+OmuY1EHTprIw+xHTgtxamaRSBmyFSgiGXA8trsE6hHTLhYDO7h5bz5iOymINE/Rt
         nFK0hCyNHEr8qQ8Gg9U93rGqdAEPFZt+BMWBWoC6LCU2EhWWmhKC+rb88n3ssItgnbUe
         K7yYo7u+jcdKo70rx2RZRoFY/5eBO8y4UeD4i/j2GvDA/fMWRxpaYklQRnJKAUjwyUnh
         ZGiVerlYIy2CnIJb22jim9tITpvMMssmswtBMhV9mjfjOfnLy3sB/QKbLEo9UYjGYft9
         Yx5Q==
X-Gm-Message-State: APjAAAUYsiP0gJBkRdYW8pB83U7TwWWT1eE/2Zn8bFZYoNSbVrDLTo5/
        81fWXISQjjxiYsdplIhDpjodiDNdtqPVZBoXE4s=
X-Google-Smtp-Source: APXvYqw+/+l4TU8MnRPJY/0QM+/n6dz63yhB3Tos1/yKikkudqjJOJz96pmHgigEYGyQGTuqPhtK+8RryixvKeSD6Q8=
X-Received: by 2002:a0c:e892:: with SMTP id b18mr13357898qvo.16.1556207049182;
 Thu, 25 Apr 2019 08:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190423143258.96706-1-smuchun@gmail.com> <24b0fff3775147c04b006282727d94fea7f408b4.camel@kernel.crashing.org>
In-Reply-To: <24b0fff3775147c04b006282727d94fea7f408b4.camel@kernel.crashing.org>
From:   Muchun Song <smuchun@gmail.com>
Date:   Thu, 25 Apr 2019 23:44:00 +0800
Message-ID: <CAPSr9jHhwASv7=83hU+81mC0JJyuyt2gGxLmyzpCOfmc9vKgGQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Fix use-after-free and double free on glue directory
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        zhaowuyun@wingtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cheers,

Benjamin Herrenschmidt <benh@kernel.crashing.org> =E4=BA=8E2019=E5=B9=B44=
=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:24=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Tue, 2019-04-23 at 22:32 +0800, Muchun Song wrote:
> > There is a race condition between removing glue directory and adding a =
new
> > device under the glue directory. It can be reproduced in following test=
:
> >
>
>  .../...
>
> > In order to avoid this happening, we we should not call kobject_del() o=
n
> > path2 when the reference count of glue_dir is greater than 1. So we add=
 a
> > conditional statement to fix it.
>
> Good catch ! However I'm not completely happy about the fix you
> propose.
>
> I find relying on the object count for such decisions rather fragile as
> it could be taken temporarily for other reasons, couldn't it ? In which
> case we would just fail...

It could be taken temporarily for other reasons, what reasons?
I also can not figure out which case could result in this.

>
> Ideally, the looking up of the glue dir and creation of its child
> should be protected by the same lock instance (the gdp_mutex in that
> case).
>
> That might require a bit of shuffling around though.
>
> Greg, thoughts ? This whole gluedir business is annoyingly racy still.
>
> My gut feeling is that the "right fix" is to ensure the lookup of the
> glue dir and creation of the child object(s) are done under a single
> instance of gdp_mutex so we never see a stale "empty" but still
> poentially used glue dir around.

I agree with you that the looking up of the glue dir and creation of its ch=
ild
should be protected by the same lock of gdp_mutex. So, do you agree with
the fix of the following code snippet?

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1740,8 +1740,11 @@ class_dir_create_and_add(struct class *class,
struct kobject *parent_kobj)
 static DEFINE_MUTEX(gdp_mutex);

 static struct kobject *get_device_parent(struct device *dev,
-                                        struct device *parent)
+                                        struct device *parent,
+                                        bool *locked)
 {
+       *locked =3D false;
+
        if (dev->class) {
                struct kobject *kobj =3D NULL;
                struct kobject *parent_kobj;
@@ -1779,7 +1782,7 @@ static struct kobject *get_device_parent(struct
device *dev,
                        }
                spin_unlock(&dev->class->p->glue_dirs.list_lock);
                if (kobj) {
-                       mutex_unlock(&gdp_mutex);
+                       *locked =3D true;
                        return kobj;
                }

@@ -2007,6 +2010,7 @@ int device_add(struct device *dev)
        struct class_interface *class_intf;
        int error =3D -EINVAL;
        struct kobject *glue_dir =3D NULL;
+       bool locked;

        dev =3D get_device(dev);
        if (!dev)
@@ -2040,7 +2044,7 @@ int device_add(struct device *dev)
        pr_debug("device: '%s': %s\n", dev_name(dev), __func__);

        parent =3D get_device(dev->parent);
-       kobj =3D get_device_parent(dev, parent);
+       kobj =3D get_device_parent(dev, parent, &locked);
        if (IS_ERR(kobj)) {
                error =3D PTR_ERR(kobj);
                goto parent_error;
@@ -2057,9 +2061,14 @@ int device_add(struct device *dev)
        error =3D kobject_add(&dev->kobj, dev->kobj.parent, NULL);
        if (error) {
                glue_dir =3D get_glue_dir(dev);
+               if (locked)
+                       mutex_unlock(&gdp_mutex);
                goto Error;
        }

+       if (locked)
+               mutex_unlock(&gdp_mutex);
+
        /* notify platform of device entry */
        error =3D device_platform_notify(dev, KOBJ_ADD);
        if (error)

Yours
Muchun
