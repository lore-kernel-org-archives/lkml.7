Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BB9C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BBB21D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LJvkmSHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393038AbfIYUN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:13:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46372 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbfIYUN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:13:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id k25so19528oiw.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QGYgy//3euTBO2RPb921udeY715yYdyyXRCdc+pkFYA=;
        b=LJvkmSHKTXJkhgo4wUmQXkaASca4THuoqb6DDCkkD0mdLdbmQsccsT2LoSe7W1oHgO
         Udc+z0gUY9Atmz++PJrdOx8NDhg3RqQ/FAsHm3lKZIRqmWFhR2sDGODYqcGoX5OysHFk
         DIXGxLPFZcv0lCS3+fwnw9VGpx7OJ+8qDdT70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QGYgy//3euTBO2RPb921udeY715yYdyyXRCdc+pkFYA=;
        b=NNQZDpzE+ny9vsM8cvmYXi5SLuabrQnNnO5rB808Ghjp9oqksG5wScfz02TPWvQEqx
         DB/ocao19mjhK1mrU8bR9u9O5sY3dxmOYYsfRmYhA0zXVFNtrki3j2dWp5sZQAwDJCle
         hEnz4zOxHYOnCNs2EmLogEgyvcH5V6KDRt+cLcOued6fmAKU/dZ9BL88f9m2JTqfTa18
         UJu0GmYBCKWpD/YwhBTRXlhkhvrP6/Ijfoqna8EHpfpCMT4CJavApTJ37rYDjXM5DczT
         GeYApNOE/a4weMoU2ItC7wt+me/yX2ST+Rw+5j9fTiQoAknZmO6HIO5EVy/1rHoPACjU
         FFhA==
X-Gm-Message-State: APjAAAWZfNnJgr0caRFarRw+QEBNlUVyWFKFMeqDrfJ0N2VhVI+WifIT
        B2b5ZqQswh/XVoLhUXYwxGSMzz4BNUM=
X-Google-Smtp-Source: APXvYqywsgBSnyIW3KNh9krp+VmQJRIpdUQRjsc5EC73bQv/UaGNM31E7SqpK8nWMTEa2Cz8VS/7xg==
X-Received: by 2002:aca:4e87:: with SMTP id c129mr6018143oib.7.1569442434738;
        Wed, 25 Sep 2019 13:13:54 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id t18sm1954837otd.60.2019.09.25.13.13.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:13:54 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 41so5987964oti.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:13:53 -0700 (PDT)
X-Received: by 2002:a9d:4787:: with SMTP id b7mr192692otf.351.1569442433479;
 Wed, 25 Sep 2019 13:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190916181215.501-1-ncrews@chromium.org> <20190922161306.GA1999@bug>
 <20190922190542.GC3185@piout.net> <CAHX4x876iDn_6Q1+p1SNMncHJezSUQysfM+py0gjD2ytMKBj=w@mail.gmail.com>
 <20190923201938.GB4141@piout.net>
In-Reply-To: <20190923201938.GB4141@piout.net>
From:   Nick Crews <ncrews@chromium.org>
Date:   Wed, 25 Sep 2019 14:13:41 -0600
X-Gmail-Original-Message-ID: <CAHX4x87P6ZHX9e_846NnzCCVJxTTULie_QZ8Dtuvt7HCS312Mg@mail.gmail.com>
Message-ID: <CAHX4x87P6ZHX9e_846NnzCCVJxTTULie_QZ8Dtuvt7HCS312Mg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rtc: wilco-ec: Remove yday and wday calculations
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Benson Leung <bleung@chromium.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Sorry to be a pain, but I passed this by some other Chrome OS
kernel engineers, and when the HW gives a bogus time we
want logging at a more severe level than the dev_dbg() call
in the core, so I'm going to send another revision. It's going to
require duplicated calls to rtc_valid_tm(), but we feel that it is
required.

Thanks,
Nick

On Mon, Sep 23, 2019 at 2:19 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 23/09/2019 11:20:42-0600, Nick Crews wrote:
> > > This is coming from struct tm, it is part of C89 but I think I was no=
t
> > > born when this decision was made. man rtc properly reports that those
> > > fields are unused and no userspace tools are actually making use of
> > > them. Nobody cares about the broken down representation of the time.
> > > What is done is use the ioctl then mktime to have a UNIX timestamp.
> > >
> > > "The mktime function ignores the specified contents of the tm_wday,
> > > tm_yday, tm_gmtoff, and tm_zone members of the broken-down time
> > > structure. It uses the values of the other components to determine th=
e
> > > calendar time; it=E2=80=99s permissible for these components to have
> > > unnormalized values outside their normal ranges. The last thing that
> > > mktime does is adjust the components of the brokentime structure,
> > > including the members that were initially ignored."
> >
> > This is very non-obvious and I only knew this from talking to you,
> > Alexandre. Perhaps we should add this note to the RTC core,
> > such as in the description for rtc_class_ops?
> >
>
> I'm planning to add documentation on what should be done in an RTC
> driver, I'll ensure to add something on this topic.
>
> > For this patch, do you want me to make any further changes?
> >
>
> No need for any changes, however, I can't apply it right now because we
> are in the middle of the merge window.
>
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
