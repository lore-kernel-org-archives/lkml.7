Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AE3C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A00020B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IPgMHj+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfHEVPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 17:15:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42985 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHEVPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:15:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so40247939pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 14:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=6keXzspKhAmzHHzUYun2hJRtsp74WGjMcjc/4i8xe0o=;
        b=IPgMHj+EcmPJ2dDH01EyZqip1NHlIJQNthd6U1205Ff0WJvlhkvwc8qLu8636IzfIV
         d1eP/tAlFQNp1tuEqKZBk2JCAGKEQ1YBKU3PAVAInp/d9O+WHourXyWS556U3XvXkbWy
         6HvgO1wLh5JtSyn4/J3b+laIkLf/HYISi8P4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=6keXzspKhAmzHHzUYun2hJRtsp74WGjMcjc/4i8xe0o=;
        b=aVAqH3pPR3AVisd5IqauV6V9jnrTdhHq8+aNjc6oMWjBFS586OwJG8dCywyky332rC
         01nPTexfZGCH/wqpC/R0cQ1gxXxZ8/SIzg2NR4ZH8NsVMATxa6Q4+wyFH3h0lOxyqL4L
         6G82plw73i/SSaepDBwe9LpHkAZ9qI0D3QaKURwrrl1rfQ/B8IA1lcf0/gn2n4vtPWX8
         h8NfAbrp7+ZQjf2Lv/LL11vjWEWLTO14hvsD+y3xWp9V+OzVtUJkhWSLwL92v3UNFs+3
         JUhYrAquqVLStJLww7QgdtgWr7hDIptjzfefOckpMFFyQmE1AbPXxaIOU+GPkSlG0IZr
         jlNA==
X-Gm-Message-State: APjAAAUZk9br3e25U8QMYOjU2ol9+eaaMZDReaTbDEaZmFUlmjEoEfhr
        /et/IcEBJrsmf8WD0YnQMRg2DQ==
X-Google-Smtp-Source: APXvYqxUCVPnWbjyu68XCc3fQ5aGD1/GCroeo2qy0DJlXwm8x/Cq36U/Awi4tu3dV9++yFSmFeBFVA==
X-Received: by 2002:a17:90a:208d:: with SMTP id f13mr19474353pjg.68.1565039716253;
        Mon, 05 Aug 2019 14:15:16 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i126sm99416306pfb.32.2019.08.05.14.15.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 14:15:15 -0700 (PDT)
Message-ID: <5d489c63.1c69fb81.f26ec.f009@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANA+-vBX0ZAyZu3itcHUpFcqbbDsa5n3xz547mMYCn_q2dbHtw@mail.gmail.com>
References: <20190805175848.163558-1-trong@android.com> <20190805175848.163558-2-trong@android.com> <5d48976e.1c69fb81.a6781.3565@mx.google.com> <CANA+-vBX0ZAyZu3itcHUpFcqbbDsa5n3xz547mMYCn_q2dbHtw@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] PM / wakeup: Drop wakeup_source_init(), wakeup_source_prepare()
From:   Stephen Boyd <swboyd@chromium.org>
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
To:     Tri Vo <trong@android.com>
User-Agent: alot/0.8.1
Date:   Mon, 05 Aug 2019 14:15:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tri Vo (2019-08-05 14:11:55)
> On Mon, Aug 5, 2019 at 1:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Tri Vo (2019-08-05 10:58:46)
> > > @@ -96,13 +79,23 @@ EXPORT_SYMBOL_GPL(wakeup_source_prepare);
> > >  struct wakeup_source *wakeup_source_create(const char *name)
> > >  {
> > >         struct wakeup_source *ws;
> > > +       const char *ws_name;
> > >
> > > -       ws =3D kmalloc(sizeof(*ws), GFP_KERNEL);
> > > +       ws =3D kzalloc(sizeof(*ws), GFP_KERNEL);
> > >         if (!ws)
> > > -               return NULL;
> > > +               goto err_ws;
> > > +
> > > +       ws_name =3D kstrdup_const(name, GFP_KERNEL);
> > > +       if (!ws_name)
> >
> > Does this intentionally change this function to return an error if
> > 'name' is NULL? Before, wakeup_source_prepare() would just assign
> > ws->name to NULL, but now it errors out. I don't see how it's good or
> > useful to allow NULL for the wakeup source name, but it is what it is.
>=20
> Yes, the change to not allow ws->name to be NULL is intentional.

Ok. It would be good to mention it in the commit text so we don't think
it was a bug when looking back a few months later.

