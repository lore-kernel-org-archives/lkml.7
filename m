Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA293C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B522166E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="wZS2b/tM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfGHXZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:25:17 -0400
Received: from mail-eopbgr810055.outbound.protection.outlook.com ([40.107.81.55]:5248
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727151AbfGHXZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:25:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfElbK/aYEcfrxeMz7nuYPwaU1RNrrdC88CLTezGGNWD8XI95xKmOXEgiIJ0zot2pj/i3fz8sWgNoFp7LFHr0ThlBMJRnF/Kc8/PPjeOOLN03fZJQ59vyYDbY+JMSBePdiywUwKd7Lm8a3GKAto9r8ihYbD1fslMFJsmtr9u8hP8Whj8uk98MLjkF/KlelfQVLj2Ju96CB9dDIzw4DSv8qjUeiBHNcd3GxKTWue40pDQZToqQ6v2Kb226fkMi/LFu6GmQa37/wpEk3c+rhvksQZTeuuyU+cD9+iNRBJwepa7tdgTDxwqjlrNbUHeTWghcmeiebkHK7OmhCMpnUtnNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKp9CySZDig76vbPVjNNuWG1BYCblEvkLxy95hvOdCk=;
 b=NODtbdgUHXyRtngcsDQYZoklgHi0zeVEccJUV7pbFWMeCvtq6q82928B/nqXbuh8IqsAuYMp68HBYzBPa/AhwYA6YqOu1N812Witb67pJzkNd4zE3W7wocHoUZPlYbIQQsxcDTKwxhXyPudfBaTRPiRUF7KJ7srHq8qud6jjeLLer8hGDWyThFrzlKMaHHzaTq5U/POjZ81fGNScXjVfbztjHdb19AtJbqNt9+v/3IeFd0dWqQdgDlwl1jfD+NKhSolf6X9Fky/3mQZpwjqnx1AKq1dwbANMUn+vkZFiGHKsOsdRJYLcSa2qMlVkH6yRtS4Hw1oVcYWMp18SBPIToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKp9CySZDig76vbPVjNNuWG1BYCblEvkLxy95hvOdCk=;
 b=wZS2b/tM7dLS6tDxdEjSW/99x9q9MgRZCjBKf+0OS/euxxVlZVST8fBUUVtylG1lxxqdO7d7bTTvw3uP2ppEqBMaUccHU/RUacsTpgDo7QDf/jUqPH/gHtC206yX/QPN7DMZ6o5tt0bp5Wo3D3FyE0EWOmVGxjWqW8wO6GbL0Z8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6614.namprd05.prod.outlook.com (20.178.235.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.9; Mon, 8 Jul 2019 23:25:12 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2073.008; Mon, 8 Jul 2019
 23:25:12 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg KH <greg@kroah.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Thread-Topic: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Thread-Index: AQHVIaxkp0bwsFh6w0+5MKCG3RI9WabBg/6AgAABcAA=
Date:   Mon, 8 Jul 2019 23:25:12 +0000
Message-ID: <A3330909-6201-4FB6-B20B-89D8C1CE7A0C@vmware.com>
References: <20190613155344.64fce8b9@canb.auug.org.au>
 <20190709092003.6087a9c4@canb.auug.org.au>
In-Reply-To: <20190709092003.6087a9c4@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18b54981-2494-41f7-5874-08d703fb86b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6614;
x-ms-traffictypediagnostic: BYAPR05MB6614:
x-microsoft-antispam-prvs: <BYAPR05MB661406F972EEBA9C4983B47DD0F60@BYAPR05MB6614.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(53754006)(189003)(199004)(53434003)(43544003)(256004)(14454004)(316002)(54906003)(14444005)(25786009)(4326008)(186003)(6506007)(53546011)(71190400001)(71200400001)(102836004)(81156014)(66066001)(3846002)(6116002)(26005)(76176011)(99286004)(478600001)(486006)(7736002)(6486002)(305945005)(8936002)(81166006)(6246003)(6916009)(8676002)(6512007)(6436002)(2906002)(53936002)(11346002)(66946007)(5660300002)(66556008)(66446008)(64756008)(36756003)(68736007)(446003)(229853002)(86362001)(66476007)(476003)(73956011)(2616005)(76116006)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6614;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p4VVRYx5nJHKYK+MQijNei31gYzBapGXbvHQB7LaKkcfg9l4O7bZ+pNZ5609LVToLh5R3/TdTN+gG3RyFLJgLSJoFN69AB+4+82l+FrtiiwA+gScyayJPe1iHPEwGjl6tm0cU3jdbAsSQDY/RmEOckG/ftliQ4gSGSfaaUWZFzqsV/gQN2JlV7ioaVo7X/+NwG/mvOI0YmgWcY7SIdz7AZ2oIWINsLPGf8MedNpXL9NzbhamdnABbcGLFrf9IdDrucmuRy/bGREP6wPRzFfIkGK1xp3Ep+7ZDVyMwafxvfgk6u8Oxu2mX8fKOhtk/xY/dlYd3ElOZS5kYTMLQY6m7r4bmW+yNJ5ngHUZyUdvgE3BOFKDEVzQxF+ZLdQYbMT82YjNVi11eWBKpijpqYJnYvpD5pq8DQIsHdDAk1ZVInc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5DD5CF10FBBCF948B753E4CF6293E6FA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b54981-2494-41f7-5874-08d703fb86b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 23:25:12.6442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 8, 2019, at 4:20 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote=
:
>=20
> Hi all,
>=20
> On Thu, 13 Jun 2019 15:53:44 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>> Today's linux-next merge of the char-misc tree got a conflict in:
>>=20
>>  drivers/misc/vmw_balloon.c
>>=20
>> between commit:
>>=20
>>  225afca60b8a ("vmw_balloon: no need to check return value of debugfs_cr=
eate functions")
>>=20
>> from the driver-core tree and commits:
>>=20
>>  83a8afa72e9c ("vmw_balloon: Compaction support")
>>  5d1a86ecf328 ("vmw_balloon: Add memory shrinker")
>>=20
>> from the char-misc tree.
>>=20
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>=20
>> --=20
>> Cheers,
>> Stephen Rothwell
>>=20
>> diff --cc drivers/misc/vmw_balloon.c
>> index fdf5ad757226,043eed845246..000000000000
>> --- a/drivers/misc/vmw_balloon.c
>> +++ b/drivers/misc/vmw_balloon.c
>> @@@ -1553,15 -1942,26 +1932,24 @@@ static int __init vmballoon_init(void
>>  	if (x86_hyper_type !=3D X86_HYPER_VMWARE)
>>  		return -ENODEV;
>>=20
>> - 	for (page_size =3D VMW_BALLOON_4K_PAGE;
>> - 	     page_size <=3D VMW_BALLOON_LAST_SIZE; page_size++)
>> - 		INIT_LIST_HEAD(&balloon.page_sizes[page_size].pages);
>> -=20
>> -=20
>>  	INIT_DELAYED_WORK(&balloon.dwork, vmballoon_work);
>>=20
>> + 	error =3D vmballoon_register_shrinker(&balloon);
>> + 	if (error)
>> + 		goto fail;
>> +=20
>> -	error =3D vmballoon_debugfs_init(&balloon);
>> -	if (error)
>> -		goto fail;
>> +	vmballoon_debugfs_init(&balloon);
>>=20
>> + 	/*
>> + 	 * Initialization of compaction must be done after the call to
>> + 	 * balloon_devinfo_init() .
>> + 	 */
>> + 	balloon_devinfo_init(&balloon.b_dev_info);
>> + 	error =3D vmballoon_compaction_init(&balloon);
>> + 	if (error)
>> + 		goto fail;
>> +=20
>> + 	INIT_LIST_HEAD(&balloon.huge_pages);
>>  	spin_lock_init(&balloon.comm_lock);
>>  	init_rwsem(&balloon.conf_sem);
>>  	balloon.vmci_doorbell =3D VMCI_INVALID_HANDLE;
>=20
> I am still getting this conflict (the commit ids may have changed).
> Just a reminder in case you think Linus may need to know.

Greg,

Can you please take care of it, as you are the maintainer of char-misc
and the committer of the patch?



