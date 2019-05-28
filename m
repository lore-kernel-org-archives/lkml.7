Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA72C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440162081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPNPgMzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfE1Oto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:49:44 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41176 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfE1Oto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:49:44 -0400
Received: by mail-ua1-f67.google.com with SMTP id l14so7996123uah.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 07:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ZsZglD+dtH05T0KC8c89LwXbA5cgi/yGq9/fSIjPic=;
        b=oPNPgMzyo5ONNyNCaq8WUbB5Vn1GA7mO4dahDdFIuHDRWc5checpqZWQUDTJ4PSAdQ
         4A1jWu60o+TJmTR5BocDnvvoRrAjA1T+d7dMiXqhApTEFJsU7k7F/DB1DVA6RcoW9K8l
         7YkVoTLCb0KW4ANvSmle47r4S3MUay/a+5OLVTK/sKuLhsuqnh/mCWnZsqjOJH68OZ+H
         2TDgBez/A25N9EboF84p5SfPGfThBg/LNOm/ZHEen1WCCLSkrJCrfnDW9tlhMu40vRLx
         YsVMtz3EW1H+JMx7tuHeqznPmmSv1Gt5t6dQRXZ26r1GO8wtIQkKPSi57+8iracsPvfc
         dKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ZsZglD+dtH05T0KC8c89LwXbA5cgi/yGq9/fSIjPic=;
        b=l/UXJCR4YOoR7S1t0qM5QuaVln8BPWMwyoj4AqlVeAOxfE+JtVsjHoRjPCP2C+IBOg
         c4/9aGle1JridIAV6met3Oq+HdmEvue8QZtF/WLo892M7s0Rmh40EGHL59NM5Djg9B1H
         Kf+IwxHIDz3A/aQCAFIQuErj9b4U57gh2mo/JmOpVkhQ5P+7NibFuxD3IMqt/izgDh5n
         gBCvZUNkOJt0EFxQ5RGRrHrAf6ayMa+ms9GQgw+9pnpJi7eB4wWPrBzgt5lPH2ibG4oY
         tqognYk/cI/aO8qiuQLf+0qG6Yku2LW0Wti0WdD0rEoTZsM/yUwqJywrwSQC6kOarMsv
         Upww==
X-Gm-Message-State: APjAAAXuCzdau5LghmGJ6Af6vN7cWwY3KN6NPmrn1RNy7RwBHothLF0X
        2wenz6sasHgi4+Vk6ZXkc4b7KHveL7irkm048Zk=
X-Google-Smtp-Source: APXvYqwHZ6XcMqEweV9vnRuX/F2evgDZcu+D7adtwtba3RgERl+kp3mZGEiSYK4ucwP0xvZEgfqH5CQ8H5UpULpic8E=
X-Received: by 2002:ab0:16d6:: with SMTP id g22mr24384530uaf.14.1559054983290;
 Tue, 28 May 2019 07:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <1559047634-24397-1-git-send-email-92siuyang@gmail.com> <9c6d3fe3-4d7b-f105-62b5-f9d4221543fb@redhat.com>
In-Reply-To: <9c6d3fe3-4d7b-f105-62b5-f9d4221543fb@redhat.com>
From:   Yang Xiao <92siuyang@gmail.com>
Date:   Tue, 28 May 2019 22:49:04 +0800
Message-ID: <CAKgHYH0kSkirQDTQh7iP0kJRUShTW4Q6b-+gPr-K2GcZFM6SgQ@mail.gmail.com>
Subject: Re: [PATCH] vboxguest: check for private_data before trying to close it.
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on your explanation, file->private_data can not be NULL before
call vbg_core_close_session method all the time, since
file->private_data is always set.
Am I right?

On Tue, May 28, 2019 at 9:19 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 28-05-19 14:47, Young Xiao wrote:
> > vbg_misc_device_close doesn't check that filp->private_data is non-NULL
> > before trying to close_session, where vbg_core_close_session uses pointer
> > session whithout checking, too. That can cause an oops in certain error
> > conditions that can occur on open or lookup before the private_data is set.
> >
> > This vulnerability is similar to CVE-2011-1771.
>
> How is this in anyway related to CVE-2011-1771 ????
>
> That CVE is about a filesystems lookup method including a direct open
> of the file for performance reasons and if that direct open fails, doing
> a fput, which is how it ends up with a file with private_date being NULL,
> see:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=703016
>
> "the problem is that CIFS doesn't do O_DIRECT at all, so when you try to open a file with it you get back -EINVAL. CIFS can also do open on lookup in some cases. In that case, fput will be called on the filp, which has not yet had its private_data set."
>
> The vboxguest code on the other hand is not a filessystem and as such
> does not have a dentry lookup method at all!
>
> It's close method is part of the file_operations struct for a character
> device using the misc_device framework which guarantees that private_data
> is always set.
>
> Regards,
>
> Hans
>
>
>
>
>
> >
> > Signed-off-by: Young Xiao <92siuyang@gmail.com>
> > ---
> >   drivers/virt/vboxguest/vboxguest_linux.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
> > index 6e8c0f1..b03c16f 100644
> > --- a/drivers/virt/vboxguest/vboxguest_linux.c
> > +++ b/drivers/virt/vboxguest/vboxguest_linux.c
> > @@ -88,8 +88,10 @@ static int vbg_misc_device_user_open(struct inode *inode, struct file *filp)
> >    */
> >   static int vbg_misc_device_close(struct inode *inode, struct file *filp)
> >   {
> > -     vbg_core_close_session(filp->private_data);
> > -     filp->private_data = NULL;
> > +     if (file->private_data != NULL) {
> > +             vbg_core_close_session(filp->private_data);
> > +             filp->private_data = NULL;
> > +     }
> >       return 0;
> >   }
> >
> >



-- 
Best regards!

Young
-----------------------------------------------------------
