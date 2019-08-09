Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C852DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A072166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DWPweNNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407540AbfHISlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:41:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32965 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfHISlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:41:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id q20so136192950otl.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 11:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65V1JuI2VA80cQiA+hQRPmXIFv0sktRgZklgyYT7uA0=;
        b=DWPweNNhV4+ruQv9Ddd4zqB9w0vtKDVgapB/ZVHrS05Sn8qP4BmMIriNe0wx9XQBGH
         hOF76QgLBKdnwg6w3+Dkuq+ngwyXRP42e/T1eL02kQNGDu00IXab7lmWTo0QiBysr9E/
         TeZlVF/M1hklUCmW09cFplmzLG5DScXSOgnbkJACjKVnylHr2s87Eta7YTGr9m2xvVN8
         qRoINJQcSrSlsguzfhx7xCQRiujtA2/A+kve2xletz9rb8leO26rubFGhWdtoxPAfIJS
         QrRzC4jGVAGQLe/Khw7yFoWPIhCpLPo4hC5Ujj2mu3KCwC/8PxZjQ2eu95XsZzEB7vE8
         Y8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65V1JuI2VA80cQiA+hQRPmXIFv0sktRgZklgyYT7uA0=;
        b=a7Mh7h2QZimzJx+zOs2FfrFaVt36gDo4Bandt1PURZT5qfJDDgPIOCD+ngVOEikKyk
         8lLQxxHlu8S9kL/zu4RApHOHPJ8YHUVCcE6ubkuehPBXK+m0rrfIASPgA+HeLwWsjY9D
         OfixZ2up8ZVRgAM+7kzHsVjFsJynOx5xqO+h9mXhoyU3/sgY3O48TaSR9XsNb4CcUig2
         uPg3N2GUVQmYAIDw0BU7CdujNeYEpq2de5IGW3CLbCbrtwGFShDOPITMlC0H8m5Ybtgn
         ovPo+g+IKYTfmybma9AbJejBK9hTVEDRiXTud3VS8K6Md2roGyaut5UcbTCpABM673rJ
         3Obw==
X-Gm-Message-State: APjAAAVp6l0JX4ev/numu0Vu6uMci4QnM5xG6iuhfVwRTFkbapJK0LMT
        lu/SIUCRE0rkoF7DWfUWajf5FsTWXaRlZGVZ9TF+mA==
X-Google-Smtp-Source: APXvYqxofUvcQ8atqUEUAeawzR1iYVttn85OBd+PtUiLhtQNlBMyJ9X3QlcGqVql+JVlFOO7UV4cffGfKEsIucd9ydw=
X-Received: by 2002:a9d:73d0:: with SMTP id m16mr20182380otk.190.1565376108768;
 Fri, 09 Aug 2019 11:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190808222727.132744-1-hridya@google.com> <20190808222727.132744-3-hridya@google.com>
 <20190809145508.GD16262@kroah.com> <20190809181439.qrs2k7l23ot4am4s@wittgenstein>
In-Reply-To: <20190809181439.qrs2k7l23ot4am4s@wittgenstein>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Fri, 9 Aug 2019 11:41:12 -0700
Message-ID: <CA+wgaPPK0fY2a+pCEFHrw8p8WCb459yw41s_6xppWFfEa=P7Og@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] binder: Validate the default binderfs device names.
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 11:14 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Fri, Aug 09, 2019 at 04:55:08PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Aug 08, 2019 at 03:27:26PM -0700, Hridya Valsaraju wrote:
> > > Length of a binderfs device name cannot exceed BINDERFS_MAX_NAME.
> > > This patch adds a check in binderfs_init() to ensure the same
> > > for the default binder devices that will be created in every
> > > binderfs instance.
> > >
> > > Co-developed-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > > ---
> > >  drivers/android/binderfs.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > > index aee46dd1be91..55c5adb87585 100644
> > > --- a/drivers/android/binderfs.c
> > > +++ b/drivers/android/binderfs.c
> > > @@ -570,6 +570,18 @@ static struct file_system_type binder_fs_type = {
> > >  int __init init_binderfs(void)
> > >  {
> > >     int ret;
> > > +   const char *name;
> > > +   size_t len;
> > > +
> > > +   /* Verify that the default binderfs device names are valid. */
> >
> > And by "valid" you only mean "not bigger than BINDERFS_MAX_NAME, right?
> >
> > > +   name = binder_devices_param;
> > > +   for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> > > +           if (len > BINDERFS_MAX_NAME)
> > > +                   return -E2BIG;
> > > +           name += len;
> > > +           if (*name == ',')
> > > +                   name++;
> > > +   }
> >
> > We already tokenize the binderfs device names in binder_init(), why not
> > check this there instead?  Parsing the same string over and over isn't
> > the nicest.
>
> non-binderfs binder devices do not have their limit set to
> BINDERFS_NAME_MAX. That's why the check has likely been made specific to
> binderfs binder devices which do have that limit.


Thank you Greg and Christian, for taking another look. Yes,
non-binderfs binder devices not having this limitation is the reason
why the check was made specific to binderfs devices. Also, when
CONFIG_ANDROID_BINDERFS is set, patch 1/2 disabled the same string
being parsed in binder_init().

>
> But, in practice, 255 is the standard path-part limit that no-one really
> exceeds especially not for stuff such as device nodes which usually have
> rather standard naming schemes (e.g. binder, vndbinder, hwbinder, etc.).
> So yes, we can move that check before both the binderfs binder device
> and non-binderfs binder device parsing code and treat it as a generic
> check.
> Then we can also backport that check as you requested in the other mail.
> Unless Hridya or Todd have objections, of course.

I do not have any objections to adding a generic check in binder_init() instead.

>
> Christian
