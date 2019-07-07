Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3493EC48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 18:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE4E20828
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 18:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI5hgz4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfGGSqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 14:46:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44681 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfGGSqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 14:46:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so3513455wrf.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FeNJhnw7kPIAjlZ9A1KqDBd0/gUAXLx+l991tdp7HWE=;
        b=lI5hgz4f3lMVnuuucYRij4MuusAiMy9xvR68qeq2bFyW7nq7qNIFafruAs/5vdQF3o
         2QHm5aeHd0g0K4gl7OLL0YpA30HKmR/5gxamsCf5CPLKC0mCV0qKYzw5+E64nhbSFYuU
         XhhSRWFFt7J7mrOkU+C1L+GX04KpIhSKuE2ls1t5EWA0qyZaehrpKCr5JSmBHYhbkIKA
         PoeYFBKHXxyx9n6e/valVPBDBtTOJUU3kdrZMRLu7a+H0/5qSZwzlLV0dZug2IVdW+iu
         8vyIdBVcfTnf3HCAvrpmiSM+hm5SodLpJgmXB95CMJOzMMXHPGIbztsb+O9JDUr28GwW
         9r8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FeNJhnw7kPIAjlZ9A1KqDBd0/gUAXLx+l991tdp7HWE=;
        b=OFnUuKcvZq2x1X5EkzmKxW+8iaNy2b0YZ/m/+pcUgAyjOdr5sSPGpr0vh+c0eWyujp
         lV8tZ3ZXhpjXb8RVSIUnJkpJcUrvRuFI/74uSLlaCNHtAc8pEWwcFPgwdKZV/EF5/g9v
         yBg2niS8E51JoOptokE7auszvZoLtJIDebP2LfTymyuIBzad8yGtgqO/ErR59nIiiTul
         REEgYvHPJGVGb9cDV38PbEu3pq5BSB8jEZ1ty7eJ0FVo70oVTlo89lI2nmKZLE9gk0AZ
         Xl2k5xz7zP2iUtgBJoueI88MQXK8GY9NXXf3EWgT95imhgEsi54RGn8LlfPu2twHwB0l
         kx1w==
X-Gm-Message-State: APjAAAVXyO3D4IpuX7F7p8ndnnIDMaAxUl4/6/e2lF+m1HoLCqs+puCI
        TkzLjeQNdvpAUK2Mg7O6C9osl0XPlzaEJdRBd6o=
X-Google-Smtp-Source: APXvYqxU1tDH0OYZdseEWpc1ICvZoYOj/V+pjGS6Zbeb05OCnENFn50fmP8dSHU6TGuixN8wqASNCeTs6wlpwmEZINQ=
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr14769726wrw.185.1562525159360;
 Sun, 07 Jul 2019 11:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190522231948.17559-1-chris.packham@alliedtelesis.co.nz>
 <355dad1321ed46baa98ca6f47b4d00b5@svr-chch-ex1.atlnz.lc> <CAFLxGvwNNWKzbfKvDjAK6rujbr5qtmVAWCDD5aULO4BVKutRKw@mail.gmail.com>
 <365a80987504424f8685faaceb23b468@svr-chch-ex1.atlnz.lc>
In-Reply-To: <365a80987504424f8685faaceb23b468@svr-chch-ex1.atlnz.lc>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 7 Jul 2019 20:45:47 +0200
Message-ID: <CAFLxGvxs0aQq7kLFQ0e1=PZ6SrWK=KdgEeKXmNoXy1Fh9TRwng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mtd: concat: refactor concat_lock/concat_unlock
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 12:11 AM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
>
> On 18/06/19 10:08 AM, Richard Weinberger wrote:
> > On Fri, Jun 14, 2019 at 5:26 AM Chris Packham
> > <Chris.Packham@alliedtelesis.co.nz> wrote:
> >>
> >> Hi All,
> >>
> >> Ping?
> >
> > Your patch is not lost. We start soon with collecting all material for
> > the merge window. :-)
> >
>
> OK thanks for the confirmation and sorry for the noise.

Applied. :-)

-- 
Thanks,
//richard
