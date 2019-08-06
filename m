Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0110CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBB0216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbfHFGVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:21:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46508 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731641AbfHFGVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:21:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so81263461edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 23:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0U+y13dMiHzwCn4V2Kd/3Vuhw7hdWOKVjn17zxDfeFA=;
        b=adSYW4hdHxzk3GSWK3Ij8L4+k4NgUDIV4zWvlh1nwVgGmIU6lGEvW5wdRLLQpRogvw
         HKVvV9GLLclBGPA6UMWcrOs5i5R209bQHjOlFvy/T6+IxtGr5qg3CFIUDowMBF0budEt
         FrQqkgXpXz2B4Vc+FKKFq3QolQwSbSgdlopfI7g1kGjCE8wEgryOlkQkVL9Kex331v6+
         RQDzhhYzlUDE3iyTTZTjG9XA48YG15/OUfaMWK6jJQMYE5Xzw95gG006eWy0sCIK4NXD
         0P9QntTWm6Rfb5tr8VPj1o3TJR8xc7yQ/SdtNuYR26ikqQD7rzBJ2bvrEpVrx6Xixq7s
         gHuA==
X-Gm-Message-State: APjAAAUUhFnRDrUh8h0oni8AFKkOYb9ncsmfdKqXNF2KeyFeSsakq0sL
        B1BdkdWWWixGCCU8BiN4sReY+589PGA=
X-Google-Smtp-Source: APXvYqw6r6nNdlKfKLYqz7mmZtKzNLMzdEF60joiVbKXWRRr6vTFff4MuVnx5XZ52tQ5UpUPGs94vg==
X-Received: by 2002:a17:906:32c2:: with SMTP id k2mr1595848ejk.147.1565072459227;
        Mon, 05 Aug 2019 23:20:59 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id f24sm19738390edt.82.2019.08.05.23.20.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 23:20:58 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id g67so71064321wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 23:20:58 -0700 (PDT)
X-Received: by 2002:a1c:c545:: with SMTP id v66mr2563319wmf.51.1565072458497;
 Mon, 05 Aug 2019 23:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-3-swboyd@chromium.org>
 <CAGb2v65njFXzLM_BvkDsZEzxEfkp_FFmFrS+1Ww9ZVen3iwy9g@mail.gmail.com> <5d489548.1c69fb81.44fd6.ab81@mx.google.com>
In-Reply-To: <5d489548.1c69fb81.44fd6.ab81@mx.google.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 6 Aug 2019 14:20:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v67JN_5chMA9ayqCuk-zP4x6qzs8MZCupqLsYRhrg4SfaQ@mail.gmail.com>
Message-ID: <CAGb2v67JN_5chMA9ayqCuk-zP4x6qzs8MZCupqLsYRhrg4SfaQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/57] bus: sunxi-rsb: Remove dev_err() usage after platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 4:44 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Chen-Yu Tsai (2019-08-04 20:35:05)
> > On Wed, Jul 31, 2019 at 2:16 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > >
> > > Please apply directly to subsystem trees
> >
> > I didn't follow this series. Is this for -fixes or -next?
> >
>
> It's for -next. Sorry for not including a link to the patch that
> introduces the platform_get_irq() changes. You can see it here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=7723f4c5ecdb8d832f049f8483beb0d1081cedf6

Applied for 5.4.

Thanks.
