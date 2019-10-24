Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFE5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E30F20679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436759AbfJXQpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:45:15 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:36106 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2393978AbfJXQpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:45:10 -0400
Received: from mr1.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OGj8XT006602
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 12:45:08 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OGj3kS017652
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 12:45:08 -0400
Received: by mail-qt1-f197.google.com with SMTP id n34so12713069qta.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=1k/OHruc2b54fj2ZTH33R/zhw5wiURkFRV48Xs6l6kQ=;
        b=Y0oZODMZA6yRckmgAM394XIBHoLDub0C14ECMrJn9SR+8fGmYr+7UV4QxbQ8W8onh3
         2hauuPFMeb5WINRoO8bg2VmG/8bG/99XaVSycvhvBbaewAiT0BYAfuszroWWYI5NG1nD
         al58l+u1BNJL27HN6Id7hj6bVj5+EQbEqly9l3MHR+N8/mMEJF5hL69IdY6WyifOOVZY
         r8Nrac6bU+DpiO/ZPpA0sFHd+X9EVFWNHWEEgNSQFKrm6SvxizEsOoG8jINGeLnRreoI
         GzgxNHvRWO0zmgDpPz8lAsRnTEqUNHKzpsTE2ViDPMdgSdCGsVLTdQu9UHnEMGH6+OtQ
         1JwA==
X-Gm-Message-State: APjAAAUdtneZVG0tNaGu/uFthjZVL9Gud9bIZsibJBHJNq6Feyo3cHJb
        9vCpUMlSK+mSy7wbTbxpXRGajgN4v5PnsOejpHO6k1dpa/yrEWRO0Mw2EQP7g4tITkyaFw9FFc2
        8M6ai2vvSYKcgtzl5hssXQGPl1PCq09n1ovI=
X-Received: by 2002:ae9:e8c3:: with SMTP id a186mr14144557qkg.97.1571935503604;
        Thu, 24 Oct 2019 09:45:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzPmugAIBdJbLw5E7Sxj5nx/GCPtHQUdyKIKhqTlpoBsI7n1U229JrkQCk9r/OOO0i4y5A1bg==
X-Received: by 2002:ae9:e8c3:: with SMTP id a186mr14144530qkg.97.1571935503279;
        Thu, 24 Oct 2019 09:45:03 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id y10sm14239753qkb.55.2019.10.24.09.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:45:02 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] staging: exfat: Clean up return codes
In-Reply-To: <db3315695d3ea493e05f63f3b21fb3a1482293fd.camel@perches.com>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
 <db3315695d3ea493e05f63f3b21fb3a1482293fd.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1571935500_59326P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 12:45:01 -0400
Message-ID: <1116230.1571935501@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1571935500_59326P
Content-Type: text/plain; charset=us-ascii

On Thu, 24 Oct 2019 09:23:24 -0700, Joe Perches said:

> All well and good, but does converting the error code from
> positive to negative have any impact on any of the code
> paths that use these return values?
>
> 	if (error > 0)
> vs
> 	if (error < 0)

I was keeping an eye open for that, and didn't see any.

An interesting case is the FFS_EOF patch, which fixes an actual bug. If you did
a read for length 0, it would return FFS_EOF (==15) - which would be
interpreted as the number of bytes returned by read().


--==_Exmh_1571935500_59326P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXbHVCwdmEQWDXROgAQK2bxAAoiL4k5jX4a3hoTsKKCckfkYTxrHif6dM
u+mgSh7iFo0wQZvdt+Fyihcy2gPDWR6cEbnuEkgRE5PVyHzGjSJjsLPVB6Vwwyf3
78crIJ+HlIHyr/mjZD3RPs9Nqaev77jojfXupvn83aqcIFtAZ10olVXkNq0ZGWiR
O5x2dfxxH4c8sfDDi+UjBrzNblARpPn59pBT6Ae4CMNJ+Skwe/NIQv8wQrmgMnlQ
dbvbGr8bERy0tbenq4fKIvU8T8cmjaBH1ddceUsdxlTGygKJlSKi2DQuMj180IDd
jN7tcZSPzXnHuyrr6Hy1cwyFnvgj+vMC6hv4Ifl2QUhnUXkBVURa2a2jVXvdnSna
B3dZxniAKAB1xhG/0FNAqBpRFx5hAL5X06LrsgEVTjBzacnq6T0oqp0NSiuzL1UA
8qsZvcHAd6SFhpPtt9PMXcRkCSrjcoGK9Ne9d98HwAShS7tnX5AxyFbKdKBQLZjV
FV7/KmS3O56tmQm4zFblgIAsBk8VjWZyo2roimEWZWTN66TjfUZ/66F0tPFIsHXb
WQRs59YLkRqjzZPxJCTfO3hmjcfUt2je9dkQ8aHeI6NX/r9IFb/V9X/lzyFOsL+1
26Oxy8YWftofOBz/9lwMORSbQa+2Q4bujhaRcHYccKDtkDHps710UJIy4BeJjLps
CjuTWTdQoWc=
=xOuK
-----END PGP SIGNATURE-----

--==_Exmh_1571935500_59326P--
