Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028A0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA3B21900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="H4tl8G2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfCUXk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:40:26 -0400
Received: from mail-eopbgr750105.outbound.protection.outlook.com ([40.107.75.105]:63617
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726374AbfCUXkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnFgwaiIXsQ1O3TcsUebHzVVpnJVlKryNcNrMdWKakQ=;
 b=H4tl8G2SzSaC0sec5xy8jSDQyjuMCv7p9CJive8aFZCDYFS00HTQkcawZqCxj0WvcfgXY2v+iFO39ESVCHPou56TnXlX0U1dSq+pn6EcFlXJ9tV1D5ntyPmG7w/1vPdGc9K1JbVmfB3gJB4dPasEr5Jsd6uldasm1KOEh+QMkgc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1086.namprd22.prod.outlook.com (10.174.169.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 21 Mar 2019 23:40:21 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 23:40:21 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     George Hilliard <thirtythreeforty@gmail.com>
CC:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] mips: ralink: allow zboot
Thread-Topic: [RESEND PATCH] mips: ralink: allow zboot
Thread-Index: AQHU4AgLQNJaCLPr+E2sTRrwfQ+CsqYWo1mAgAATLgCAAAhLgA==
Date:   Thu, 21 Mar 2019 23:40:20 +0000
Message-ID: <20190321234019.5ifoywetz2vnhpne@pburton-laptop>
References: <20190321170334.15122-1-thirtythreeforty@gmail.com>
 <20190321170334.15122-2-thirtythreeforty@gmail.com>
 <20190321220159.GC7872@darkstar.musicnaut.iki.fi>
 <CACmrr9hj6A_ZgbgO=bHuueav1FEc4jQ2-T9ddASa61Qe4mKR9g@mail.gmail.com>
In-Reply-To: <CACmrr9hj6A_ZgbgO=bHuueav1FEc4jQ2-T9ddASa61Qe4mKR9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::42) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49e2af6f-5515-4e72-1764-08d6ae5694c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1086;
x-ms-traffictypediagnostic: MWHPR2201MB1086:
x-microsoft-antispam-prvs: <MWHPR2201MB108654DB46105C764DF647EAC1420@MWHPR2201MB1086.namprd22.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(366004)(396003)(39850400004)(346002)(376002)(189003)(199004)(76176011)(52116002)(71190400001)(102836004)(6916009)(6506007)(386003)(476003)(186003)(58126008)(99286004)(26005)(6246003)(14454004)(6116002)(97736004)(81156014)(68736007)(14444005)(478600001)(4326008)(256004)(5660300002)(71200400001)(3846002)(8676002)(6486002)(1076003)(486006)(6512007)(305945005)(33716001)(42882007)(54906003)(66066001)(53936002)(81166006)(7736002)(1411001)(316002)(11346002)(229853002)(105586002)(9686003)(93886005)(8936002)(446003)(106356001)(2906002)(6436002)(44832011)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1086;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v8ktZiZNjkHDtTlUSF3FTUsb0OLizcUjJrx1vX9cUaCoQyzThdv9dVvQu9ZHUixEmobzLEdByNF06Mibzlznv2XbuVy+IXETHxu/FPwIBCp5lbWMO5KfoQx4aQG+TmqFgN07qmKBF0wd35SoeN43Eduoo1zI/U3ogiscdmKB5kKJPYjClSf+XsiBZ8rT+fbkV8F+GU+5CYS3rJSZLLUusxmAWjxlOmwFKAo1ASDtyufFvRKFWhp52L6hH7aFbf3An9LICRI2A3qwzhRq9jhLPTfeswklXSeuUQLq9e6ZveY8UjAkrZl0sp3u2cw2rwe/72VpmI6BtXUc+RN1/ogl4T/FAkqp+VsR8joDvhjeN2Ydg7oZE+8ozhRSEBRPS3ALEdELu4ZRupBbbNQ9vzPhWS1/7bDZh2e4ZaZmC8TQ3eg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9EBC57223C84DD47A70D9EDB4525B54F@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e2af6f-5515-4e72-1764-08d6ae5694c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 23:40:20.9890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On Thu, Mar 21, 2019 at 05:10:38PM -0600, George Hilliard wrote:
> My version of U-Boot complains if I compile out LZMA support:
> ---
> =3D> tftpboot 0x81000000 uImage; tftpboot 0x84000000 hawkeye.dtb; bootm
> 0x81000000 - 0x84000000
> (snip)
> Bytes transferred =3D 7349 (1cb5 hex)
> ## Booting kernel from Legacy Image at 81000000 ...
>    Image Name:   Linux-5.1.0-rc1
>    Image Type:   MIPS Linux Kernel Image (lzma compressed)
>    Data Size:    1465871 Bytes =3D 1.4 MiB
>    Load Address: 80000000
>    Entry Point:  80344338
>    Verifying Checksum ... OK
> ## Flattened Device Tree blob at 84000000
>    Booting using the fdt blob at 0x84000000
>    Uncompressing Kernel Image ... Unimplemented compression type 3
> exit not allowed from main input shell.
> =3D>
> ---

There you're using a uImage though, which is different to
CONFIG_SYS_SUPPORTS_ZBOOT. Even without CONFIG_SYS_SUPPORTS_ZBOOT
enabled, you can build either a compressed or uncompressed uImage.

Some platforms enable one of those targets by default but it doesn't
appear that ralink does, so I guess you're specifying a uImage.lzma
target when building the kernel? Try doing that when
CONFIG_SYS_SUPPORTS_ZBOOT isn't enabled - it'll still generate the same
type of LZMA-compressed uImage.

What CONFIG_SYS_SUPPORTS_ZBOOT does is produce a program (vmlinuz) which
contains a compressed version of vmlinux.bin along with some code to
decompress it. The decompression is performed by vmlinuz itself, not by
U-Boot.

A uImage in contrast is just the compressed (or uncompressed)
vmlinux.bin with a header prepended that U-Boot uses to understand what
it's loading. If the header says the data is compressed with LZMA then
U-Boot will need to support LZMA decompression.

What U-Boot is complaining about there is that you gave it a uImage
that's LZMA compressed & your build of U-Boot itself doesn't support
LZMA. That has nothing to do with CONFIG_SYS_SUPPORTS_ZBOOT or whether
the kernel binary itself supports any particular compression algorithm -
it's purely down to the configuration of your copy of U-Boot.

Options would be to rebuild U-Boot with LZMA support enabled, or to use
a different compression for your uImage that U-Boot already supports.
eg. you could specify that you want to use gzip:

  $ make ARCH=3Dmips uImage.gz

That would give you an image that will work so long as U-Boot supports
gzip decompression, or:

  $ make ARCH=3Dmips uImage.bin

That would give you an uncompressed uImage which U-Boot always supports.

Now it could still be valid to select CONFIG_SYS_SUPPORTS_ZBOOT if you
had a need for a better compression algorithm & couldn't update your
bootloader to support it, but that would be solving a different problem
than your commit message claims & it wouldn't matter at all whether the
bootloader supports a particular compression algorithm.

Thanks,
    Paul
