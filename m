Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20212C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BB62064B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JStm/axj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbfDQXuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:50:44 -0400
Received: from mail-eopbgr1310122.outbound.protection.outlook.com ([40.107.131.122]:6391
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729331AbfDQXuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09xmkmPAM1NQzKiHAXMyXjMERVGRbkhd9A9b9x8qSCk=;
 b=JStm/axjs61YN4vCOh3J9sAa0K28QHY34lssTMS9KV1ZxRAPnMeffyL//oGs5Wej/Bfyj0LwsLedBzgHw4ziupicxsiwIrItWBGJxbQKDY9LJgxFVvJieWYY+oycuP/ZNLtaGsPDYrj9ZcWSmaOeDEmIuTDZznDZoPWnrKVJrLY=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0156.APCP153.PROD.OUTLOOK.COM (10.170.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.1; Wed, 17 Apr 2019 23:50:33 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::9810:3b6b:debd:1f16]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::9810:3b6b:debd:1f16%3]) with mapi id 15.20.1835.000; Wed, 17 Apr 2019
 23:50:33 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        vkuznets <vkuznets@redhat.com>
CC:     "riel@surriel.com" <riel@surriel.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH] smp: Do not warn if smp_call_function_single() is doing a
 self call.
Thread-Topic: [PATCH] smp: Do not warn if smp_call_function_single() is doing
 a self call.
Thread-Index: AQHU84XIPd58XT1sd0attup0EFB40aY94IwAgAFaENeAAcu70A==
Date:   Wed, 17 Apr 2019 23:50:33 +0000
Message-ID: <PU1P153MB01693370A9E788356ACF989BBF250@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190412235341.29379-1-decui@microsoft.com>
 <20190415122128.GO11158@hirez.programming.kicks-ass.net>
 <PU1P153MB01695FDC44C6A2C32C7FB887BF2B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190416093123.GR11158@hirez.programming.kicks-ass.net>
 <87o9562o3w.fsf@vitty.brq.redhat.com>
 <alpine.DEB.2.21.1904162206590.1780@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904162206590.1780@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-04-17T23:50:27.8688937Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9c48e79b-e876-4de9-8560-bdf2873f6f5f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:d44c:40cf:3a0b:db6f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b32ce858-a9ad-4fab-94c7-08d6c38f7b65
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:PU1P153MB0156;
x-ms-traffictypediagnostic: PU1P153MB0156:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB015607406904EC4F564E4200BF250@PU1P153MB0156.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(136003)(366004)(39860400002)(51914003)(189003)(199004)(86612001)(7416002)(486006)(305945005)(2906002)(14444005)(11346002)(446003)(7736002)(256004)(476003)(229853002)(316002)(6436002)(22452003)(86362001)(71200400001)(71190400001)(6116002)(74316002)(54906003)(46003)(99286004)(110136005)(33656002)(68736007)(8676002)(8936002)(5660300002)(8990500004)(10090500001)(81166006)(81156014)(52536014)(7696005)(76176011)(186003)(93886005)(102836004)(6506007)(4326008)(25786009)(97736004)(55016002)(478600001)(14454004)(6246003)(10290500003)(9686003)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0156;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CY1yYAKd/sPKe6Aa/DuyxfYrBpATqzUkEMqZRftuA4NNWZ728eHrnvfZJa/oh+HMua3/O75dQ69OByOApolxkEJSBkqAWhvNisjfsQ+MW8ZFojMkyvQe0kVRNrjUOiCEcqJieZk4FWbRrejbGKBACWGtWXzIrBh8uRDfbmSXYOZEHtqncqcBpJBoRMLeBcuxfgp4PF3qsCUDNGjBUqQqrZsWsjagC3Yx6XDqvbUNpxs/OKnI08EtICaGT2bYXKJo8JOtfIGWnNgY2BXF7YistDofaAb8TZIckG9zSVbhq7TezpccIg8gK4iEo2i4RzsKAhqqfOAtDOIqSytVHJbAesfzvOYeijL3o8Ue/lp+Tgxh/ODHPka7OzEEmGkdPXkMdpcSWL2QMRj10t0eWT1fNCNR+cZtAr3TG5hHX9COk90=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32ce858-a9ad-4fab-94c7-08d6c38f7b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 23:50:33.1161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Tuesday, April 16, 2019 1:13 PM
> > ...
> > True. And before we start digging deeper into this, let's step back: wh=
y
> > do we need to do clockevents_unbind_device() on hybernation? Can we jus=
t
> > disable the device and re-enable it back on resume?

We do clockevents_unbind_device as part of hv_synic_cleanup(), which is
called as a CPU hotplug callback: see vmbus_bus_init():
    ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
                        hv_synic_init, hv_synic_cleanup);

Yes, it looks the right thing is to implement the suspend/resume callbacks =
of
the clock_event_device. Thank you for the suggestion! I'll look into this.

> Yes. That's the right thing to do. Simple solution is to implement the
> suspend/resume callbacks on the clock events device and be done with it.

Agreed.

> > Actually, all usages of clockevents_unbind_device() in kernel are
> > limited to Hyper-V and with Michael's patches moving this out of VMBus
> > driver I think it can go away completely.

Thanks for the heads-up! I'll rebase to Michael's patches.
=20
> Correct. There was a driver which required that, but that's gone by now a=
nd
> of course nobody noticed that it was the last user. The reason why this
> exists was to allow switching out an active clocksource similar to the
> sysfs unbind file but without user space interaction.
>=20
> 	tglx

Thanks for the background sharing!

- Dexuan
