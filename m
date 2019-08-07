Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55960C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260A322297
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRSw15n3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388980AbfHGQwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:52:25 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33369 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbfHGQwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:52:24 -0400
Received: by mail-ot1-f65.google.com with SMTP id q20so106878409otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPi9Lw9hTsJBEYs108zlDeMOmTTjfOUynKa82EaXNhE=;
        b=qRSw15n3xz+gD1D+HMmThXRe7Y5iSvC1GvI+Wqw1he1k0au5YKLd9rjLK9CoS6owXg
         u11Z+nthRS9L0cseyKzXV7jFamSjJJ3gTQIzBeNRm36bhAuhwHCp4QfdArnH4z5smDUZ
         cpc9IV/f6XczRjoR2u9bFXusSho8J0dTWlCAYeqfR+pgVNre1HUFvwepniR+/9qY0tV6
         HitFKbVZ4fVDcyHA5MkCib28XPd9qfIXnRrESqM5HHKOy7F2c3XQxz3uZTUFDnPhHYOc
         nXknftdVF7vA/cRHaOE6nqCRn6grkUldckxzLV2KD0n8+jrP6lS6VxmzjkO4EBjYxg1u
         VJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPi9Lw9hTsJBEYs108zlDeMOmTTjfOUynKa82EaXNhE=;
        b=a/BxiSBXpcE/1a6cRxeZPgIwBccq3CehuumDsd+nnpB20JAqssyuiq0I4HxVkJtLy5
         2LzTZJYo/ptW+fI5qAsOZbop4BJvpy4Bk0kdA2Ci/4KJvufHePV4FuCE7MQgLD6kfxah
         +AF5QOPhyS0qaik2IVbO/W/e8PBaJPo4QqxmJPCLutIFu+xh1kAAs83GJSxdRtEhDf+H
         4qLgDNICikTW/QwyZccsO/TJP5c3/iZXlAklXBlz/NCIQvd851GTeqgFfrvl5dCN1fmB
         MPojdfudxNNyRu9Xbpk6mrpI3R7DIBOaIK9vSpXSv5Z9r5NxARx6J2AZL0THhJaCBYsE
         0QAA==
X-Gm-Message-State: APjAAAXneXxMDziVHyRfBG1kXp8GuQc1RtO2DFdbLzQc9Xw4pp1Mmuh8
        ROxYPLNic62vRHjZW+sEsXdFebMfSrO/S8yDq2BcPQ==
X-Google-Smtp-Source: APXvYqztRokDDB/HAPtEnq7xZ9nL4QPdYlCFh1c4QQpB6lPX31rwuirChchc4RDvgJOjvaH4EThIIZqmucx9V7c7K3g=
X-Received: by 2002:a05:6830:95:: with SMTP id a21mr9248712oto.35.1565196743500;
 Wed, 07 Aug 2019 09:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190806184007.60739-1-hridya@google.com> <20190806184007.60739-2-hridya@google.com>
 <20190807110204.GL1974@kadam>
In-Reply-To: <20190807110204.GL1974@kadam>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Wed, 7 Aug 2019 09:51:46 -0700
Message-ID: <CA+wgaPNSWbJi3feygHixJX5cLUnQFH0tVSnBrrGQYtE7LUZPzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] binder: Add default binder devices through
 binderfs when configured
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 4:02 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Aug 06, 2019 at 11:40:05AM -0700, Hridya Valsaraju wrote:
> > @@ -467,6 +466,9 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> >       int ret;
> >       struct binderfs_info *info;
> >       struct inode *inode = NULL;
> > +     struct binderfs_device device_info = { 0 };
> > +     const char *name;
> > +     size_t len;
> >
> >       sb->s_blocksize = PAGE_SIZE;
> >       sb->s_blocksize_bits = PAGE_SHIFT;
> > @@ -521,7 +523,24 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> >       if (!sb->s_root)
> >               return -ENOMEM;
> >
> > -     return binderfs_binder_ctl_create(sb);
> > +     ret = binderfs_binder_ctl_create(sb);
> > +     if (ret)
> > +             return ret;
> > +
> > +     name = binder_devices_param;
> > +     for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> > +             strscpy(device_info.name, name, len + 1);
> > +             ret = binderfs_binder_device_create(inode, NULL, &device_info);
> > +             if (ret)
> > +                     return ret;
>
> We should probably clean up before returning...  The error handling code
> would probably be tricky to write though and it's not super common.

Thank you for taking a look Dan. Did you mean cleaning up the default
devices that were already created? They will actually be cleaned up by
binderfs_evict_inode() during the super block's cleanup since the
mount operation will fail due to an error here.

>
> > +             name += len;
> > +             if (*name == ',')
> > +                     name++;
> > +
> > +     }
> > +
> > +     return 0;
> > +
>
> Remove this extra blank line.

Will do in v3, thanks for catching this Dan!

>
> >  }
>
> regards,
> dan carpenter
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
