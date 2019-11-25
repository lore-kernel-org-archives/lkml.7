Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68201C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 00:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1D620748
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 00:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XrxAy3rB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XhknSrih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfKYAsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 19:48:41 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50075 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfKYAsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574642920; x=1606178920;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dvrZhUIjNa95JQO78KyHXMK/k5LaZqzx9O1FuOeNXk4=;
  b=XrxAy3rBWEnjBHrtM/vv/xZJpQeEvcbzgioOnypvfhTK70Cmbw7uYwcB
   rZRcNzhsIUKVJs+WS/0qrNgR5Fs4NW3Yrz5ehmRsmJzUuBQOK0dRjbEcz
   m5UjOafwI8o3GJZVbMzeFjxzSeW/ykjmRufXJfVtmj+68bnoMBFDS0GXM
   ovU1LuTn+opGULHE5neOvF9isXtuMs/1lRKJeguchP9f6o25kVTqzLSm6
   ENBnLbgdUZa41kjOSLgH9XDY5II4UbnLkXjAUYQwM1P5Fzi2ZgApGHoHa
   7S+oE0OCyBAraNDxxGG+rS/vK7LRUrMSgzAWAS4OOAbzXSVpkmIV/JARa
   w==;
IronPort-SDR: Rg4ifiyeJd9+f7d6hx8/aP6CSUlQWArKV0QD3UtCF5TZWBjVFVx8B1q41bhNCDBFs2LnIQ6wPg
 sxOqIt5xswkGs3D3+TsAjvKcjotFseQQR+nqSKXrsuZBM2/5bhrNAlMEGT1KKbLPdP9g4Fz8oU
 LRtB8rq80sH+RNPEZ5RA42D7qqlcGJWKj8a9zk7mnRiDn9NQX2Os1sJ5/CJLxcFwSoo75LUCup
 LNBLZtCxIGQzsR4+AzCdcJ1/ozRNvvToJAedrIx86/UyvAu7K6XPvcITepScYLLNP7gJfEHyuI
 swg=
X-IronPort-AV: E=Sophos;i="5.69,239,1571673600"; 
   d="scan'208";a="231320232"
