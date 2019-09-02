Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B057C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E108B21881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vX+Kj9Sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfIBHGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:06:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36952 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfIBHGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:06:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id d16so13351232wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 00:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64OQf2pr3McmMwwkBGAqwTjDXkvI31p1+ph2Ex8v9n0=;
        b=vX+Kj9SriDEymjT8Qbdi25ZCmvhmghxHjPlg3xNvRkg3ZK55IGHvGnkgGKnUvEx5es
         OK/EPM13MXDCW4ibmIN2eS9VUaqrRI4Rn+UIZ9qTH3mPHZS159Y/dshTiIBFtUiWSDO7
         GjMDRxDCBr6oRIpt6dChOTBAfpoYQKlZmAyCg9Yy9DMaEzb5hbOFArPyQ7cYHgOI161z
         TGRxGCvK+LH6CLxTcEfEU5WvPmW3RcsYU4iBD4E1MCi49TXvF/Y1Xj4POyIFW1kOCCGj
         D9xtf1un573mCkESRm+DdqYhS4J271DS773PBPPAz92MBsSh555rakOCn3TCD/SKZAgY
         yTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64OQf2pr3McmMwwkBGAqwTjDXkvI31p1+ph2Ex8v9n0=;
        b=WVUIBVhAdIS4gKLcPkYF4HVg4TULweb7KDpt1C7Mq04xBnVn7jApf91fX+0d0JLq6e
         gc/bTyAFWWnH6E6E9/PILZW1hvPrxuEaV2i62QsQbv/hj6vomwovAMwSImcDrH/BEqkA
         JciZHUkEyAcX9p4AjIaSIxMnkK7MDd7PMC3Fiirv7ELfAlmxMYpz1yuWkF1g+hoeOEV6
         Ypil/16HNA80urwMor5crSqNHmLOQKBmAfkOcVIhLP0uArCmk7UCMTTrvwtaOJtNDuL3
         xNqlItcTPjFyvqydphDroRXoQPA4UqjPy9rriLaRFSCoyRRi+VwZD2wg/AThOTq1uQhn
         GcXQ==
X-Gm-Message-State: APjAAAX4uVocR5wlAFUwgWv0TrD0VJyA5jTuKpF3gYlR9cGhfyJSxf8m
        4+NNanNb3iUWYWuynQJgDEg/6VwisIRMcM+oAyU=
X-Google-Smtp-Source: APXvYqwkzQ/PL1iNnbMXeVU/K3oC9f1m3PREeIvuYuGYPi6X7TdEL+3fLyK8EKD5nbobCsQ/whl/nZOY2IBA02izxpU=
X-Received: by 2002:a7b:c5c2:: with SMTP id n2mr35655594wmk.9.1567407961503;
 Mon, 02 Sep 2019 00:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <1566280428-4159-1-git-send-email-masonccyang@mxic.com.tw>
 <20190824130329.68f310aa@xps13> <OF22C5A579.E2E7676F-ON48258465.002F7F69-48258465.00322849@mxic.com.tw>
 <20190830115100.3fec9bf1@xps13> <OF08E1C5EC.4DAEB179-ON48258469.0025AFFA-48258469.0025D2F2@mxic.com.tw>
In-Reply-To: <OF08E1C5EC.4DAEB179-ON48258469.0025AFFA-48258469.0025D2F2@mxic.com.tw>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 2 Sep 2019 09:05:49 +0200
Message-ID: <CAFLxGvyAk33SZY2J-WYzKMW6N9mKiJ=y0XfmMd8RjUVV2Rp5vg@mail.gmail.com>
Subject: Re: [PATCH] Add support for Macronix NAND randomizer
To:     masonccyang@mxic.com.tw
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>, juliensu@mxic.com.tw,
        Richard Weinberger <richard@nod.at>,
        LKML <linux-kernel@vger.kernel.org>, frieder.schrempf@kontron.de,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 8:54 AM <masonccyang@mxic.com.tw> wrote:
> > >                 nand@0 {
> > >                         reg = <0>;
> > >                         nand-reliability = "randomizer";
> >
> >                           mxic,enable-randomizer-otp;
> >
> > Would be better (with the proper documentation in the bindings).
> >
>
> okay, thanks for your opinions.

Please document also when/why one wants to enable the randomizer.

-- 
Thanks,
//richard
