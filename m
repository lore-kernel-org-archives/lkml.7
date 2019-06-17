Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7D9C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2188F2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="I1Xjncqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfFQK2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:28:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46630 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfFQK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:28:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id d4so15378953edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 03:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8UBAA4hob1aUdMG3Ki6/LwA/eBo66cYa0fDftPuC+I0=;
        b=I1XjncqzU2jmO6RevBy9IzFleq0nMlnkC6MDumuIsz5JVeH2+1xm/ZhpM/VGcEN+9K
         9pSyXGeLCIhrXK1FMrm37s22+ShjPNYMS8/Wx1HJfbo39srKyIqMMMhR0mqjHq0Eqj2/
         EEIYhEhsAbI7rnU22Ey0TKxrY8eexf9LGgSGqqGzvkvb6TeYsTMqmkFl0qWa7ckNmYhC
         gRbkiSnv1F7ZON4E588pZS0q2mwTvOSENtx+10LxFski6vF+C1ehb6SXdQghnOXmCoNC
         IgdbbbhFi0YtJmlL+kXM01BwLelRvL7Itusxmc9seVJAYzA6dGsXWWWqK+8gqLxSqbUc
         O3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8UBAA4hob1aUdMG3Ki6/LwA/eBo66cYa0fDftPuC+I0=;
        b=iBHd7FcuIEZ84y3qtapbpqGzoZYLmiltxUc1wYWEr+500CjSHkwTENg7abc8wtyjgn
         IniELiVkSZ5hfm6xY17uiAiUxDgn3/xLfpjmb4PGZyLzOSJiG9BXcqalDwjB3dDzBcap
         /OJfUOCulbo/ygX3vQ8DXCtpUGrMB1104g5T+LZBGL6QmDSllQ9ekKAWyFpVhxpCAayV
         k8O5Supbm3slZ7i7g54O4ytA+F6rrl11FA+QBRGERF4uVCwFA4Ua3U46LL5DUHCjg3N0
         yFFUf5yPGdS2SggkNc1hBImN6bSIRoOK6ppl1EFfhMfQ+v7rJeoJoKNihmLuaCLGOa7H
         QyLA==
X-Gm-Message-State: APjAAAWo3GVMXeV3/Rvn5qPw3BNV5JlP515XIFmemqW8JzwAumSUUWyg
        1XTiZfoC+dTM2HGEbA5vCwoDOg==
X-Google-Smtp-Source: APXvYqwMwtN/9BiCAeDSq8bw6UaVIvcm2zKgRR7fZSgp8cG8nJGZNjfgqqkTyxFwZd/sIBVKqa0hXQ==
X-Received: by 2002:a17:906:a39a:: with SMTP id k26mr69719766ejz.82.1560767284087;
        Mon, 17 Jun 2019 03:28:04 -0700 (PDT)
Received: from localhost ([81.92.102.43])
        by smtp.gmail.com with ESMTPSA id f24sm3624644edf.30.2019.06.17.03.28.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 03:28:03 -0700 (PDT)
Date:   Mon, 17 Jun 2019 03:28:02 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     Andreas Schwab <schwab@suse.de>,
        David Miller <davem@davemloft.net>, devicetree@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?ISO-8859-15?Q?Petr_=A6tetiar?= <ynezz@true.cz>,
        Sachin Ghadi <sachin.ghadi@sifive.com>, sagar.kadam@sifive.com
Subject: Re: [PATCH v2 0/2] Add macb support for SiFive FU540-C000
In-Reply-To: <CAJ2_jOH-CacU9+Lce80PQzG1ytxvSZmjfSMwL9=kbXpWxyU96Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1906170324250.19994@viisi.sifive.com>
References: <1560745167-9866-1-git-send-email-yash.shah@sifive.com> <mvmtvco62k9.fsf@suse.de> <alpine.DEB.2.21.9999.1906170252410.19994@viisi.sifive.com> <CAJ2_jOH-CacU9+Lce80PQzG1ytxvSZmjfSMwL9=kbXpWxyU96Q@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Yash Shah wrote:

> On Mon, Jun 17, 2019 at 3:28 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> > On Mon, 17 Jun 2019, Andreas Schwab wrote:
> >
> > > On Jun 17 2019, Yash Shah <yash.shah@sifive.com> wrote:
> > >
> > > > - Add "MACB_SIFIVE_FU540" in Kconfig to support SiFive FU540 in macb
> > > >   driver. This is needed because on FU540, the macb driver depends on
> > > >   SiFive GPIO driver.
> > >
> > > This of course requires that the GPIO driver is upstreamed first.
> >
> > What's the impact of enabling CONFIG_MACB_SIFIVE_FU540 when the GPIO
> > driver isn't present?  (After modifying the Kconfig "depends" line
> > appropriately.)
> >
> > Looks to me that it shouldn't have an impact unless the DT string is
> > present, and even then, the impact might simply be that the MACB driver
> > may not work?
> 
> Yes, there won't be an impact other than MACB driver not working.

OK.  In that case, there doesn't seem much point to adding the Kconfig 
option.  Could you please post a new version without it?

> In any case, without GPIO driver, PHY won't get reset and the network
> interface won't come up.

Naturally, in the medium term, we want Linux to handle the reset.  But if 
there's no GPIO driver present, and the bootloader handles the PHY reset 
before the kernel starts, would the network driver work in that case?
 

- Paul