Received: from mail-sn1nam01lp2053.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.53])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2019 08:48:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liQnAhMHtdFdbjtC8cK7QcDxoS7OMrcjMrjnyd1h5Jd+WX4FKL7oDZXlRKZhktmPb55nhMg/HZmTBUzxwtha6tDmdDz48mvPZF7GacEk5yzbhLBKnBv27pp+gnPmVMl3p5ROsYwfSN9KHz8yeeVMAjJBqi+wLL3TUHjRy0tXM5Yo0/swdVMMLYGsKYpecETkbf94/ALF7f3rR0I21C4S1FrCCVg1odfkB++fDEJHdjYURZdgJyvALr9a/Tm/V7lsRZ201g7sOK8WY7hXI8yrodXZ9qFdVfmaPNgzV76P0JXMQsZedIpz9Pro4EciH79s+XtDSOU9Nsf8uA1WjrXI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3FZfYypXdNKHBsGAoqlm4dpGBrbuEm4Od2guUDX4JE=;
 b=SYX8w+U6VRi3CICpfk+5p3pcmr4ebtk4Ut7oA9W58X7qnu2IBhGCHaA6RzpaZuPn2VFXhm2WtY5hoFLZOWPh1SzTvnbyL96vpvZgPWzWdTI5EHznQt8txXtWdSfYAG0IAjPFGTeYeY1P+6H1YNeKHez3bLRk0lmS/0s+wGrMoV1iY2kXqoThydGAY85wbHNN+tB0opzOpcXpUUYaKBuA7nNz41fZKwnjNskx7PlRhmJSd1I18LLzB6VyHPCJSBqw0AEbBKm03q/nl0cYMYV6d5zVd7NqpVZPD/WmLy+qaSzk8qNlFiCCPmldytzbfzh+xv/DLtzILeyJTzjcm1b98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3FZfYypXdNKHBsGAoqlm4dpGBrbuEm4Od2guUDX4JE=;
 b=XhknSrihA95xR8RK7tvKQ5/tqebRS1E9M6HafrjF4aaKVjqPW+E4/I/Q+q+acRqev6EkOR9eoQIkLTsm3040wSJ7uxFX5UCgwAbDoAOAHEr6G4ZXSnLKJ8EvD6nh2QlJlfIsqNP7dtPBtVYW/9EeTHaqzcPYTxT28UbRigc7zXc=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4182.namprd04.prod.outlook.com (20.176.250.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Mon, 25 Nov 2019 00:48:38 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 00:48:38 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>
CC:     "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH] f2fs: disble physical prealloc in LSF mount
Thread-Topic: [PATCH] f2fs: disble physical prealloc in LSF mount
Thread-Index: AQHVoRNC1jbxwLDWckincxKmSLcqwA==
Date:   Mon, 25 Nov 2019 00:48:37 +0000
Message-ID: <BYAPR04MB58166AE029D919C6610D8404E74A0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191122085952.12754-1-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44aa8961-3a55-4780-b902-08d771413592
x-ms-traffictypediagnostic: BYAPR04MB4182:
x-microsoft-antispam-prvs: <BYAPR04MB418232309E8AF7A30ED2BA3BE74A0@BYAPR04MB4182.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(199004)(189003)(51444003)(8936002)(81166006)(81156014)(8676002)(52536014)(5660300002)(66574012)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(91956017)(305945005)(74316002)(7736002)(99286004)(2906002)(110136005)(316002)(66066001)(6116002)(3846002)(25786009)(446003)(102836004)(76176011)(7696005)(6246003)(71190400001)(71200400001)(9686003)(54906003)(55016002)(6436002)(229853002)(2201001)(86362001)(2501003)(14454004)(186003)(26005)(6506007)(53546011)(33656002)(4326008)(478600001)(256004)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4182;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dfHbA8sdLSYDiKQsKZYWXQMh0cSe9V8aSVXcfQDfIUk3VBIcgQ6P9Y9x8Zyi76E7CsTIdk9OgewlmPiKK+EUE5ETY3Xrj06v/PObHuaI5JBlnf4K13KKqSJcB2XzQ7WZXHUWbQQSvg8ZOoRUuI6IGqb3Zc8VA7XRP3aKqCDiFdGg/kmDPqECTbg1HC0QnUiTLAY3Is3ms1R4NidjBcO+baqaXHEB9nq19NpQizqnEMgwY0SDqzbO7wESGYNg4jpF4NQetO4DKWbOhJ8wAbJNaDrwZEs26/vSVpItz15Nam64E/HRpTPdm+1eyAk42QC0hYFCPATiDe/9mJDhMjAotmwmkAYFwOXGRtcXKHx4wdW+PhFV7zxSR42X6vb22vLHgLV5ZXQaaz3qO9xecEn1Q8+2pHe6jUTHJMzm1m2/G42W67dnyXV7rKgnsHl7M+qv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44aa8961-3a55-4780-b902-08d771413592
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 00:48:37.7897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Do9BI5q2xGmaeTapLAo0uw2X8QJSJ+q1r9zLCUzK2GrFKgL++n524A8gZsY0dT5dHu8quGCotl2LsJoLEmCNBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/22 18:00, Javier Gonz=E1lez wrote:=0A=
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> =0A=
> Fix file system corruption when using LFS mount (e.g., in zoned=0A=
> devices). Seems like the fallback into buffered I/O creates an=0A=
> inconsistency if the application is assuming both read and write DIO. I=
=0A=
> can easily reproduce a corruption with a simple RocksDB test.=0A=
> =0A=
> Might be that the f2fs_forced_buffered_io path brings some problems too,=
=0A=
> but I have not seen other failures besides this one.=0A=
> =0A=
> Problem reproducible without a zoned block device, simply by forcing=0A=
> LFS mount:=0A=
> =0A=
>   $ sudo mkfs.f2fs -f -m /dev/nvme0n1=0A=
>   $ sudo mount /dev/nvme0n1 /mnt/f2fs=0A=
>   $ sudo  /opt/rocksdb/db_bench  --benchmarks=3Dfillseq --use_existing_db=
=3D0=0A=
>   --use_direct_reads=3Dtrue --use_direct_io_for_flush_and_compaction=3Dtr=
ue=0A=
>   --db=3D/mnt/f2fs --num=3D5000 --value_size=3D1048576 --verify_checksum=
=3D1=0A=
>   --block_size=3D65536=0A=
> =0A=
> Note that the options that cause the problem are:=0A=
>   --use_direct_reads=3Dtrue --use_direct_io_for_flush_and_compaction=3Dtr=
ue=0A=
> =0A=
> Fixes: f9d6d0597698 ("f2fs: fix out-place-update DIO write")=0A=
> =0A=
> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> ---=0A=
>  fs/f2fs/data.c | 3 ---=0A=
>  1 file changed, 3 deletions(-)=0A=
> =0A=
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c=0A=
> index 5755e897a5f0..b045dd6ab632 100644=0A=
> --- a/fs/f2fs/data.c=0A=
> +++ b/fs/f2fs/data.c=0A=
> @@ -1081,9 +1081,6 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, str=
uct iov_iter *from)=0A=
>  			return err;=0A=
>  	}=0A=
>  =0A=
> -	if (direct_io && allow_outplace_dio(inode, iocb, from))=0A=
> -		return 0;=0A=
=0A=
Since for LFS mode, all DIOs can end up out of place, I think that it=0A=
may be better to change allow_outplace_dio() to always return true in=0A=
the case of LFS mode. So may be something like:=0A=
=0A=
static inline int allow_outplace_dio(struct inode *inode,=0A=
			struct kiocb *iocb, struct iov_iter *iter)=0A=
{=0A=
	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);=0A=
	int rw =3D iov_iter_rw(iter);=0A=
=0A=
	return test_opt(sbi, LFS) ||=0A=
	 	(rw =3D=3D WRITE && !block_unaligned_IO(inode, iocb, iter));=0A=
}=0A=
=0A=
instead of the original:=0A=
=0A=
static inline int allow_outplace_dio(struct inode *inode,=0A=
			struct kiocb *iocb, struct iov_iter *iter)=0A=
{=0A=
	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);=0A=
	int rw =3D iov_iter_rw(iter);=0A=
=0A=
	return (test_opt(sbi, LFS) && (rw =3D=3D WRITE) &&=0A=
				!block_unaligned_IO(inode, iocb, iter));=0A=
}=0A=
=0A=
Thoughts ?=0A=
=0A=
> -=0A=
>  	if (is_inode_flag_set(inode, FI_NO_PREALLOC))=0A=
>  		return 0;=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
