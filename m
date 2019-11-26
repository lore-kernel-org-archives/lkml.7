Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA7AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C077720656
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iKhW4vKa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vM5cQ7Zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfKZGUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 01:20:34 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45633 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfKZGUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 01:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574749233; x=1606285233;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rw0c8MR2zm+zV2ZpZJVw9YXj3Jt5iLsfZeLO4udaQEk=;
  b=iKhW4vKa3WDUmRnM4ENAHKWmKcz1wMuCzsOAM3zo7u8/bORrh2GclqKU
   HYjAVWRllO+murcdWF1SGedxXA1nECjJXHIItXrrXXMv316snsF/CCrvA
   QY7oTADQIcgVM/Lsb60DAekcBOOXt/GtCcqWrqsDzj4C2F+jysgGlFpsW
   wlA/X2ZMPamXulI/Sqy+6UlBJTVHPZal1k1vLw/xxRVt68+5xvfj4rJZ7
   iXLtzghfu9uKdejHe7TZS8Q4XYyNvkBKOmxPc4OwKfSb8BX5AoVZGCoFl
   cGkAjDHJ4FE0ruFwtDEC3AW6sZx/Kk6MWc58BK5bQcK/BtwkXfi7LKo2l
   w==;
IronPort-SDR: JLPrOr0w3sDmRjHVNeAw9HbpJOw8Z0fCtaVwf+3ils2GBcvVuiqcLan5LwzIFlOOcIpuskUSq1
 Ab7lacOx5oIu+okQ/p7yWecygMxNdsufUFTx9gBg8LMsv5olNXlTa7eBkv2lw/zTOh5yRiDlLm
 jZejvt8Zfp3b+hRjntyOSWtcO/KeGkcSLwZICSKMDn2VuDAy2FcSsstee0fzeqcfJvOStiKEHJ
 QwyJAz6qnj+VeqyhjokOoG/72xLAhRbwVPa/fGk1VlhRP5BHPLHQF35dVX2yOzduRwtAhfl3JF
 OVI=
X-IronPort-AV: E=Sophos;i="5.69,244,1571673600"; 
   d="scan'208";a="125619595"
Received: from mail-co1nam03lp2051.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.51])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2019 14:20:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpjRY0FhR7WB1NK+permKTEnFZAKLBYRhp1PHAtdqXfO3oGGDajjuFzG2OkceVGbDbJyYBdjIw6RPaY56XpL/hZ/BJSBBk8qd8qHNxn2jtUqKsHHHTPPbP0VgAGMjxT21/PJzpX0yTp+yD0QI/m+fyTcwPCpYwQKGNivDROSlmvYN2dmYT6p2S3EDa3vhcKzJA7AZBHOeMnVWe6as6J0rCSvZzbfIt+geUfMQpDPFhbFmsJicl+qhwf8ePgbs0RU3HRAqmbe3zy/p1UWU5c2olQh9xAyKFXRjNyyeTS9Hffoe3CrhnDdT9tp/xPNJc4OhiyYB3qO6eE3JVFEN4T/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWufAtH5f8x/BD+L+zyEpuDTJHcRRtbC/XmD5DiSmi0=;
 b=DhvPilrMxgh18rlxdanP6KARJap/kFX1/+XqAUryetaifmzYDo40D+BfFwdl2tLgd0+XZoHo1H5Cuodbm0oOHaiJurrwETrL0gmlQMh4B23jPZcChFLaWkPwe4sTeIemZyN/FaRQUkXkUsRj5EYUkzKWgyh9sI4ZYWffDF5lGTROx+oKghEpg3o8JKq9vziXZfWbqYupVfm/2R4iutItwWtTK/dltTiGnrnaffLQmfIC2O7J48166Ex6N1XsRZSFwKxcfQG9tIkhxkSqZDz1o917mBWApgjul3Zuuj0tJXxqPMOrs9hw7DcYaY8KFQWdyOZNmFVqy6mV/nEBW+BRzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWufAtH5f8x/BD+L+zyEpuDTJHcRRtbC/XmD5DiSmi0=;
 b=vM5cQ7Zko6XXfo6Jab02UZnR8SM8IRZVhYdyetyMYKb2Zg2QKXK3k3TZeMt+yVxS6+Y5LbHax9mBRb6UzFpRyZKaxsx4d6KqcvD0h2+mQruBJ0MqsW4fYxfndyEnXmsDb36RgBPfGe6eZgA4eNYd5eDa5mmt23QMCrKMyULQBh4=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4629.namprd04.prod.outlook.com (52.135.240.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Tue, 26 Nov 2019 06:20:30 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 06:20:30 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] f2fs: disble physical prealloc in LSF mount
