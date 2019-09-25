Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8797CC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9D7214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634002AbfIYHxT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:53:19 -0400
Received: from m4a0040g.houston.softwaregrp.com ([15.124.2.86]:40609 "EHLO
        m4a0040g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2633991AbfIYHxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:53:19 -0400
Received: FROM m4a0040g.houston.softwaregrp.com (15.120.17.147) BY m4a0040g.houston.softwaregrp.com WITH ESMTP;
 Wed, 25 Sep 2019 07:52:18 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 25 Sep 2019 07:50:42 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 25 Sep 2019 07:50:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xvk0b0SdVGAOJNUZVkr/+DilJ3kUvWCZP35fNFpfBqH8kK7tKfVmwFhr5FVdf/Vj08C25fCGRWgFgA/3A95+XG8dczyZP1wxYLsTY11lP3/sXlQwkjr8hJnrp9M+QlFIx5vIqCQ9dYvLNokckEgvkMQ6tco39l2rfJE7oqYU1i5Q+tOnQD2XhOCZn2OeVW6U3JSfqQKaR0u11qXqEoUmOdPc8WmLm8GsJjyvcvA9EpeanjA1Jh82vNw6RQgKRQTZYYNYLDvo3WzNytqg8mki1Q3dQzEpbRDvlTd7gY5Kr8HzuUlUXlwgyQi3/bHwpR+esFFE1yZroF7TejlT2aTRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eois5P32oIZv0K9DssAPNxTCkJ2DGjSmxNLh9Qo2MPM=;
 b=WReTtKzqshS4lzDBeuN40K3QZ4IWoOOJWh9yI/Bvxgay1sXGUAg9TiUUBX8XYpM+kBvqnGzTm7zfr+fJ9wIQeUJksy41DEsI49rFYQpGPTlP5X9K4d57NCv/vayqEn3CBk4KkNXIzCwjupaVojo2PnhI0Cpo9I5fYCi37Tbel6PWxYORT5BIMEJXk85lEEs6Yc4uAx78UJCx/acwZvOFSURUlGgQ0fnt/SWgZ36DFMP3u02ey1YTzshpn8AjvDm49GJXwsddX+Zdy7cE+G5om8gjBOILoH9C34SAQ6JVR2KM28k9w8caCS5QP+YuloX6NPjZ303fa3eSJgdMIBrKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from MN2PR18MB2736.namprd18.prod.outlook.com (20.179.23.30) by
 MN2PR18MB2685.namprd18.prod.outlook.com (20.179.82.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 07:50:36 +0000
Received: from MN2PR18MB2736.namprd18.prod.outlook.com
 ([fe80::a4a5:349f:5e99:fbaf]) by MN2PR18MB2736.namprd18.prod.outlook.com
 ([fe80::a4a5:349f:5e99:fbaf%5]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 07:50:36 +0000
From:   Joey Lee <JLee@suse.com>
To:     Gabriel C <nix.or.die@gmail.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: acer_wmi: Unknown function(s) on Acer Nitro 5 (AN515-43-R8BF)
Thread-Topic: acer_wmi: Unknown function(s) on Acer Nitro 5 (AN515-43-R8BF)
Thread-Index: AQHVckeCx20Ww7D6Ok6go3mJWdsWyac8BzoA
Date:   Wed, 25 Sep 2019 07:50:36 +0000
Message-ID: <20190925075026.GY3878@linux-l9pv.suse>
References: <CAEJqkgjSes-4bSKbyfbNhXfcQwdEMzp8X4f72_SS=NpBoBtWmQ@mail.gmail.com>
In-Reply-To: <CAEJqkgjSes-4bSKbyfbNhXfcQwdEMzp8X4f72_SS=NpBoBtWmQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0101.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::17) To MN2PR18MB2736.namprd18.prod.outlook.com
 (2603:10b6:208:a4::30)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=JLee@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [60.251.47.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33bcc37f-1b61-4fbc-2f08-08d7418d0d5b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB2685;
x-ms-traffictypediagnostic: MN2PR18MB2685:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR18MB2685402CEF901AEB10C120D6A3870@MN2PR18MB2685.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(199004)(189003)(1076003)(5660300002)(81156014)(99286004)(55236004)(52116002)(76176011)(26005)(6506007)(102836004)(386003)(186003)(446003)(11346002)(476003)(486006)(66446008)(64756008)(66556008)(66476007)(66946007)(7736002)(54906003)(14454004)(80792005)(966005)(25786009)(81166006)(8676002)(478600001)(36756003)(316002)(71200400001)(71190400001)(256004)(14444005)(6916009)(305945005)(33656002)(86362001)(8936002)(4326008)(6246003)(66066001)(6306002)(6436002)(6512007)(9686003)(6486002)(3846002)(6116002)(229853002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR18MB2685;H:MN2PR18MB2736.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: si4p/fZ27J0LtuHl2icJ/ykSnoACjXlE01n2FJDmKO4LQS8BhYuBIw5+bDjanl/EGN0JhaU2xpHFSb9LBEGdDYORCQWsoukOoaL75l1H4eCQe4mdVG+zkmX5imYaheBjgi3pmxQxGYruwtD3FdfedUAsL9wvB0niXTzLpRRfS1CCuMaJc2f79/8gIh1i++u5LvFinz0ZGNHMbOQGfbEw0dM+WmQ/swwlVHeBTfI8d1gPOIB3MttJZz81Kallp/Omyh+PfOoxJZrRmWjTWYi7B8JKBMF+7FrR6dSPOMdk4AGKV/r7Du1KDnZwRGQD89Gg8rppD2PM4Rn5/Oz/vpSKKkoN8jrltNYpBvPNeZ1QD1U+HP6AHTvHVgQwNgeDIKYYYXZg4sWqQ/+zB/jVqfSOcRCiOltDba568bnH76SL1upVccCCJ+iX+Jh2kLvFflJ2r1Er2gp+sBmvN7+MQCIGQQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5B6AC137F0D9645BF47A0B0835B6F54@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bcc37f-1b61-4fbc-2f08-08d7418d0d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 07:50:36.8976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rH8PXpCIwAw91vpopNh255ipBIQUfejMGJ7t83nolpPuSeHK31gklVGNT2mXzDA2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2685
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

On Mon, Sep 23, 2019 at 09:45:05PM +0200, Gabriel C wrote:
> Hi guys,
> 
> I noticed some warning in dmesg on this Laptop.
> 
> Fn+right, Fn+left is BrightnessDown/Up and produce the following warning:
> 
> acer_wmi: Unknown function number - 4 - 0
> 
> The brightness has some other issue on this Laptop but not sure
> who to blame on this. Probably amdgpu.?
> 
> /sys/class/backlight/amdgpu_bl1/brightness <-> actual_brightness
> seems to mismatch.  EG: when brightness is 0 actual_brightness is still 5140.
>

Base on _BCM and _BQC in your DSDT. The backlight control is handled by EC.
But, in some Acer machines that the _BCM is broken. You can try to modify
brighess by echo to sys/class/backlight/acpi_video0/brightness
 
> Unplugging the AC gives the following warning:
> 
> acer_wmi: Unknown function number - 8 - 0
> 
> When plugging the AC back I see;
> 
> acer_wmi: Unknown function number - 8 - 1.
> 
> I uploaded a dump of the acpi tables and dmidecode of the box.
> 
> https://www.frugalware.org/~crazy/nitro5/ACPI
> https://www.frugalware.org/~crazy/nitro5/DMI
> 
> Please let me know if you need any other informations.
>

Thanks for your report the behavior for the function 4 and function 8.
Maybe we can use the platform event to do something. e.g. expose key code
to userland. Unfortunately my working list is too long that I do not have
time for it currently.

Thanks a lot!
Joey Lee 
