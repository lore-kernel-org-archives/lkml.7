Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02484C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAB520879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UKkidZ0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbfEMRku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:40:50 -0400
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:11326
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbfEMRku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZdm1jzS4NfYO6Ve1ZOFhIDFDQye31NCzYq2gp1Gdvk=;
 b=UKkidZ0D+VBSmeEqiMREnz4CRBbn4JCW9cq326va5+3mxqx+ykDn2UrHjUdFjDLBEVQT9yAohfKWwD0bWEs9Vbc1ZsEE4XHHac2ZiRTgix/yG4WHPeJO4buXUJRHTQtOaEtJG6yaodIQsZtBGE7fMIxaboZOeynhkMQPFvScwLs=
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2870.eurprd04.prod.outlook.com (10.172.248.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Mon, 13 May 2019 17:40:46 +0000
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e194:a71a:3497:783e]) by DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e194:a71a:3497:783e%8]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 17:40:46 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     "jocke@infinera.com" <joakim.tjernlund@infinera.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v1 4/8] soc/fsl/qbman: Use index when accessing device
 tree properties
Thread-Topic: [PATCH v1 4/8] soc/fsl/qbman: Use index when accessing device
 tree properties
Thread-Index: AQHVCaZIiomHQCI79kqjC6Wc0PXpqw==
Date:   Mon, 13 May 2019 17:40:46 +0000
Message-ID: <DB6PR0402MB27278B23001A8965AE493CE3860F0@DB6PR0402MB2727.eurprd04.prod.outlook.com>
References: <1557763756-24118-1-git-send-email-roy.pledge@nxp.com>
 <1557763756-24118-5-git-send-email-roy.pledge@nxp.com>
 <1afd837287cebccfc1dd68365870d0f5d1cf27f7.camel@infinera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a06044f-cc39-4f81-0e58-08d6d7ca216a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR0402MB2870;
x-ms-traffictypediagnostic: DB6PR0402MB2870:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB6PR0402MB28704443C1E042FF213C77ED860F0@DB6PR0402MB2870.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(366004)(189003)(199004)(102836004)(66476007)(6116002)(66066001)(26005)(66946007)(476003)(64756008)(66446008)(5660300002)(66556008)(73956011)(446003)(91956017)(6436002)(71200400001)(71190400001)(9686003)(3846002)(76116006)(52536014)(25786009)(53546011)(44832011)(74316002)(186003)(486006)(7736002)(86362001)(76176011)(2201001)(53936002)(14444005)(6506007)(256004)(305945005)(4326008)(81166006)(8936002)(2501003)(6636002)(7696005)(110136005)(81156014)(99286004)(8676002)(54906003)(33656002)(229853002)(55016002)(316002)(2906002)(6246003)(14454004)(478600001)(68736007)(491001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2870;H:DB6PR0402MB2727.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SRflkqzjBuziEhBL/L+gcsR/lDP0TMPxgmcOVGkMu/cdbSQ1QKY8KI/XCFbu7/h5MjxA0jrepdC4I5LLtGd1O6EhzbOUs/mXzloZO/MkwnYqR0xD05kFLs7wj2aqk1gbL5mUrD4btc9IAjsd/T7e+5YMP7C9IZQEg/X4SUicR2ehVE3v5WfpEIcutHnc9G/+AX3fcHL0Rmfdd9G7Z30c2Z1kzzVe3aEsmyG630Dz6WfDXK/anvmkL3xvgkFS2dxpQaCYoqVx0Mp8RUf8LDjaYnz1kEfenvydOstyTbaYBENlPoVnqg0/7M9SsYV60XVNWRwgoqO2gU4okkmfYMzJzZcSjy/d95f8YD3qL1SHZqjOWCG7N8W5LT8RIY1YJDobceBmILh+6e2bpVfbVy4F12vR4bd6VvAwnb8fFCq6rG8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a06044f-cc39-4f81-0e58-08d6d7ca216a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 17:40:46.1976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2870
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/2019 12:40 PM, Joakim Tjernlund wrote:=0A=
> On Mon, 2019-05-13 at 16:09 +0000, Roy Pledge wrote:=0A=
>> The index value should be passed to the of_parse_phandle()=0A=
>> function to ensure the correct property is read.=0A=
> Is this a bug fix? Maybe for stable too?=0A=
>=0A=
>  Jocke=0A=
Yes this could go to stable.  I will include stable@vger.kernel.org when=0A=
I send the next version.=0A=
>=0A=
>> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>=0A=
>> ---=0A=
>>  drivers/soc/fsl/qbman/dpaa_sys.c | 2 +-=0A=
>>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/drivers/soc/fsl/qbman/dpaa_sys.c b/drivers/soc/fsl/qbman/dp=
aa_sys.c=0A=
>> index 3e0a7f3..0b901a8 100644=0A=
>> --- a/drivers/soc/fsl/qbman/dpaa_sys.c=0A=
>> +++ b/drivers/soc/fsl/qbman/dpaa_sys.c=0A=
>> @@ -49,7 +49,7 @@ int qbman_init_private_mem(struct device *dev, int idx=
, dma_addr_t *addr,=0A=
>>                         idx, ret);=0A=
>>                 return -ENODEV;=0A=
>>         }=0A=
>> -       mem_node =3D of_parse_phandle(dev->of_node, "memory-region", 0);=
=0A=
>> +       mem_node =3D of_parse_phandle(dev->of_node, "memory-region", idx=
);=0A=
>>         if (mem_node) {=0A=
>>                 ret =3D of_property_read_u64(mem_node, "size", &size64);=
=0A=
>>                 if (ret) {=0A=
>> --=0A=
>> 2.7.4=0A=
>>=0A=
>=0A=
=0A=
