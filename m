Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D12FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EF620643
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L45FU6S5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKNAlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:41:49 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10550 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfKNAls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:41:48 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191114004146epoutp04fe3a04ec78306fc5c24825f29bd2ac0f~W4KIZjWnL1752417524epoutp04p
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 00:41:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191114004146epoutp04fe3a04ec78306fc5c24825f29bd2ac0f~W4KIZjWnL1752417524epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573692106;
        bh=3nKxhfn3QKWb/HaThz1/AtERm4reG8NxbkcosujDoE0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=L45FU6S5fK4W9hBf3e6iCDixjgh8IXVyYUUQxt03gySwcgmA0fRJuw/+XRpsaApn5
         YIpczQOlVQFmYpbFvHetm7lcpnzRHjx/kCHScs9+SmbJyLfXYvRKtYgYIXoSBbHScv
         wc3wD4qCLuhohJEuNqX5A7VOCzXWfshhy2PxcMQU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191114004145epcas1p1d1a2bf89012aab2ea6b0b31447c62002~W4KHZtlC82838528385epcas1p1a;
        Thu, 14 Nov 2019 00:41:45 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47D2jh3Q64zMqYm5; Thu, 14 Nov
        2019 00:41:44 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.56.04135.8C2ACCD5; Thu, 14 Nov 2019 09:41:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191114004144epcas1p439302839cefe1e9c89de63ea3ace0a20~W4KF_SCVX1491714917epcas1p4A;
        Thu, 14 Nov 2019 00:41:44 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191114004144epsmtrp215af9d75922b44789d3a869181e25076~W4KF9oqlh2646826468epsmtrp24;
        Thu, 14 Nov 2019 00:41:44 +0000 (GMT)
X-AuditID: b6c32a36-7e3ff70000001027-5e-5dcca2c8318e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.A8.25663.7C2ACCD5; Thu, 14 Nov 2019 09:41:43 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191114004143epsmtip1b76194f9a2adf7abdc3a23dbff30902d~W4KFvBWC40748507485epsmtip1I;
        Thu, 14 Nov 2019 00:41:43 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Eric Sandeen'" <sandeen@sandeen.net>,
        =?UTF-8?Q?'Valdis_Kl=C4=93tnieks'?= <valdis.kletnieks@vt.edu>
