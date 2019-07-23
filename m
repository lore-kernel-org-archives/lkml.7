Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF185C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC66223A1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="rdbqmrwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfGWM2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:28:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43008 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfGWM2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:28:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id w17so41645074qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 05:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GXr2RkmAYQxUCXIi8U3i5+heOs5LuyUU9Xu1IQTdpfg=;
        b=rdbqmrwkbDGlVde6fjKbpiDe6a+hbFSKvl5lGpPkzo2ySMazROUZESkedZhMjdDPk1
         Ov9ceNzVy95InpQ039T4ONvyPJhm/QVmZYJa7w/fVmbayR9rdmqQp00URuJY1EN6cria
         GS6Fns0WGJVaDNt+ZtCxhpfjGrb1mt/KBzrfs2KXa/qUM/g5eblCxwsUULu6QoPeyrwr
         QDVZAioYc84pK2DnAcZicKWZksbhk7dwJeG7JHy0qk2EyXufRT4B60kYK0BsqkH7AzW7
         eyVN8JhLO64I+Sao0YbQDjNimDUC4rk+k4sXXqZpUCtd+kmkNHs8B525WixMaJtFsMgM
         eQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GXr2RkmAYQxUCXIi8U3i5+heOs5LuyUU9Xu1IQTdpfg=;
        b=IauwrvmaFNUTKgrXavdSczYHnXIw8K9npz45ZH7nfJ4TyBa1Agh+vufTyB/IdRZAqn
         sXscls0sh9VBhsT89FGKkm89ZMsqZVLgTJn4alhRz6Q/oqlsctx9nPfeul4a4QZGP3m1
         aqB0ZmvSURrLJTh/wW41S2YwvVnqWNPkvc3qMt4bLBZytRzmdoBqFuxMa/hj/Ek/36gY
         2lgsivdyUHzUh62eqO3xiocSNEcBLq8EcGajuEigrBmf4sGi8mXUx2MD7mizlClFrcUJ
         pZKF+54hF8fDP+lF9zgd34SGAsP8lqTM+4qyh0ZKKOMhdNB8e1zTVvwDt3udfldxzOgH
         YGLg==
X-Gm-Message-State: APjAAAXTEOx0Tqm75ObEknrYnO3U7sQ8OhWnnRz/W/Ke4+3Z2VkhYSEE
        +yuvrsoMF69lF6zsVbxCXYaPzjO/E2NIKg6lQhk=
X-Google-Smtp-Source: APXvYqxDtIjpiml4X/oHgwmyqDmfNiqQZfTOPeDDKZwjbxmlf7pML1FYn7nbSWK8I7UrXg3KZwv4fRdRV/Hh9yVVebA=
X-Received: by 2002:a0c:ae6d:: with SMTP id z42mr54243584qvc.8.1563884926970;
 Tue, 23 Jul 2019 05:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190711113517.26077-1-axel.lin@ingics.com> <20190723112647.GE5365@sirena.org.uk>
In-Reply-To: <20190723112647.GE5365@sirena.org.uk>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Tue, 23 Jul 2019 20:28:35 +0800
Message-ID: <CAFRkauDSbmtGRnE0xvKOKxb=SWOA+03i60Wu-9KHYxh1qFuCEg@mail.gmail.com>
Subject: Re: [PATCH RFT] regulator: lp87565: Fix probe failure for "ti,lp87565"
To:     Mark Brown <broonie@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2019=E5=B9=B47=E6=9C=8823=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:26=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Jul 11, 2019 at 07:35:17PM +0800, Axel Lin wrote:
> > The "ti,lp87565" compatible string is still in of_lp87565_match_table,
> > but current code will return -EINVAL because lp87565->dev_type is unkno=
wn.
> > This was working in earlier kernel versions, so fix it.
>
> This doesn't seem to apply against current code, please check and
> resend.

I re-generate the patch but the new patch is exactly the same as this one.
It can be applied to both Linus and linux-next trees.
Did I miss something?
