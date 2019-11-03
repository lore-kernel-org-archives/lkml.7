Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE2CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 20:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C3721744
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 20:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KNYR2v1q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="g24be1C2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfKCUON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 15:14:13 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2664 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfKCUOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 15:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572812054; x=1604348054;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TPR2Ja254OcNAjqJYZIR6qF4CTahRKAttamanF+Tdz0=;
  b=KNYR2v1qydEe7HXHUNguwCMyZrEkTgc1cWbbGdWK8mr5d2y/wXutySy9
   7dMBf4LfbzpbgPjnYxK9Qjm4Key7G6zqvGPiNKW6yrSUgbb7iJ2Pk0LTc
   G888onyT6fdnJROn1aj6jKZcV1om1MjGtDjxNbg4YMNpT+QYW1GlhEDWB
   BKM8SLREeF3D36uELDYM1NgLlwe4fIibjf2HJ9P5rLSCPwrpz+04LTNYg
   a11uC0r3NmU8wVHv0aj56cklKrhra+LGoD+4QHyh4q9pKfjyWHfZPmBpc
   T++W3YeUTlmE8/CSBrEa32jKCIVLwVdOOiOaIYoXfmVhs1qlCJwKNY9zz
   g==;
IronPort-SDR: 6u4hlUp1WsJroJQ7v4U07w3MfBVaHeEeOWAOiQNiti8dEvNo7fv+Qyo9svyesgHSALefMiNDVu
 JTucqC1z5F1nDIx924gsoYgrCqyTCfyaZaqxFe8OJb1isfeaLHQmWJ2F5L56ee8L0UETlskr2v
 /0T4RQm7tZPRpuYA2xyikHSPFNP3gUC8x3dZxvOVoZ36Kf7qw+fSnvLNSCxwmrFjsQ0Pp8Ox3N
 S8EqQtjfx+te0D6+pdDN9467fOdYjUjmNoYgAW0ZIOYkhGYb7ftVXkIf/qZuBUQ3+M9CHy/jQ3
 zNM=
X-IronPort-AV: E=Sophos;i="5.68,264,1569254400"; 
   d="scan'208";a="223189753"
Received: from mail-bn3nam04lp2050.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.50])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2019 04:14:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfWm0BEmWyqR4s5XWsYDaqNgypjTI9qy82C/ZR9CYn7iL560lGouMHSlEqjvqAhuUOl3UtUFP5kyt6mfzX+KVr4QqYzHcD1z/6gHAdpVk4pWcCR5WOEFXEZ4TbDKERTQw3ElWfTi7//+rhVJ5kkdnk+ul1QPOho3HpRO9vRSDQBH2Wlkmsb0uRak28EislEX0qo5F2AS8UUm+z2yqlCSuGr1Eqgh1wcmzzxXJYZ9N6pQ7f+k4wID6VEDveAeW/vFAt5Y0pStZU6BM3eprjLPCb04Wxd0pewo9CQ8Y5sRGnHvxQ2suj6EKkz4oPSAKQbV7H+f8eEaBQBa3/sxUe19Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPR2Ja254OcNAjqJYZIR6qF4CTahRKAttamanF+Tdz0=;
 b=DI02RagDYhZlg5owsCGKcRSym7hZT3QK3dS1bTNu3rFizf+94aZxukXD5hoOo4mjcLoGNtijgIRezaA5Hhu4mneCYm/B+GAnAOBUnDVMuY4VZSRk1aErLxCOg1+LzfX1974ywH7cZuV64in2DtFVhPd9pFKlYST8FmSKSOLhSf6ou6EbvC4eRjfTloFt3laB4EVdV+2f554QGcCuHlxvaO5/XvMht51ZgfbM615LM+xV28lAiNQeYcB8E5RacpgNa2aHEgK1h9s0bcsXOlSMsOXKiGmprxI48pntojmVJrgfOkegzgxWrCwRyiyIamS0kgs1jQIY8ot0bynmuC+niA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPR2Ja254OcNAjqJYZIR6qF4CTahRKAttamanF+Tdz0=;
 b=g24be1C2whit+N00Kw8cblhR6vkGqakmVFjwWFGoxmviv0Qw3W4atU/z1kWrj0wPTU6Z5Z7IRRowiLa8vVZiIsvdViVlfCQfrduJkKWEToNNLMM0Y3pR0lY+UJpHdYhmsCqFalC2tNtnofnoqsfw4sPbvHjpefeYlzZU0ei0QsU=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB3781.namprd04.prod.outlook.com (52.135.213.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Sun, 3 Nov 2019 20:14:09 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2408.024; Sun, 3 Nov 2019
 20:14:09 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC] nvmet: Always remove processed AER elements from list
