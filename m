Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809CDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3535020882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rb3T1q7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDCSj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:39:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38075 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCSj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:39:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id a6so12489654lfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 11:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fxx0faKFyb7TKtNU/G105y+zDWx6qPB8nbFmxnBcXaI=;
        b=Rb3T1q7essD1fw8HaIIgd0wm2NwLq2iM/iWRbjl6CIAE9QBDI+wNVT86PGYvfv3KEu
         +fvYE9yLPG7KxRLbWi+3aajaMHDrXx9grKsw1a82ZTHuocVQscb0skCM6bG/mz4JrCML
         5mXbQdtddlt7bhYrRiTJAQ7xjanrVZw27lVW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fxx0faKFyb7TKtNU/G105y+zDWx6qPB8nbFmxnBcXaI=;
        b=e238/C7WLkvj1unhY4Og4/7aHih0aNVTPyQlfql01D7zRfCaHW3EsKZAJGatYUg3LI
         TXbfy+XkaQ02JjuNTDIfPgcE3tdUrckreve8hwuVAQVoCVjfTS4KDztvjdlP7K5xzJB0
         tlhAHUvKvFL+v4YCeGZkONrSiN6SqvjAocsT+CqOyX4OQ8jOC6hPouAwS+SRDHFENZ8J
         TqgFTV8SAdTfoLf/rOVhdHapHHtTQb8eKrLKM6RwIbG9MlYwxAtXYH6B6utnWa7s/LV0
         0dS0lYlgD0subVa3MjDFshP4SjOOWKkMVsmGAzmJ4k0JYwcwIlcWe9o1A2aWTCBVVgd3
         dKLg==
X-Gm-Message-State: APjAAAXi0d8dZBkaSzOdgPatb1OAju/hpQPore5i9AY6W0eNYxBJApzK
        N0FcTQ6qYzNHKwaHdSxRAAPyDqNC6CM=
X-Google-Smtp-Source: APXvYqyRxZ6+gpbxTsffMddQrlS+q79ohR0qxY0TeP//ssnngtFdszVZaeMwRJQYw6KO3Yf0DF77fg==
X-Received: by 2002:a19:520e:: with SMTP id m14mr667230lfb.65.1554316794834;
        Wed, 03 Apr 2019 11:39:54 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w19sm2632831lfe.23.2019.04.03.11.39.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 11:39:51 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d18so12471370lfn.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 11:39:50 -0700 (PDT)
X-Received: by 2002:ac2:420b:: with SMTP id y11mr724981lfh.104.1554316790355;
 Wed, 03 Apr 2019 11:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190403160526.257088-1-dianders@chromium.org>
 <CA+ASDXN-4Ya6cK5wsmARXxP0bJCGpMkoyu1t_fS7hqVFKF0ZBw@mail.gmail.com>
 <20190403181415.GQ112750@google.com> <CAD=FV=UC6MpTgmir+nwUy4hWk8Vvz97M5G45=-r5JAg_=z6vQQ@mail.gmail.com>
 <20190403183010.GR112750@google.com>
In-Reply-To: <20190403183010.GR112750@google.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 3 Apr 2019 11:39:38 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMkWha7Lrf8TrDhyF2fXonPjqLKvyKFzVQthxDQUOp=kQ@mail.gmail.com>
Message-ID: <CA+ASDXMkWha7Lrf8TrDhyF2fXonPjqLKvyKFzVQthxDQUOp=kQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_spi: Transfer messages at
 high priority
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Simon Glass <sjg@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ryan Case <ryandcase@chromium.org>,
        Randall Spangler <rspangler@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 11:30 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> The worker is owned by this driver and supposedly we know what we are
> doing. Changing a member in the struct after calling complete() would
> likely be a bug anyway (though not necessarily a fatal one).

The work_struct is owned by the driver, but the *worker* is not. If we
haven't ensured the worker is totally done with the work_struct, then
we should not be freeing the struct. (i.e., we should not return from
the context where it was stack-allocated.)

Anyway, I think we've all agreed that this should be changed,

Brian
