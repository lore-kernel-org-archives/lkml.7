Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219B2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E8F20656
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j9/Ox1oe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gv4K0AIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfKZGTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 01:19:49 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45588 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfKZGTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 01:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574749189; x=1606285189;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qJ9Xm04pLV4GcH2eujk7a1yowygV2ZFo6GS7Rc2vJ6I=;
  b=j9/Ox1oeNRLdtxmDNQJei9XiCsz5mb3ES09+6IT8/pNyDCrPoPkMTcHN
   mTuKl7sHaRNBrCj5Yli8Q+w6xVVpjw8Ekx0MrmjvY5ExJLC0K9nOj/kGO
   VPmd2iqiXdqdWb6LDvGCyM26amZVWYazzwLDM71Nlg+HpCCPQfqxviFNO
   X5TSCTi6j8t6nwghlbm24uP2YzSYklRwVPPS+Ms5vRsQPb/cXFJOvUpt5
   DG+zxtfzSptAp5Fbe6YkbwnpJ677wd7Yu89xQZycZDN6Ey3pDrfMAFzGV
   y2tc4q9Gr8WxXAXLVKW3jVe0GFE4shxk146ERXQiveFxmimtCRpKZe2Lj
   g==;
IronPort-SDR: Xg9+wfF3DFLsWZ4881Mj78GR4BvFFfWvoHxTyMtM4OXm0HgfEuTvewGkOwIuKJffbsYUz9pvbh
 tWsx4IP8jyfDmjJrCDpasJN7IW2Rw3DDqvxExX9gmG1dWPePCsrrmYF5dKE4C2b14/fFZcutzA
 xZh7aN7yXl2qOPtMqoxl1MG5fDoFNCNUkDOzTz0z1DhmwRVY8lLPnop4+db7PlM82WCB0X6zlg
 4bghsyo5XgjXdYg9cJPn0dpXpWxzsew9KjK3RcsCEL+Y9KjXLwTO4rHUsTRYTh/wIIzp3SuTiz
 Vjo=
X-IronPort-AV: E=Sophos;i="5.69,244,1571673600"; 
   d="scan'208";a="125619544"
