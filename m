Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BA4C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884F92075E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6uS7I64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfF0VmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:42:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43218 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0VmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:42:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id 16so3841878ljv.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMYPQ8HMwHsCu6Nb47E3eYy5SYkz8O/qNoaUqvE9/MA=;
        b=i6uS7I64eUcQYgWj3c9jAsLFmKoZ/q4U1ARoqLXaf/YYG6/XKX4AFmJsVHu8ajhu8F
         u/851Ek5TISb9oKcMr4gdoc97WJOWUN9L2EaFUzcuHcVgkAFa/aIk00P2zCsY+DEKLbb
         QVX4X2B53szP9bzFueP7gJQs6nlm5JL1pPJAXbZ7xyVGoTv4qCLOGtK9IlKbuNK7mpS1
         V9V4nYBBIn9uw/jdDC6NzHcOCeJdusC/cbvB5yzj/ZOuu/3cHn3fzNuEjgt+KCGgFJax
         RMZitSXX+ZB+xjhqB/Au1y7H81Xk+YEcQEZ163jAPyP6SEOQRWfTHLbio0Upf6BZZ8CG
         ok0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMYPQ8HMwHsCu6Nb47E3eYy5SYkz8O/qNoaUqvE9/MA=;
        b=VNntjrJJ/0la/PkoOBdZvI0Y8gSh1y3qMiUe2HYQLRvAmgcyBJns/pApgFk4poOjGs
         mX122N5lYpKhJpQwSxm64jlxwaeIwoB/My2ch4zNNaumyc3PBkEOhh9W3IGegxsTWT9U
         aKxZF6cCRSHPPJYXrP/LIvJ11droWcFHfMo43GnlNlhR4l9JJmGZe8ajHDsck4E4mTTK
         pTBJXkN3cXR7LhJzp+YA+TMt0UvM/NtoU+2//KefGyqu2gc1aFniiOq0wh++lEOIaVvp
         gu8xAGKqT4oJMhyA3cAS6j7qNfTfmH5s2HxIL/w9FzblUuuFwG51IltNFRT3s0c5XWbk
         a7VA==
X-Gm-Message-State: APjAAAWy61A8m3VG0KfKpCNUXeaX8OmpeqbyuiwIC5aAXoKgj6hQ08tD
        nGpE4eeqTrhU1zaqkyJULCaiXhLr9hAXzhfx3I37IhWIz5w=
X-Google-Smtp-Source: APXvYqwjCRMWLMJwN8uYVOflAp6npBo8Enm8Kh9HtUnKPohkjA5si4zEphHh9vaaaJMztaekITPHbnUJZQJyzpu0bOI=
X-Received: by 2002:a2e:8345:: with SMTP id l5mr3873254ljh.18.1561671737949;
 Thu, 27 Jun 2019 14:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190625205101.33032-1-rajatja@google.com> <a755588b-1062-7c4f-7c03-f35ca23f39a4@collabora.com>
In-Reply-To: <a755588b-1062-7c4f-7c03-f35ca23f39a4@collabora.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 27 Jun 2019 14:41:41 -0700
Message-ID: <CACK8Z6HFzn+tAL7KRmTF4Eet2VRYwr9D2sndeQXcfrQg2qkGPw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: lightbar: Assign drvdata during probe
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Wed, Jun 26, 2019 at 1:34 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Rajat,
>
> On 25/6/19 22:51, Rajat Jain wrote:
> > The lightbar driver never assigned the drvdata in probe method, and thus
> > causes a panic when it is accessed at the suspend time.
>
> Good catch, that's one of the problems I currently have with mainline on Samus.
> The other one, that I didn't find time to look at is, that for some reason, when
> I suspend the system reboots. Is suspend/resume working for you in current mainline?

I haven't tried current mainline yet. (I tried, but wasn't able to
build it like I used to. If you have a recipe, can you share and I can
give it a try).
I was seeing the same symptoms on my Hatch (using 4.19) before this
patch. I found this was the cause of the reboot, and is fixed now with
this patch. May be you can try on Samus with its fix?

>
> There is no drvdata because we don't really need extra private data for this
> driver, the ec_dev is directly the drvdata provided by device parent. I am
> wondering if you can just do
>
>    struct cros_ec_dev *ec_dev = to_cros_ec_dev(dev);
>
> in the suspend/resume calls like we do in the show/store calls or get the
> drvdata from its parent. I guess I prefer the first one.

The dev in suspend() callback points to "cros-ec-lightbar" device
instead of "cros-ec-dev", so we'd need to reach the parent. I'll send
a new patch in a moment.

Thanks,

Rajat


>
> >
>
> Would be nice have a fixes tag here.
>
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  drivers/platform/chrome/cros_ec_lightbar.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> > index d30a6650b0b5..98e514fc5830 100644
> > --- a/drivers/platform/chrome/cros_ec_lightbar.c
> > +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> > @@ -578,11 +578,14 @@ static int cros_ec_lightbar_probe(struct platform_device *pd)
> >
> >       ret = sysfs_create_group(&ec_dev->class_dev.kobj,
> >                                &cros_ec_lightbar_attr_group);
> > -     if (ret < 0)
> > +     if (ret < 0) {
> >               dev_err(dev, "failed to create %s attributes. err=%d\n",
> >                       cros_ec_lightbar_attr_group.name, ret);
> > +             return ret;
> > +     }
> >
> > -     return ret;
> > +     platform_set_drvdata(pd, ec_dev);
> > +     return 0;
> >  }
> >
> >  static int cros_ec_lightbar_remove(struct platform_device *pd)
> >
>
> Thanks,
> ~ Enric
