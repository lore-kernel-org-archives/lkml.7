Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1138C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9B4207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="KgzdJc6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbfJNKG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:06:29 -0400
Received: from mail-eopbgr770041.outbound.protection.outlook.com ([40.107.77.41]:30002
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731016AbfJNKG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:06:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSt0etDXzwPshAKS9lJQnZfVsg94jfhFXVNrWcbbMVFsQP1N7FLKtkbqBIRYSPS9J6gVqeo2UKOeYlxWx0QneLt6xWQrghxre2kNnNhB0Xr0dAvSGI1c7XIQ9nSjooOaJlWQUDFrSpmrRDAn3cQ7KNGQvwP4zRX6NgLNdaA8J7OoAYVwb69uxqBP5TkSeZDisYtl2cjAzZ2WJnJqKqedzuWB5ShL53iyJ8bU3d4KSRORG7t+QQLpqAmYsM6PK/vmBAFXd/+1nG9zULHD+r1KVQd2Nnqs25g7GbawhFnVXPXlAyJOWawwxMkiTddVAYYOMzbr0geN4XZb7W3IU7Y8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+4r3Icnk1hrl9E5RLz7i/CEFcRypRwfU2n/aeXgCiQ=;
 b=ONzRpJndd2+yFYh9715gy+RKkv5X1oFTfmzfkwo5dGrw1Vg3KsCvTNrqFivRZwveNM1u1wBD3wLf/kILHb54V9gzhEYg+nOW2uWSmyitFLtDOZZbh9Rq0e3RI/AFInpttn8vaj5nXBX4zj2jOJkeFKsvvmMAmaKP16NjzG0xW3w9VKTpyWrOqA2nfRdD9NxBSMYz/sFK38LMvMmN8xqSgnfwQ7+Q7IYE6LCTeE1miXFVlOLZJIv9/IhTgrIgcAe9QZCp/tYGsssjFgFVLsdjnatBpyfsf7aW/OeptWIh1H0gJn4woSHExD2mVuvF0GFt5iIzOYAU341hrGutkcUMEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+4r3Icnk1hrl9E5RLz7i/CEFcRypRwfU2n/aeXgCiQ=;
 b=KgzdJc6cRPcPDwPIOmPUiP+zDg2CGx3mhMSFzRvUWVcsNwLrOfWDT7CFz0rNp8E13mTQrTk+dHvM+SoBq1plLyCKKiWnCd0mTftgMnZzggdGtGabFqMoIV9MJy1l00iXQN6tS/QLMCuqcQylzepf88KiydFDkpXKWbXKB6TclaY=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB3805.namprd11.prod.outlook.com (20.178.253.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Mon, 14 Oct 2019 10:06:25 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f%5]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 10:06:25 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     zhong jiang <zhongjiang@huawei.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2] staging: wfx: fix an undefined reference error
 when CONFIG_MMC=m
Thread-Topic: [PATCH RESEND v2] staging: wfx: fix an undefined reference error
 when CONFIG_MMC=m
Thread-Index: AQHVgFJI7oBgPIfynUuM0VKvgctb36dVqUeAgAClQYCAA5s9gIAAA6gA
Date:   Mon, 14 Oct 2019 10:06:25 +0000
Message-ID: <2864258.2Qbmp6UNZe@pc-42>
References: <1570811647-64905-1-git-send-email-zhongjiang@huawei.com>
 <5DA13F17.6090409@huawei.com> <2927969.oKuMf0pyRb@pc-42>
