Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CA4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8C320823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z9uDEr+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbfCZUjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:39:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36406 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCZUjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:39:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id r124so8805037pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=8gazi28c20822jWbnu97Ff27qgZuzyclqPEStdgiz60=;
        b=Z9uDEr+7LnsTBf7wW31awvFoJm+qIEpxbW9Syhv+0Xus7ZNdNrA3JRcb/j8s7kGlWV
         4OA8lQCvLxguBKHrYAB31jwTYwz02BTpWv6iItQV8R9n0mqfXHwXj2NXgTpD+dlQVXz4
         W4s5t8I1WHCZM8w8aEGI9sfptdoStTd8Vg29E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=8gazi28c20822jWbnu97Ff27qgZuzyclqPEStdgiz60=;
        b=ZoYHk+epnf7Ap5TKFxbCOberH+AtfZfZEt+mHpVxTGW1S9er3uefZoAJY7dj3tmuPR
         938F3JWuNMW7Ffii34BlByOOfKC05D0wmjN4gqIdEqL+T0t2YL/wVFauhLpUgXeD3NuB
         yUses7+DHaY2ppVGkKzmeUO5Dez3B4ZinH/r0cxvzoKVX4nU3RF9C9BpSFra/l6wFlR2
         6LPr6bU8obhnh56gs09OjpDqPb0/pKH0W666GVfVc4dHFQEfBaL4X2lDfviD6OwINvhs
         lMpVB6PigNLBNK8/ZB6M79BWsy1m5I6ogOL08fpd28dUJWx+ZBUtVGED4h+1a7m4xMCf
         9eyA==
X-Gm-Message-State: APjAAAWHiuHCdTXsWDr5QxQA8QyZnK/m1/feZ95ygyK3vnAqeK+rJ28Y
        jvpwGg4HS+s6yWtb6wVPjeg+3HIUpf9xkA==
X-Google-Smtp-Source: APXvYqwK24qEf/f28VXKN+4bbwKyNUS3Gy8Hpo0FlaXqTovXoG5clNg3JG2A14DSAjO72u+n3GYMzg==
X-Received: by 2002:a63:1322:: with SMTP id i34mr30284474pgl.208.1553632741756;
        Tue, 26 Mar 2019 13:39:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i72sm35120674pfj.147.2019.03.26.13.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 13:39:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ff5bffea-2689-0ace-9c77-2aaa6605342c@siemens.com>
References: <20190325184522.260535-1-swboyd@chromium.org> <20190325184522.260535-4-swboyd@chromium.org> <227f1a1f-d8dd-72f4-4eb9-43bba714d52a@kernel.org> <155361993610.20095.762425616683725063@swboyd.mtv.corp.google.com> <ff5bffea-2689-0ace-9c77-2aaa6605342c@siemens.com>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 3/4] scripts/gdb: Add rb tree iterating utilities
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Jackie Liu <liuyun01@kylinos.cn>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Message-ID: <155363274033.20095.10762543028999566245@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 26 Mar 2019 13:39:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jan Kiszka (2019-03-26 10:21:21)
> On 26.03.19 18:05, Stephen Boyd wrote:
> > Quoting Kieran Bingham (2019-03-26 01:52:10)
> >>
> >> Do you foresee any similar issue here? Or is the corresponding RB code
> >> in the kernel fairly 'stable'?
> >>
> >>
> >> Please could we make sure whomever maintains the RBTree code is aware =
of
> >> the python implementation?
> >>
> >> That said, MAINTAINERS doesn't actually seem to list any ownership over
> >> the rb-tree code, and get_maintainers.pl [0] seems to be pointing at
> >> Andrew as the probable route in for that code so perhaps that's already
> >> in place :D
> >=20
> > I don't think that the rb tree implementation is going to change. It
> > feels similar to the list API. I suppose this problem of keeping things
> > in sync is a more general problem than just data-structures changing.
> > The only solution I can offer is to have more testing and usage of these
> > scripts. Unless gdb can "simulate" or run arbitrary code for us then I
> > think we're stuck reimplementing kernel internal code in gdb scripts so
> > that we can get debug info out.
> >=20
>=20
> Could we possibly leave some link in form of comment in the related heade=
rs or=20
> implementations? Won't magically solve the problem but at least increase =
changes=20
> that author actually read them when they start changing the C implementat=
ions.
>=20

Sure. Can you propose some sort of patch against the 'list'
implementation for this? I'd like to just use whatever policy is decided
here.
