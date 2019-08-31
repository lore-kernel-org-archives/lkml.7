Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9660C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73B822CE9
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfHaKb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 06:31:58 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43286 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727404AbfHaKb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 06:31:57 -0400
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7VAVu4o004686
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 06:31:56 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7VAVmeg024972
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 06:31:56 -0400
Received: by mail-qt1-f198.google.com with SMTP id k47so9882426qtc.16
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 03:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=IDGw4t+jkka64Wht6d3CAXrxONGQFYzW5tFrvF9rQ80=;
        b=gQlnDP8tf7truzshqgEMJrDDH81tzMLiUYm9oT3mKR2DLDPOYuZqB4VXRwdYRgZzYp
         TUw5vtRlfOSgr0VKOOBq/9x6IatlDsZciqPsdrwPfOQoc2gSdiqYo+CZdeOn0yYNGxed
         jUc4g0/jo4u30mYS7Z4V0OaiYev8niEozykqLXth6gBPK12Pk0uefX1Y7mvbOQqTwAti
         geQE+lK9pnEpOznlPYGvdRL4IpHbc5lzI/QB+no+IuJMkjfyr2GS5wS3gInyscDDYpYl
         4hn8qaSGjRI2eB7upbsKWuYZEBaIwz1DcazC9iJM7Gj5GM4BZAetvse3eVsU6xeLbdoA
         vb3w==
X-Gm-Message-State: APjAAAVwRwd9wfeOo/TeZv/S/c+pwTP6H2MAL/H0upthI7sJ3RGYZ0Ky
        jl+4trxnvEGf0ycCKYO1YT0gnI447lUe/gFy4A7EZnCUG0FpU8+hXm3/JT0FkTVQ+kiYPMs9S8q
        8FMDOC1l8J3PZWuq35tMoFJAHlPhxZhs19PA=
X-Received: by 2002:a37:8c04:: with SMTP id o4mr19360114qkd.163.1567247508216;
        Sat, 31 Aug 2019 03:31:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwY45aL6/n6Q+yi+UlWzypyRQEmcFtucMm/svMFPIxtNeXRyUsVRUo0F9jcenYO+qbRIHxMog==
X-Received: by 2002:a37:8c04:: with SMTP id o4mr19360098qkd.163.1567247508020;
        Sat, 31 Aug 2019 03:31:48 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id 22sm4217243qkc.90.2019.08.31.03.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 03:31:46 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Dave Chinner <david@fromorbit.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        devel@driverdev.osuosl.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
In-Reply-To: <20190830215410.GD7777@dread.disaster.area>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org> <20190828170022.GA7873@kroah.com> <20190829062340.GB3047@infradead.org> <20190829063955.GA30193@kroah.com> <20190829094136.GA28643@infradead.org> <20190829095019.GA13557@kroah.com> <20190829103749.GA13661@infradead.org> <20190829111810.GA23393@kroah.com>
 <20190830215410.GD7777@dread.disaster.area>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567247505_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 31 Aug 2019 06:31:45 -0400
Message-ID: <295503.1567247505@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1567247505_4251P
Content-Type: text/plain; charset=us-ascii

On Sat, 31 Aug 2019 07:54:10 +1000, Dave Chinner said:

> The correct place for new filesystem review is where all the
> experienced filesystem developers hang out - that's linux-fsdevel,
> not the driver staging tree.

So far everything's been cc'ed to linux-fsdevel, which has been spending
more time discussing unlikely() usage in a different filesystem.



--==_Exmh_1567247505_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXWpMkAdmEQWDXROgAQJ88g/+L8aZBmGh/szeaXflnEcMn79pb3NyBxih
+ZtyT6+w4tFSdaj5tNw2bqM+p/gNl7wEdZj0UsBmCZaogZi95/ZfawiJ/Fr/Ck5g
YAa6JJCa8KJfl5TwC3ojDmHSc92/zqivcB4DY58rjLkeHe6b0RkouQZVLGsLtGYY
3VsID8G7CKOVkBzGLOyv6xHpjcOg125ulCd+eoQw5Z2GHL7/50JDvy2TpAYlxut8
kGK07Fs2pwQMxDBMbxTS51qSGu51ZscURPt6jUGpqSEa1a/1x/y5fuILeoxyy9HO
hSrqc3lXnvbL7+0mXIqg7cm62kJ72GmGoE6mNwuG6Z9q0T7uK/0rT0Ffnnopf/b0
2cZz4+xTMJVeS3cZQttHVN9XNgq2DajdoDLNWFgTiPABIdRsaBeUrGRIzwbeTYRH
xESRCtZpePDBDWvu7q/IyuQoQJHWq7oqEHOTE0SJ4cZvycEnsf1AN6oN4ES3Umqs
ZQmPwjtm7vu10SsJPEYoxZQPau5qq/vPr9lF0pMW8J9fUH4Ro45wD2sSgllVBqQj
2PF59qNEfMzwuUiX8+Snb/cKChD6wzpMuz18+m1wEZGzuvybpdZITp2HofmRbovD
Dr+BttOImxJB7tpyJKtoRkr5A0Zf4pxk1RambfMqxtUtsJSr7JxCiH24nthjR0gG
ONk8TCj1hSg=
=xo/v
-----END PGP SIGNATURE-----

--==_Exmh_1567247505_4251P--
