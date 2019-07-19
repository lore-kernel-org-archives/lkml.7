Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975E0C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D15A2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jz+RWi2W";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nCf8bFR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfGSFBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 01:01:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45286 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGSFBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 01:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563512465; x=1595048465;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hjY7onLd/nZMe5ZOrSXIqAHGPGCz5yvPcvTjI0wBtqc=;
  b=jz+RWi2WDPLMr1owt1b8EGi0XVTRBNuBJxw1ex61hyRgeA6VI7X7y1c6
   kLrGebUlwxz/PiOrG3/fj4gFuiHT4KviDNRAZDi07hbDsj+LvvkQFdi6H
   DUu4oI1Jt3vki/iPu1ooHvEX1VPH4tVVOT0a6fpwiirkH0x2MJ0hr4fIi
   9Ojf7ep2F6BsXEnPc5ov0fJR5CfuvMx3HvwVOAzZJljTE5F0iVTP3Bc0R
   +XqKuLXdAN36QqBQ3SO1s4nOa/Zkn0lc9y//fOd81BTvHdF03GuXw9JNA
   CrIu2B087FDUur0OpZFMbhvG8XAHHldfdwzmKDFRrATFsALwA87sHNSP4
   Q==;
IronPort-SDR: mG1sgHEsrxaqg2TqA79faofQ6FhsodyE8e+i3HQslPTcAAQzN5NGBaRkShmZzu3AGu04vEuH2A
 e1riIt96VYXUg8ZupCP5KVNZrKjn60oXTls35EC6JIeLE0gwZgNILhdQWu4tP5hVIQN4TuE1c/
 8u/UBenWQbSmkkBwi6jYRGRoQLmv+JiKUyxhe4ynLkyPOOO8RQF2qm955JgUGogV2NL7Hb3Ley
 J1OhnRDkGw0G1Qp5ymuhaYAmu0Qee8cAyKijIf4kY4ozZIXmQtmmodeRgFDdfBHG2SdROIyymW
 D/Y=
