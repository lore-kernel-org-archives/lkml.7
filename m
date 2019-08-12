Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A26C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B5720679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TEtlpoZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfHLOQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:16:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41950 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfHLOQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:16:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so39211930pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=4+IxFmcczn6w0IUyxNclj/z/O54y2p3yNKEitHl1YCg=;
        b=TEtlpoZjJG3S9Vk8AuZ9w3eWebrsx2oy57Mz6EW5bfwt+PEVz38MLfQDGSkDt2jjbk
         D6PTeTmGtc6EFWdvkklBfDZjlq2QNhrZnQa6lgTKzKOEFB6FUtaACBYds3TT0XIHOobu
         m9gaNn0eDPcz28Cn4bPcqtr2NkLrlEfsxgeyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=4+IxFmcczn6w0IUyxNclj/z/O54y2p3yNKEitHl1YCg=;
        b=h+YgrzlsLey6VXMqQzUqN9sJK7J9u6iqbZeOzh643OD2gL1qauHF+0OTk6Wl1PzRGk
         ItR+Aqp8mSAEBQasHKp0LWL5LMNGGxEnRJt3ayTxUSESrokwL1qjd0yHgdUiz2DeqS6M
         8fPObWw2JwXZggvMt07RNgL2V0ecVQFVm6Ziu+oTHa/lEqexOaeRNgTvafjk4aysegGt
         YRTBKRrRh2fTZZcKQ4TCUXbXw86MqD46/jCUPfbpvdcxzZbI3dJuAAiKsff0EGJwhNJa
         i4Eu2TqbxIwmoWpqB8Bc0zE2q86qqRbws6KKARBJaBQVkZqFuYTmQTCTiub1yddX2jVp
         k58A==
X-Gm-Message-State: APjAAAUg1R/1Og5cVyphQZxpL3H7792qsBBcLbvJebEumxUgz2VR4tsm
        Zcu+2GUq3cVTf08vMxJ51shECClZjtg=
X-Google-Smtp-Source: APXvYqxDfttKUcmHsgU/Xg053HVQ+iP2DBqp6JswvMD+CUZv/8p7Qt9eF+EOEyeg6kNVnw+Q/T5xpg==
X-Received: by 2002:aa7:8201:: with SMTP id k1mr34931618pfi.97.1565619374901;
        Mon, 12 Aug 2019 07:16:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i15sm111311568pfd.160.2019.08.12.07.16.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 07:16:14 -0700 (PDT)
Message-ID: <5d5174ae.1c69fb81.85930.8e93@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f441fd9a5452bf2943e5dbe6d74b5d5f26016a90.camel@linux.intel.com>
References: <20190806220750.86597-1-swboyd@chromium.org> <20190806220750.86597-3-swboyd@chromium.org> <f441fd9a5452bf2943e5dbe6d74b5d5f26016a90.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/4] tpm: tpm_tis_spi: Export functionality to other drivers
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
User-Agent: alot/0.8.1
Date:   Mon, 12 Aug 2019 07:16:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-09 13:28:13)
> On Tue, 2019-08-06 at 15:07 -0700, Stephen Boyd wrote:
> > We want to use most of the code in this driver, except we want to modify
> > the flow control and idle behavior. Let's "libify" this driver so that
> > another driver can call the code in here and slightly tweak the
> > behavior.
>=20
> Neither "libifying" nor "slightly tweaking" gives an idea what the
> commit does. A great commit message should be in imperative form
> describe what it does and why in as plain english as possible.
>=20
> Often commit messages are seen just as a necessary bad and not much
> energy is spent on them but for a maitainer solid commit messages have
> an indispensable value.
>=20
> > +     void (*pre_transfer)(struct tpm_tis_spi_phy *phy);
>=20
> Adding a new calback should be a commit of its own.
>=20

Ok. I will do that and focus the commit message.