Thread-Topic: [PATCH] f2fs: disble physical prealloc in LSF mount
Thread-Index: AQHVoRNC1jbxwLDWckincxKmSLcqwA==
Date:   Tue, 26 Nov 2019 06:20:30 +0000
Message-ID: <BYAPR04MB5816F0BB42891E49C5AB42DDE7450@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191122085952.12754-1-javier@javigon.com>
 <BYAPR04MB58166AE029D919C6610D8404E74A0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20191125190320.g7beal27nc5ubju7@mpHalley>
 <BYAPR04MB58161C14246FA30366B69B9DE7450@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20191126035726.xj7pierxsck6adow@mpHalley>
 <BYAPR04MB581676157DCF909EDF1AAAFCE7450@BYAPR04MB5816.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 140074a5-3535-4a9e-6e13-08d77238bcc5
x-ms-traffictypediagnostic: BYAPR04MB4629:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB462978796DFC6CC81E7A1DD3E7450@BYAPR04MB4629.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(51444003)(199004)(189003)(4326008)(305945005)(55016002)(6116002)(3846002)(6916009)(76176011)(102836004)(229853002)(316002)(7696005)(6506007)(86362001)(33656002)(478600001)(2906002)(99286004)(74316002)(66066001)(66946007)(66476007)(66556008)(64756008)(91956017)(76116006)(52536014)(53546011)(54906003)(66574012)(14454004)(446003)(14444005)(6246003)(6436002)(5660300002)(8936002)(186003)(8676002)(66446008)(81166006)(9686003)(25786009)(71190400001)(71200400001)(256004)(81156014)(7736002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4629;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QbiQYG506hx3FA5hCSLHFWWQxRDvMMPDeYyE2LhAGcK4IUNqykPfQmqi0Bbpxzz5Rhuvix58zoG/BI0TqHhUBgobJJugjKPECo8+szp1QEJpHUyi5Gkk/SWwUsR9xOcy1xa2m45hHoEnM33mLNFim9ZN9bs+XU7nNzDfUkcb9O2bGedv5Lfes2s7FVxa+3PLZ1BqlhTp9oAWG9YjqiSMZYNoAVFW5csNOj0XP7ejEJWiKwnKc4W9b1c8CblnYBG4/0ajUtBNRhdNjByYHM0OQGbX5+vzCQRYshmml9zwhtfjzN0XuDDHwyDJIqKWkit9yVvYcM8r403jDC9rzXj/UBa//LNs/02LGS+XWw5/EqEqNXBkzN+Ev/otsPJ9h+PmgbARp8BafPSrUdnWkzd6P8qvPNIlGFK2e4RPTMVvNVZQJP1rDLbJYgh2SijXI8W8
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140074a5-3535-4a9e-6e13-08d77238bcc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 06:20:30.4636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SylEVGrexVPdMqOKZVt7bU5qgD4AOubzFOy4P26ygoauIYQ0lKqtaZ1nR3zKHaSZkZWzv8VV1T1UH/efoGXlEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Shin'Ichiro=0A=
=0A=
On 2019/11/26 15:19, Damien Le Moal wrote:=0A=
> On 2019/11/26 12:58, Javier Gonz=E1lez wrote:=0A=
>> On 26.11.2019 02:06, Damien Le Moal wrote:=0A=
>>> On 2019/11/26 4:03, Javier Gonz=E1lez wrote:=0A=
>>>> On 25.11.2019 00:48, Damien Le Moal wrote:=0A=
>>>>> On 2019/11/22 18:00, Javier Gonz=E1lez wrote:=0A=
>>>>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>>>>=0A=
>>>>>> Fix file system corruption when using LFS mount (e.g., in zoned=0A=
>>>>>> devices). Seems like the fallback into buffered I/O creates an=0A=
>>>>>> inconsistency if the application is assuming both read and write DIO=
. I=0A=
>>>>>> can easily reproduce a corruption with a simple RocksDB test.=0A=
>>>>>>=0A=
>>>>>> Might be that the f2fs_forced_buffered_io path brings some problems =
too,=0A=
>>>>>> but I have not seen other failures besides this one.=0A=
>>>>>>=0A=
>>>>>> Problem reproducible without a zoned block device, simply by forcing=
=0A=
>>>>>> LFS mount:=0A=
>>>>>>=0A=
>>>>>>   $ sudo mkfs.f2fs -f -m /dev/nvme0n1=0A=
>>>>>>   $ sudo mount /dev/nvme0n1 /mnt/f2fs=0A=
>>>>>>   $ sudo  /opt/rocksdb/db_bench  --benchmarks=3Dfillseq --use_existi=
ng_db=3D0=0A=
>>>>>>   --use_direct_reads=3Dtrue --use_direct_io_for_flush_and_compaction=
=3Dtrue=0A=
>>>>>>   --db=3D/mnt/f2fs --num=3D5000 --value_size=3D1048576 --verify_chec=
ksum=3D1=0A=
>>>>>>   --block_size=3D65536=0A=
>>>>>>=0A=
>>>>>> Note that the options that cause the problem are:=0A=
>>>>>>   --use_direct_reads=3Dtrue --use_direct_io_for_flush_and_compaction=
=3Dtrue=0A=
>>>>>>=0A=
>>>>>> Fixes: f9d6d0597698 ("f2fs: fix out-place-update DIO write")=0A=
>>>>>>=0A=
>>>>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>>>> ---=0A=
>>>>>>  fs/f2fs/data.c | 3 ---=0A=
>>>>>>  1 file changed, 3 deletions(-)=0A=
>>>>>>=0A=
>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c=0A=
>>>>>> index 5755e897a5f0..b045dd6ab632 100644=0A=
>>>>>> --- a/fs/f2fs/data.c=0A=
>>>>>> +++ b/fs/f2fs/data.c=0A=
>>>>>> @@ -1081,9 +1081,6 @@ int f2fs_preallocate_blocks(struct kiocb *iocb=
, struct iov_iter *from)=0A=
>>>>>>  			return err;=0A=
>>>>>>  	}=0A=
>>>>>>=0A=
>>>>>> -	if (direct_io && allow_outplace_dio(inode, iocb, from))=0A=
>>>>>> -		return 0;=0A=
>>>>>=0A=
>>>>> Since for LFS mode, all DIOs can end up out of place, I think that it=
=0A=
>>>>> may be better to change allow_outplace_dio() to always return true in=
=0A=
>>>>> the case of LFS mode. So may be something like:=0A=
>>>>>=0A=
>>>>> static inline int allow_outplace_dio(struct inode *inode,=0A=
>>>>> 			struct kiocb *iocb, struct iov_iter *iter)=0A=
>>>>> {=0A=
>>>>> 	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);=0A=
>>>>> 	int rw =3D iov_iter_rw(iter);=0A=
>>>>>=0A=
>>>>> 	return test_opt(sbi, LFS) ||=0A=
>>>>> 	 	(rw =3D=3D WRITE && !block_unaligned_IO(inode, iocb, iter));=0A=
>>>>> }=0A=
>>>>>=0A=
>>>>> instead of the original:=0A=
>>>>>=0A=
>>>>> static inline int allow_outplace_dio(struct inode *inode,=0A=
>>>>> 			struct kiocb *iocb, struct iov_iter *iter)=0A=
>>>>> {=0A=
>>>>> 	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);=0A=
>>>>> 	int rw =3D iov_iter_rw(iter);=0A=
>>>>>=0A=
>>>>> 	return (test_opt(sbi, LFS) && (rw =3D=3D WRITE) &&=0A=
>>>>> 				!block_unaligned_IO(inode, iocb, iter));=0A=
>>>>> }=0A=
>>>>>=0A=
>>>>> Thoughts ?=0A=
>>>>>=0A=
>>>>=0A=
>>>> I see what you mean and it makes sense. However, the problem I am seei=
ng=0A=
>>>> occurs when allow_outplace_dio() returns true, as this is what creates=
=0A=
>>>> the inconsistency between the write being buffered and the read being=
=0A=
>>>> DIO.=0A=
>>>=0A=
>>> But if the write is switched to buffered, the DIO read should use the=
=0A=
>>> buffered path too, no ? Since this is all happening under VFS, the=0A=
>>> generic DIO read path will not ensure that the buffered writes are=0A=
>>> flushed to disk before issuing the direct read, I think. So that would=
=0A=
>>> explain your data corruption, i.e. you are reading stale data on the=0A=
>>> device before the buffered writes make it to the media.=0A=
>>>=0A=
>>=0A=
>> As far as I can see, the read is always sent DIO, so yes, I also believe=
=0A=
>> that we are reading stale data. This is why the corruption is not seen=
=0A=
>> if preventing allow_outplace_dio() from sending the write to the=0A=
>> buffered path.=0A=
>>=0A=
>> What surprises me is that this is very easy to trigger (see commit), so=
=0A=
>> I assume you must have seen this with SMR in the past.=0A=
> =0A=
> We just did. Shin'Ichiro in my team finally succeeded in recreating the=
=0A=
> problem. The cause seems to be:=0A=
> =0A=
> bool direct_io =3D iocb->ki_flags & IOCB_DIRECT;=0A=
> =0A=
> being true on entry of f2fs_preallocate_blocks() whereas=0A=
> f2fs_direct_IO() forces buffered IO path for DIO on zoned devices with:=
=0A=
> =0A=
> if (f2fs_force_buffered_io(inode, iocb, iter))=0A=
> 		return 0;=0A=
> =0A=
> which has:=0A=
> =0A=
> 	if (f2fs_sb_has_blkzoned(sbi))=0A=
> 		return true;=0A=
> =0A=
> So the top DIO code says "do buffered IOs", but lower in the write path,=
=0A=
> the IO is still assumed to be a DIO because of the iocb flag... That's=0A=
> inconsistent.=0A=
> =0A=
> Note that for the non-zoned device LFS case, f2fs_force_buffered_io()=0A=
> returns true only for unaligned write DIOs... But that will still trip=0A=
> on the iocb flag test. So the proper fix is likely something like:=0A=
> =0A=
> int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)=0A=
> {=0A=
> 	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
> 	struct f2fs_map_blocks map;=0A=
> 	int flag;=0A=
> 	int err =3D 0;=0A=
> -	bool direct_io =3D iocb->ki_flags & IOCB_DIRECT;=0A=
> +	bool direct_io =3D (iocb->ki_flags & IOCB_DIRECT) &&=0A=
> +		!2fs_force_buffered_io(inode, iocb, iter);=0A=
> =0A=
> 	/* convert inline data for Direct I/O*/=0A=
> 	if (direct_io) {=0A=
> 		err =3D f2fs_convert_inline_inode(inode);=0A=
> 		if (err)=0A=
> 			return err;=0A=
> 	}=0A=
> =0A=
> Shin'Ichiro tried this on SMR disks and the failure is gone...=0A=
> =0A=
> Cheers.=0A=
> =0A=
> =0A=
>>=0A=
>> Does it make sense to leave the LFS check out of the=0A=
>> allow_outplace_dio()? Or in other words, is there a hard requirement for=
=0A=
>> writes to take this path on a zoned device that I am not seeing?=0A=
>> Something like:=0A=
>>=0A=
>>    static inline int allow_outplace_dio(struct inode *inode,=0A=
>>    			struct kiocb *iocb, struct iov_iter *iter)=0A=
>>    {=0A=
>>    	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);=0A=
>>    	int rw =3D iov_iter_rw(iter);=0A=
>>=0A=
>>    	return (rw =3D=3D WRITE && !block_unaligned_IO(inode, iocb, iter));=
=0A=
>>    }=0A=
>>=0A=
>> Thanks,=0A=
>> Javier=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
