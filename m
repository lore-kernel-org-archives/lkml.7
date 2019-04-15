Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7B9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8311720848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="b32nZHHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfDOXkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:40:17 -0400
Received: from mail-eopbgr1300112.outbound.protection.outlook.com ([40.107.130.112]:2208
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727202AbfDOXkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 19:40:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=ZCNVMi1QJgwyVfgGIi37YL/O8BBHvVq+kuj6NuvoRwUFdWGsFHo7ivGuGhEssNCCCs78ugtoQCiByrUIPmFcIZY3N3sFrkzkV5uDpdc/4GUaRZp/MFxIUOSAKV6guOtXzxhOtvQhdJ/R2iskHynWo7zmsBayIsKbK1pm/k5NsjWaNeoSgH49pwSRVFOyXLZo8tUK13fd/Uzu2m84oF9+mrh9Y/s4bbj78gSliSsYMpLQZkwpua1oi+jHOt2U/JDTrPyVLb2YhPydiM9TxejsTEWZwakz/YszQ3JJNkuRBBrsVIPEU1FennH3aI8Gu2pK2bcCKph6jMoLVC2iKSFXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5NARdqM2lmVvMt9i9zXcxcad1KjEdoWqzTXmjzgEzE=;
 b=e00JBki07GsywuIkf/hC6vVTppu+wIwXBT0oE01K0o8sZSlCjbo14UViUFzrsl5NTH1kXT4k4ggn7iH+6FyHOW9U7u7PbJdy1TeyrsvoFtKVgWy7jLwAFQEQ1tPiml8c5yO5WKyA+0lHMIZ/r5uYOhqtNSZYfEY/Nuvd8Emm3R/9/3+Is0mEEV2/9QFp34Cx+E/jsLQDoW/Vv4ozKRiEMz7Pc01CZ1TvdMWcGhU5Zt+I4Y/ftwm35Z4iSzeBogjUK1RkCVDf/PsxHIfLEtQxgOxMxQliaaiWwIzZiWkQigWWEhs277QJCJ0RqS8t46JXVuGbOeq+sKP6XTEHwQWJPg==
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none
 action=none header.from=microsoft.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5NARdqM2lmVvMt9i9zXcxcad1KjEdoWqzTXmjzgEzE=;
 b=b32nZHHK5I/4ZwgIPUwUXVBPqaHj4MaDYunw6Ng8CIk30UmqOfaebN+A1mbS9UPWDcxjBN9n+aqihz8qeO0jbIWsnjBl7iEA2g+EjhyB2YceNuCbEs2shFDvzJrtlqiZjxLgpM7nrx2cYovwNjmcZ92fRYrIucRqyTQeLGQ895E=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0170.APCP153.PROD.OUTLOOK.COM (10.170.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.2; Mon, 15 Apr 2019 23:39:58 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::9810:3b6b:debd:1f16]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::9810:3b6b:debd:1f16%3]) with mapi id 15.20.1835.000; Mon, 15 Apr 2019
 23:39:58 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "riel@surriel.com" <riel@surriel.com>,
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
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH] smp: Do not warn if smp_call_function_single() is doing a
 self call.
Thread-Topic: [PATCH] smp: Do not warn if smp_call_function_single() is doing
 a self call.
Thread-Index: AQHU84XIPd58XT1sd0attup0EFB40aY94IwA
Date:   Mon, 15 Apr 2019 23:39:57 +0000
Message-ID: <PU1P153MB01695FDC44C6A2C32C7FB887BF2B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190412235341.29379-1-decui@microsoft.com>
 <20190415122128.GO11158@hirez.programming.kicks-ass.net>
In-Reply-To: <20190415122128.GO11158@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-04-15T23:39:54.3315002Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=49f62ccb-ea35-42ea-b712-cc1ed31dc74d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:5ccc:8ef3:4a1f:27b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ff43cbb-1fda-429a-c2dc-08d6c1fbaba9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0170;
x-ms-traffictypediagnostic: PU1P153MB0170:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0170FCCD3563E06B43C3F152BF2B0@PU1P153MB0170.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(54906003)(5660300002)(4326008)(229853002)(68736007)(22452003)(71190400001)(6116002)(6436002)(4744005)(7416002)(6916009)(53936002)(106356001)(2906002)(52536014)(9686003)(25786009)(33656002)(55016002)(105586002)(86612001)(316002)(74316002)(305945005)(7736002)(86362001)(14454004)(102836004)(8676002)(11346002)(186003)(6246003)(8990500004)(14444005)(99286004)(256004)(71200400001)(10090500001)(476003)(7696005)(76176011)(97736004)(81156014)(478600001)(53546011)(8936002)(446003)(10290500003)(6506007)(46003)(81166006)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0170;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5MuGwtUKrf6lddAOH4vsNADHf4MIpEBYQmaO1pwGKTT8jKvm9ZlpJk3cqcBh6KRrj9j1aLZjRHY/DuWJwAXeZk69dbgtG2BL33fG7ZAyPCY6Fi5naKRMdaFcWQ6olWqkJXCMl2q+9dVGCGGgsovkwsJWnVzPqJh727SztkXOY4kjGsqddbOYs6ykIIjBHRdKrNQn9eawRM4RHiAdYop89fRyNUBMNeHRo88wgUdfv+rv9Im0MqpcTvb1pmSwLlyTHEMt9f8EsAnQIBsUvRqrICocxo7CaJckTHfHirHRsmtOuVrcRfQRaDKC2DLT8t7131Ja2IsFxMyCvEgmEurfqRIYgoIh10sPVXF7zcFh3vN2jD/pkxfiq6JT4j8SlbwHG/soqUdKzXZ9DBdKRNJxEe8XEThKRzFIa3M/iUvMnlU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff43cbb-1fda-429a-c2dc-08d6c1fbaba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 23:39:57.5458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Monday, April 15, 2019 5:21 AM
> To: Dexuan Cui <decui@microsoft.com>
>=20
> On Fri, Apr 12, 2019 at 11:53:57PM +0000, Dexuan Cui wrote:
> > If smp_call_function_single() is calling the function for itself, it's =
safe
> > to run with irqs_disabled() =3D=3D true.
> >
> > I hit the warning because I'm in the below path in the .suspend callbac=
k of
> > a "syscore_ops" to support hibernation for a VM running on Hyper-V:
> >
> >   hv_synic_cleanup() ->
> >     clockevents_unbind_device() ->
> >       clockevents_unbind() ->
> >         smp_call_function_single().
> >
> > When the .suspend callback runs, only CPU0 is online and irqs_disabled(=
) is
> > true.
>=20
> Pray tell, how well do you think mutex_lock() works with interrupts
> disabled?

Good point. I realized generally speaking this patch makes no sense, so let=
 me
try the solution proposed by Vitaly, i.e. fix clockevents_unbind() instead.

Thanks,
-- Dexuan