Received: from mail-co1nam03lp2050.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.50])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2019 14:19:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnEo9fME1Y18l9ekcd22Vjl0bh9wHbXHSDhJezPg02a6oye9bhSlH6RyjviNbxUh33Iu+AVAa+eX10r47mhJmH5sUfTloKU312FAVdiaCg7dpOzTeUSJyMpYFsdb8pWQWEKZs+Lj6G+CtCGRN4YGFlFF9rRkVJFFuuaBTyqIxAVyDPxb0oIfsSFmkPlVkHlsgE/RZYr7PRP9VVTIwl6wGKeNWMi3m6rqf2ADrG6Z5UmHOLgEhFBzr7LUmdyVYTP3Mr28UBjvcKwYZkf+H4qp6l2365x9jQcmjWlVBbNEIW46r7j2sdt9rgshbzgcN8kUyAJmCOyK0grQz63q/EnHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGBc70jtzFZA1dWOiXOjtf59YxZoo6+ALbKNORXzzqA=;
 b=En8hh6sjyONM9jktMB7Cp2zl90czf5WOzkbe5zkTvcgEO2YzVQfHqUR2Eh3RIokCGZ9TsXSgV5JV4DC94nQmVcjg1dkuWK2eakAEYEpM7pWK1I4WpclLjclOw7hyL/ytllIZ99MWLRVl/joL7IlA9f4blzxarX5CAQej3MW6j0zLVsmM6723kYqbwKmnNeNLv0xuEvD6XE41VItqpWVXX1E3yXmgr4O9Bdeq4h338jqossD9/2Ern7Fir6o/gu2jGJg3zDZVU+LL8NumgWyQgoNTs9Y7foGOeNsh7hOVOGCh3MCYnQGlHnW9FfFX8bMNE3hHvk87WdUSKzUCUoUT2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGBc70jtzFZA1dWOiXOjtf59YxZoo6+ALbKNORXzzqA=;
 b=gv4K0AIKsSuyasFUDZe0hfkDnKFMewIp0LX9YwWBJ0QuUV/PQVVZjMh+ob/7Po2+7IE0kk9RJyVzbAKujcL3q+ZIKDmy0muaZb04a2WTRXPYnmdI47BEvyAQkBQ913LuN122KIRlmzxx1ezG+7vC1Y0FXCt4wVrBERCRfUp+Gzg=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4629.namprd04.prod.outlook.com (52.135.240.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Tue, 26 Nov 2019 06:19:46 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 06:19:46 +0000
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
Date:   Tue, 26 Nov 2019 06:19:46 +0000
Message-ID: <BYAPR04MB581676157DCF909EDF1AAAFCE7450@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191122085952.12754-1-javier@javigon.com>
 <BYAPR04MB58166AE029D919C6610D8404E74A0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20191125190320.g7beal27nc5ubju7@mpHalley>
 <BYAPR04MB58161C14246FA30366B69B9DE7450@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20191126035726.xj7pierxsck6adow@mpHalley>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b815eb58-7723-412d-8192-08d77238a297
x-ms-traffictypediagnostic: BYAPR04MB4629:
x-microsoft-antispam-prvs: <BYAPR04MB4629F82EE11DFA9391845ADBE7450@BYAPR04MB4629.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(51444003)(199004)(189003)(4326008)(305945005)(55016002)(6116002)(3846002)(6916009)(76176011)(102836004)(229853002)(316002)(7696005)(6506007)(86362001)(33656002)(478600001)(2906002)(99286004)(74316002)(66066001)(66946007)(66476007)(66556008)(64756008)(91956017)(76116006)(52536014)(53546011)(54906003)(66574012)(14454004)(446003)(14444005)(6246003)(6436002)(5660300002)(8936002)(186003)(8676002)(66446008)(81166006)(9686003)(25786009)(71190400001)(71200400001)(256004)(81156014)(7736002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4629;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M2QBJ2ym/nKDiWFYzzqWwEv1Ybxdr6Zecr5nkDk2Vm3p9AtgpBEl5UeC2MdTHxAoKD//pJUzZoju3Pgu9nR22oD3NuDp3vW0kYEnTZOcIV9Uxi7e+OnmDlN9sXwj4u3Gu6rLo5EKOtXA/bxflRwXTuVP7XHa3esIKW85WaNsxK7WCBSBvUAwj3dll2IFU2LBmtBUN+ISaNSZy59t9/1PoBtos8lw3st6pejhBnCGyeEJe8ngturYl2KcPLLQh5VpZOmwEb11m+d30WLOfAe5Ox1anUOPQAP/6oAAaTxp6QruNvg93zdJaECi/fBk/IejcJWFF00fwBKfY0K8G4yW0mwVp+gZYHBJhRWaRKmsdM1oS4++LPjH8jh+X+00xNUNmE1tL1GFqqoO7sbTFKUZyOwZPZ0CnLVlem1c83ryrEqhdVhFMIt/ve8ztC8x5skU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b815eb58-7723-412d-8192-08d77238a297
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 06:19:46.5938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNWexbfcNujjnHy04ftexd5sho9o/27AxJXfQ0n1PG6E4m2rIXMFr+euU3HYoJCB6M12IW5zOukmrsN3uvgLRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/26 12:58, Javier Gonz=E1lez wrote:=0A=
> On 26.11.2019 02:06, Damien Le Moal wrote:=0A=
>> On 2019/11/26 4:03, Javier Gonz=E1lez wrote:=0A=
>>> On 25.11.2019 00:48, Damien Le Moal wrote:=0A=
>>>> On 2019/11/22 18:00, Javier Gonz=E1lez wrote:=0A=
>>>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>>>=0A=
>>>>> Fix file system corruption when using LFS mount (e.g., in zoned=0A=
>>>>> devices). Seems like the fallback into buffered I/O creates an=0A=
>>>>> inconsistency if the application is assuming both read and write DIO.=
 I=0A=
>>>>> can easily reproduce a corruption with a simple RocksDB test.=0A=
>>>>>=0A=
>>>>> Might be that the f2fs_forced_buffered_io path brings some problems t=
oo,=0A=
>>>>> but I have not seen other failures besides this one.=0A=
>>>>>=0A=
>>>>> Problem reproducible without a zoned block device, simply by forcing=
=0A=
>>>>> LFS mount:=0A=
>>>>>=0A=
>>>>>   $ sudo mkfs.f2fs -f -m /dev/nvme0n1=0A=
>>>>>   $ sudo mount /dev/nvme0n1 /mnt/f2fs=0A=
>>>>>   $ sudo  /opt/rocksdb/db_bench  --benchmarks=3Dfillseq --use_existin=
g_db=3D0=0A=
>>>>>   --use_direct_reads=3Dtrue --use_direct_io_for_flush_and_compaction=
=3Dtrue=0A=
>>>>>   --db=3D/mnt/f2fs --num=3D5000 --value_size=3D1048576 --verify_check=
sum=3D1=0A=
>>>>>   --block_size=3D65536=0A=
>>>>>=0A=
>>>>> Note that the options that cause the problem are:=0A=
>>>>>   --use_direct_reads=3Dtrue --use_direct_io_for_flush_and_compaction=
=3Dtrue=0A=
>>>>>=0A=
>>>>> Fixes: f9d6d0597698 ("f2fs: fix out-place-update DIO write")=0A=
>>>>>=0A=
>>>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>>> ---=0A=
>>>>>  fs/f2fs/data.c | 3 ---=0A=
>>>>>  1 file changed, 3 deletions(-)=0A=
>>>>>=0A=
>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c=0A=
>>>>> index 5755e897a5f0..b045dd6ab632 100644=0A=
>>>>> --- a/fs/f2fs/data.c=0A=
>>>>> +++ b/fs/f2fs/data.c=0A=
>>>>> @@ -1081,9 +1081,6 @@ int f2fs_preallocate_blocks(struct kiocb *iocb,=
 struct iov_iter *from)=0A=
>>>>>  			return err;=0A=
>>>>>  	}=0A=
>>>>>=0A=
>>>>> -	if (direct_io && allow_outplace_dio(inode, iocb, from))=0A=
>>>>> -		return 0;=0A=
>>>>=0A=
>>>> Since for LFS mode, all DIOs can end up out of place, I think that it=
=0A=
>>>> may be better to change allow_outplace_dio() to always return true in=
=0A=
>>>> the case of LFS mode. So may be something like:=0A=
>>>>=0A=
>>>> static inline int allow_outplace_dio(struct inode *inode,=0A=
>>>> 			struct kiocb *iocb, struct iov_iter *iter)=0A=
>>>> {=0A=
>>>> 	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);=0A=
>>>> 	int rw =3D iov_iter_rw(iter);=0A=
>>>>=0A=
>>>> 	return test_opt(sbi, LFS) ||=0A=
>>>> 	 	(rw =3D=3D WRITE && !block_unaligned_IO(inode, iocb, iter));=0A=
>>>> }=0A=
>>>>=0A=
>>>> instead of the original:=0A=
>>>>=0A=
>>>> static inline int allow_outplace_dio(struct inode *inode,=0A=
>>>> 			struct kiocb *iocb, struct iov_iter *iter)=0A=
>>>> {=0A=
>>>> 	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);=0A=
>>>> 	int rw =3D iov_iter_rw(iter);=0A=
>>>>=0A=
>>>> 	return (test_opt(sbi, LFS) && (rw =3D=3D WRITE) &&=0A=
>>>> 				!block_unaligned_IO(inode, iocb, iter));=0A=
>>>> }=0A=
>>>>=0A=
>>>> Thoughts ?=0A=
>>>>=0A=
>>>=0A=
>>> I see what you mean and it makes sense. However, the problem I am seein=
g=0A=
>>> occurs when allow_outplace_dio() returns true, as this is what creates=
=0A=
>>> the inconsistency between the write being buffered and the read being=
=0A=
>>> DIO.=0A=
>>=0A=
>> But if the write is switched to buffered, the DIO read should use the=0A=
>> buffered path too, no ? Since this is all happening under VFS, the=0A=
>> generic DIO read path will not ensure that the buffered writes are=0A=
>> flushed to disk before issuing the direct read, I think. So that would=
=0A=
>> explain your data corruption, i.e. you are reading stale data on the=0A=
>> device before the buffered writes make it to the media.=0A=
>>=0A=
> =0A=
> As far as I can see, the read is always sent DIO, so yes, I also believe=
=0A=
> that we are reading stale data. This is why the corruption is not seen=0A=
> if preventing allow_outplace_dio() from sending the write to the=0A=
> buffered path.=0A=
> =0A=
> What surprises me is that this is very easy to trigger (see commit), so=
=0A=
> I assume you must have seen this with SMR in the past.=0A=
=0A=
We just did. Shin'Ichiro in my team finally succeeded in recreating the=0A=
problem. The cause seems to be:=0A=
=0A=
bool direct_io =3D iocb->ki_flags & IOCB_DIRECT;=0A=
=0A=
being true on entry of f2fs_preallocate_blocks() whereas=0A=
f2fs_direct_IO() forces buffered IO path for DIO on zoned devices with:=0A=
=0A=
if (f2fs_force_buffered_io(inode, iocb, iter))=0A=
		return 0;=0A=
