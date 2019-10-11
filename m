Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAE4C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768C9206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D9WNb4+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfJKMsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:48:11 -0400
Received: from mail-eopbgr50071.outbound.protection.outlook.com ([40.107.5.71]:21893
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727243AbfJKMsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:48:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsbNxve1/Rqi8qlKjfhD4ySV32IzaoOE2+ISM/dzA3KGOvH5W65RxRq+3K1AUZtRUW+MCcmrGRNinh+Y1HQdXUNj+ba2UCINIk7pj+6pz+78rx2ljOxxNNUPJ23LV3fxzifdSnujCKd9haCRmbXV0svTzyjb811YlkD/G4hFHBPar/Hzg7SX6DBJSeKnweqciPWsxNMYGvChD3i2g+uwthgFL16E9xcFV/KH5yu5S4x8ILZ3FdfgQiFcIT0e7FjNZFtKMsAHmUqWvc/sMI20vvJo6niA4r4kpE44c+xDdLOIIPcluRUrVrAWFYMctmL/OqIUdO2yND1+7zi2yjdVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VRcqZyd/7HeGBi6IpU6sm+eEXMpCe9WOGSgi5zd5Us=;
 b=VuK+lHZHzHt3EI4oGvNmfHBgEIpTzjX2jHK5abH/b2wITajfw1ldUbRYsKjFhRERkojT14Zet6Y3SE/IrGtGDwPERwJwivInYk7cL9IHDYUuI5Z4MmdDMl+y9pZV6pDaNEoUFVzXJzdiYknHkP3LKzU0Opm2ddCIuyEScOSUYwnSd+M8gh4tisnDB/fLN9ZVKCsZDApQxLQ35f/rW56UKVQRn486PVbnnWUePJtiXKSCMeUUDozUFKdUKg3+I+n1i9RyWm2EwHznuG4OCaT4DNRANp+KN/0PqqCXUbvik4HP6cX1/r8OUyvPBq4Kf8CER4o6ilzS5DHpmijYRTeOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VRcqZyd/7HeGBi6IpU6sm+eEXMpCe9WOGSgi5zd5Us=;
 b=D9WNb4+8P/IVxi8F7Pfkz1DBpd5ykg2QD+0Wwnls/d2lcYKQ+TkoaHFkPH8BTTTQRcuVqKmh42tcKEAVbUMEn71w/V99bXNYSAKnFNrtIVkEeqnjOITll1+Vpef6aFE1orTLyo9tN3clTpWt35ytZoSz/dGEetbSyMdf8fdFWLE=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3183.eurprd04.prod.outlook.com (10.170.229.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Fri, 11 Oct 2019 12:47:27 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::8c20:60f:5a1c:42ef]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::8c20:60f:5a1c:42ef%3]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 12:47:27 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Joel Colledge <joel.colledge@linbit.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
CC:     Kieran Bingham <kbingham@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER is
 set
Thread-Topic: [PATCH v2] scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER
 is set
