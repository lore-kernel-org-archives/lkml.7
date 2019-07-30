Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CBEC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFF92067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sma1hF7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbfG3VS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:18:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40271 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387628AbfG3VS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:18:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so30481038pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=k25bbBxrj71AiOvcgKU3QmoOQriQ0XSTDWlRTYXe0pA=;
        b=Sma1hF7pz/FTcBGWICvGeP7v3c2UxR/eHqbhVrY3dt6dbhhY9TKjbXmVAg41wGbZ+0
         ILDPGlvraupgEtzDH0C0zJxFESuJI69WGvf/8bBegcfMVKTbf7pbbqhMZYXCGe5qJFKC
         831o4DYoiXOiAMl2OnZJD5zm6TIpIRpZ8RuRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=k25bbBxrj71AiOvcgKU3QmoOQriQ0XSTDWlRTYXe0pA=;
        b=M47eUsFHH6aPU4Dr34Qwk6P5umJIrfVAMM4OzU+EZGAo/rRry5y+hdV5PhbR5fLDxn
         BITw+kl8yP8zn3BLlLei/vcQsIymGbVcfIupr/pgq+YwpNpj8lRVNBv/A4PfapZ3zx4q
         cNaVv6q9NzEiueeegmFgDak0rbNslBoiZfdzmmao9qeadklsO14BBw5zK4szwx0EjGUV
         dEUoDJ2dbX6S0KdzF2xbJyOY3/62XDF6YnGjedlDjX8FlqzY/DFDj56eDw48ltyYJ6gO
         R8bRKUwA/p9RnIFy9f+VUdRy4FOqNNs/2ueme75AGjClLXLyc2oc0qTbfesuB7uOI+2I
         ondg==
X-Gm-Message-State: APjAAAUD/F6dMPRrgjzy2HEJJ3iZvKdg/dsiNsz0FkKllbGwIsrI2fCa
        949TGJMyAY+uTuCwfOOX1FF7ZOH8hijm+Q==
X-Google-Smtp-Source: APXvYqzvQLeDEwvNTxn+rNx6BufjmxfuAKjelJV7vuPtHfLYpsOuMNgmHgSU4xzB9MsNOZtVSZcd1Q==
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr110215149pgq.130.1564521506924;
        Tue, 30 Jul 2019 14:18:26 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x13sm70320598pfn.6.2019.07.30.14.18.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 14:18:26 -0700 (PDT)
Message-ID: <5d40b422.1c69fb81.204e.b4d8@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190730211250.GD4700@bombadil.infradead.org>
References: <20190730210752.157700-1-swboyd@chromium.org> <20190730211250.GD4700@bombadil.infradead.org>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Tri Vo <trong@android.com>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] idr: Document calling context for IDA APIs mustn't use locks
User-Agent: alot/0.8.1
Date:   Tue, 30 Jul 2019 14:18:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthew Wilcox (2019-07-30 14:12:50)
> On Tue, Jul 30, 2019 at 02:07:52PM -0700, Stephen Boyd wrote:
> > The documentation for these functions indicates that callers don't need
> > to hold a lock while calling them, but that documentation is only in one
> > place under "IDA Usage". Let's state the same information on each IDA
> > function so that it's clear what the calling context requires.
> > Furthermore, let's document ida_simple_get() with the same information
> > so that callers know how this API works.
>=20
> I don't want people to use ida_simple_get() any more.  Use ida_alloc()
> instead.

Fair enough. I'll document it as deprecated in another patch.

>=20
> > - * Context: Any context.
> > + * Context: Any context. It is safe to call this function without
> > + * synchronisation in your code.
>=20
> I prefer "without locking" to "without synchronisation" ...
>=20

Ok. Resending shortly.