X-IronPort-AV: E=Sophos;i="5.64,280,1559491200"; 
   d="scan'208";a="118237891"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2019 13:01:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U084n0YmnIsAgl95WwC/3IdnoVZhMJfyVLRVetzMOzxQ3oIG0eZOvHs03EZpOmT6Sem1xaMht4h64rfcxtHIO4T/3H50m3XAeS5YMFcw5rusa5aLSyahhzNjrXFdU46brJ+UKhDademtWIoH7n9XFnomx6hRkmIPaBXS4bSA/gwkZqqfrtg22YyDpT8cvNnaGinj4BV3Af0tbjXrhinzIfZmy9qDHe0UydY/qhu4vdFg7ELfxVSewCczGzFVg2YQCcnPaWb2hRLrRu+B3NBerIZqPiGI44CCZGL+PpBVL5CNABrjNBV0HSQ3DfM8lTv+lSNhZ6R/eEFqAJO0wEilyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjY7onLd/nZMe5ZOrSXIqAHGPGCz5yvPcvTjI0wBtqc=;
 b=e2qvRAhVfzvhNh2nXkERCWxYyTKPIsL2CKzMOyvQXYcZkb1yBqYr6jK46i1bEpOvey7lJ9HhGXEuoZWAiYlBDcU0NRXDpGS8c35SlGTz3URk5MxLoA71ZWLOUnsGq1gfYBzCKwlzaa/zgzKDVqjMUTRexJkzBifUXIgLYP69aZcpUX5UYcepKNfT01z+r0kiXiAOaoAmIpFTdLzTO2oYlLsYtXDH8sCiCPMfpoXn9oKuBZUZB8vi1FzQV8lglYO1AUrYbAF41kALTYTGe7Fyx5jUKPbVmObMyhVhcWy9dbdPEPnQjci5O/gQ+UUapY05c7d54gdkr3d7p3SE5DLqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjY7onLd/nZMe5ZOrSXIqAHGPGCz5yvPcvTjI0wBtqc=;
 b=nCf8bFR1WCZoTVQSro+lvCWmkKoAXd8hTM3rbM0vja4KZZS/V4u0corDrJmkhZepoKIVEiC5hzjIR1jMuvnR1oa24MUE7/kiTrdX9QJ6VrZNtHH4d6j0d6zI2EJYEOBOEytHtFjE3G/7JhaBHWOIYxf/brmMtyhqVdol0PEvsp0=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5095.namprd04.prod.outlook.com (52.135.235.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Fri, 19 Jul 2019 05:01:01 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 05:01:01 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Pawlowski <paul@mrarm.io>, Jens Axboe <axboe@fb.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
Thread-Topic: [PATCH v2] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
Thread-Index: AQHVPeud+CKl01N5fESdJwM9xjcYQQ==
Date:   Fri, 19 Jul 2019 05:01:01 +0000
Message-ID: <BYAPR04MB58166CED3126757BEC56D3A8E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <f19ac710b4dc28fb3b59ef11bd06d341bc939f3d.camel@kernel.crashing.org>
 <BYAPR04MB58168C42A68712287F734242E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <bc856389e6b09f7c545144be0f370f7ad3b05784.camel@kernel.crashing.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a76189b9-b6dc-4d81-5e63-08d70c0618ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5095;
x-ms-traffictypediagnostic: BYAPR04MB5095:
x-microsoft-antispam-prvs: <BYAPR04MB509530D315A2F9A71659CE01E7CB0@BYAPR04MB5095.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(47660400002)(189003)(199004)(110136005)(7736002)(54906003)(74316002)(53936002)(2501003)(8676002)(71200400001)(476003)(71190400001)(55016002)(76176011)(446003)(14454004)(316002)(9686003)(305945005)(76116006)(66946007)(66556008)(3846002)(99286004)(91956017)(64756008)(66476007)(6506007)(4326008)(66066001)(53546011)(8936002)(6116002)(5660300002)(52536014)(6246003)(66446008)(33656002)(25786009)(6436002)(478600001)(7696005)(86362001)(186003)(102836004)(486006)(68736007)(229853002)(81166006)(256004)(2906002)(26005)(81156014)(46800400005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5095;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O9P5IFz45HAOwJzzbMfgrsL14xlc5RDfZx0+/sbkM0RyxeU/csIzgbkR4illU1j4loaq5IKquK8Mt1cgtbOdt1+Rk5YuM9+Tl1PKKLrtTmbcD2avbNO2Aek6R5GgUJz0boDdHWy8xOcFqQ0DrD7dP6Y9TDnQkSGv+Wl9Akfyg3SwK0M2dpijCYpr1f5y0e5E7bNbhlaftOvhcUtpS8Ns8VL18P6awQeSNX4CC1qkhT+1sTa67Mi2LtBJNSCVySk5XcHE2A007L5C+lEy/D/1eSHzye0sMFG0OQoQ2PCn31uKxzYKK59qVeCLzXYuQBRtx7v2MuK7OXx6KFQNA2ZBFZBXt0mybj0sT/ejEczl6e19Nu2TvbUTfl5MxeO7YymU07viiJKbtoXsVaMkwOfQh/EcNmgGhaXKyJ1fBCKwkMQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a76189b9-b6dc-4d81-5e63-08d70c0618ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 05:01:01.8271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/07/19 13:49, Benjamin Herrenschmidt wrote:=0A=
> On Fri, 2019-07-19 at 04:43 +0000, Damien Le Moal wrote:=0A=
>> On 2019/07/19 13:37, Benjamin Herrenschmidt wrote:=0A=
>>> Another issue with the Apple T2 based 2018 controllers seem to be=0A=
>>> that they blow up (and shut the machine down) if there's a tag=0A=
>>> collision between the IO queue and the Admin queue.=0A=
>>>=0A=
>>> My suspicion is that they use our tags for their internal tracking=0A=
>>> and don't mix them with the queue id. They also seem to not like=0A=
>>> when tags go beyond the IO queue depth, ie 128 tags.=0A=
>>>=0A=
>>> This adds a quirk that offsets all the tags in the IO queue by 32=0A=
>>> to avoid those collisions. It also limits the number of IO queues=0A=
>>> to 1 since the code wouldn't otherwise make sense (the device=0A=
>>> supports only one queue anyway but better safe than sorry) and=0A=
>>> reduces the size of the IO queue=0A=
>>=0A=
>> What about keeping the IO queue QD at 128, but marking the first 32 tags=
 as=0A=
>> "allocated" when the device is initialized ? This way, these tags number=
s are=0A=
>> never used for regular IOs and you can avoid the entire tag +/- offset d=
ance at=0A=
>> runtime. The admin queue uses tags 0-31 and the IO queue uses tags 32-12=
7. No ?=0A=
> =0A=
> I suppose that would work and be simpler. I honestly don't know much=0A=
> about the block layer and tag allocation so I stayed away from it :-)=0A=
> =0A=
> I'll dig, but a hint would be welcome :)=0A=
=0A=
Uuuh.. Never played with the tag management code directly myself either. A =
quick=0A=
look seem to indicate that blk_mq_get/put_tag() is what you should be using=
. But=0A=
further looking, struct blk_mq_tags has the field nr_reserved_tags which is=
 used=0A=
as an offset start point for searching free tags, which is exactly what you=
=0A=
would need.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
