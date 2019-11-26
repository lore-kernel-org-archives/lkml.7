Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95107C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 02:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C612075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 02:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fm6nTPHN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HIHkrn3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfKZCG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 21:06:56 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19784 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfKZCGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 21:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574734015; x=1606270015;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/cFIM2LzUhBibSMlFJQ/oOIGcDJC+GWwtRaHQElceT0=;
  b=Fm6nTPHNaUv9OfWMFWSnkq9yNNg3sBLc3UKUyBDiA1CLWtDw1NfTXEHq
   S0OS6d4DDzRn7bV3/V+9bLczPMYDuss1lO5S1iED6A6sP8L/22rOnQ9xR
   PF7YfrSpk3rlFQHTaI2jx77II2SDsEOMXAqC2QyjaqZGy4bWw6LhU8YbY
   xKqo+adhGcScHrofpT4CvRfdD8QWdckYX5qnpw/Y8fAMBlmHtThk+aRsQ
   X3YrzAWei/BLkA1UZ/E8A4DFoWdNIT/+HR5btCOH2YFAFxnOpxx9JUEAr
   2MjZHaP/MaOBHoLPsNeywPcR1l2MGE/u6DFIOwSJumRoYvQUMC39JZpjN
   w==;
IronPort-SDR: Y8RIdcTS8gvI2m/EC1mBkQ6jJTkv+Za/LTTyhnwjXNBcZ/jvZ8fWO/xeClb45LCqpoi0Mfk+2+
 Dc2ghQ6T3J+xlW7O0XES8BwuoJkVNIV0d3OMXOFD8lmSX3e9PYEs2aOnLXnr8p/MKfqFy4BZJT
 ZFSEWtJYW1W3Orysyrjw/U9rb66IoFANWUd9Y/CCjKQ7yoZ6r+4+CqspYgoz416Q7TVyd37uwn
 vqrRDbZuh4xnQoKhQ5EFXa1i1ChmgRzsZtW+Hwc8rAx/uVIBAwjU04zY+eRG1tMbTJP/ip6EAh
 9gs=
X-IronPort-AV: E=Sophos;i="5.69,243,1571673600"; 
   d="scan'208";a="123985609"
Received: from mail-sn1nam02lp2052.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.52])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2019 10:06:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBMh7nlQK1Cp8KLtRIMhfUrmm/S2p+MvjxCSXGRBBlMvEAHkbYrkmKkqdgQYLdvm9hTblQCHaSgI0Md6CWORaKTrEP2JPgbFjE14bf65ri7vSs02x/hcEZufQ2OzOIBhq8IpXT3TfoAsG5o+2Fc2M0JtVbGwC5jGs5Y2e3hBtqVg6kiQgTzvnjwrtml/DXzOlfQfROmJYdDTyBZVn3+bsJcpVG0nN+sgE301LoVV5s7k61ouyMST4qFM/qlYSy/b2UKNYh8gNFrBfKMuXandvrtxTF8R0Y3aCIwJOw7UmJP7SEBjd7cTIBtbSApm3iu/jYcU1FeBLpHajJnT4Sm3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrsrwSglufURVR32hyfrmCpa82OMh6icqLJdQKJxrzU=;
 b=QdifWR+Ga+PjvM3vt/jgU60u8RVAsA2mMFxBB4/w1bgVQxurt2kfbmKjqhni+ntj35z2T4q1bhaIV1zegbVGeqkDYPXvVs7xF86AqTEqPhYX5I6SSB6OHtG2IDrg6PyvaxhyVN7cpgI7zvVIacEu7/ZKWCBJrbsAlpwlsk5OQiY5m05WKsC0oWPPLwhN79dOC5WlNLNMtoHTMn7rOY6eLvEmRErJKSTD3zEKjXEuo9S1XcMMwa2eldJyr+p7G/bZl9a46f6dZvPv0eZhjFjAFZzAHbbHMKdl1Ue1AEwOw5QhhNUGa9Nyogu5VtmLcgPIJChTfxATP7c4J9O+H9T35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrsrwSglufURVR32hyfrmCpa82OMh6icqLJdQKJxrzU=;
 b=HIHkrn3qKQxd/i9lo+3Cmii/okSYRwV4Ir+u+sBv2E1GvShcD3ukYZw2L2hNHblDhbsfMtb7UnVdG1hxf25cHJ/zMgRDoiqopoOqvATKdD/S9sD0QTgrYhv5PMOlKhYcAXEh8A4VjK0yqyOfpYu00HMPxuoByWSvGH8HFBmsD0A=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5608.namprd04.prod.outlook.com (20.179.56.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Tue, 26 Nov 2019 02:06:53 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 02:06:53 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH] f2fs: disble physical prealloc in LSF mount
