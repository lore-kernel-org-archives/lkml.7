Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820CDC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615BC216E3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGIQWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:22:10 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:49260 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726133AbfGIQWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:22:10 -0400
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x69GM8ET029037
        for <linux-kernel@vger.kernel.org>; Tue, 9 Jul 2019 12:22:08 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x69GM3N7020051
        for <linux-kernel@vger.kernel.org>; Tue, 9 Jul 2019 12:22:08 -0400
Received: by mail-qt1-f199.google.com with SMTP id x7so19827958qtp.15
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 09:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=AeNqLIavBQU2jaz1EVONE/nn9rzf6yeKY0A80d2Rc5I=;
        b=cb/XMKMy1tYUgrShuWWD0ad7Pql1q6UR8THNAI2agc/FD7RCSghbgkzDArhchO8B+F
         bKlubMtHQZSKXwJw5PXEigY4TvuWPSFAGYw8fOcq9jv7MT5EsGCLXTBujDEAUfIM8DWc
         Q0xAYa1Ghcqo+mwEi1RO0dnFUjeWuVOYWATnI7GbGS3NCLcnGEIrzQjXYXVFZoKys7Y4
         Hyk2UzjKl8h6PVQUGk9piKrvyXXrXGnM/yCcF47FzCR69jDN34vYsa01tFYD3wFjDCnp
         nJvJkgqcg/0VnuxEsBuEHRRGs1d8OzXRrVgsC9zfFx1ogOIcTvAbDp+BDctJez972FRz
         lXgg==
X-Gm-Message-State: APjAAAU2UZ7SrmnW9nk0Nwqu2JZh+mjo02WIs3d/5x6pevCF5JRTFhWr
        HhaMCpBvfxYeW5Dva619wRErUkZfFoNd2+veFH8SePoyH7iqMBlTJuTkyHXBqtaVjDOa7/u0Elz
        KSzj1rf9o3BFIOIzgDhQwPYk6PVytLFlwYmk=
X-Received: by 2002:ae9:d606:: with SMTP id r6mr19014442qkk.364.1562689323236;
        Tue, 09 Jul 2019 09:22:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz73ZAgK9eZK6CI+vjMNwlRqTNw895f8ZNT6RNkI7Yk9A4kFfUyb9h9brqr19IgxqlljVxO4w==
X-Received: by 2002:ae9:d606:: with SMTP id r6mr19014424qkk.364.1562689323029;
        Tue, 09 Jul 2019 09:22:03 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::7ca])
        by smtp.gmail.com with ESMTPSA id x42sm2490742qth.24.2019.07.09.09.22.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 09:22:01 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, kys@microsoft.com,
        Sasha Levin <sashal@kernel.org>
Subject: Re: exfat filesystem
In-Reply-To: <20190709154834.GJ32320@bombadil.infradead.org>
References: <21080.1562632662@turing-police> <20190709045020.GB23646@mit.edu> <20190709112136.GI32320@bombadil.infradead.org> <20190709153039.GA3200@mit.edu>
 <20190709154834.GJ32320@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1562689319_2389P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Jul 2019 12:21:59 -0400
Message-ID: <22959.1562689319@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1562689319_2389P
Content-Type: text/plain; charset=us-ascii

On Tue, 09 Jul 2019 08:48:34 -0700, Matthew Wilcox said:

> Interesting analysis.  It seems to me that the correct forms would be
> observed if someone suitably senior at Microsoft accepted the work from
> Valdis and submitted it with their sign-off.  KY, how about it?

I'd be totally OK with that....


--==_Exmh_1562689319_2389P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXSS/JgdmEQWDXROgAQLYWA/+IsHeZtVAiVMZ6bjpDTfWqg6B1nIV/psL
Cqhyj5AcsxgpCLQHrtFhyDIB4suPWa9Mqlglg00eTBsQe1DYRwVK30IQRXHrgXaV
xwIuN38RaP3XQjFeczUUTghvPhirnQ2CDrV9q13jgKs/AvPIFotNG/XDawDK2zvK
nTAepX1mJ9zIom4xcZIz4nc/m/qsmwQAoVEGywmeXGcapFTVpI3yErsOnwW5B8V1
45zsfLrZOU3GuSZ61EMSJRe3UH50kNppQbmUCfVEE3yoHI7kqNM1Qhhjwx/6YfNI
5kyPHq5gEv1sbUFg+VXDmI7JseXdl4jB19XRu8yOjQxQB1Vpd+5pjsUr89d+3R5Q
8oX2TapLS0W+BozW3eFWhVdY610xqkCEDR9h+2wtrgV/bpXG7Prva0hQE/qscHYQ
4Azo1lkwUKKYOKR7aYVfXtq+mztND3nxvMVvUQWNdwiWXDmHpGVp1Hps4ZWdFZKJ
Z8654wqKIi6VG+SPvpG596hbMnEhNRIKkievWZF7Rue50Z+uiwHySQuGOjlYabdC
LD4r/E6RzgiayvKqn0akjVK89tx/lUhAM9kGvnaEF8xKmMIARY5kpAPL4/xCi7sT
ZdmA6KJEr4vfIcZTyYI7elGlyUxpdfO0pMU+GgUuXRwKQiIDfgus++Gr6RUul/Zl
zsOlhd3mjmg=
=h3KC
-----END PGP SIGNATURE-----

--==_Exmh_1562689319_2389P--
