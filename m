Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73792C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3500721738
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+kee0cR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfHSKjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:39:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37319 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfHSKjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:39:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1so986801pgp.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 03:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qphoGsTHXUSskf2pKRE//n4CuHLfwr9wJ/jka9mWkIA=;
        b=L+kee0cRCI8M5izNzivlgVPwdLxWmOOTtNBBV6ID4Quyhk5+IERBAgvrK4C2us9n8l
         bj73Z4Mx4YBbKfcTo6FXeeE3BihZ1lXKomYW0g7EqcjR/9ZnbUmp8oNBNVrz/x4q0YKg
         eRPB1SK7lBViPcwiiie1arfJFaZNLBbF33cMoqstHm8l5up1ui9GiUIiu63U9hfihKcM
         Lh9lhbClAEMviwDmyjYdH3MVushub9l3qdOQ/Kxj2kqxQtW2anWNSKNy6eiqKl7nsMdG
         knyfOtCIj6dJR5EYb0xVpbvty4SwchMqomrc3WhiUUTbLrryHrqdxatieczbOwbCOvvq
         zAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qphoGsTHXUSskf2pKRE//n4CuHLfwr9wJ/jka9mWkIA=;
        b=pde2C7UXZSftRkozDab27k6IHbw8oBA+pqLkAnU/1UwGcfK5ynqHTVQMkkvz2YGYK7
         WDb0KAEPdf/0u0Hs5Ft6X6mx27cUZ3+ZcyHN90rZKXJZ+x/GVAAE7zrnjKMxtnQsL5RL
         9KDb8iXt2QcgfwS53ByTJ2C7HHhdn3hpOWzKmzzLGoggL5hSxw/y+MlBuEBktOLK5WTi
         lhOEXyMt26KCc8kzbQpts6SBE6qwDe9TMyfnbTW2s43iC3K4sBSTbrhBf8st89zsvp3e
         NuGQCoLCy6z6XsXcHkoGCQse083jXG6CTXj8yEwms8ydYd0LIHX7w0WS+RAfj8LTf2Lg
         hdlw==
X-Gm-Message-State: APjAAAWlwSmp+KQd6KMvs5vEfQ+TfKlp+X3m3Qk6pBa58M0iUFcyuwyW
        /tovU0vz+I+65Votq0nGI+uWR+fAj/VSCVozVPc=
X-Google-Smtp-Source: APXvYqxTdjeLKQn7HKwDqRoRk4jzL6ShzAQ5pBlwUkq3qAXHaYMS2db8boYszKlqULbL7i9uBimraKEmDOgD5BgTYcQ=
X-Received: by 2002:a63:6eca:: with SMTP id j193mr18892153pgc.74.1566211185659;
 Mon, 19 Aug 2019 03:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190819100724.30051-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190819100724.30051-1-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Aug 2019 13:39:33 +0300
Message-ID: <CAHp75VfivaaAz1s5AD0BxcTCyO3P0yJUajKh0=WJ6f4w1XkHPg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] software node: Introduce software_node_find_by_name()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 1:08 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> There was still one bug spotted by Andy in v2. The role switch node
> was not removed in case of an error (patch 2/3). It is now fixed.

It would be nice to have immutable branch for these changes. There is
at least some other activity regard to intel_cht_int33fe driver.

> The cover letter from v2:
>
> This is the second version of this series where I'm introducing that
> helper.
>
> Hans and Andy! Because of the changes I made to patch 2/3, I'm not
> carrying your reviewed-by tags in it. I would appreciate if you
> could take another look at that patch.
>
> I added a note to the kernel-doc comment in patch 1/3 that the caller
> of the helper function needs to release the ref count after use as
> proposed by Andy.
>
> In patch 2/3, since we have to now modify the role switch descriptor,
> I'm filling the structure in stack memory and removing the constant
> static version. The content of the descriptor is copied during switch
> registration in any case, so we don't need to store it in the driver.
>
> I also noticed a bug in 2/3. I never properly destroyed the software
> node when the mux was removed. That leak is now also fixed.
>
> thanks,
>
> Heikki Krogerus (3):
>   software node: Add software_node_find_by_name()
>   usb: roles: intel_xhci: Supplying software node for the role mux
>   platform/x86: intel_cht_int33fe: Use new API to gain access to the
>     role switch
>
>  drivers/base/swnode.c                         | 37 ++++++++++++
>  drivers/platform/x86/intel_cht_int33fe.c      | 57 ++++---------------
>  .../usb/roles/intel-xhci-usb-role-switch.c    | 27 ++++++---
>  include/linux/property.h                      |  4 ++
>  4 files changed, 71 insertions(+), 54 deletions(-)
>
> --
> 2.23.0.rc1
>


-- 
With Best Regards,
Andy Shevchenko