Thread-Topic: [PATCH] f2fs: disble physical prealloc in LSF mount
Thread-Index: AQHVoRNC1jbxwLDWckincxKmSLcqwA==
Date:   Tue, 26 Nov 2019 02:06:53 +0000
Message-ID: <BYAPR04MB58161C14246FA30366B69B9DE7450@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191122085952.12754-1-javier@javigon.com>
 <BYAPR04MB58166AE029D919C6610D8404E74A0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20191125190320.g7beal27nc5ubju7@mpHalley>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18423625-5152-4a53-41b4-08d772154e7e
x-ms-traffictypediagnostic: BYAPR04MB5608:
x-microsoft-antispam-prvs: <BYAPR04MB56082F945DBFF1C4A284FAC4E7450@BYAPR04MB5608.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(51444003)(4326008)(14454004)(86362001)(74316002)(446003)(478600001)(186003)(76176011)(7696005)(6916009)(2906002)(6246003)(102836004)(25786009)(6506007)(26005)(53546011)(6116002)(3846002)(305945005)(66946007)(9686003)(6436002)(7736002)(316002)(66574012)(66066001)(91956017)(64756008)(66446008)(66476007)(76116006)(66556008)(52536014)(5660300002)(256004)(8676002)(71190400001)(71200400001)(14444005)(33656002)(229853002)(54906003)(55016002)(99286004)(8936002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5608;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MA7DkGZ/vdnFN5T2yj434ps2mWP6o7IZKa7eiiTdWywrEIP8PSpm0wTLzV2/Lw1s3iZwI8ZYCPwUXvSJJJr+RcWDU0hwBicrO+cpT0EnM8t1TVz/nUBWT8OrDyy1t+JbU421HK4YraxjEHCjdB2KGFjQM983VHzSdAVmXt2ORvTHQUpUKzyoi7cN2JqKDGXBWijPPb2KGUV0PSFju5TnIH1pBkrLZDUOgp8dvC3O0q5wxZ57NVxlehb4YwAhgVauAoyddPQucPmQ94iH0lVQmvmpltE9pw+Bck7jFcjMpxf45s0xNOSOBx1IFKzDu0+8TLV9zfb/RAvwdS8KI7Y52G5Qan/uKBbvIxD4k+jnCjp1+AVdB9fu+JyH2yoz1/NeuT7LBfe9B2NkQBt70OuTBmVWILfy7YyPExWGvhfMq12QxKASO3PRts2kukiCFlMC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18423625-5152-4a53-41b4-08d772154e7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 02:06:53.1502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nzSoaKo4uacd0QkF3EGT5ZShXauYlgj083OyRjZjXhKwIstqbTr5yGy3OE3RJrwTySTZu9BtytUpsFxKqLQBVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/26 4:03, Javier Gonz=E1lez wrote:=0A=
> On 25.11.2019 00:48, Damien Le Moal wrote:=0A=
>> On 2019/11/22 18:00, Javier Gonz=E1lez wrote:=0A=
>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>=0A=
>>> Fix file system corruption when using LFS mount (e.g., in zoned=0A=
>>> devices). Seems like the fallback into buffered I/O creates an=0A=
>>> inconsistency if the application is assuming both read and write DIO. I=
=0A=
>>> can easily reproduce a corruption with a simple RocksDB test.=0A=
>>>=0A=
>>> Might be that the f2fs_forced_buffered_io path brings some problems too=
,=0A=
>>> but I have not seen other failures besides this one.=0A=
>>>=0A=
>>> Problem reproducible without a zoned block device, simply by forcing=0A=
>>> LFS mount:=0A=
>>>=0A=
>>>   $ sudo mkfs.f2fs -f -m /dev/nvme0n1=0A=
>>>   $ sudo mount /dev/nvme0n1 /mnt/f2fs=0A=
>>>   $ sudo  /opt/rocksdb/db_bench  --benchmarks=3Dfillseq --use_existing_=
db=3D0=0A=
>>>   --use_direct_reads=3Dtrue --use_direct_io_for_flush_and_compaction=3D=
true=0A=
>>>   --db=3D/mnt/f2fs --num=3D5000 --value_size=3D1048576 --verify_checksu=
m=3D1=0A=
>>>   --block_size=3D65536=0A=
>>>=0A=
>>> Note that the options that cause the problem are:=0A=
>>>   --use_direct_reads=3Dtrue --use_direct_io_for_flush_and_compaction=3D=
true=0A=
>>>=0A=
>>> Fixes: f9d6d0597698 ("f2fs: fix out-place-update DIO write")=0A=
>>>=0A=
>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>> ---=0A=
>>>  fs/f2fs/data.c | 3 ---=0A=
>>>  1 file changed, 3 deletions(-)=0A=
>>>=0A=
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c=0A=
>>> index 5755e897a5f0..b045dd6ab632 100644=0A=
>>> --- a/fs/f2fs/data.c=0A=
>>> +++ b/fs/f2fs/data.c=0A=
>>> @@ -1081,9 +1081,6 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, s=
truct iov_iter *from)=0A=
>>>  			return err;=0A=
>>>  	}=0A=
>>>=0A=
>>> -	if (direct_io && allow_outplace_dio(inode, iocb, from))=0A=
>>> -		return 0;=0A=
>>=0A=
>> Since for LFS mode, all DIOs can end up out of place, I think that it=0A=
>> may be better to change allow_outplace_dio() to always return true in=0A=
>> the case of LFS mode. So may be something like:=0A=
>>=0A=
>> static inline int allow_outplace_dio(struct inode *inode,=0A=
>> 			struct kiocb *iocb, struct iov_iter *iter)=0A=
>> {=0A=
>> 	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);=0A=
>> 	int rw =3D iov_iter_rw(iter);=0A=
>>=0A=
>> 	return test_opt(sbi, LFS) ||=0A=
>> 	 	(rw =3D=3D WRITE && !block_unaligned_IO(inode, iocb, iter));=0A=
>> }=0A=
>>=0A=
>> instead of the original:=0A=
>>=0A=
>> static inline int allow_outplace_dio(struct inode *inode,=0A=
>> 			struct kiocb *iocb, struct iov_iter *iter)=0A=
>> {=0A=
>> 	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);=0A=
>> 	int rw =3D iov_iter_rw(iter);=0A=
>>=0A=
>> 	return (test_opt(sbi, LFS) && (rw =3D=3D WRITE) &&=0A=
>> 				!block_unaligned_IO(inode, iocb, iter));=0A=
>> }=0A=
>>=0A=
>> Thoughts ?=0A=
>>=0A=
> =0A=
> I see what you mean and it makes sense. However, the problem I am seeing=
=0A=
> occurs when allow_outplace_dio() returns true, as this is what creates=0A=
> the inconsistency between the write being buffered and the read being=0A=
> DIO.=0A=
=0A=
But if the write is switched to buffered, the DIO read should use the=0A=
buffered path too, no ? Since this is all happening under VFS, the=0A=
generic DIO read path will not ensure that the buffered writes are=0A=
flushed to disk before issuing the direct read, I think. So that would=0A=
explain your data corruption, i.e. you are reading stale data on the=0A=
device before the buffered writes make it to the media.=0A=
=0A=
> =0A=
> I did test the code you propose and, as expected, it still triggered the=
=0A=
> corruption.=0A=
> =0A=
>>> -=0A=
>>>  	if (is_inode_flag_set(inode, FI_NO_PREALLOC))=0A=
>>>  		return 0;=0A=
>>>=0A=
>>>=0A=
>>=0A=
>>=0A=
>> -- =0A=
>> Damien Le Moal=0A=
>> Western Digital Research=0A=
> =0A=
> Thanks,=0A=
> Javier=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
