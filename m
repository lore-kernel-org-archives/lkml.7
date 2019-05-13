Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316D7C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13552084E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="br89Uott"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfEMQDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:03:43 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43932 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbfEMQDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:03:43 -0400
Received: by mail-ua1-f68.google.com with SMTP id u4so1559966uau.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LhqduOUwS+O6B5Ih2GpJJXA30cnrCE8y/7lD4jak7zA=;
        b=br89Uottwez2IWUAknU6LNVFpUXyul6AjXPYo2WtfeR027fkRHL+kRf3UQD7snqoFU
         QeaulT/nCD5jsWybxpHI/SLO0sdvx6XGQgtabNpbIld1CJlQ0/UTyNK2xxHsL/ICpODm
         69A9I3JkhxSVco01rZ2p+C20qosS5jrtbVRT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhqduOUwS+O6B5Ih2GpJJXA30cnrCE8y/7lD4jak7zA=;
        b=OaTRXAaUnrZvb2NXQaJI6gh7GDcILfY19dqZBgOXZ1afRYDvZX9F+ECXMFQdgc6Jw3
         IjojJM4MwPBJSZeT+XWH7c4UgLfzE8a+zHqXdj7nXzUDIUhCkEhKfJeCpZT+gFeSAkno
         FdIo5NRS4C47xX1tx6+fPibHG3wvvYCHQ9aOxkqUW5E/R3Bkj7XNvdoj2XULPaId9qZX
         SkSsfrcL5cM7OACy1Jeqgl6rRhbspCbIelWY6PMXtFlhDjxkqmcygr/Ai4VyrAJoRrZR
         M7B9Q0naIDCTz8V6z7FaLv+O4MX2IbDQ5GDopfXG3cZXTgr9tGcPACy/25gW+VHLo0mw
         WrIg==
X-Gm-Message-State: APjAAAUKLv5W8RA3N6S9n3f5/wwR4giwh4ZOUWsLKll3h33A7w8zKboc
        mR2YuM3YE+5qz6WVSw189dT9Mwo1hk0=
X-Google-Smtp-Source: APXvYqxR8RUFYDAN4d4ZlqXfO9qEDlf+PmHnb/SuYv3GZJI0CdpP6rUx+JDhyahVyAHM6BWsO7SSgg==
X-Received: by 2002:ab0:2692:: with SMTP id t18mr7456668uao.106.1557763421317;
        Mon, 13 May 2019 09:03:41 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id w136sm11022347vkw.18.2019.05.13.09.03.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 09:03:40 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id s30so5012677uas.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 09:03:40 -0700 (PDT)
X-Received: by 2002:ab0:20c1:: with SMTP id z1mr12511820ual.109.1557763419691;
 Mon, 13 May 2019 09:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190510223437.84368-1-dianders@chromium.org> <20190510223437.84368-5-dianders@chromium.org>
 <20190512074538.GE21483@sirena.org.uk> <CAD=FV=Xg96SGg-JDjEJRtC6jACcN9Xizcr-zV4rQwXYvuEvmRA@mail.gmail.com>
 <20190513160153.GD5168@sirena.org.uk>
In-Reply-To: <20190513160153.GD5168@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 May 2019 09:03:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xm-2oxit7doVAYJr28c-xHqUdt9PQC=WYpYfsAyUxuaw@mail.gmail.com>
Message-ID: <CAD=FV=Xm-2oxit7doVAYJr28c-xHqUdt9PQC=WYpYfsAyUxuaw@mail.gmail.com>
Subject: Re: [PATCH 4/4] Revert "platform/chrome: cros_ec_spi: Transfer
 messages at high priority"
To:     Mark Brown <broonie@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 13, 2019 at 9:02 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, May 13, 2019 at 08:57:12AM -0700, Doug Anderson wrote:
> > On Sun, May 12, 2019 at 10:05 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > It isn't clear to me that it's a bad thing to have this even with the
> > > SPI thread at realime priority.
>
> > The code that's there right now isn't enough.  As per the description
> > in the original patch, it didn't solve all problems but just made
> > things an order of magnitude better.  So if I don't do this revert I
>
> I'm not saying the other changes aren't helping, I'm saying that it's
> not clear that this revert is improving things.

If I add a call to force the pumping to happen on the SPI thread then
the commit I'm reverting here is useless though, isn't it?

-Doug
