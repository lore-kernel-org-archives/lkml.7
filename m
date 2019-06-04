Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C75EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CF524860
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg5NaBQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfFDIPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:15:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35809 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfFDIPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:15:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id h11so18821399ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLlcBHBLLtHstGlRzl9TA6x38HKIxAAJAQ+NO6ZQeWw=;
        b=gg5NaBQkvVlyEjdj76PxCTZ1E9NORC9Uvd2TwtPXwamT631BYBINpO1n7lK40xKlDO
         YF75M03YPHv++3XvpBenhsCevE5QP7jrqgBlPPpsxQf51yLY6i1cDVealPzeWuUeOETM
         Ln8JFOLHaVnUBWlqWtttsyLypGE2AUK6dJbQPwWb8IaMS2uov9Ribb9tr0Px/NPd77BZ
         Vq/ZUbvc7w1hd3O2czGTLEIl+HviRJodECXWHyuwPhv+2YED4WlErKwRwgz0j/FSpbNQ
         BTyOuHsVjmHZEuUOPLjDQWOR3mp4KfA/QHcX/64K8vTFTQx8TqPMWoAJLp6RCAYNkKyw
         5Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLlcBHBLLtHstGlRzl9TA6x38HKIxAAJAQ+NO6ZQeWw=;
        b=TtmJhqfoYTMZLFGUcSS8EYAS59E6eHPsrZc9rM8rdCG2yNUZNnKOLgn+3w9vtVN2Rs
         aFEud32JBBBAxggkRCO4R1e0TS+8Hn14j2Dg/6Jxhmo1eOdn1PhlF3jypyDNoUMLqozA
         1nKXDUTzmfKPM/0Q7+vP07+B0PE+9Yx6zJgZKihDRK98ADAXhjG09nasGkDLO5g4WR1d
         QMbK/YEywtKw8NEHY/coDxcon0XzAZx4mbzav2v4tt76bnUzRM02KUggXROngrTCVHVY
         daX4CuRGNRAsJD4ZKeeX0ndheJPNkW13u40bYCE+xVgqkEGkTt7jGZq8xAfPxlGw23iM
         UZEg==
X-Gm-Message-State: APjAAAWtWcobVIEzCPP+x/6kfuXltubHRSuD6Lzixu7cVunmTEQKAz/m
        Hg1RmrZLwoQb1Fua8cyT+frFPJHdjsy8RoQCU1fQyfXN
X-Google-Smtp-Source: APXvYqzP1NG5gWwqUWs2RU4TEYclgqRL9GlvmJKeApSsoDlNeSku/Zjez2PSP00HTB0NSoYWsCg5La13x7bHF3bdJrY=
X-Received: by 2002:a2e:91c3:: with SMTP id u3mr16042008ljg.130.1559636134081;
 Tue, 04 Jun 2019 01:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190603174735.21002-1-codekipper@gmail.com> <20190603174735.21002-2-codekipper@gmail.com>
 <20190604073443.cnnqd7ucbaehxdvj@flea> <CAGb2v64T5MypDD9A5FNfyikB9vFJZf9+TiQaXi_o2K53QmfaQg@mail.gmail.com>
In-Reply-To: <CAGb2v64T5MypDD9A5FNfyikB9vFJZf9+TiQaXi_o2K53QmfaQg@mail.gmail.com>
From:   Code Kipper <codekipper@gmail.com>
Date:   Tue, 4 Jun 2019 10:15:22 +0200
Message-ID: <CAEKpxBn-XX+GRrMuCccwcC9TFKXGYV4S2ZwX+jBV==33RsW-aQ@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v4 1/9] ASoC: sun4i-i2s: Fix sun8i tx
 channel offset mask
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019 at 09:39, Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Jun 4, 2019 at 3:34 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Jun 03, 2019 at 07:47:27PM +0200, codekipper@gmail.com wrote:
> > > From: Marcus Cooper <codekipper@gmail.com>
> > >
> > > Although not causing any noticeable issues, the mask for the
> > > channel offset is covering too many bits.
> > >
> > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> >
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Would be nice to have
>
> Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")
Thanks....I'll keep this in mind for future reference as jernej also
mention this to me.
BR,
CK
>
> But otherwise,
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
