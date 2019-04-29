Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E4AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718DC20449
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zNwGC9WU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfD2KBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:01:21 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41581 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfD2KBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:01:21 -0400
Received: by mail-vs1-f65.google.com with SMTP id g187so5524572vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 03:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wu8vgvBuJ0ba1a1wtubjAQOiFEAHkL9wdKCwmj/BeCo=;
        b=zNwGC9WUEItvbivjH1HnlPfR2Xw8BjgG21df7sQOOm+CmS8MGiuqxkOd+mkg4GeKeI
         gB+yEpX5Ektbw0vL2PfnJn9i+5op0GXZ8oC+H+LZkWKP73H765lzZzxXpWLP/9so3u2Q
         1JgRtBL6bFJaCXAbs15cTKLRLbeFA9k5Lh6zEx2nVqN2TSXTV4OgvAozToeirly2+fjm
         w44XH8ZnRveeNH7iYAMMuzDNACL7g28RErEwv5l7JMjM7A0dNR3OMwl/i9bTI2jLg2as
         G5hQV8E4Kc08/X83lFii4XceCxNNyrfHyfh76us1WGO4AKfzusgtv8cExnfqEQ31foyr
         5frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wu8vgvBuJ0ba1a1wtubjAQOiFEAHkL9wdKCwmj/BeCo=;
        b=PQoJGMGVSrNR2eBwKH2VIq+E0asj1L9Jz46wREMG0epmQFqZKNWyYfmO1n+mX/eHS7
         1q9z7iCh61Gsf6Ly3odBmYDPPXyJighfYV9dPpfSHoO56bU9HGrr2jfoEfSDjLsFUlW/
         dMjoKBOLV/A/5uS36BWi2FFMyuWdml15Fo0yQHFI+tHiVTKjfZu7MDIrDMs43r51+Tll
         xMsPany0y8NBu5yRk2HQZpxy0LqV2ZaostQLvLZ7pcUDSHOA3L4MdJASxv4AJKNJy3Cq
         lnCTjOQhWYbyoAJxi/hfnG+ybVsuaO5DwU/dSMrC+oemFwNCcYifQYN4emw6rPseQsMw
         e6DQ==
X-Gm-Message-State: APjAAAWt25zSBXoZuNbuX6RvKpm5MIa1cVggdjVFF/4wA2EzQtuaLwvi
        4/I0wrmghb0lXcD9ItxFBO/R2SGyL8kWUMnBrQLX3Q==
X-Google-Smtp-Source: APXvYqyqS5Sf1iB7vb255neQ/NpXaXjA0EXJp+yj0f1nS8TQQzrZVn+UD8BMoxBhqrONGrF77kV0qczcnH4jdIeLuaw=
X-Received: by 2002:a67:8155:: with SMTP id c82mr2470478vsd.200.1556532079983;
 Mon, 29 Apr 2019 03:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190416185705.256369-1-rrangel@chromium.org> <SN6PR04MB4925C1C304B992339621808AFC260@SN6PR04MB4925.namprd04.prod.outlook.com>
 <20190424155659.GA193321@google.com>
In-Reply-To: <20190424155659.GA193321@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Apr 2019 12:00:43 +0200
Message-ID: <CAPDyKFpGC2siKvv3dAJWQUJw7O5ajX1PG4BO51xz+F55yJvN8w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: Verify SD bus width
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "zwisler@chromium.org" <zwisler@chromium.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 at 17:57, Raul Rangel <rrangel@chromium.org> wrote:
>
> On Thu, Apr 18, 2019 at 06:20:26AM +0000, Avri Altman wrote:
> > >
> > > The SD Physical Layer Spec says the following: Since the SD Memory Card
> > > shall support at least the two bus modes 1-bit or 4-bit width, then any SD
> > > Card shall set at least bits 0 and 2 (SD_BUS_WIDTH="0101").
> > >
> > > This change verifies the card has specified a bus width.
> > >
> > > AMD SDHC Device 7806 can get into a bad state after a card disconnect
> > > where anything transferred via the DATA lines will always result in a
> > > zero filled buffer. Currently the driver will continue without error if
> > > the HC is in this condition. A block device will be created, but reading
> > > from it will result in a zero buffer. This makes it seem like the SD
> > > device has been erased, when in actuality the data is never getting
> > > copied from the DATA lines to the data buffer.
> > >
> > > SCR is the first command in the SD initialization sequence that uses the
> > > DATA lines. By checking that the response was invalid, we can abort
> > > mounting the card.
> > >
> > > Acked-by: Avri Altman <avri.altman@wdc.com>
> > >
> > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > Reviewed-by: Avri Altman <avri.altman@wdc.com>
> >
> > Thanks,
> > Avri
> Thanks for the review. Should I rebase this on master so it applies
> cleanly without the MMC trace patches?

Yes, please do!

Kind regards
Uffe