Thread-Topic: [RFC] nvmet: Always remove processed AER elements from list
Thread-Index: AQHVjzYhgmqnvQGm+02Suay/wXEq1Q==
Date:   Sun, 3 Nov 2019 20:14:09 +0000
Message-ID: <BYAPR04MB5749B6370CC8DECC4DABF702867C0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191030152418.23753-1-dwagner@suse.de>
 <20191031145127.GC6024@lst.de>
 <BYAPR04MB574907EE2666D6DA48DE30AD867C0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <BYAPR04MB5749D02B62E8F4BB12F8DB9A867C0@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f4ec2f5-8646-4a89-0bc8-08d7609a6289
x-ms-traffictypediagnostic: BYAPR04MB3781:
x-microsoft-antispam-prvs: <BYAPR04MB3781F0B10608152D6AF9C22A867C0@BYAPR04MB3781.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0210479ED8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(76176011)(26005)(558084003)(256004)(186003)(14454004)(7696005)(66946007)(33656002)(305945005)(2906002)(7736002)(478600001)(476003)(446003)(6436002)(86362001)(81166006)(4326008)(8936002)(229853002)(81156014)(66066001)(8676002)(66476007)(76116006)(66446008)(64756008)(66556008)(5660300002)(6246003)(486006)(74316002)(102836004)(52536014)(6506007)(3846002)(6116002)(55016002)(53546011)(110136005)(71200400001)(54906003)(9686003)(71190400001)(99286004)(316002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3781;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7CM4xYTW9IZJDXlXQY6s956H+zRUJvZrjUlzCRCgtEPKR6apcPfnmt8ZUfJWOQFoBuWAz2mdZ+cvg7QkZ8D49bjpXpHWCDIGogEJSsyeoMg5NqQGodQakf+OlzRJBBMx9u5sV3biq3Gab07AmTFtkLFTmjFkwmThvWBzvdCHLVuO2gFkP1jvXI8cTT7z5nQrhssq6DZXaGT4rIe9A65uzgzjqqbArw3SNGkX9Ix9/9HKgxt5OaI2hLGhNcjtcQKYMJixDXXGaVeukROhNQueeQXKRubcMaVjvRRJw/cL/pwup7z2hB3Hy22nziwpGBsFZc9kJvMum2DZTKlFM8da7PpX4mqIAnr30PhQBGT9zYgdICIjiuJA2bAGpIQK5GB5OepDg+avVVQFmypicV/ZepSU6R6rTA+kbm//vwVZkqqHiqGCiNX7RDgzyIhXvqDD
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4ec2f5-8646-4a89-0bc8-08d7609a6289
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2019 20:14:09.0363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dl//aLc4PYCuK4bFPUxyweObgyWClVkU0IbkL3+rT26zABmyfcWAh+HqN7wti97iDCy4F1P8lOMDbAmH2vNJlysuAfJgp1shbAeN5gry4ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3781
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sent out a patch with fix, please have a look.=0A=
=0A=
On 11/03/2019 11:48 AM, Chaitanya Kulkarni wrote:=0A=
> It will not work as it will consume outstanding command=0A=
> posted by host for which aen is not generated yet, and=0A=
> when aen is generated it will not have command in the=0A=
> async_event_cmds[].=0A=
=0A=
