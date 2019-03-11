Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512BDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F13206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="ah1lZjlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfCKQnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:43:41 -0400
Received: from mx07-00287e01.pphosted.com ([91.207.212.151]:30144 "EHLO
        mx08-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726625AbfCKQnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:43:40 -0400
Received: from pps.filterd (m0111311.ppops.net [127.0.0.1])
        by mx08-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BGe5ar002041;
        Mon, 11 Mar 2019 17:43:28 +0100
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2050.outbound.protection.outlook.com [104.47.9.50])
        by mx08-00287e01.pphosted.com with ESMTP id 2r459fhy85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 17:43:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkgEHWypkMkmLeVUxgvfkHX90G83vB0n+v/DX7fAjrM=;
 b=ah1lZjlcM5YNWduRWVXcoQ1QTEHel+CtpqhJ/7vHWVYKYO0DLrN6E85tqarabpROxFITnUyevXKw5OOiQBGsAw41wL2av7cKjW8wdxO0M4Wd6fuqcA/ssEiTvlo+LISfbFa810nxG+lR63us48x6wFe9BbOpCHIm4LxI7UL3zv4=
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com (20.178.125.158) by
 VI1PR04MB5805.eurprd04.prod.outlook.com (20.178.204.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 16:43:26 +0000
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::4574:93ab:72b8:d1ec]) by VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::4574:93ab:72b8:d1ec%3]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 16:43:26 +0000
From:   Erwan Velu <e.velu@criteo.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Erwan Velu <erwanaliasr1@gmail.com>
CC:     Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "esc.storagedev@microsemi.com" <esc.storagedev@microsemi.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Topic: [PATCH v3] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Index: AQHU0Ej71hFBJ8QqukmW6H53WkBkdaX+5ShZgAfNU4A=
Date:   Mon, 11 Mar 2019 16:43:25 +0000
Message-ID: <21c537b9-5d45-d170-cfdb-d49a3e36b924@criteo.com>
References: <1551455797.3334.6.camel@linux.ibm.com>
 <20190301160806.16099-1-e.velu@criteo.com> <yq1y35rzz31.fsf@oracle.com>
