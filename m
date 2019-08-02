Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E22C19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA8A216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="HHpUAOqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfHBDCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 23:02:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40848 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfHBDCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 23:02:43 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so72477795qtn.7;
        Thu, 01 Aug 2019 20:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pMvBx1hh8/G6Czd/FV/OwlwQ8LJ13TfBmKizcKZrRrs=;
        b=HHpUAOqqbJLsZvBpfU4B2ieP1G/ChCo8uBUPMEmCma/20hEezhFd8aoEeR1umSF8st
         7GxteKnxNfdURFGMMp6U/7upsqAq16TOUhW4ynIdOjUInlB+AfUCDBkFzVQKITorXkBw
         D8rvt6E/LHBk1CNSmBCzubB5Ews/Mo/hG3wE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMvBx1hh8/G6Czd/FV/OwlwQ8LJ13TfBmKizcKZrRrs=;
        b=b5mUm4/RVpg3U1DNFF83cmqZCMAoowxRrGM55kNoTTKv5qXBWBkyUzmXfim8htNGAi
         V2VcRUASl3wiaOWFO20rZjfxdk7Gm0WCJlOQRo3tWmrMXjEoYeQhGQI0Vni7dufSSxZu
         pkWXt7lDFMr6f7W9S22/tO/zj+SumyOq5oApuTGxLwz7yygH7nBNBPr1vDKBHQtDWrzT
         KiJRDoOZIoWzfbuc/dICtHWh12LsIM/pNVKvyxJn/pnB2qUsLN1SFUjtSi3Ce15VhFAH
         cVjmCurA5CCwEyDAhCVfkGlpqobQUuzrhYfjZqbHJQXO2XUy6H1o78k9b3CgH3PYSULG
         50gQ==
X-Gm-Message-State: APjAAAVda9tRluc4aGIoBe2NQEZfC4r9sImJogmKlpUJeWm+CVaYR0BM
        iYw0XbE1mN5Kw3tZH4BtBUwkttSDmC6rFFiHtO8=
X-Google-Smtp-Source: APXvYqz7mHdc8lBlyD3HcADLWRy1k1ur3idhBRDnYpffy7ym+Av1tf5AlRYkmS9IXaNcLXyUw56O4NlOlpWTDVLcclE=
X-Received: by 2002:ac8:2fc8:: with SMTP id m8mr94544340qta.269.1564714962033;
 Thu, 01 Aug 2019 20:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190802010155.489238-1-taoren@fb.com>
In-Reply-To: <20190802010155.489238-1-taoren@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 2 Aug 2019 03:02:30 +0000
Message-ID: <CACPK8XdS4m9+74oxK0-ed3ZLr_QCh--AsFgGcF-OpLw24v9g4Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Add Facebook Wedge100 BMC
To:     Tao Ren <taoren@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019 at 01:02, Tao Ren <taoren@fb.com> wrote:
> +
> +       chosen {
> +               stdout-path = &uart3;
> +               bootargs = "debug console=ttyS2,9600n8 root=/dev/ram rw";

Are you sure you want 'debug' in your boot arguments?

The rest lgtm. I can remove debug when applying, or leave it there if
it was intentional.

Cheers,

Joel