Cc:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <hch@lst.de>, <sj1557.seo@samsung.com>, <linkinjeon@gmail.com>
In-Reply-To: <5965ff2d-6cf5-f0b2-54c6-cba6e0cfc364@sandeen.net>
Subject: RE: [PATCH 00/13] add the latest exfat driver
Date:   Thu, 14 Nov 2019 09:41:43 +0900
Message-ID: <003a01d59a84$498b1570$dca14050$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Content-Language: ko
Thread-Index: AQHHxga7Pe0xkp6Lg43M9LEQ0kGZ9QIMNz33AdkqbhQCC3wlLQJLNfGap2OXC/A=
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29nOOatWX9ust0WxDhRprG3OrVO4riKLoqQiKLJ1cAeVtrO1
        M8UulHRVsbAoqpldscgiQ1apEda6mKBRWUSGXciYrdTULj+MaNsx8t/zPe/zfO/7fN9LE+pr
        pI7OFwK8X+DcDDlKfvN+ssHw+HxrtulY2yR2z4Vakr185aGMfdXZQbDtjadIdt+LFDb054GC
        fd73Tb6QcjQEOylHU9VVynH7dTHpOBSqQY7QhQ8yx2DdVEf41lcyi1rvTs/jORfv1/NCjteV
        L+TamWWrnUucVpvJbDDPZecweoHz8HYmY3mWITPfHZuH0Rdy7oIYlcWJImOcn+73FgR4fZ5X
        DNgZ3udy+8wm32yR84gFQu7sHK9nntlkSrXGlJvcedHql5RvQFPUe/2arBjVaMqQkgacBp9/
        V8jL0ChajesR/IiUy+IFNR5AEAkbpcJPBF11PeQ/R/TMW4VUuIOg8l43kg5RBPee3kjYSWyA
        P7+bEg4t3gw3HjRTcRGBdyM48+mEIl5Q4gVwPNKSMGiwDb7vPZowyPF0GGivQXGswnPhzeE3
        w3g8tJzskscxgWfBxXNfCGkkPdS3fUESr4XK0v2E1HgFNLw7kggH+BcJkccdw4YMCFZ9QBLW
        QLQ5RElYB4O9d2JD0DG8HfqbhuUlCLp/2SVsgde11xVxCYGTobbRKNHToGGoaniEsdD7o1wh
        3aKCkv1qSTIdDj2/L5PwZCg78I2qQExwRLDgiGDBEWGC/5udRfIaNIH3iZ5cXjT7Ukd+dh1K
        7GqKrR6df7I8jDCNmDGqu0mt2WoFVyhu9YQR0ASjVc0UYpTKxW3dxvu9Tn+BmxfDyBp798OE
        LinHG9t8IeA0W1MtFgubZptjs1qYiapFl6qz1TiXC/Cbed7H+//5ZLRSV4xsV3Weu3TPknE7
        X6LTDW3vjmtStYpI34YrSV1b0r9rncoZC7SNb4vG7/6Idpzo7pzZ/8i4HrcrdSVjn2X3C2OK
        OmhLWsWqbXvtyStNPZS+1VkYisLBnY+ChZ/XVeNFjZPXoJbmtaNLdz1cl+I1Dh0Q3y+esdRV
        3Jd5e2hj2uAUYORiHmdOIfwi9xcGG05awQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnO7xRWdiDZ59MLNoXryezWLl6qNM
        Ftfv3mK2uLxrDptF6xUtiy3/jrBaXHr/gcWB3WPnrLvsHvvnrmH32H2zgc2jb8sqRo8tix8y
        eXzeJOdxaPsbtgD2KC6blNSczLLUIn27BK6MvRd3MBa85K3YvK+TrYHxNVcXIyeHhICJxKv5
        91i7GLk4hAR2M0r8Ov+eCSIhLXHsxBnmLkYOIFtY4vDhYoiaF4wSd/o2MYLUsAnoSvz7s58N
        xBYRyJbYeuQ4O4jNLNDBKLGpyxaiYSqTRNv+mWANnAL2EtOfnwRbICxgJvGlZQpYM4uAqsSn
        y6vAangFLCVuT7wNZQtKnJz5hAViqLZE78NWRhh72cLXzBCHKkjsOPsaKi4iMbuzjRniID+J
        nfcnsUxgFJ6FZNQsJKNmIRk1C0n7AkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsY
        wRGmpbWD8cSJ+EOMAhyMSjy8EhJnYoVYE8uKK3MPMUpwMCuJ8GrkAYV4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFwSjUwOji73ri1dvfuZx1Wzy+aL39r/Svl
        T/5D/65fc0OVHWdsFopZYq5qM9P9AJPwFRHvI08PqM1br/x2ctdqucCTrru3Mk8pedPckGBX
        obLz0fVTz2+dvbGqLWiTw6UZr6pz9n2YG+or4f56beH/mcG/j5ucWTXl1mEW1Vfm1s1lMiJc
        82ZwtL9/YqXEUpyRaKjFXFScCADErj4xrAIAAA==
X-CMS-MailID: 20191114004144epcas1p439302839cefe1e9c89de63ea3ace0a20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113082216epcas1p2e712c23c9524e04be624ccc822b59bf0
References: <CGME20191113082216epcas1p2e712c23c9524e04be624ccc822b59bf0@epcas1p2.samsung.com>
        <20191113081800.7672-1-namjae.jeon@samsung.com>
        <69d00c12-7b8a-1d47-0c18-58323f7ca60b@sandeen.net>
        <367298.1573682134@turing-police>
        <5965ff2d-6cf5-f0b2-54c6-cba6e0cfc364@sandeen.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 11/13/19 3:55 PM, Valdis Kl=C4=93tnieks=20wrote:=0D=0A>=20>=20On=20Wed=