=0A=
which has:=0A=
=0A=
	if (f2fs_sb_has_blkzoned(sbi))=0A=
		return true;=0A=
=0A=
So the top DIO code says "do buffered IOs", but lower in the write path,=0A=
the IO is still assumed to be a DIO because of the iocb flag... That's=0A=
inconsistent.=0A=
=0A=
Note that for the non-zoned device LFS case, f2fs_force_buffered_io()=0A=
returns true only for unaligned write DIOs... But that will still trip=0A=
on the iocb flag test. So the proper fix is likely something like:=0A=
=0A=
int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)=0A=
{=0A=
	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
	struct f2fs_map_blocks map;=0A=
	int flag;=0A=
	int err =3D 0;=0A=
-	bool direct_io =3D iocb->ki_flags & IOCB_DIRECT;=0A=
+	bool direct_io =3D (iocb->ki_flags & IOCB_DIRECT) &&=0A=
+		!2fs_force_buffered_io(inode, iocb, iter);=0A=
=0A=
	/* convert inline data for Direct I/O*/=0A=
	if (direct_io) {=0A=
		err =3D f2fs_convert_inline_inode(inode);=0A=
		if (err)=0A=
			return err;=0A=
	}=0A=
=0A=
Shin'Ichiro tried this on SMR disks and the failure is gone...=0A=
=0A=
Cheers.=0A=
=0A=
=0A=
> =0A=
> Does it make sense to leave the LFS check out of the=0A=
> allow_outplace_dio()? Or in other words, is there a hard requirement for=
=0A=
> writes to take this path on a zoned device that I am not seeing?=0A=
> Something like:=0A=
> =0A=
>    static inline int allow_outplace_dio(struct inode *inode,=0A=
>    			struct kiocb *iocb, struct iov_iter *iter)=0A=
>    {=0A=
>    	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);=0A=
>    	int rw =3D iov_iter_rw(iter);=0A=
> =0A=
>    	return (rw =3D=3D WRITE && !block_unaligned_IO(inode, iocb, iter));=
=0A=
>    }=0A=
> =0A=
> Thanks,=0A=
> Javier=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