Thread-Index: AQHVgC7oaoKGJTwDR023SeD0lnQ+JA==
Date:   Fri, 11 Oct 2019 12:47:26 +0000
Message-ID: <VI1PR04MB70239DA9EED5F689645071E9EE970@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <VI1PR04MB70236211F170522DD456553AEE940@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <20191011122409.23868-1-joel.colledge@linbit.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9a37a02-6936-43bc-3e44-08d74e492bd7
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB3183:
x-microsoft-antispam-prvs: <VI1PR04MB3183A4DF52EB28317F4AEDEDEE970@VI1PR04MB3183.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(54094003)(51914003)(189003)(199004)(2906002)(71190400001)(7736002)(86362001)(256004)(3846002)(6116002)(66066001)(305945005)(14444005)(74316002)(5660300002)(71200400001)(4326008)(8936002)(52536014)(81166006)(81156014)(229853002)(6246003)(476003)(486006)(54906003)(446003)(44832011)(99286004)(110136005)(186003)(33656002)(76116006)(316002)(66476007)(26005)(102836004)(25786009)(8676002)(7696005)(6436002)(64756008)(66556008)(66446008)(91956017)(55016002)(14454004)(9686003)(66946007)(76176011)(53546011)(6506007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3183;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OHHhqjsW1wy370477EFgPTLhA8SJ9U6IC561d3B3LTFdV0TGdgc5lLt+1RCYNqCcexuMjb2up69rQ6wt4IeWXCg3qxfaTneui+Q3cVAAr0e0pVfsBlwQjA+tecRpEZA4P2113YYQp6IF3lkTABKVHWwkkYA1N0hRRy6X27FLEs7OVXI63eS3lvG/X/Xo4g2d3CxL/B64ztBXebTUCz9k/q3qDXCKoyrIUK7qr3VEVW8Db0B+qTSqoHgGs4T4Ewl49mLR1MRdgtOV+cQPcHC7FqrA/85v3paYsA3Y4LB7SgfNzme0p+kE0EbVtvtDgHtEYg7PYKPOOFq55KwgtEg1m3lZG0QpV5j64xch1W+Pyj7Pjj8HAzap+Lr/Os2nM006Qwm45pBJ1XzOmpAwXL+vWVEmVWEDW/DCnKZlmtBcaWA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a37a02-6936-43bc-3e44-08d74e492bd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 12:47:26.9678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TGSbM57Ge26Vm/qNxGU4eH7ZhPdtcouEh5YQlxN58VL3FQh4s3RCRq9w6KH/DOWzcsgeG/iIkgPkq7fHvr8qDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2019 15:25, Joel Colledge wrote:=0A=
> When CONFIG_PRINTK_CALLER is set, struct printk_log contains an=0A=
> additional member caller_id. This affects the offset of the log text.=0A=
> Account for this by using the type information from gdb to determine all=
=0A=
> the offsets instead of using hardcoded values.=0A=
> =0A=
> This fixes following error:=0A=
> =0A=
>    (gdb) lx-dmesg=0A=
>    Python Exception <class 'ValueError'> embedded null character:=0A=
>    Error occurred in Python command: embedded null character=0A=
> =0A=
> Signed-off-by: Joel Colledge <joel.colledge@linbit.com>=0A=
> ---=0A=
> Changes in v2:=0A=
> - use type information from gdb instead of hardcoded offsets=0A=
> =0A=
> Thanks for the idea about using the struct layout info from gdb, Leonard.=
 I can't see any reason we shouldn't use that here, since most of the other=
 commands use it. LxDmesg has used hardcoded offsets since scripts/gdb was =
introduced, so I assume it just ended up like that during the initial devel=
opment of the tool. Here is a version of the fix using offsets from gdb.=0A=
=0A=
This struct printk_log is quite small, I wonder if it's possible to do a =
=0A=
single read for each log entry? This might make lx-dmesg faster because =0A=
of fewer roundtrips to gdbserver and jtag (or whatever backend you're =0A=
using).=0A=
=0A=
> =0A=
>   scripts/gdb/linux/dmesg.py | 16 ++++++++++++----=0A=
>   1 file changed, 12 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/scripts/gdb/linux/dmesg.py b/scripts/gdb/linux/dmesg.py=0A=
> index 6d2e09a2ad2f..8f5d899029b7 100644=0A=
> --- a/scripts/gdb/linux/dmesg.py=0A=
> +++ b/scripts/gdb/linux/dmesg.py=0A=
> @@ -16,6 +16,8 @@ import sys=0A=
>   =0A=
>   from linux import utils=0A=
>   =0A=
> +printk_log_type =3D utils.CachedType("struct printk_log")=0A=
> +=0A=
>   =0A=
>   class LxDmesg(gdb.Command):=0A=
>       """Print Linux kernel log buffer."""=0A=
> @@ -42,9 +44,14 @@ class LxDmesg(gdb.Command):=0A=
>               b =3D utils.read_memoryview(inf, log_buf_addr, log_next_idx=
)=0A=
>               log_buf =3D a.tobytes() + b.tobytes()=0A=
>   =0A=
> +        length_offset =3D printk_log_type.get_type()['len'].bitpos // 8=
=0A=
> +        text_len_offset =3D printk_log_type.get_type()['text_len'].bitpo=
s // 8=0A=
> +        time_stamp_offset =3D printk_log_type.get_type()['ts_nsec'].bitp=
os // 8=0A=
> +        text_offset =3D printk_log_type.get_type().sizeof=0A=
> +=0A=
>           pos =3D 0=0A=
>           while pos < log_buf.__len__():=0A=
> -            length =3D utils.read_u16(log_buf[pos + 8:pos + 10])=0A=
> +            length =3D utils.read_u16(log_buf[pos + length_offset:pos + =
length_offset + 2])=0A=
>               if length =3D=3D 0:=0A=
>                   if log_buf_2nd_half =3D=3D -1:=0A=
>                       gdb.write("Corrupted log buffer!\n")=0A=
> @@ -52,10 +59,11 @@ class LxDmesg(gdb.Command):=0A=
>                   pos =3D log_buf_2nd_half=0A=
>                   continue=0A=
>   =0A=
> -            text_len =3D utils.read_u16(log_buf[pos + 10:pos + 12])=0A=
> -            text =3D log_buf[pos + 16:pos + 16 + text_len].decode(=0A=
> +            text_len =3D utils.read_u16(log_buf[pos + text_len_offset:po=
s + text_len_offset + 2])=0A=
> +            text =3D log_buf[pos + text_offset:pos + text_offset + text_=
len].decode(=0A=
>                   encoding=3D'utf8', errors=3D'replace')=0A=
> -            time_stamp =3D utils.read_u64(log_buf[pos:pos + 8])=0A=
> +            time_stamp =3D utils.read_u64(=0A=
> +                log_buf[pos + time_stamp_offset:pos + time_stamp_offset =
+ 8])=0A=
>   =0A=
>               for line in text.splitlines():=0A=
>                   msg =3D u"[{time:12.6f}] {line}\n".format(=0A=
> =0A=
=0A=
