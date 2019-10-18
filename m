Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5467CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF34F20869
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzSwJdSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502793AbfJRSfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:35:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37084 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbfJRSfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:35:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id p14so7283254wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kzOxNxVRX1SmQHuvJ1treZltNyYijexf2ck9J3jXKY8=;
        b=UzSwJdSHGIGnMOL6in+EbhaqHjudWKwi1NoXNc6Uge3Dz+yb1bVaLT75noRv8dYHuV
         ambS0/SltyEdVI84pa4PETyzZPBjm0QQeoohLUkpMbeUPDsW09cyefdSo3jhGiRdQFjh
         LAEoSm3ko6X6szew313BbYAZTgKoPXf05eBXT4V6315zT8oeA4siuvoM8Fcw9gTHYMuB
         lGI/ld+ycFiFQilNyDoK2BP/TnSDSiKKchL6SYYkSO/wC0GyF9CeqRJ2rHSxcbbfnNqi
         ZM8nMiBXw96ozZGOoQvZfrqOOJUhOAEeoHrPbXl4IJloKUCXGUusZ+lnVNnKYNPTMY89
         EcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kzOxNxVRX1SmQHuvJ1treZltNyYijexf2ck9J3jXKY8=;
        b=OWzZKwLVrfzKrQh2P4Rh3RZwBV3fzeMfwVCxjAsL4SbF07nm7IuVaTU+PChUgF5PUA
         eT7ZGBik4KvPu3bLCSekbrI0L0dQ8/linFGwQ++ZMZvj9BMbENcSdP8V4ZR4DjczhJ+p
         iu34JjQ/dIXRTWVYjZxzoKiYh/ZduqRrjqVwbdSosv1Tm/dpBR4mQ3L2cAvM1Xcw+fvU
         38fgDxbkYqHzOPov5+aq+sSWiYlwaAulGA9+r6euvzhkl6bz66F/vmQ3O+/5XLVjr7gO
         0o9k0hSOXzhB5J0MHl0SjCfxeAx1e2xpt7vPpbgaHXKM0qoUvJ4ED2aSNegV5FSBAqUQ
         CdEA==
X-Gm-Message-State: APjAAAVzJLDXhb8hv2gUlIX2dcUBppZHLAt6WcW5K5BbApVLIbGrlHju
        F5MCUsn7DZ0Y9LARr2HGKY69Qw3bW5SdG2rb1rc=
X-Google-Smtp-Source: APXvYqxgG14kjuTvpv6QghuU/6AEcoV0jY0g70gj1cgl2Yr04sPjTVuLXuZMnzd6TF8thZsV6Aj7jvraefEXiSU/vGY=
X-Received: by 2002:adf:db42:: with SMTP id f2mr9736231wrj.287.1571423747128;
 Fri, 18 Oct 2019 11:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191017142229.3853-1-miquel.raynal@bootlin.com>
In-Reply-To: <20191017142229.3853-1-miquel.raynal@bootlin.com>
From:   Brian Norris <computersforpeace@gmail.com>
Date:   Fri, 18 Oct 2019 11:35:36 -0700
Message-ID: <CAN8TOE8mNf1VhoRLiiE6bjrVmDUHCwvPNaHuvDw71cxa9OhSYw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mtd/ubi/ubifs: Remove inactive maintainers
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 7:22 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Despite their substantial personal investment in the MTD/UBI/UBIFS a
> few years back, David, Brian, Artem and Adrian are not actively
> maintaining the subsystem anymore. We warmly salute them for all the
> work they have achieved and will of course still welcome their
> participation and reviews.
>
> That said, Marek retired himself a few weeks ago quoting Harald [1]:
>
>         It matters who has which title and when. Should somebody not
>         be an active maintainer, make sure he's not listed as such.
>
> For this same reason, let=E2=80=99s trim the maintainers list with the
> actually active ones over the past two years.
>
> [1] http://laforge.gnumonks.org/blog/20180307-mchardy-gpl/
>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Artem Bityutskiy <dedekind1@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

I've been meaning to do this for a while, so thanks.

Acked-by: Brian Norris <computersforpeace@gmail.com>
