Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6361DC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ED9206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfLENP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:15:58 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:41098 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729396AbfLENP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:15:58 -0500
Received: from mr1.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xB5DFv7j031594
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 08:15:57 -0500
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xB5DFqSl001986
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 08:15:57 -0500
Received: by mail-qt1-f200.google.com with SMTP id r9so2437231qtc.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 05:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=B+V35yq0yLrVPZQXw17FfOlVfkBn2Axc+qxIitr2DJo=;
        b=HGwV5Mg7QPgDacAecCxvGz05CpyoS/YCtfKrZVyLM+xdC+zxO47viNx8OViKVWrhV8
         QtRSp+YWjhgU1COK56ogE7PP6ZRLiH7eamGPZX4N/PVtwRZCADAz28fQoO9emIB5Jcht
         2p+lkQF4y5pvz1FqY9BCP7Je6btHyz1WwsV6r3oDng8cDjZ+QucT3li5jqc9l+XAnCP6
         y345iFhSamAXln6R1SzBDV530SFD9Yv80JFAi/3hp8hXKxrBtjFrQskCSoWM2tRMrXym
         pGGi8d2Cj5n7i8N7aJ9Fp9G4gCfEx+fv258t5qDsy01GYKkhf2DykkNtX/pY5buUcA4H
         ELTA==
X-Gm-Message-State: APjAAAXcIwsr3l+S3RuJWWwh1iHLve+2Kq+f95THJ0e2mKeEOCUhGXa1
        b5qOGuCF26mFCRjKD30vt0Ar5bivchtsXtoH93ddivFFRIfBkehRbRBeT31Ol5SewVSnRytQxSC
        x0nuA2t4d+It2zs8eQStKd43CqIA7XeELDSQ=
X-Received: by 2002:a05:620a:a1a:: with SMTP id i26mr7844463qka.383.1575551751590;
        Thu, 05 Dec 2019 05:15:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9inJYNpDhnSphzZMDWgRJobZqbHDmIjG5eF+JAQjYhmTnPDUKWaICcTM0whp/JwcV0PLskA==
X-Received: by 2002:a05:620a:a1a:: with SMTP id i26mr7844438qka.383.1575551751239;
        Thu, 05 Dec 2019 05:15:51 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id t36sm2015117qtt.96.2019.12.05.05.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 05:15:50 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Steven Price <steven.price@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next 20191204: crash in mm/pagewalk.c
In-Reply-To: <20191205123025.GA46328@arm.com>
References: <4587.1575548582@turing-police>
 <20191205123025.GA46328@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1575551748_4281P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Dec 2019 08:15:49 -0500
Message-ID: <7712.1575551749@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1575551748_4281P
Content-Type: text/plain; charset=us-ascii

On Thu, 05 Dec 2019 12:30:26 +0000, Steven Price said:
> On Thu, Dec 05, 2019 at 12:23:02PM +0000, Valdis Klētnieks wrote:
> > linux-next 20191204 dies a horrid death on my laptop while booting:
>
> This is due to an unfortunate conflict between my series reworking of
> the page walk infrastructure to reuse it for kernel walks and a commit
> by Thomas Hellstrom to allow safe modification of entries in the
> callback. See [1] for more detail.
>
> I believe Andrew has dropped my series for now while I rework it to fix
> this conflict.

Thanks for the prompt response - I'll try again with today's -next if the series
has dropped out...

--==_Exmh_1575551748_4281P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXekDBAdmEQWDXROgAQJAdg/7BYsaBUhSz+9hXiSkPtIKyTU29pxSoFrl
mOxl7X7y6iTQu1LKUIgSERGh3aC+iKmAfPfBjw9xBxfGm4nf5QOhDNVucMpN7dMI
avgmFzY9xJCeAohJUi6qkNfxn776bvaQGNgK2OtCC+9mIJ69VZZa3oy9hmikKkGx
88iWdaDg++b4SnkTyjD0Q40382axMvEp9wSMnKPKT0u4JCFbOgpDVzcOJvdgok6k
zwb6P83NdpMuc+7TY+sFeE/ggdyOs04rHgC9DDmiKojzlxQUiHGxRkjOSB7jAzny
OejUX9ukYIjiqxXUUaQGuFPSVY03bCUqfrJFZ75y28I+zEkEC3bcvT7yZ/X+iVY1
qK5DvIJCFr2JYtDAAc74UCTo1nYVkBGpZfbyWGiobZ2P4HAqTJmV1i9Ex1YCnRoU
AxOgwwtd8JjL70pXU/2iipktrT88WckGzaq1zyZVYvoSstmCTGfxGhQwUxwX+Gwt
JGlxywGd3bUe/qwPo7C9hqC1jQOTtfY5DkokGzmupPbjrqU4sbjzrLeZQRqlZxtn
gzYVhovMls2uweeiHXfU+pfYDBP70iPRcLfRbNafGhqEHfQyF0V2pCRcBdKcKHGb
sPs1VXksYMoCismgy0CBjAoMZQpV02RHbu6gw0K1u4uJYWEPdGMxwt1xMLQ3Aqut
4wdCJWQpbr0=
=XB1S
-----END PGP SIGNATURE-----

--==_Exmh_1575551748_4281P--
