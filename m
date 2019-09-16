Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E803AC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE79214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Rl9N/b/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbfIPMTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:19:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41780 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfIPMTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:19:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so37626954wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NDGvPfQ28itbhitNrIVDuhKKTVjuBYonvfjlM/t21wU=;
        b=Rl9N/b/bMFTs4X2mlxsYJ/i0nofx3+KjiSTSMKqDk7k43o9uPTcRGGKaBLYSGkVa1B
         voTuhEb7qmNSFPUdCT5O24IUW6a4z9+rjv+UCr+DqKMn/VkEIMZfSm/4azEaAAb/kE6R
         Yw2GGNiKSrVNlYy9kP/IOPD6PDxRvn1R3SIIzsaDC2JZLjBfhiWBauUxAVAIgcGjf3bt
         j0+9LP4wrZBuEwrsf8L9QDYddK6psSURIMxWN4x8tegJWReSC2PIgKK9tUTwyY2QcxP7
         AZUt3EanN9GfsJ65EBgauTJoymGZWhyJwd6D7Dft5+az/R2WVWfLaG371HEBh9wWjE1Y
         1bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NDGvPfQ28itbhitNrIVDuhKKTVjuBYonvfjlM/t21wU=;
        b=n2fcZRrzVeNrpON/mgSD2jI5FfJOGIUXMdvEsMZZoe6dos2iq9/zKdY1Ty6hnF5ESc
         SbI1kIhrPmQ/3VdqMSdGLlwN5e20LrZjrMcmJI2kNY0aPBzh7KnHNljO7Yj8u1PEUlf+
         +y2zGC4vf8IM0N9MWRH74FHgKhothWiV3NSvzVVwit4rTMUGIddjLupmqXAOXwUN0X4m
         cyGVpCBO8AG30oUyEIB0Hw0VezXVipaGa2MOxeXVhbdblVulKhSTWfXgnv9ZL8avnWFE
         3ZYYfwiXMN5Z6T8dnMVwGg8zDbD6UZ1R+fdcQgK1Dglvat7nfKvugTa/TFTIfn5TA/Qk
         oTFQ==
X-Gm-Message-State: APjAAAUBxkwZA9d9dcxrJ1n0yDpL+mkKSvWgw+05JddwL56QGt0aNupL
        28/WhYqHjgHR9YdnyqT3KdoPZ62x294=
X-Google-Smtp-Source: APXvYqy7wvBYXW5sQMm779PclJz5ZIXC7oobUxc9rjxX7S6QW5vk4bewbnRrdKgZb166GugimeCvjw==
X-Received: by 2002:a05:6000:11cb:: with SMTP id i11mr1328338wrx.171.1568636339222;
        Mon, 16 Sep 2019 05:18:59 -0700 (PDT)
Received: from localhost ([195.200.173.126])
        by smtp.gmail.com with ESMTPSA id m62sm17234528wmm.35.2019.09.16.05.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:18:58 -0700 (PDT)
Date:   Mon, 16 Sep 2019 05:18:57 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Andreas Schwab <schwab@suse.de>
cc:     Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
In-Reply-To: <mvm7e68fo2g.fsf@suse.de>
Message-ID: <alpine.DEB.2.21.9999.1909160513100.9917@viisi.sifive.com>
References: <20190910055923.28384-1-hch@lst.de> <mvm4l1kskny.fsf@suse.de> <20190910070503.GA31743@lst.de> <mvmzhjcr2d4.fsf@suse.de> <alpine.DEB.2.21.9999.1909160456010.7214@viisi.sifive.com> <mvm7e68fo2g.fsf@suse.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1252070807-1568636337=:9917"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1252070807-1568636337=:9917
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 16 Sep 2019, Andreas Schwab wrote:

> On Sep 16 2019, Paul Walmsley <paul.walmsley@sifive.com> wrote:
>=20
> > On Tue, 10 Sep 2019, Andreas Schwab wrote:
> >
> >> On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:
> >>=20
> >> > On Tue, Sep 10, 2019 at 08:57:37AM +0200, Andreas Schwab wrote:
> >> >> On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:
> >> >>=20
> >> >> > The sifive serial driver implements earlycon support,
> >> >>=20
> >> >> It should probably be documented in admin-guide/kernel-parameters.t=
xt.
> >> >
> >> > How so?  W=D1=96th OF and a stdout path you just set earlycon on the
> >> > command line without any arguments and it will be found.
> >>=20
> >> Doesn't work for me.
> >>=20
> >> [    0.000000] Malformed early option 'earlycon'
> >
> > Try:
> >
> >     earlycon=3Dsifive,0x10010000
>=20
> That's not what Christoph wants.

I support Christoph's plan to add generic implicit earlycon support.

In the meantime, once v5.4-rc1 is released, I'll send a patch to add a=20
sifive driver section to the earlycon documentation in=20
admin-guide/kernel-parameters.txt.  Thanks for the (earlier) suggestion.


- Paul
--8323329-1252070807-1568636337=:9917--
