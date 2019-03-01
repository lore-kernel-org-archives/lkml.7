Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCC4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735232084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="MWWKzE0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388933AbfCAQAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:00:43 -0500
Received: from mx07-00287e01.pphosted.com ([91.207.212.151]:52093 "EHLO
        mx08-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727952AbfCAQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:00:43 -0500
Received: from pps.filterd (m0111313.ppops.net [127.0.0.1])
        by mx08-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x21FtF6c018584;
        Fri, 1 Mar 2019 17:00:22 +0100
Received: from eur01-db5-obe.outbound.protection.outlook.com (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58])
        by mx08-00287e01.pphosted.com with ESMTP id 2qtwfgf0j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Mar 2019 17:00:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAMveYDU8VgJ0iXYVjLqnCdn3zn8qXekvlkzlpTzVC0=;
 b=MWWKzE0/0SWGP/2rIOHAKtUPMBxJT1zO0OEEQRAQZtUaSmda82wttT1EJhXQyrFzLUgtP63lnxTSvh/pA8PWSuFNqJ03rPQEdztpx4Nl/ZNnnsa1FE/rn4aDw3V0g5A7/Dyeb+TM9lQ1jwhEhgfK9+UsxOVG6YnCRLqkB1zZzuo=
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com (20.178.125.158) by
 VI1PR04MB4015.eurprd04.prod.outlook.com (10.171.182.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Fri, 1 Mar 2019 16:00:20 +0000
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::4574:93ab:72b8:d1ec]) by VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::4574:93ab:72b8:d1ec%3]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 16:00:20 +0000
From:   Erwan Velu <e.velu@criteo.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Erwan Velu <erwanaliasr1@gmail.com>,
        "elliott@hpe.com" <elliott@hpe.com>
CC:     Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)" 
        <esc.storagedev@microsemi.com>,
        "open list:MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)" 
        <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Topic: [PATCH v2] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Index: AQHU0D9MEwbiRTQ1W0O9RWBUcKAFRaX25ceAgAAVdYD///L5gIAAAQiA
Date:   Fri, 1 Mar 2019 16:00:20 +0000
Message-ID: <a34de194-1602-08fc-9c67-27a1585b4d2c@criteo.com>
References: <20190227163133.26283-1-e.velu@criteo.com>
 <20190301145832.12735-1-e.velu@criteo.com>
 <1551453987.3334.2.camel@linux.ibm.com>
 <c858605b-7283-7882-64a8-8d1584274b95@criteo.com>
 <1551455797.3334.6.camel@linux.ibm.com>
