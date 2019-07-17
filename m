Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD01C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE932173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/IbRSzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfGQPod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:44:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55227 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfGQPod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:44:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so22640370wme.4;
        Wed, 17 Jul 2019 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Qch/TVAKot2dKHV6qyPU+W7J+jIVm1gKTvbYcAMOlUM=;
        b=J/IbRSzcXCSvjhGEJ+5hBWofziqCzCHUzlMYD0Mgv1HqWiSAXTNH8KI9OrFooGGaIF
         j8SypGEe6/OdUHASZl51e914qPtOVd2e8INp9Jv5w6yp8OLBi+jSoSa0bQqn0IHdJMV/
         xsxPqNiTv94uJfc4IfFNvhFrogjVTD6CzG/SO5sd1A2HF5hsVf8ltAJ08xtG+pbWN5cB
         mdXW6MfsBX+5nPBOaT7GGQjcc2PXzKiheCfw2JrnTealbeyZSvtmCsP5FyeBvNB26nsU
         uUzS7IoGnOOEIB6d8q7xBk1iu4MEvOsWJPK9algl39NgHeTrXl0MbWjwAnpP0TYukCtl
         oyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Qch/TVAKot2dKHV6qyPU+W7J+jIVm1gKTvbYcAMOlUM=;
        b=QByQzBQqZvldRT/2IJyf7HD23+jZr7YU46yyhwjJY7xXU3Af6fAf8nVAtxESUPamo3
         PWZFn9ePlWAUH3Eg/PDs9QuaCN3L9IrwtYIs/CEA2tp5B+KawCVc+DdjRVOA/fTE/CGQ
         b1KXW0MyDAUTBXzXQJoxrwqUjQz3Yv2LjdAFbEd0ZHP87K4KRTlicmz/xGdd/y+s59Nd
         PaH+fPmwy0zVb/dcFqe8JuZbWMGzha/XOk+H3Zlw/8JVKJAUHv4AQw6Eft4AjTwmNEXo
         4AodLUk4zln/vKqB1p/Z1hBDi47nMTcOnRwpDv/vTAQB1DVCJxop+BWYDs/3ywnHtXv4
         gw4w==
X-Gm-Message-State: APjAAAVZBsoagZY93H3LNNWNbm/D2dQiVN9oXh6Z2MMXrCA8a2tDE+P/
        bTsHRqTiVuNpRCydlIsDrTYZY1kDAAdGnlvmBg8=
X-Google-Smtp-Source: APXvYqwqNFiFeOHVGU1GtaRE5wXsQHq3mTcuRlCjMmkM6WgjXan4vIyY5ip+eLHmyv5LyluXe2DalTx5xlNyCNBfeeM=
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr39188861wmm.81.1563378270614;
 Wed, 17 Jul 2019 08:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190717142922.214d54ec@canb.auug.org.au> <CA+icZUUhnSGkLQcCZBzYXCRxExiZ1F=KnzdeiNSbojHRfxRjOA@mail.gmail.com>
 <20190717153329.GC7116@magnolia>
In-Reply-To: <20190717153329.GC7116@magnolia>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 17 Jul 2019 17:44:18 +0200
Message-ID: <CA+icZUUKk0DfhyA881bSc=huHCo5VaMy2oXYV7hE+HAjV09+tQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 17
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 5:33 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Wed, Jul 17, 2019 at 05:30:47PM +0200, Sedat Dilek wrote:
> > Hi Steven, Hi Darrick,
> >
> > Unfortunately, my build-script is not working anymore.
> >
> > I am using builddeb/mkdebian scripts.
>
> Yeah, I accidentally uploaded an internal build patch yesterday which
> got sucked into for-next.  It's been fixed in the iomap-for-next tree
> and should disappear in Thursday's for-next tree.  Sorry about that. :(
>
> --D

Shit happens.

- sed@ -
