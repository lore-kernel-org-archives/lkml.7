Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40690C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C88214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KfAlM1Gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfDWRxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:53:07 -0400
Received: from mail-eopbgr690050.outbound.protection.outlook.com ([40.107.69.50]:45385
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726655AbfDWRxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjUbdGalkUVKkeYeJ96d3eHoeEhZTuaMaUuqW4xuo9g=;
 b=KfAlM1Gcn2iGcanPgGEJa1WxM9vzigluuJjZmm6ruvHfwDMl1H2GE2HTOnOlv8G0eP26vsjf5L5h/h/x+DAk4pJ97bfOe0FX9YYJ+qa/hYuFfCE/Pf9iHt9/QVNelyD5z+Rr7G/2oTDDhuOHmnMrbFwd7YSNRP1EpupPGcWfaRg=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2687.namprd12.prod.outlook.com (52.135.103.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 17:53:03 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d8ec:7415:96b0:afe0]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d8ec:7415:96b0:afe0%2]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 17:53:02 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "len.brown@intel.com" <len.brown@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: RE: [PATCH] tools/power turbostat: Make interval calculation per
 thread to reduce jitter
Thread-Topic: [PATCH] tools/power turbostat: Make interval calculation per
 thread to reduce jitter
Thread-Index: AQHU4zDAw6kMdRt2pEeSvDZqbzvAVaZKM7PQ
Date:   Tue, 23 Apr 2019 17:53:02 +0000
Message-ID: <SN6PR12MB26394D7FEE4582FD19860104F8230@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190325173232.216357-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190325173232.216357-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f169ded-36ce-47e3-37af-08d6c814883b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2687;
x-ms-traffictypediagnostic: SN6PR12MB2687:
x-microsoft-antispam-prvs: <SN6PR12MB2687E0F0F076D137A7122922F8230@SN6PR12MB2687.namprd12.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(199004)(189003)(13464003)(4326008)(7736002)(66946007)(25786009)(446003)(2201001)(71190400001)(71200400001)(55016002)(478600001)(305945005)(74316002)(14444005)(486006)(73956011)(256004)(14454004)(97736004)(476003)(6436002)(64756008)(66556008)(2501003)(66476007)(9686003)(86362001)(11346002)(76116006)(66446008)(316002)(76176011)(3846002)(52536014)(102836004)(110136005)(68736007)(99286004)(54906003)(5660300002)(6116002)(8676002)(72206003)(81156014)(6506007)(66066001)(81166006)(8936002)(53936002)(6246003)(186003)(7696005)(26005)(33656002)(53546011)(2906002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2687;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HjCyaRdpcNwq5wqbHfcrJNUxDo+AiExqVUovpPJHC6nrw8W1zplg8ylNn7Gd81za6NULb01fkqFsTAleAZMaH3ZhAVJoYCfh9n4q597PGkzqRw4woqz/Ncs6mwGJF0z41CYuiVnpeVmzpAxAJHch1OiiJkfqyBNKwKN7nrkPVRJzoE/SI9HoWWTc2dvoBg8zRb6//BAUh/p61Ew9q9txFAT0UXQ0IfwoXdNjKo3BjloV1cMjX9qi1za6aMGlriGPUCK44K23iutZc+opHbCZ3W5u5ix3bF2/gS8Cq7OLrjbAEu5ttE+XDZ/JVcDGZQ2Yu1AW1JyBTPSHtEEw3tuOxkLeb6qJ59D5sg4Wi0TWwRYMfxOhPowm3yOtLH6vong/pl+KNwevdVbXvihXLqJ4OIsMn1o+roqMtc8erR4Ne3g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f169ded-36ce-47e3-37af-08d6c814883b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 17:53:02.8596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.=
org> On Behalf Of Ghannam, Yazen
> Sent: Monday, March 25, 2019 12:33 PM
> To: linux-pm@vger.kernel.org
> Cc: Ghannam, Yazen <Yazen.Ghannam@amd.com>; linux-kernel@vger.kernel.org;=
 lenb@kernel.org
> Subject: [PATCH] tools/power turbostat: Make interval calculation per thr=
ead to reduce jitter
>=20
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>=20
> Turbostat currently normalizes TSC and other values by dividing by an
> interval. This interval is the delta between the start of one global
> (all counters on all CPUs) sampling and the start of another. However,
> this introduces a lot of jitter into the data.
>=20
> In order to reduce jitter, the interval calculation should be based on
> timestamps taken per thread and close to the start of the thread's
> sampling.
>=20
> Define a per thread time value to hold the delta between samples taken
> on the thread.
>=20
> Use the timestamp taken at the beginning of sampling to calculate the
> delta.
>=20
> Move the thread's beginning timestamp to after the CPU migration to
> avoid jitter due to the migration.
>=20
> Use the global time delta for the average time delta.
>=20
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---

Hi Len,

Any comments on this patch?

Thanks,
Yazen