In-Reply-To: <1551455797.3334.6.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0280.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::28) To VI1PR04MB5629.eurprd04.prod.outlook.com
 (2603:10a6:803:de::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [91.199.242.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4aabc4b-106c-4498-833f-08d69e5f0192
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4015;
x-ms-traffictypediagnostic: VI1PR04MB4015:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0MDE1OzIzOmt3VDdoRisvZFhsdnRJQ2J4OWhMd1dZS3Bs?=
 =?utf-8?B?Vk9OMXlTS1N1MENBeTJWMElNYnZEOGNZZklTOWdvdWxoVkhjbCtEcUtvK0ox?=
 =?utf-8?B?UGdGaUhiZ0Y0K0UyVEVyMXRKYWlyRCtCaFBSSnc4M241UkFJdlZ5Y3B3M1hw?=
 =?utf-8?B?YlM0ZnI5Z0tUajRvSzEwRXZFd2hEdnJVQ01iRGxtYTcvaUhsMVZVWmVjRVNk?=
 =?utf-8?B?SGNyR2M1WlNndVN5Yk5odEFGUkRsSUJrK1lLVjhldmZLMWszd2YxdVFIaFNL?=
 =?utf-8?B?ckwxalkwekQ1enhVVVlFMzl3Slg4aGpZMFhNdzQ2d1QwVllBU0liR3Z3cFIx?=
 =?utf-8?B?OWdxMlE1SXIrMHQ5Umwwb3RwZG05UmhFNkcyazdHdHRoT0V3RXFzakdsN1k3?=
 =?utf-8?B?LzFzd293azRpSDQzR3VGclpNRVdZU2Irak9kelV5d1lweUNaT0tuRDdxaEVl?=
 =?utf-8?B?dXBFZXdHS1hhVFhOc0x3T2RkeVdlY055V21mQVQ4QjNMcXErVCs5VTZrTFVy?=
 =?utf-8?B?dG9QVFRONmFBRUxLSEllVHFRMStUcC9wWkxJVHFNMUM2eGZ0Q3ErT0tYcVVZ?=
 =?utf-8?B?MXNNTXNMY0NxcGo4aGFWM1h2ZS93OWN3YXhHSjdBZnQ2MFIrR1JBVDFrZWdY?=
 =?utf-8?B?QmRyUjBwRy83R0ZOMHV4QnRNNW5Jc0haUHJYR1c4anU5NC93ZkVha2RRakty?=
 =?utf-8?B?SXhlUk45QlRLeUppb1h0Y3V2ZVgyZVhCQ0VhY2NqUmNuMzhadWZ6Y0hha01M?=
 =?utf-8?B?OGV2N0kwMjBCZk9JM2Mya0xOM1F5ZFJtdGhRQnpVams2WGlvQ3BiU0V1NUdx?=
 =?utf-8?B?ZzUzelYzbnFGN0Jmc2lIaFRHbk43VnJZLyt5Y1lCSnRIRkpXcy9tRkNIVk91?=
 =?utf-8?B?Q0tXNzQ1M2RYbHJzRUsxZnZwdWVtVDhuTFE5OWJma29jU0ZiQkdqWXdzVEU4?=
 =?utf-8?B?NEN4WkFyQ08rZ0c2Wk9wWXFtTjJYYnhhZHBZZ3lIWXRoZjlvcVo3emZDT3hq?=
 =?utf-8?B?aVJVMVhRQklIUkk1RVRrWHhLTXBST1B3KzVjbVZnajVDSktPMlVUb1dUb3dW?=
 =?utf-8?B?c1BPaU91VUd5Y0NhTmMzN2xBbHhMZDd1NzhpcXFVamFQWkMvc3NBSk1mVmZl?=
 =?utf-8?B?QWVhMHVBRU5kY0NETVJHLzFXMEYzSEs2RnlDeUVPdGhmeFZ5ZUhDMzJWakdP?=
 =?utf-8?B?bGRqTWJtcXV3bjRYTnp3ZzZ1K3o1MVBsVXNVWU9xalFTRDhYSUZBbmIrV2N1?=
 =?utf-8?B?NEtJMG94SHZzcG5yUDI5MEtzZXdJVG43TVlGWXMvZ09SdlJYY0FuKzBNTGc1?=
 =?utf-8?B?T0NwcThkYy9GQjN0Y1F2b0RwMEg2M2hQajRjb3E3YVduN0thL29iT3FzaThE?=
 =?utf-8?B?SVpjeVRyaGllUnZmbDBpNVFCbmZ1cHo4QzZabXQ0Qk5FODJrY0RWblVnNEo2?=
 =?utf-8?B?ZWM5a25HeFhKZ2wvY0ZHVGJYaEhRclJONkVpc0VwRHJhenV3UjJZRUtObTdU?=
 =?utf-8?B?bTZ1bkF5bkVxcnVPNERrdFVNTzdnZDVBNXFEUjdaRVRPUTR1OFdIbnp6Y0RU?=
 =?utf-8?B?WjQ4VVQ4T05odWpnV2ZUelJ6Y052T0ZkaXE1b0Nmc2IzYWtIbzZDNU5GbmRN?=
 =?utf-8?B?b3R4WXlUMTArRmxjcTdBaHM0b1hCVFFsRmI5cVBDbm4rc3NOSFNZMEtid2Yr?=
 =?utf-8?B?c0FNMmZHamMvYml2MkJKZTBGNDNhZ0JXbU53MkVYZWp6V3Y4L3hld0ZtckF6?=
 =?utf-8?B?aGx1NUFOb1JCblE5UUlLYUZIZzI0azdWSmdSY2JqU0V5bklNRkcyN1hEZXR0?=
 =?utf-8?B?NUdVQ3p2aWVMSytWKzlSNFB5eDkwOFRsdlB0OGFSR21qWW13ODBPZklCRTBw?=
 =?utf-8?Q?6lTHHUv5q5c=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB4015E734840C6AF1E0D1F4DAF2760@VI1PR04MB4015.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(346002)(39860400002)(51914003)(199004)(189003)(105586002)(31696002)(81156014)(81166006)(25786009)(36756003)(26005)(66066001)(305945005)(71200400001)(71190400001)(8676002)(478600001)(14454004)(102836004)(4326008)(106356001)(6246003)(7736002)(76176011)(52116002)(4744005)(54906003)(97736004)(110136005)(316002)(6506007)(386003)(486006)(31686004)(68736007)(5660300002)(6116002)(3846002)(2906002)(11346002)(446003)(2616005)(476003)(2501003)(186003)(6512007)(53936002)(6486002)(6436002)(93886005)(14444005)(256004)(86362001)(99286004)(66574012)(8936002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB4015;H:VI1PR04MB5629.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oC9zx0zcjcXnW1e/HW8pDEDJNYp92c3BTemwgwkEs3tNSIOWsKKf8qqGWoSjQ6nO9rm3iMKw/JZaSOC91IvbzaX32HAl5KYHPZEVDO5Cxi09GhB8XQdGmVjp1UTuhhb5upLfUvLw8oSNrG+W0nZ6WiNmoN0eb8cNYgkdydIlAKBL5wJ5r6114a1winThMrhkrlqAHTOjF1FEL/jl/LJmLgRO1A6XC2Vli8wtADT3zTJ0sPvz4N+54mAL7PKzv/QwMpwg2dHMnVBZX0TmUUeSu/TZ5OOJaB9nlcFcgzHYYT8n6oI3p4D/FELGSq2cs74Jc0MVWw9Z0tRlI9WYrvthMeFpEq3YNDkFBSm3+3S21oipsatY/GRkZqZuir3Wtx+AcrujvgW+MCBLg5MS4Cjw4A1VowbHhaSI4rIrH+b6Aas=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E985F7DEA1A37548B830DD81173DBECE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4aabc4b-106c-4498-833f-08d69e5f0192
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 16:00:20.6805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpMZSAwMS8wMy8yMDE5IMOgIDE2OjU2LCBKYW1lcyBCb3R0b21sZXkgYSDDqWNyaXTCoDoNCj4g
Wy4uLl0NCj4gSSB3YXMgdGhpbmtpbmcganVzdA0KPg0KPiBpZiAocHJpbnRrX3JhdGVsaW1pdCgp
KQ0KPiAJc2NtZF9wcmludGsoS0VSTl9FUlIsIHNjbWQsICJyZWNlaXZlZCAnbG9naWNhbCB1bml0
IGZhaWx1cmUnIGZyb20gY29udHJvbGxlciBmb3Igc2NzaSAlZDolZDolZDolZFxuIiwgLi4uDQo+
DQo+IFRoYXQgd2lsbCBnaXZlIGFsbCB0aGUgbmVjZXNzYXJ5IGluZm9ybWF0aW9uDQoNCkknbSBw
cmV0dHkgbmV3IHRvIHRoaXMgYXJlYSwgbGVhcm5pbmcgZnJvbSB5b3XCoCA7bykNCg0KSSdsbCB1
cGRhdGUgdGhlIHYzIHRoaXMgd2F5Lg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCkVyd2Fu
LA0KDQo=