In-Reply-To: <yq1y35rzz31.fsf@oracle.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0098.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::39) To VI1PR04MB5629.eurprd04.prod.outlook.com
 (2603:10a6:803:de::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [71.6.57.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9290844-1ea8-45b9-cd21-08d6a640ae7e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5805;
x-ms-traffictypediagnostic: VI1PR04MB5805:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI1ODA1OzIzOktsWmM3czlLcjFhSzZHemRRQkJHa2JXMVJ4?=
 =?utf-8?B?eUF3bjdOM2lTcWF0bmVZK3NMQUVaMENDTmNCUnl3dWNoVkZZekdLVUJlaWZ1?=
 =?utf-8?B?cXFnS0xyMEtmcHNQVG5QU0FYQ3R5cC9xYTlkSFllY1RFR3ZEQzRldnZQZ1Ra?=
 =?utf-8?B?UVNoMXRoVlRFRmxwMXMzbzUyZTZ5TFlhTmJBZGFZRGNkaE0yMExYVnFYR2hK?=
 =?utf-8?B?QWNWZ3VISGNCeTJSbDRNRmRRcXg0RldjOGpDZVRLalVsWWtSYitNZE5hM2xK?=
 =?utf-8?B?S2NTR1FGME0zL25ZejNFT1djUGRnWm9CYnNhUWIrTnNDMkFTWnd4ejBOMERl?=
 =?utf-8?B?UWtPeWhMQmxQT01McjRRcjd2di9mb0grc1dLajM4WFFIcTVSOEpib2YwbTht?=
 =?utf-8?B?UklIZHFkQ1haN0xHYitFL1F6blBCS2JDSXg2MnV5M0RiRndOcGhQSm1YTS93?=
 =?utf-8?B?Sy9uRklrZVRxL0JZOXJ0bjBpRGY5aCtJa0NHeE5LM1QvNlJGYUEzRGVzYnNw?=
 =?utf-8?B?Q1FsalgzK2NyS3dtV2puNy9pQk5Gd3RVSjhpWmhhRFV0ZjR2QTJaSEFEMnpQ?=
 =?utf-8?B?QzNBOXIvMGVhSW9kY2w0dlJ5S3JJQTErOGMydUpTYkM1bFZzY2pveWlmamg2?=
 =?utf-8?B?d2E4M1ZYR3Qxb29UTVpsdDRnTlJzNkVuaWVoUjJoNWtINFBsR2ZRWlQ1NVJY?=
 =?utf-8?B?Y1dGZ1FFS3poR0tGVUZKOWZncGNpYzV3am55YTlQNHdMOXF0S3V2VFdxb2Vl?=
 =?utf-8?B?dldnQ2d0SFFwMXNJdmtEK1h2SXdadUlLSjNBTXRTbEdJb2c1M2FMQjBDd09Y?=
 =?utf-8?B?TFErQlVyZXBHN1VhVXlNY1NNZGh3dk9TcGRNb0t5YTVGY1NDb1FoQ3RjNzZt?=
 =?utf-8?B?alpjT0orWXdCVkxCUzRzVVN2ck8zY085OWtrVGZrNzk4OEZUcEpUYldMSVBR?=
 =?utf-8?B?Mlo0MGFIVjAwekRMK0cwZWRyWTlZdDR6K3dDYVd2SWtNdzYyMEZKYTRGV1Jt?=
 =?utf-8?B?WmhjM0M2UzBISFZMd2Y5dHF4V3dScERvVW5rMW1vVDU0VHQwbG5rZVlFL1l0?=
 =?utf-8?B?QzEyakczVm9OS3l6bU9tb1A3OUpid3REM1F6c2cwVm9jRGxTcHNmN1J0Z3dK?=
 =?utf-8?B?RWJYcW5GVmJaWTNKYXNSR0J3YjZ6d0FnT09aUE5zeEVOeWFXTXQ5eGt5SnhE?=
 =?utf-8?B?aHBRUXlWRDk1b3RLbVZzM0IvRDd2Q0pEN3psM0N5OEhvZGppdVN0ZmVSR2hl?=
 =?utf-8?B?NzJOVVlFL3l0ODN4NTRNYThWY1I1c2JLRjVqNFllOUZ1OHM0LzFaV1RWbXp0?=
 =?utf-8?B?dlBTaEJnYmJOaVNMdnNPbDJmVWUvZVV5N3BiYkJvWHB0Q05HcUxqeXU1Uyt0?=
 =?utf-8?B?TUl1RDVTQzd1UG56OWQvVUQxOTBvalRRSUNiblhnT0VEajJSTTVGSlR0d1dQ?=
 =?utf-8?B?N2c0eStxcytiZXZaVTdpbFltbnpKY2I2LzBZaHMwNFd1VGlzanRacWhjV3Rx?=
 =?utf-8?B?dk84RmFtYytlTXVyRlRmSWkyNHFvZHlScGJDWUhTMGUzOER4VHNETm9MYkp3?=
 =?utf-8?B?RXFxL09KQjlpSXcvQ3RJTXJ1VCt3aGJLY0MxVC9sTGFhWEpDbTB3MUZidVZt?=
 =?utf-8?B?R3BKK08vR3FvQVlyNVBZZGNjUWhTNjZEQ2ZVQ1lBL2hRR0hCYXo1QmFFWHpS?=
 =?utf-8?Q?VM+jjysbAsRA7412+afWCk29lePTy+tUW3tEWEU?=
x-microsoft-antispam-prvs: <VI1PR04MB5805C531028D28A1A5DC4764F2480@VI1PR04MB5805.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(52116002)(5660300002)(71200400001)(4326008)(71190400001)(102836004)(86362001)(6306002)(14454004)(31686004)(105586002)(99286004)(106356001)(6436002)(386003)(97736004)(6512007)(26005)(6486002)(53936002)(6506007)(31696002)(229853002)(478600001)(36756003)(76176011)(316002)(7736002)(476003)(2616005)(6246003)(8676002)(25786009)(6116002)(305945005)(11346002)(81156014)(486006)(81166006)(8936002)(256004)(186003)(446003)(68736007)(110136005)(54906003)(2906002)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB5805;H:VI1PR04MB5629.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2+53mw8ov6S2UGWAIwmQCSKxNw6aqjwN2PXTZJny3cCAbx3/SToP4YuDklxh7c2Rsnw+T2YA0ThFgvQtpz/53iGloCwieAIG2qsKGjTEQ8PB1orqm4YkRHu7KO+jBR5bLKgN2tRV6xx8ba3Fw/b+Ghv9rKn4TkQrxxLjYnhVJjRWsOy6/pXsfvJVl+KcIxUzlQgPZpxCvtfA6c5cVJwtINpYKknLBvYO1CShAoJDsrAJl1W0BiATx/LBhWrbCjf7uNme8c2Fy3kJvBRlcGLih6SP8sbNNdtQPwzlhdC/jS12IP9nc4KuPcafXB3De20dLwUCdVA+aTv1KAnJr/Ni4ZPUz+AhDb4Zz0qgBSmJaL8fDhTZrtrl1hY8JMDRVCddBLviUdEvv54gEPd8tMRISKUelvABXuncdYMnCMBQZpc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD45D42A682DC942A47EFE49D959C8CD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9290844-1ea8-45b9-cd21-08d6a640ae7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 16:43:25.8989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpMZSAwNi8wMy8yMDE5IMOgIDE4OjM0LCBNYXJ0aW4gSy4gUGV0ZXJzZW4gYSDDqWNyaXTCoDoN
Cj4gRXJ3YW4sDQo+DQo+PiBXaGVuIHRoZSBIQVJEV0FSRV9FUlJPUi8weDNlLzB4MSBjYXNlIGlz
IHRyaWdnZXJlZCwgdGhlIGxvZ2ljYWwgdm9sdW1lDQo+PiBpcyBvZmZsaW5lZC4gIFdoZW4gcmVh
ZGluZyB0aGUga2VybmVsIGxvZywgdGhlIHJlYXNvbiB3aHkgdGhlIGRldmljZQ0KPj4gZ290IG9m
ZmxpbmVkIGlzbid0IHJlcG9ydGVkIHRvIHRoZSB1c2VyLiAgVGhpcyBzaXR1YXRpb24gbWFrZXMN
Cj4+IGRpZmZpY3VsdCBmb3IgYWRtaW5zIHRvIGVzdGltYXRlIHRoZSByb290IGNhdXNlIG9mIHRo
ZSBpc3N1ZSB0aGV5DQo+PiBhbmFsaXplLg0KDQoNCldoaWxlIEkgd2FzIGRlYnVnZ2luZyB0aGlz
IHNjZW5hcmlvLCBJIHdhcyB3b25kZXJpbmcgaWYgc29tZSBvdGhlciBjYXNlcyANCndlcmUgcG9z
c2libGUuDQoNClRoZSBjdXJyZW50IGNvZGUgaXMgY29uc2lkZXJpbmfCoCAoc3NoZHIuYXNjID09
IDB4M2UgJiYgc3NoZHIuYXNjcSA9PSANCjB4MSksIGJ1dCB3aGF0IGlmIGFzY3EgaGF2ZSBhIGRp
ZmZlcmVudCB2YWx1ZSBoZXJlID8NCg0KVGhlIHNwZWNpZmljYXRpb24gKGh0dHA6Ly93d3cudDEw
Lm9yZy9saXN0cy9hc2MtbnVtLmh0bSNBU0NfM0UpIHJlcG9ydHMgDQpvdGhlciBzdWItdmFsdWVz
IGxpa2UgQVNDUT09MDIgd2hpY2ggbWVhbnMgYSB0aW1lb3V0IG9uIHRoZSBsdW4uDQoNClNvLCBk
b2VzIHRoZSByYWlkIGNvbnRyb2xsZXJzIHN1cHBvcnRlZCBieSBzbWFydHBxaSBjYW4gZ2VuZXJh
dGVzIHRoZXNlIA0Kb3RoZXIgdmFsdWVzID8gSWYgc28sIGhvdy93aGVyZSBhcmUgdGhleSBoYW5k
bGVkID8NCg0KSSB3YXMgY29uc2lkZXJpbmcgYXQgbGVhc3QsIHRvIGEgc3dpdGNoIHN0YXRlbWVu
dCBvbiBzc2hkci5hc2NxIHdpdGggYSANCjB4MSBjYXNlIG9uIHRoZSBjdXJyZW50IGNvZGUgYW5k
IGEgYSBkZWZhdWx0IG9uZSB0aGF0IHByaW50cyBhdCBsZWFzdCBhIA0KbWVzc2FnZSBzYXlpbmcg
dGhhdCBhIG1lc3NhZ2UgZ290IHJlY2VpdmVkIGJ1dCBub3QgaGFuZGxlZC4NCg0KVGhhbmtzICEN
Cg0KRXJ3YW4sDQoNCg==
