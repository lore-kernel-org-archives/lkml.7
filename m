Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8A5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276922084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SXyz+cp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDIQaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:30:02 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43063 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDIQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:30:00 -0400
Received: by mail-ua1-f68.google.com with SMTP id n16so1056595uae.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dqVrkebP9i8uuyqyr4MqTXK9lcw0lbYjOb+pihL7B98=;
        b=SXyz+cp9YUh+SITTF07b/RFtwdxCMRFTVxMVL+Wb7A66MpIeIV6Z63tQCZHdRmQ+3E
         LSwgMFrRHqJnm8xeqh+8fR/pysZYkDi0D9xly4o2p8LJLQj3behuV6hNylzsh8obwydb
         7YCF03C20P2tOm3lVuu4mwZ0acmp8KxzHYJes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dqVrkebP9i8uuyqyr4MqTXK9lcw0lbYjOb+pihL7B98=;
        b=f6kA5O35/SLj6eQVVZRJ+ZNPTsTSCS8NYfF1QY4XhIkh0wnu0/sCdLcorbC5uBMZQb
         Bmg4nUu9vnQfjm2850ihMm8hjhVU2yRASYpq4EbFeX10jGvCSa78Ke9WqGVzg0WUfroD
         EcKZPtGAU+rXaGjcAVeZ0+ycF7JVvHBJFW/08sMAGVkW5HKMgsMdJ6OI5kmUqbHiA9ti
         uYlehORCMgqOAjkxIty2JtNzqp6uxB20i8yL5lxzXjrulkgOgweKUp5vez4YKFoSn9wP
         4f7z6kLHGJ/PX0QxhvQh/OaJ+OLG5BHs2UyyeHhsHax4O7eEQHHIAmSxbvwRYL+JLFrr
         4jZQ==
X-Gm-Message-State: APjAAAXWOx0D3+uC7cNJEscM9/Ht902/X0tgn607dd8HxRwL9i4mmizJ
        Kz9qKIkUGhDFoCcddt8jy+nZtxXseC0=
X-Google-Smtp-Source: APXvYqyrWd+q/fTauvJdnQtzj3dZVPRhtkmsZin4wXpxOc48YwYxd/iMR4rq8ojKeTkkCWawgbrm1Q==
X-Received: by 2002:a9f:2448:: with SMTP id 66mr4635293uaq.84.1554827399204;
        Tue, 09 Apr 2019 09:29:59 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id s194sm15701711vkf.37.2019.04.09.09.29.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:29:57 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id i207so10166873vsd.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 09:29:56 -0700 (PDT)
X-Received: by 2002:a67:1345:: with SMTP id 66mr20102814vst.30.1554827395980;
 Tue, 09 Apr 2019 09:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190213185741.GA5047@embeddedor>
In-Reply-To: <20190213185741.GA5047@embeddedor>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 9 Apr 2019 09:29:43 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLaZ3czP9YDJ9R+3UeBxuULubBPcnFNdh+qT_S9D5eZZg@mail.gmail.com>
Message-ID: <CAGXu5jLaZ3czP9YDJ9R+3UeBxuULubBPcnFNdh+qT_S9D5eZZg@mail.gmail.com>
Subject: Re: [PATCH] NFC: pn533: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:57 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> drivers/nfc/pn533/pn533.c: In function =E2=80=98pn533_transceive=E2=80=99=
:
> drivers/nfc/pn533/pn533.c:2142:6: warning: this statement may fall throug=
h [-Wimplicit-fallthrough=3D]
>    if (dev->tgt_active_prot =3D=3D NFC_PROTO_FELICA) {
>       ^
> drivers/nfc/pn533/pn533.c:2150:2: note: here
>   default:
>   ^~~~~~~
> drivers/nfc/pn533/pn533.c: In function =E2=80=98pn533_wq_mi_recv=E2=80=99=
:
> drivers/nfc/pn533/pn533.c:2267:6: warning: this statement may fall throug=
h [-Wimplicit-fallthrough=3D]
>    if (dev->tgt_active_prot =3D=3D NFC_PROTO_FELICA) {
>       ^
> drivers/nfc/pn533/pn533.c:2276:2: note: here
>   default:
>   ^~~~~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Addresses-Coverity-ID: 1230487 ("Missing break in switch")
> Addresses-Coverity-ID: 1230488 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

--=20
Kees Cook
