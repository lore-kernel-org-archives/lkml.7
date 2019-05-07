Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108D6C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE95E20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZNkPxKEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfEGFEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:04:38 -0400
Received: from mail-eopbgr1320124.outbound.protection.outlook.com ([40.107.132.124]:16263
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725839AbfEGFEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:04:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=aTsCasY2C8Mk+MrENu613ngWBC2ZILCGVa830HPGMhRlWvNu57w1398fRS8w/XpP6+Ot3wfo/jHMl52YLY20tb9NL8N0IX8HZCk7e5pXefBuYT7HWSYtHkF5d0K0hUQYaWuwHDKLYSqENrQS9JQyIb8wpHfunwEGuHNHFAfxe+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdj/IUcPKEkxOCR+ltQyixdqXOfYVpsQTMU6XxmtcLE=;
 b=ibm0a+WYXn/jVxapKrfxxhzpy3U84AbzxHPFSGx2uuD+QC3rO8O0003x8nyONzSIxyA9BaEfcGVpSC6EC+J7dPbGWFtcK3ZpP/L50jstFzu6E+9go0R1Km+eompmIMCjbSqRwtEpvLIswdDSG973Hx5m+7KRUPx8NCyDnEGqaXs=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdj/IUcPKEkxOCR+ltQyixdqXOfYVpsQTMU6XxmtcLE=;
 b=ZNkPxKEHizaRVcELviP1tm89g4jyDDQjr3JvlzwpxXZARHJKzfjzt216KBloDYZTMPEMGftbcSpsVnOBqoCXPCbX5MvCtcgTDFBT+UMGJztHHgAEdJqw6YgocGIPEGl6TakiiSX6k5srhFL+i8vadzgoArfkmNu3xxFyYX70VJ0=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0124.APCP153.PROD.OUTLOOK.COM (10.170.188.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.4; Tue, 7 May 2019 05:02:48 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::dc7e:e62f:efc9:8564]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::dc7e:e62f:efc9:8564%4]) with mapi id 15.20.1900.002; Tue, 7 May 2019
 05:02:47 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Adrian Vladu <avladu@cloudbasesolutions.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Subject: RE: [PATCH v2] hv: tools: fixed Python pep8/flake8 warnings for
 lsvmbus
Thread-Topic: [PATCH v2] hv: tools: fixed Python pep8/flake8 warnings for
 lsvmbus
Thread-Index: AQHVBDHuNJnrC1p4dEOqKi273j4CEqZfG1YQ
Date:   Tue, 7 May 2019 05:02:47 +0000
Message-ID: <PU1P153MB016957AD2B1C356FA1BFB1A8BF310@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190506172737.18122-1-avladu@cloudbasesolutions.com>
 <20190506173331.18906-1-avladu@cloudbasesolutions.com>