,=2013=20Nov=202019=2015:00:23=20-0600,=20Eric=20Sandeen=20said:=0D=0A>=20>=
>=20On=2011/13/19=202:17=20AM,=20Namjae=20Jeon=20wrote:=0D=0A>=20>>>=20This=
=20adds=20the=20latest=20Samsung=20exfat=20driver=20to=20fs/exfat.=20This=
=20is=20an=0D=0A>=20>>>=20implementation=20of=20the=20Microsoft=20exFAT=20s=
pecification.=20Previous=20versions=0D=0A>=20>>>=20of=20this=20shipped=20wi=
th=20millions=20of=20Android=20phones,=20an=20a=20random=20previous=0D=0A>=
=20>>>=20snaphot=20has=20been=20merged=20in=20drivers/staging/.=0D=0A>=20>>=
>=0D=0A>=20>>>=20Compared=20to=20the=20sdfat=20driver=20shipped=20on=20the=
=20phones=20the=20following=20changes=0D=0A>=20>>>=20have=20been=20made:=0D=
=0A>=20>>>=0D=0A>=20>>>=20=20-=20the=20support=20for=20vfat=20has=20been=20=
removed=20as=20that=20is=20already=20supported=0D=0A>=20>>>=20=20=20=20by=
=20fs/fat=0D=0A>=20>>>=20=20-=20driver=20has=20been=20renamed=20to=20exfat=
=0D=0A>=20>>>=20=20-=20the=20code=20has=20been=20refactored=20and=20clean=
=20up=20to=20fully=20integrate=20into=0D=0A>=20>>>=20=20=20=20the=20upstrea=
m=20Linux=20version=20and=20follow=20the=20Linux=20coding=20style=0D=0A>=20=
>>>=20=20-=20metadata=20operations=20like=20create,=20lookup=20and=20readdi=
r=20have=20been=20further=0D=0A>=20>>>=20=20=20=20optimized=0D=0A>=20>>>=20=
=20-=20various=20major=20and=20minor=20bugs=20have=20been=20fixed=0D=0A>=20=
>>>=0D=0A>=20>>>=20We=20plan=20to=20treat=20this=20version=20as=20the=20fut=
ure=20upstream=20for=20the=20code=20base=0D=0A>=20>>>=20once=20merged,=20an=
d=20all=20new=20features=20and=20bug=20fixes=20will=20go=20upstream=20first=
.=0D=0A>=20>>=0D=0A>=20>>=20Apologies=20if=20I=20should=20know=20this=20alr=
eady,=20but=20where=20are=20the=20userspace=0D=0A>=20tools=0D=0A>=20>>=20fo=
r=20exfat=20located?=0D=0A>=20>=0D=0A>=20>=20The=20upstream=20for=20that=20=
is=20https://protect2.fireeye.com/url?k=3Dc58c1a81-=0D=0A>=2098101be1-c58d9=
1ce-0cc47a31307c-=0D=0A>=20f7e416d4f44c26c5&u=3Dhttps://github.com/relan/ex=
fat=0D=0A>=20>=0D=0A>=20>=20On=20Fedora,=20they're=20available=20in=20the=
=20rpmfusion=20RPM=20'exfat-utils',=20not=20sure=0D=0A>=20where=0D=0A>=20>=
=20Ubuntu=20or=20other=20distros=20put=20it.=0D=0A>=20=0D=0A>=20Thanks,=20I=
=20wasn't=20sure=20if=20that=20was=20the=20=22official=22=20repo=20at=20thi=
s=20point.=0D=0AI=20am=20preparing=20exfat-tools=20project=20and=20will=20s=
hare=20it=20here.=0D=0A>=20=0D=0A>=20-Eric=0D=0A=0D=0A=0D=0A
