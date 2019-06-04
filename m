Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6722C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9596E24C53
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfFDHjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:39:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45248 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfFDHjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:39:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id f20so30560326edt.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYZmXX0Qajsd2CJ4M9QVAkg8+0uFy5kGttoDqJVnpRg=;
        b=iksKGf7/KT9+ZQtLoB6dvKmG0mw5TUxzpjdG5S6iMzcjZUlaqdcmAzOvbxmceMoZRl
         OqDMgOfKWKwFjqUIOvbBZCUJTM03BAQjkrEOn80Q8DS0rPPopEoggSLmKfif3zmqO792
         rUu020k1Lr+wBoFjIzvZ43ycQ5pTCoMmRrNZPUzeZYyW8OOYuFiLEh5sX968pYydLJ+v
         ZYeyxF4W4Qed+UrKRgVopOGLSW4fJQEOuM9v90+jaJOVsN4t++n/DHp1wPwpCJvmataC
         pbKfWoiATSG3vups8V7NxQcrzTrcXQ6X3qgr8rFQs+QdIkZrBG1W5TlkVtllI2MKkN0B
         CFFQ==
X-Gm-Message-State: APjAAAUOOoSONtDNtkTmdV06GTP+RR5LcbVrXb0zbk8xD8I1JEhqrIEJ
        LVlaivH7KUZXx11uBo9ROD6z0lJZUmk=
X-Google-Smtp-Source: APXvYqywVdAf/P2UH0OHwJ0kpTCCBRkRyM6KgWfOpSR5cKmSnC6CshvV8KqKDONy44XtqCXjB7tEhQ==
X-Received: by 2002:a17:906:606:: with SMTP id s6mr28632594ejb.192.1559633945279;
        Tue, 04 Jun 2019 00:39:05 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id a19sm2330179ejb.22.2019.06.04.00.39.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 00:39:04 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 16so9269126wmg.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:39:04 -0700 (PDT)
X-Received: by 2002:a7b:c344:: with SMTP id l4mr16737404wmj.25.1559633944348;
 Tue, 04 Jun 2019 00:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190603174735.21002-1-codekipper@gmail.com> <20190603174735.21002-2-codekipper@gmail.com>
 <20190604073443.cnnqd7ucbaehxdvj@flea>
In-Reply-To: <20190604073443.cnnqd7ucbaehxdvj@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 4 Jun 2019 15:38:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v64T5MypDD9A5FNfyikB9vFJZf9+TiQaXi_o2K53QmfaQg@mail.gmail.com>
Message-ID: <CAGb2v64T5MypDD9A5FNfyikB9vFJZf9+TiQaXi_o2K53QmfaQg@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v4 1/9] ASoC: sun4i-i2s: Fix sun8i tx
 channel offset mask
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Code Kipper <codekipper@gmail.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
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

On Tue, Jun 4, 2019 at 3:34 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Jun 03, 2019 at 07:47:27PM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > Although not causing any noticeable issues, the mask for the
> > channel offset is covering too many bits.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Would be nice to have

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")

But otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>