In-Reply-To: <20190506173331.18906-1-avladu@cloudbasesolutions.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-05-07T05:02:44.9091445Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f9a6ae3d-861a-4b37-8cf0-d93b1c3d378b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:2947:1fea:71ab:41dd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca0f0b70-b96b-4115-04ff-08d6d2a93fb2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0124;
x-ms-traffictypediagnostic: PU1P153MB0124:
x-microsoft-antispam-prvs: <PU1P153MB0124C104E93DD1DC878D8A6ABF310@PU1P153MB0124.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(396003)(39860400002)(376002)(199004)(189003)(6116002)(229853002)(102836004)(478600001)(486006)(10290500003)(9686003)(8936002)(53936002)(2906002)(256004)(76176011)(86612001)(2501003)(71200400001)(71190400001)(86362001)(7696005)(5660300002)(99286004)(55016002)(54906003)(76116006)(66946007)(73956011)(68736007)(66476007)(66446008)(64756008)(66556008)(53546011)(6436002)(22452003)(316002)(110136005)(81156014)(8676002)(81166006)(446003)(11346002)(10090500001)(476003)(74316002)(186003)(46003)(8990500004)(25786009)(33656002)(52536014)(6246003)(14454004)(6506007)(7736002)(4326008)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0124;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5lRRXpdIjcer/nTOUpqDCOg7zVLMicTxMXSMVPuWmz+xK76VDVVTv12TSODd17imy8+Z8fVT8DnwiG1R6dSaamRiuyf/OpFz9I/XLEgdwoaEPjbFEYmnF3m0fNvlhyb+M+gr70C0IepUABIFTsG7SGGH4OZzgSx1AXqoa34/r1YjnQObuQCJD8kCi6jPqEf9jJXqa1XTTy78NlhQKm8wLRLeWXfW3mNjwnw9M1B2YYTv5r0jVLUYq0q0XbmjjJnsmx+T2MOY7YffH8zv1hMmJgVb4lRU2ttVHBc/GDtsgE7WbxKJkP2IIBOSuIHb7Zz7ygQLmLvuOF5PaznJ2no+9OelKYYFJBjUGX+R5Re+lOZO6HBkogZI0ida+ZeLIcpbOVf0Mi5RZBdr2FaKTYmpuXtl1Rm8/f6uLZ2oko7BBus=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0f0b70-b96b-4115-04ff-08d6d2a93fb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 05:02:47.4464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Adrian Vladu <avladu@cloudbasesolutions.com>
> Sent: Monday, May 6, 2019 10:34 AM
> To: linux-kernel@vger.kernel.org
> Cc: Adrian Vladu <avladu@cloudbasesolutions.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>;
> Dexuan Cui <decui@microsoft.com>; Alessandro Pilotti
> <apilotti@cloudbasesolutions.com>
> Subject: [PATCH v2] hv: tools: fixed Python pep8/flake8 warnings for lsvm=
bus
>=20
> Fixed pep8/flake8 python style code for lsvmbus tool.
>=20
> The TAB indentation was on purpose ignored (pep8 rule W191) to make
> sure the code is complying with the Linux code guideline.
> The following command do not show any warnings now:
> pep8 --ignore=3DW191 lsvmbus
> flake8 --ignore=3DW191 lsvmbus
>=20
> Signed-off-by: Adrian Vladu <avladu@cloudbasesolutions.com>
>=20
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
> ---
>  tools/hv/lsvmbus | 75 +++++++++++++++++++++++++++---------------------
>  1 file changed, 42 insertions(+), 33 deletions(-)
>=20
> diff --git a/tools/hv/lsvmbus b/tools/hv/lsvmbus
> index 55e7374bade0..099f2c44dbed 100644
> --- a/tools/hv/lsvmbus
> +++ b/tools/hv/lsvmbus
> @@ -4,10 +4,10 @@
>  import os
>  from optparse import OptionParser
>=20
> +help_msg =3D "print verbose messages. Try -vv, -vvv for  more verbose
> messages"
>  parser =3D OptionParser()
> -parser.add_option("-v", "--verbose", dest=3D"verbose",
> -		   help=3D"print verbose messages. Try -vv, -vvv for \
> -			more verbose messages", action=3D"count")
> +parser.add_option(
> +	"-v", "--verbose", dest=3D"verbose", help=3Dhelp_msg, action=3D"count")
>=20
>  (options, args) =3D parser.parse_args()
>=20
> @@ -21,27 +21,28 @@ if not os.path.isdir(vmbus_sys_path):
>  	exit(-1)
>=20
>  vmbus_dev_dict =3D {
> -	'{0e0b6031-5213-4934-818b-38d90ced39db}' : '[Operating system
> shutdown]',
> -	'{9527e630-d0ae-497b-adce-e80ab0175caf}' : '[Time Synchronization]',
> -	'{57164f39-9115-4e78-ab55-382f3bd5422d}' : '[Heartbeat]',
> -	'{a9a0f4e7-5a45-4d96-b827-8a841e8c03e6}' : '[Data Exchange]',
> -	'{35fa2e29-ea23-4236-96ae-3a6ebacba440}' : '[Backup (volume
> checkpoint)]',
> -	'{34d14be3-dee4-41c8-9ae7-6b174977c192}' : '[Guest services]',
> -	'{525074dc-8985-46e2-8057-a307dc18a502}' : '[Dynamic Memory]',
> -	'{cfa8b69e-5b4a-4cc0-b98b-8ba1a1f3f95a}' : 'Synthetic mouse',
> -	'{f912ad6d-2b17-48ea-bd65-f927a61c7684}' : 'Synthetic keyboard',
> -	'{da0a7802-e377-4aac-8e77-0558eb1073f8}' : 'Synthetic framebuffer
> adapter',
> -	'{f8615163-df3e-46c5-913f-f2d2f965ed0e}' : 'Synthetic network adapter',
> -	'{32412632-86cb-44a2-9b5c-50d1417354f5}' : 'Synthetic IDE Controller',
> -	'{ba6163d9-04a1-4d29-b605-72e2ffb1dc7f}' : 'Synthetic SCSI Controller',
> -	'{2f9bcc4a-0069-4af3-b76b-6fd0be528cda}' : 'Synthetic fiber channel
> adapter',
> -	'{8c2eaf3d-32a7-4b09-ab99-bd1f1c86b501}' : 'Synthetic RDMA adapter',
> -	'{44c4f61d-4444-4400-9d52-802e27ede19f}' : 'PCI Express pass-through',
> -	'{276aacf4-ac15-426c-98dd-7521ad3f01fe}' : '[Reserved system device]',
> -	'{f8e65716-3cb3-4a06-9a60-1889c5cccab5}' : '[Reserved system device]',
> -	'{3375baf4-9e15-4b30-b765-67acb10d607b}' : '[Reserved system device]',
> +	'{0e0b6031-5213-4934-818b-38d90ced39db}': '[Operating system
> shutdown]',
> +	'{9527e630-d0ae-497b-adce-e80ab0175caf}': '[Time Synchronization]',
> +	'{57164f39-9115-4e78-ab55-382f3bd5422d}': '[Heartbeat]',
> +	'{a9a0f4e7-5a45-4d96-b827-8a841e8c03e6}': '[Data Exchange]',
> +	'{35fa2e29-ea23-4236-96ae-3a6ebacba440}': '[Backup (volume
> checkpoint)]',
> +	'{34d14be3-dee4-41c8-9ae7-6b174977c192}': '[Guest services]',
> +	'{525074dc-8985-46e2-8057-a307dc18a502}': '[Dynamic Memory]',
> +	'{cfa8b69e-5b4a-4cc0-b98b-8ba1a1f3f95a}': 'Synthetic mouse',
> +	'{f912ad6d-2b17-48ea-bd65-f927a61c7684}': 'Synthetic keyboard',
> +	'{da0a7802-e377-4aac-8e77-0558eb1073f8}': 'Synthetic framebuffer
> adapter',
> +	'{f8615163-df3e-46c5-913f-f2d2f965ed0e}': 'Synthetic network adapter',
> +	'{32412632-86cb-44a2-9b5c-50d1417354f5}': 'Synthetic IDE Controller',
> +	'{ba6163d9-04a1-4d29-b605-72e2ffb1dc7f}': 'Synthetic SCSI Controller',
> +	'{2f9bcc4a-0069-4af3-b76b-6fd0be528cda}': 'Synthetic fiber channel
> adapter',
> +	'{8c2eaf3d-32a7-4b09-ab99-bd1f1c86b501}': 'Synthetic RDMA adapter',
> +	'{44c4f61d-4444-4400-9d52-802e27ede19f}': 'PCI Express pass-through',
> +	'{276aacf4-ac15-426c-98dd-7521ad3f01fe}': '[Reserved system device]',
> +	'{f8e65716-3cb3-4a06-9a60-1889c5cccab5}': '[Reserved system device]',
> +	'{3375baf4-9e15-4b30-b765-67acb10d607b}': '[Reserved system device]',
>  }
>=20
> +
>  def get_vmbus_dev_attr(dev_name, attr):
>  	try:
>  		f =3D open('%s/%s/%s' % (vmbus_sys_path, dev_name, attr), 'r')
> @@ -52,6 +53,7 @@ def get_vmbus_dev_attr(dev_name, attr):
>=20
>  	return lines
>=20
> +
>  class VMBus_Dev:
>  	pass
>=20
> @@ -66,12 +68,13 @@ for f in os.listdir(vmbus_sys_path):
>=20
>  	chn_vp_mapping =3D get_vmbus_dev_attr(f, 'channel_vp_mapping')
>  	chn_vp_mapping =3D [c.strip() for c in chn_vp_mapping]
> -	chn_vp_mapping =3D sorted(chn_vp_mapping,
> -		key =3D lambda c : int(c.split(':')[0]))
> +	chn_vp_mapping =3D sorted(
> +		chn_vp_mapping, key=3Dlambda c: int(c.split(':')[0]))
>=20
> -	chn_vp_mapping =3D ['\tRel_ID=3D%s, target_cpu=3D%s' %
> -				(c.split(':')[0], c.split(':')[1])
> -					for c in chn_vp_mapping]
> +	chn_vp_mapping =3D [
> +		'\tRel_ID=3D%s, target_cpu=3D%s' %
> +		(c.split(':')[0], c.split(':')[1]) for c in chn_vp_mapping
> +	]
>  	d =3D VMBus_Dev()
>  	d.sysfs_path =3D '%s/%s' % (vmbus_sys_path, f)
>  	d.vmbus_id =3D vmbus_id
> @@ -85,7 +88,7 @@ for f in os.listdir(vmbus_sys_path):
>  	vmbus_dev_list.append(d)
>=20
>=20
> -vmbus_dev_list  =3D sorted(vmbus_dev_list, key =3D lambda d : int(d.vmbu=
s_id))
> +vmbus_dev_list =3D sorted(vmbus_dev_list, key=3Dlambda d: int(d.vmbus_id=
))
>=20
>  format0 =3D '%2s: %s'
>  format1 =3D '%2s: Class_ID =3D %s - %s\n%s'
> @@ -95,9 +98,15 @@ for d in vmbus_dev_list:
>  	if verbose =3D=3D 0:
>  		print(('VMBUS ID ' + format0) % (d.vmbus_id, d.dev_desc))
>  	elif verbose =3D=3D 1:
> -		print (('VMBUS ID ' + format1) %	\
> -			(d.vmbus_id, d.class_id, d.dev_desc, d.chn_vp_mapping))
> +		print(
> +			('VMBUS ID ' + format1) %
> +			(d.vmbus_id, d.class_id, d.dev_desc, d.chn_vp_mapping)
> +		)
>  	else:
> -		print (('VMBUS ID ' + format2) % \
> -			(d.vmbus_id, d.class_id, d.dev_desc, \
> -			d.device_id, d.sysfs_path, d.chn_vp_mapping))
> +		print(
> +			('VMBUS ID ' + format2) %
> +			(
> +				d.vmbus_id, d.class_id, d.dev_desc,
> +				d.device_id, d.sysfs_path, d.chn_vp_mapping
> +			)
> +		)
> --
> 2.19.1

Looks good to me. Thanks, Adrian!

Reviewed-by: Dexuan Cui <decui@microsoft.com>

