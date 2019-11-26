Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BBFC43141
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 00:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324D42080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 00:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="DIUUFeWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfKZA7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 19:59:33 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45740 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfKZA7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 19:59:32 -0500
Received: by mail-qk1-f195.google.com with SMTP id q70so14626509qke.12;
        Mon, 25 Nov 2019 16:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7XFzCWonYVHxuwP5fu1PxHNZ55RMRiDHqimUZntDh4=;
        b=DIUUFeWUjfSEHzwzxtnqA+xNH2Id50fnNM/fiBRukFlSKzmoT5qSKQJFnv4GuHOpq6
         71gU4R+PrKIedYDMQNEvHspR/u/S/UeN7YoHLzEi3ZRGmbuqRDp0szLHgOxQ2c+DuMdS
         BmuAqg6Z2B73TF+Td/X7g38Qz0Klg/3Muk4Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7XFzCWonYVHxuwP5fu1PxHNZ55RMRiDHqimUZntDh4=;
        b=ZOqZQbdQIhDSlRF9pNVsG9/IXgpGqlkmAo1q9AJaUqEz4IsVNbFlUKkS0uYbU0kaTl
         h6kVxY9CDynX05V+JnTg3mMHkMyv3OP/2/IiwtW3P7UJl0OtzU3t0C8KpJg0o/E3/iRs
         FQmGvUvXimpx6S6iVU/eqUwRgPo4EXfKTizqSyqkDK8El092z3PDvSBYkzJlC+YEX61B
         2p1C2Kt39dBLzzDMJynFvbz9fpBtVCMH+20j5x8ui3JYV40824IB0TbdYjnD0z0nrTHe
         rEcpRryEmv3MrOmNjEmuayTUiyoUwTA7GZ5kPOmPQW8LDr2P/qCoog9QuRQ7tBOA6RhC
         0gFQ==
X-Gm-Message-State: APjAAAXFuA4kiAnjTqBp66d3bPrSvk1aTqcZvLBoX9/Mlazyb/R9ZISM
        0SnPwX3ENR/TYmTBoVPW+UxepVIZMK9HArdeeRI=
X-Google-Smtp-Source: APXvYqzxouakbsyDuepwnrAYMPQWMY5b7/QqbsrmtOXq9S445ZLuU58+ueka4h/ftWC1n2cYQWh+IaXs6/v0/YH2Je4=
X-Received: by 2002:a37:ac05:: with SMTP id e5mr13396683qkm.414.1574729971439;
 Mon, 25 Nov 2019 16:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20191010020655.3776-1-andrew@aj.id.au> <20191010020655.3776-3-andrew@aj.id.au>
 <CACPK8Xcrc_2itUcGw6caa8Fp3sJE8oHBO5LJgBtqScwmVAuHJw@mail.gmail.com>
In-Reply-To: <CACPK8Xcrc_2itUcGw6caa8Fp3sJE8oHBO5LJgBtqScwmVAuHJw@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 26 Nov 2019 00:59:19 +0000
Message-ID: <CACPK8XchwGdgE95jkdhwWbp0r+NHge7W3q6yQp-wzfxV3Kpajg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: aspeed: Add RMII RCLK gates for both AST2500 MACs
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, 10 Oct 2019 at 23:41, Joel Stanley <joel@jms.id.au> wrote:
>
> On Thu, 10 Oct 2019 at 02:06, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > RCLK is a fixed 50MHz clock derived from HPLL that is described by a
> > single gate for each MAC.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

I noticed this one hasn't been applied to clk-next.

Cheers,

Joel
