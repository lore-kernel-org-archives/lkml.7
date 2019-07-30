Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F29C31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6392089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qte2AXEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbfG3PgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:36:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36500 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbfG3PgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:36:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so30251251pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=RsDSvj0XBd9M9JvA+8Ajc4I4kcw4F4tZOAQ1/F5AMyE=;
        b=Qte2AXEU7YiOINjmyRfa5IdVOEkz9PiH+5rZyPAyajCthtckGYDS7ptqMCWgsgsvLG
         5reTtHRCUT02LCdEOlW0EWfPphXwpdxy0Ed0k3671RCUnlTNJjAJOJiBfHg1BrusDyWV
         CGEFCn7PZp2V9dwXoMFM7ZJ1eeQyN3Oqh1yk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=RsDSvj0XBd9M9JvA+8Ajc4I4kcw4F4tZOAQ1/F5AMyE=;
        b=Xm4NXOa/xenbLPxGFsQV7VusRfQFU2JLqYPbNIxtaCbkBV6LDanFpbnTkWiED8lRMF
         BHAU9ELhW4+d3INftKcvw4URKLtnCLGSYuIY3RYUQLe2E/VaVmkej49MqTfIkJorRO27
         S0XC3alnRfc9sEI9zX6DQ9WkXFUPU7zI+KH5xlRIqFT9/SzYIbYtNEoibsBdc9OqGIc3
         OLk10whWQqRAhd5ycCP12rj53lZPZBIXd4Stb9Fsz5B9nMnxyT8tojDD8f9Qmus2qoQs
         wH7S2Bl0HvezNWXpNdgG4O5HZLestVXOB9QM50w8yOl9wleho2MhMgsVtNFSMFsJUHVZ
         e+xw==
X-Gm-Message-State: APjAAAUd7GtBw1MnKIfUA9jGzs1+BwmsHB9YmKxOExGa7V2jqI8igfBR
        dLx28BupD96HqFRqXSX98i8Giap949w=
X-Google-Smtp-Source: APXvYqzO0GSirfw7WDJNi/jcxwVL3Bb8RoFr1kgOalH1sd2bjfLLIGbTJyBpNQ1fe29rlNh5vpH+Ww==
X-Received: by 2002:a63:1918:: with SMTP id z24mr104902465pgl.94.1564500960627;
        Tue, 30 Jul 2019 08:36:00 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id cx22sm54730541pjb.25.2019.07.30.08.35.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 08:36:00 -0700 (PDT)
Message-ID: <5d4063e0.1c69fb81.fb7c2.9528@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190730064917.GB1213@kroah.com>
References: <20190730053845.126834-1-swboyd@chromium.org> <20190730053845.126834-3-swboyd@chromium.org> <20190730064917.GB1213@kroah.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 2/3] treewide: Remove dev_err() usage after platform_get_irq()
User-Agent: alot/0.8.1
Date:   Tue, 30 Jul 2019 08:35:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg Kroah-Hartman (2019-07-29 23:49:17)
> On Mon, Jul 29, 2019 at 10:38:44PM -0700, Stephen Boyd wrote:
> > We don't need dev_err() messages when platform_get_irq() fails now that
> > platform_get_irq() prints an error message itself when something goes
> > wrong. Let's remove these prints with a simple semantic patch.
> >=20
> > // <smpl>
> > @@
> > expression ret;
> > struct platform_device *E;
> > @@
> >=20
> > ret =3D
> > (
> > platform_get_irq(E, ...)
> > |
> > platform_get_irq_byname(E, ...)
> > );
> >=20
> > if ( \( ret < 0 \| ret <=3D 0 \) )
> > {
> > (
> > -if (ret !=3D -EPROBE_DEFER)
> > -{ ...
> > -dev_err(...);
> > -... }
> > |
> > ...
> > -dev_err(...);
> > )
> > ...
> > }
> > // </smpl>
> >=20
> > While we're here, remove braces on if statements that only have one
> > statement (manually).
>=20
> I like this, and I like patch 1/3, but this is going to conflict like
> crazy all over the tree with who ever ends up taking it in their tree.
>=20
> Can you just break this up into per-subsystem pieces and send it through
> those trees, and any remaining ones I can take, but at least give
> maintainers a chance to take it.

Ok. Let me resend just this patch broken up into many pieces.

>=20
> You are also going to have to do a sweep every other release or so to
> catch the stragglers.

I was going to let the janitors do that.

