Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90616C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6053B20679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwXMEarF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436530AbfHBNkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:40:32 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40830 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406490AbfHBNkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:40:32 -0400
Received: by mail-yb1-f196.google.com with SMTP id j6so4701068ybm.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnFIxOkpNcZYRay8DKQqQvnlT+t5tL3INkAqh/eYj7U=;
        b=LwXMEarFcR4Bs/zcWuQ8IJ1fnw5GW8qi7QewqVHSgPtxEMZwFnr70Ww/mfO4fsGMsU
         vst2cS60sOBdSWQ+ahzOfd/EX0Huk7RSVXUTyR8jJOCema3fcTbIDC91OAE6uQ60jKCN
         saJRbOOu7t1+twXuZQZ8kdVtoPj5THrS0dZJxlToQ8jPfXwRW5zvJ4gZ1AAfLuvZjwCL
         5Qe6KtgL2vlpQArknto3oiIGXhIDYndqcmwZyWnEs0tAcA3ggoyZDmj/qd41TDwHBY23
         fI0R+qIRrWZjaTFDaECoRlkYW3rHOyH68XzDzTagRens4oc9AUXKOAaMZt09TJ2yfIx0
         ofWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnFIxOkpNcZYRay8DKQqQvnlT+t5tL3INkAqh/eYj7U=;
        b=Ln9Ekzhxmqzm8gLdfsNcu51wCkFkOlG+A+AwObYUb8wz1DlviDLs0TZgrjsHGzJ6Na
         4AFsSccZbu+rbt/5w7VqSoyfT3ESSbEcYVUNv9kt57ZsWwTll+dfGbrcNqZzdosRuJBW
         WlzS16X6do9/f/RRVvHuD1KUMfqqf9cQ01q3VKKD1wB5WxS0C5xJthG4LXU5GSm6XEmX
         KN+pKetlaxtqkvq6RmYsfS8LxkMKIdN+G/IW70CHmndt3a97ifNZTXTwEh5XgA2qvQ15
         xzutSuIADl2iW74COuP+DdLXFFTJ+63QKemoATIdsLvlMWYh+GeW8ELPPBKCT7DeJZVP
         dkzg==
X-Gm-Message-State: APjAAAU9+FoizOdrCrH2Jgp5tEjKZYnUgjmdjMZRZ8MdVVWCX2M6BM/C
        Kn8kBHltLz/D18n32rlifTXIaI3S
X-Google-Smtp-Source: APXvYqy8FKdeT5aid8DhmNpmzqsYkTh87wGYuv7VWkmczODk9fAjG9eY+voHf018cXZxS+fuzuc9+Q==
X-Received: by 2002:a25:338b:: with SMTP id z133mr82353257ybz.85.1564753230287;
        Fri, 02 Aug 2019 06:40:30 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id k64sm17138045ywk.77.2019.08.02.06.40.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 06:40:28 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id a5so26866857ybo.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 06:40:28 -0700 (PDT)
X-Received: by 2002:a25:5e44:: with SMTP id s65mr77950006ybb.235.1564753227994;
 Fri, 02 Aug 2019 06:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190802083541.12602-1-hslester96@gmail.com>
In-Reply-To: <20190802083541.12602-1-hslester96@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 2 Aug 2019 09:39:51 -0400
X-Gmail-Original-Message-ID: <CA+FuTSc8WBx2PCUhn-sLtYHQR-OROXm2pUN9SDj7P-Bd8432UQ@mail.gmail.com>
Message-ID: <CA+FuTSc8WBx2PCUhn-sLtYHQR-OROXm2pUN9SDj7P-Bd8432UQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cxgb4: sched: Use refcount_t for refcount
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Vishal Kulkarni <vishal@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 4:36 AM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> refcount_t is better for reference counters since its
> implementation can prevent overflows.
> So convert atomic_t ref counters to refcount_t.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>   - Convert refcount from 0-base to 1-base.

This changes the initial value from 0 to 1, but does not change the
release condition. So this introduces an accounting bug?
