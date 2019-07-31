Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5044C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77DF206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="AvBrsDTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbfGaWRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:17:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44866 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731311AbfGaWRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:17:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so21721741otl.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a10evfwAD+Hsk/+rS/a81Pg1X9pPEg2+w8iwbXmndgQ=;
        b=AvBrsDTtKVpWZKlZbwnKzPkf5f+TVBYWFzf95aUmvH4n1Y3VKfDf4QBLp497o5oNQa
         YtDnI0+1LbWrRUtm5jKc0nHT39Bt5sSRWT6KDy3dDgednsrf7PwJIfNhsaFdB2SpMIuF
         MFrRtn3UtjIsRdnPQOtECJcu8vefrAjVfVfvmwTClIOKyyjA3NWKATjgtq5kzbF21EVQ
         R9J/qCIo6Vjrf2ICh3xxxXS5u/gYrD+fqwxddeBeNFLlrWnEV6GD6azfEUdlnO6YBVJj
         VjjbGt8WGMq2iEk+OieRyUAX9ivRDxQuiuU6HrRxE1mSvOKtgcLkRD7jM9LvzX+eJ3zv
         TS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a10evfwAD+Hsk/+rS/a81Pg1X9pPEg2+w8iwbXmndgQ=;
        b=OfH3itdAQ6phawYqnV4TG9sUExwPPC87Lko8sxsd0TG6YvAAZYG0GovkMkQb5r+hLy
         4okDvXdWynb7axtdFbLRfKQzSOK9E7ww3w5eOrlUDgKNWXb7gvNpNREtx0Y/SWgri7mN
         zWFDgSRjeiGn4Et43HxBfKUSGMeinYK+1LD670mdZ4sdc8VbM0ogQo3E1GVx7KEnSElZ
         yMzbuPUuBvxaHLf8xK8uGH7eJGMc5+Tvve9h6GPScgipomp7rTMTrxp8ufSnSWG7bW9X
         VAZHhUKtnZDrVcUJujzi9GOTeEsIUme8PzOO+eiVXgGwJt4OFw6+AnuvxTWQ1YQSdL3O
         ELDA==
X-Gm-Message-State: APjAAAVFErGUZr3VNz0Xj8OQFtzYlptJr5Lt2wCdS96ydL8MrqlvxJ5s
        Viak79mzgz5hoB4E7lCO90XcbH4XWBA0oaz66Rc=
X-Google-Smtp-Source: APXvYqzODCYvYkPdL40yypyBxqTSTIOqIIV2J+FHMU4bE3UEZzFjarJMqO/VRYPQackmC8oGV2/kOue+qXp4H+2D058=
X-Received: by 2002:a9d:4b02:: with SMTP id q2mr56683404otf.312.1564611428275;
 Wed, 31 Jul 2019 15:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <5d420f45.1c69fb81.35877.3d86@mx.google.com>
In-Reply-To: <5d420f45.1c69fb81.35877.3d86@mx.google.com>
From:   Tri Vo <trong@android.com>
Date:   Wed, 31 Jul 2019 15:16:57 -0700
Message-ID: <CANA+-vAEnH7JpC1RLQW6jfe=+azyksoLBLQQ1vWVdszJy1xeqA@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 2:59 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Tri Vo (2019-07-31 14:55:14)
> > +/**
> > + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> > + * @parent: Device given wakeup source is associated with (or NULL if virtual).
> > + * @ws: Wakeup source to be added in sysfs.
> > + */
> > +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> > +{
> > +       struct device *dev;
> > +       int id;
> > +
> > +       id = ida_alloc(&wakeup_ida, GFP_KERNEL);
> > +       if (id < 0)
> > +               return id;
> > +       ws->id = id;
> > +
> > +       dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > +                                       wakeup_source_groups, "ws%d",
>
> I thought the name was going to still be 'wakeupN'?

I don't really have an opinion on this. Rafael seems to prefer "ws",
and he's the maintainer :)
>
> > +                                       ws->id);
> > +       if (IS_ERR(dev)) {
> > +               ida_free(&wakeup_ida, ws->id);
> > +               return PTR_ERR(dev);
> > +       }
> > +
> > +       ws->dev = dev;
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
> > +
> > +/**
> > + * wakeup_source_sysfs_remove - Remove wakeup_source attributes from sysfs.
> > + * @ws: Wakeup source to be removed from sysfs.
> > + */
> > +void wakeup_source_sysfs_remove(struct wakeup_source *ws)
> > +{
> > +       device_unregister(ws->dev);
> > +       ida_simple_remove(&wakeup_ida, ws->id);
>
> Should be ida_free()?

oops
>
> > +}
> > +EXPORT_SYMBOL_GPL(wakeup_source_sysfs_remove);
> > +
> > +static int __init wakeup_sources_sysfs_init(void)
> > +{
> > +       wakeup_class = class_create(THIS_MODULE, "wakeup");
> > +
> > +       return PTR_ERR_OR_ZERO(wakeup_class);
> > +}
> > +
> > +postcore_initcall(wakeup_sources_sysfs_init);
>
> Style nitpick: Stick the initcall to the function it calls by dropping
> the extra newline between them.

will do
