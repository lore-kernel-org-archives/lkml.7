Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C20C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92942177E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IXHXS6Ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfEWJeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:34:03 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:33805 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730461AbfEWJeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:34:03 -0400
Received: by mail-ot1-f46.google.com with SMTP id l17so4831081otq.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 02:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qfnurdhL9DGvOCuNZVn+xWrGj2H80qaR7gYmd3yWp84=;
        b=IXHXS6IpytKvuEmrz61XQgbxHsVwt7l+u8OYJGbGODZt9dUA0uKXVtuxNutCvA7H1D
         t4E+lSRLBO6S12qNJWxR4rejO2ALA1z3p6e+oXsKRn9+vzj1XjqZlprtDBCT3iJinzaA
         RFAfHtR0X1FIeiIsqEMBBb1MK8Ro9MjZK7AyvUqKVdR5trQaOMXIadORvDwirxOMlq0Y
         ZFmqPjX/BBRR+vIFKYLv4mtYX4l72v0N1O0YkXqbm2KOyDNXK/eEWkXgNVghP7leFPUp
         UgpyN2dYs5SsqvHByTMA64gXQ8VTkjBOY0LEdlP446zu/vM+mrFP79Ppmfr66CsNt3Xm
         qopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qfnurdhL9DGvOCuNZVn+xWrGj2H80qaR7gYmd3yWp84=;
        b=F/ZrH6iL2NXSwSjLs+5Ve6Sz6dHc1kp8cvnEHoV5UOd7ANiSlXany8Z6cSVm4I23ka
         d6qQqYLouZD4+4RlCqbmTauCu2QY7MEaGZEvs2H6I3Oqg9GL6bI1FuivhopC+BYVAB1P
         z2dJ8j6LiHSVkobllE4UG5PA66VYJTJVkgEsqLND83pKOJ063UQMC9GUKvdklud23qmr
         BX58FDDVtrg2XC+7532rCviWrAJfqje7SnHLDwGNOeRYQMtuX/DO0Fur2ZCAUq0b0i1E
         DvG1+GNcyjVWG7zLIMo13xtT51UonUeE3xbKmLNq+OyZu0OMKfrNdSQr0oMSyR2bTfxO
         KzqQ==
X-Gm-Message-State: APjAAAU9+Vg0ioPeIDj/TPEGmWew+txVcAqNRJJMMpYYbPpabfZpYt/i
        ZMQ6Ss3W+DWj6xgOnSo+8i4QEeOE9jCgAY/EZm5+CA==
X-Google-Smtp-Source: APXvYqzONqunLE6E2JZQJ8PzLwSPxcG74zkmGr8QTPUterWsbK7xEC53Ir41m58RIXWWf8FnjxGxnBNYB7+8CIIfeSg=
X-Received: by 2002:a9d:6c5a:: with SMTP id g26mr2158692otq.194.1558604042585;
 Thu, 23 May 2019 02:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAMpxmJWDJiLZA7NQ12VkxqV9nKV-9idn3JsZGdXhz0e19NX54w@mail.gmail.com>
 <CAFRkauBu511Mf7jgLMuX0M_C_KjmBrxSG_d4OEh6ChHfSYK80w@mail.gmail.com>
In-Reply-To: <CAFRkauBu511Mf7jgLMuX0M_C_KjmBrxSG_d4OEh6ChHfSYK80w@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 23 May 2019 11:33:51 +0200
Message-ID: <CAMpxmJWtbtQCKTKw-fo+spvve_5caQA0=xNJJ7zOJWGDqtpm=Q@mail.gmail.com>
Subject: Re: regulator: NULL-pointer dereference in tps6507x
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 23 maj 2019 o 11:31 Axel Lin <axel.lin@ingics.com> napisa=C5=82(a):
>
> Bartosz Golaszewski <bgolaszewski@baylibre.com> =E6=96=BC 2019=E5=B9=B45=
=E6=9C=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:28=E5=AF=AB=E9=
=81=93=EF=BC=9A
> >
> > Hi Axel,
> >
> > commit f979c08f7624 ("regulator: tps6507x: Convert to regulator core's
> > simplified DT parsing code") causes the following crash on da850-evm
> > board with linux v5.2-rc1:
>
> The fix is already in regulator tree and linux-next tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/drivers/regulator?id=3D7d293f56456120efa97c4e18250d86d2a05ad0bd
>
> Regards,
> Axel

Cool, thanks a lot!

Bart
