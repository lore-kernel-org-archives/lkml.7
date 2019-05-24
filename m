Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15C2C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994AE21850
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EPJpKkUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403936AbfEXTxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 15:53:11 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46124 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403797AbfEXTxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:53:09 -0400
Received: by mail-oi1-f195.google.com with SMTP id 203so7874172oid.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/KUgll3hSEj/FU/ezNNzycl4J+PKbwr5l6FIma0m5Sk=;
        b=EPJpKkUkNZi0HQkddOgj0vcBeOyYhQyV2IWdV8FvZv/s5rSSbzfQectenhyOnmrAku
         aFgH24HdcfZnEJnXLoxqxbVDLIUtW7cNpqpwB9dXhhNX52eXylf1KC//2Zj8k5P3G8Ne
         1R0QUwMuSLKCSmH8v07lXlQ9j/bPUJA6kDVIp5rvMRoZDVJRGIN8wmM/j0YTcdWdtp9l
         FY91Y1A43POToBpe2cV+Ypwu4WMSbYsH2vPEfSxMGdrYc9oCxqzZycJnZGfCBU1gI0fq
         KU8no2evP/2L48FC2NVKqx8YpbRsnneHZXwKJZ9kCnk3yX6O4jw6HZmsEC/jIT2WZkya
         OuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KUgll3hSEj/FU/ezNNzycl4J+PKbwr5l6FIma0m5Sk=;
        b=ud+vWgr950rWPebBBoTv3fmc3rlmGfrPhXUUlkuUf/MJbUBzYaP2cUXnWX4YYhCSao
         xoGVusWmbXp66HXG+cPOuQMGM4+kLx1itn9J5FXzlYt5Ba8vojls9csQt1LNhz1tompJ
         M9bfpZzcRHxbonxu/Z5ZCf71rBkzA7oYeLzHmhROYKiLtEyVYjgmbpWp/K2518o3yweJ
         tuw/DXjyXJd6Pv46N+zlWAJmksg47uHy5x2XXbwo1g39lRMMpbAafyIQBo7khO4Qxq4e
         OogMmHkxlkrfr3BG7yylO2AonotYZ/B/pVzR0RHtks/AKa27rW2igS/sEv7m9DXp9mXj
         6ulA==
X-Gm-Message-State: APjAAAVPXsnwSjEfNgm43vZv/4XSLuZ4JRD2Qzy/gZkJxu4Fukb/RJw7
        tmT3hT6kVLx/Duf7dxcbHjjdIs9vtDFTs6OIoIk=
X-Google-Smtp-Source: APXvYqw9p122eNIr2+xbjUdUHyP6yQjFHu1ATd8aLdpOKuGyZ6p25J+SPof/YcZhERZnyWKHwjzNawD0xZ3t6obdee8=
X-Received: by 2002:aca:ab04:: with SMTP id u4mr830724oie.15.1558727588184;
 Fri, 24 May 2019 12:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190524181936.29470-1-martin.blumenstingl@googlemail.com> <7hblzr1vxm.fsf@baylibre.com>
In-Reply-To: <7hblzr1vxm.fsf@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 24 May 2019 21:52:57 +0200
Message-ID: <CAFBinCAueC3EKQXg-o5ennbPmfQC17+z8YKQ3TXwvxq1m9HtNw@mail.gmail.com>
Subject: Re: [PATCH 0/1] ARM: meson8b-mxq: better support for the TRONFY MXQ
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hexdump0815@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 9:42 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
> > A while ago a user asked on #linux-amlogic about the state of the
> > TRONFY MXQ in mainline. I did some research (mainly downloading an
> > Android firmware image for that device and looking at the .dtb) and
> > updated the mainline .dts accordingly.
> >
> > I kept this patch in my tree but didn't hear back from anyone with one
> > of these boards (who could actually test my patch). That was until
> > today where I got the following message on IRC:
> >   any plans to submit your latest own version of the meson8b mxq dtb
> >   to mainline? it works really well for me and the one in mainline is
> >   too simple to be usedful ...
>
> Any chance of getting a Tested-by: from that IRC user on the patch?
I CC'ed hexdump0815 so I'm hoping that he can send a Tested-by (he
left IRC before I could reply to him)