In-Reply-To: <2927969.oKuMf0pyRb@pc-42>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5bfcb0c-b6d6-4bbd-5bdc-08d7508e2c53
x-ms-traffictypediagnostic: MN2PR11MB3805:
x-microsoft-antispam-prvs: <MN2PR11MB38051879153B1D197BCB210F93900@MN2PR11MB3805.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(366004)(376002)(396003)(136003)(39850400004)(51444003)(199004)(189003)(76116006)(6246003)(66476007)(66446008)(64756008)(14454004)(66946007)(66556008)(316002)(91956017)(54906003)(6436002)(6486002)(6512007)(9686003)(25786009)(7736002)(478600001)(66066001)(4326008)(99286004)(486006)(305945005)(6506007)(71190400001)(2906002)(6116002)(229853002)(71200400001)(11346002)(3846002)(26005)(476003)(186003)(256004)(33716001)(446003)(8936002)(81166006)(8676002)(76176011)(86362001)(81156014)(66574012)(6916009)(102836004)(5660300002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3805;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zfvvICDy7xXF1C6kHc/VyITsQe6EocerlpwXYqxYpuqxpXeZimJlELFcm7TulLKBV4EgxS9Yll63PWmEV0sPZSOvBq/8ysdLuRnicKRb8ntQOGwurfpi7f+qqQ2AgdN0IyTWaC5AL7cZE6bq0sz7GFYv/kvwBGdc7auHq91d2pdXiV766/rHjal+LmtsDtsIxkFp0BWQwQsIeaYfONftT+6hYF1iA8Rv/HSQJ58U4TsKR9LYsYqWoys8pafiQiLvLBZfC5XLSv0VyniQNqtuAQn326gf8Y3tiUm+ZSTo1+ZrvMU7X/wFi5VGkpbXFMY777Pk1Q5/QByF0LtRZTQ2qauD92qk21YlHBAEws2hVnkOIn6JOMaRy2PgRLjsReUD9q6vzzoW7Uvnmz9yjzReoP2YSVlqk7IlMpDtXghdKJg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <91988F16F6AEA64E955A552DE0EB8EFB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bfcb0c-b6d6-4bbd-5bdc-08d7508e2c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 10:06:25.4503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /krnCWoTq1PiVD/ovDr315iZdg8dD03korrFZeeE2Q09xAril6ISJCnYv7yxKAxOOZDuu+QKRFTxdmrAAF9mtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 October 2019 11:53:19 CEST J=E9r=F4me Pouiller wrote:
[...]
> Hello Zhong,
>=20
> Now, I see the problem. It happens when CONFIG_MMC=3Dm and CONFIG_WFX=3Dy
> (if CONFIG_WFX=3Dm, it works).
>=20
> I think the easiest way to solve problem is to disallow CONFIG_WFX=3Dy if=
=20
> CONFIG_MMC=3Dm.
>=20
> This solution impacts users who want to use SPI bus with configuration:
> CONFIG_WFX=3Dy + CONFIG_SPI=3Dy + CONFIG_MMC=3Dm. However, I think this i=
s a
> twisted case. So, I think it won't be missed.
>=20
> I think that patch below do the right thing:
>=20
> -----8<----------8<----------------------8<-----------------
>=20
> diff --git i/drivers/staging/wfx/Kconfig w/drivers/staging/wfx/Kconfig
> index 9b8a1c7a9e90..833f3b05b6b4 100644
> --- i/drivers/staging/wfx/Kconfig
> +++ w/drivers/staging/wfx/Kconfig
> @@ -1,7 +1,7 @@
>  config WFX
>         tristate "Silicon Labs wireless chips WF200 and further"
>         depends on MAC80211
> -       depends on (SPI || MMC)
> +       depends on (MMC=3Dm && m) || MMC=3Dy || (SPI && MMC!=3Dm)
>         help
>           This is a driver for Silicons Labs WFxxx series (WF200 and furt=
her)
>           chipsets. This chip can be found on SPI or SDIO buses.
>=20
>=20
>=20

An alternative (more understandable?):

diff --git i/drivers/staging/wfx/Kconfig w/drivers/staging/wfx/Kconfig
index 9b8a1c7a9e90..83ee4d0ca8c6 100644
--- i/drivers/staging/wfx/Kconfig
+++ w/drivers/staging/wfx/Kconfig
@@ -1,6 +1,7 @@
 config WFX
        tristate "Silicon Labs wireless chips WF200 and further"
        depends on MAC80211
+       depends on MMC || !MMC # do not allow WFX=3Dy if MMC=3Dm
        depends on (SPI || MMC)
        help
          This is a driver for Silicons Labs WFxxx series (WF200 and furthe=
r)


--=20
J=E9r=F4me Pouiller

