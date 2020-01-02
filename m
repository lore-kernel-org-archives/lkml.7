Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB397C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8952053B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="gjbU7MT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgABGu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 01:50:26 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36669 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgABGu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 01:50:26 -0500
Received: by mail-qv1-f68.google.com with SMTP id m14so14712416qvl.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 22:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Th769lDcsvGyOzJ6s6RGz8473usM//yYcJrZpTqUCA=;
        b=gjbU7MT6I+8Z6cM15EGiWf1f7XKDyDcOy2i/9F78VzJ5wlpnbBkiKew6wKA4sbVuP5
         l+JqJO+G5+cJZlqT7zgO+xPbSB/7qI5S6PqLg+U+zh1YiEzVG9BGmH5Twxkgds8fOPJu
         /KG6gA7A9AIXOZzZDPgXAV8ImDqkVtU8ADv8N+WX/J8alyIq+2E5u1mK4PleSzgnINt0
         K+IGku67zFJiy0dkp8LZLUg//6S0yNlazJounyr72HK1Pw1RmRLKNretlQePzJfof7wC
         R+0cbUSGYkECZe6s6IN0rSIml6ENkhAHEIiCZhW+IH0oddqld/T+Indl11SgR5Svy+aG
         XrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Th769lDcsvGyOzJ6s6RGz8473usM//yYcJrZpTqUCA=;
        b=fGmDbPG8sr2Tudaqb7d0wEgFvcElbomkQyw+HIGsyYt9EM1uakHxFZDAPAyKU1iLez
         eeLywt2b6q1/TGidEchvpD3l5fHQjh223aAhdRRDw+YKThhYj66amhU7jaP9u9ii/s+o
         VSJ9nk0YR9znfwEH8xXPIyEHgGg7bjBOX0jttqTofj7RiZY16sgx4D7pEBOmOi9QkG/N
         A8XkWM2LwJ2h/adtuNW6a0EOhNwuZu0Y0tmuAT/1e/CdHpRp0pEyIS0SEv7K4x8SaDm6
         S7rrYyeZbAws6JdBSvOWsuXOiM+LnP1yOo58/0pk2buhUUJgub+Q/SEkboPVePQn2H0b
         Kp+g==
X-Gm-Message-State: APjAAAUbukhujODzQS8dKkWIuhpCcWWEe6+HkoSMjMqwEJa6dOwvTp+4
        nK+DyecC0rqrXBH5gVu5rmX0eQ1MZUV/2kjtM2nNOg==
X-Google-Smtp-Source: APXvYqwaFIczvJ+D7E6Ut/yhTGV/ynQlL+Nj9vFpVcoLiNXpxB1JNIeT3Rvh0vxnFsAVplpoA6LdAtGT0e2TJUSsWzY=
X-Received: by 2002:ad4:44ee:: with SMTP id p14mr61089773qvt.114.1577947825319;
 Wed, 01 Jan 2020 22:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20200101022406.15176-1-axel.lin@ingics.com> <356b68fe844846c7fa1e6b7cefae93220508e4b0.camel@fi.rohmeurope.com>
In-Reply-To: <356b68fe844846c7fa1e6b7cefae93220508e4b0.camel@fi.rohmeurope.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Thu, 2 Jan 2020 14:50:14 +0800
Message-ID: <CAFRkauBs6QPUrco+aNaXXE0vd_0GXyXTWz0qRxNkKsH7a4f9Rg@mail.gmail.com>
Subject: Re: [PATCH] regulator: bd70528: Remove .set_ramp_delay for bd70528_ldo_ops
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vaittinen, Matti <Matti.Vaittinen@fi.rohmeurope.com> =E6=96=BC 2020=E5=B9=
=B41=E6=9C=882=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:48=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hello Axel,
>
> On Wed, 2020-01-01 at 10:24 +0800, Axel Lin wrote:
> > The .set_ramp_delay should be for bd70528_buck_ops only.
> Indeed! Only the bucks on BD70528 can change the ramp-delay. Thank you
> for fixing this! May I ask, how did you notice this prolem?
I just read the code.
