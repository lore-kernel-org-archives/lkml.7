Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36863C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31B12087E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfKEWVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:21:08 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42854 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729830AbfKEWVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:21:08 -0500
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA5ML7Hq004927
        for <linux-kernel@vger.kernel.org>; Tue, 5 Nov 2019 17:21:07 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA5ML2G2009658
        for <linux-kernel@vger.kernel.org>; Tue, 5 Nov 2019 17:21:07 -0500
Received: by mail-qt1-f197.google.com with SMTP id h15so13355133qtn.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 14:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=vyZgv1MiU+dLASUlz/w5fhHaWpJco8awE8e8/l18HM8=;
        b=P3yI+0fJX6gy7a2hp46L6pWO6f/+GZp+tiRDJKaFL/pEkyb0MtudL2FbOATb0bzDx4
         9HiRTMGbVkAqVp7EHVekHbcbRqblOHEPstgqtb+7PQIYk4o+A0gOOaKHNo3zx5A0Vzam
         zkbhD7XDva6b4WfRjgzoeyrOxD3htmLNnRiZ3OndSVqbQheoyoByEO6vd8M3uKKNHLB9
         GTwgtth36Dq+MByCrT34qDUZANblFfQZ8MPrS2FYH/YnRlRoTOvGaVMdApIhsR35UvRO
         KYbej2N831pehRZf8bIeJuB+ue2r2ohlHUEx/kNAXvH3wEcNpJyxH6SKddFz/DVx2Ba5
         SkYw==
X-Gm-Message-State: APjAAAU2ZdFFvhHgxCwOtSg5wBYxXEFNnRvSz0JB8UVfhsUcB+aipcEQ
        ob27U0f9mfmutLuF6JbJPd+gTKJRyw2ZKrOsi3KKG74ErpE4atT/UgS4gSPIlfGVr7CEHQEWmd0
        4tGvNHh2wmTHBMrZV8T6Y4VUoCIxzMzN42pI=
X-Received: by 2002:a37:4a03:: with SMTP id x3mr8462587qka.301.1572992462003;
        Tue, 05 Nov 2019 14:21:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPsD33kXaQMHPELEvfE/dIKy+dRschpRCQh2Q7Ve/jTW1IiTuRxbnvGU6B68MwsWvRCSASsA==
X-Received: by 2002:a37:4a03:: with SMTP id x3mr8462563qka.301.1572992461718;
        Tue, 05 Nov 2019 14:21:01 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id w30sm7962787qtc.47.2019.11.05.14.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 14:21:00 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] staging: exfat: Clean up return codes - FFS_FORMATERR
In-Reply-To: <20191105170515.GA2788121@kroah.com>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu> <20191104014510.102356-2-Valdis.Kletnieks@vt.edu>
 <20191105170515.GA2788121@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1572992459_14215P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Nov 2019 17:20:59 -0500
Message-ID: <254569.1572992459@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1572992459_14215P
Content-Type: text/plain; charset=us-ascii

On Tue, 05 Nov 2019 18:05:15 +0100, Greg Kroah-Hartman said:

> This patch breaks the build:
>
> drivers/staging/exfat/exfat_super.c: In function ‘ffsMountVol’:
> drivers/staging/exfat/exfat_super.c:387:9: error: ‘FFS_FORMATERR’ undeclared
(first use in this function)
>   387 |   ret = FFS_FORMATERR;
>       |         ^~~~~~~~~~~~~
>
>
> Did you test-build this thing?

Yes.

And in my tree, that section of code has:

 385         /* check the validity of PBR */
 386         if (GET16_A(p_pbr->signature) != PBR_SIGNATURE) {
 387                 brelse(tmp_bh);
 388                 bdev_close(sb);
 389                 ret = -EFSCORRUPTED;
 390                 goto out;
 391         }

but 'git blame' says that was changed in patch 02/10 not 01/10, most likely
due to a miscue with 'git add'.

Will fix and resend.

--==_Exmh_1572992459_14215P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXcH1ygdmEQWDXROgAQI1kA//Rfa96SA6XLx+Daor411E3eDVKUZtliYZ
g+je1j8mXFOcy3OfO7yWz6d9LFZ7/NIWIif7veH3RMe0inn9iLDuxNUKF0Pw3Ceu
yy1NMnS+UT7YbO2PZuiWf/mmjW5FJ9nQ8zyHbiNhF886+5FWAmygDyHJzzNP90pQ
ZaCSTlMPHCviDPPJIwOCiw66sT6loNLRJPiYAzjhgRgQ5QMNpH32413GGKx+DQFj
34LAI7SAVJWGOEK6dE3HRAn+jmTayN2o/9SMqewgaTFh9JNVYHytH24mDLLQFDYu
IdbCK5zU6/IDFJn5TcPbzkH+K6R/2ZY3RU8MFZFaJ/jrtR54gG40MX/8BdHqVp1/
nsMhHaBLnh1GAmZy7QRGHhCsCCvJOozMzL25k9943hC7WBw9hhR0XgT6UDsiFhNU
i/YqUu5KN7gzjuflDHvQ+9ot4YL6sreuTM5Oq7MaQsS6UhHWLGK7f2K0dhrokvVC
cSLedpOuqgXZ7CWt9X7ZPWf/W3LzX6URoJi4ou+CJHjAX3/bRCeUCiPXdFoKFLGl
yo4Xe2jxuellQ3HHgBEVkKTDMw63gGFY2/pRMT8LmHYn/36A36DI6UDB88snqu9U
vHtS1JpXq32lEzcidLSLB7Kobn8vM85ZutaiV+L1eB6hPuy6mo1qXDVLauKGxc3p
UesLLDPlgn4=
=ZmFx
-----END PGP SIGNATURE-----

--==_Exmh_1572992459_14215P--
