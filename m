Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC60C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221F420859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="c9/O9xDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfE0SH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:07:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41363 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0SH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:07:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id l25so15474849otp.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Go+cEvT6712i8SHCbemtxGqeOx5oRlOrOPZ06KB/6pI=;
        b=c9/O9xDnVa9qfikYjzqlRoKsnQFQ1aK7GaX4prunNHFVQi9lyKXEt5whBvlvqgwr4f
         MYJkoXO7aqsBngJhVDNbzgA0Xm/zPG0qgLojsI+XMfq/iCMDkM85hmN3YGyxcsAMa7Ru
         xGzJ0OFpzGTbs8pgA5WpQROAKPkqriqTI2MldOMqetEDIBG831p5j/elghOt6riHpUDA
         NBpSqB4w/o6MuI3CfXwfu6/BvCmI1szXdEnrBHgLEN+sBKmYdyRQwZwrVj+EEvpykBCF
         KMleOxni2gdGev/Vt1r2ZSn4iALPh41VUVUNZFgWJeOwL2IUUBTCJXMn+qaImEB7hmWx
         mLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Go+cEvT6712i8SHCbemtxGqeOx5oRlOrOPZ06KB/6pI=;
        b=XfFDSSEU1kemspJWNjX5BydUPEqU3TkJwOCks7ATCiPCppIPe0lPbDL9Hsm6vRKFO1
         UG0/Pwb8NloVYEtbCTO5KXgGZqkUmt9f/addH894p3sW+TDUarA+CKITbC/bbquGaFPZ
         1iJOLQPdrtqO9y4C9dE30NZuWb/FySl66JG7OxqpkjHYwp0q3EqAjnvZyNo0d8UzVKIP
         gO/KGwxYPpO9tCYstDLeSWJrxz7h6Rn1wyuXbqCp9yc2IgrSjmxsfDJApo1IGxEp72X2
         ADL5o32qlSDB9D1kwy+fDcIzM/X4jAdQg+4plB/cviUrSaXBUspyN//wyMs2f/heuPWv
         X+ig==
X-Gm-Message-State: APjAAAXVPOpT4UDBnAwjXp4YkkOotGqzwC+D6zBQh4PES2Vj02zAHFFN
        mQQeC4Ht7VtDBTvfJRh7liLfog7dnCXNDScR7Hk=
X-Google-Smtp-Source: APXvYqz/9+0ObAJ5pB6MCxeVNlNEP+TlRsEgZaxElNO5sPQsDcX55Fk2AEf9l6nS3x5OOn4JdfLsG7SfFNWlMdQSOUg=
X-Received: by 2002:a9d:7c84:: with SMTP id q4mr2118953otn.98.1558980446983;
 Mon, 27 May 2019 11:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190527133857.30108-1-narmstrong@baylibre.com> <20190527133857.30108-7-narmstrong@baylibre.com>
In-Reply-To: <20190527133857.30108-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:07:16 +0200
Message-ID: <CAFBinCDCvLUHVvk7q+1dJ54mjrGyNfaGDfmVCNeMns--s=nj-Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] ARM: dts: meson8b-mxq: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:40 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> While the text specifies "of the GPL or the X11 license" the actual
> license text matches the MIT license as specified at [0]
>
> [0] https://spdx.org/licenses/MIT.html
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
