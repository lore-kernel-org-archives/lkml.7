Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA56CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1227A204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jabil.com header.i=@jabil.com header.b="V5EIDtRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbfJ1Lh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:37:27 -0400
Received: from mail-eopbgr740098.outbound.protection.outlook.com ([40.107.74.98]:29424
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfJ1Lh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:37:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgtB6klRgTZj4ZzhNw9tvDfNeGtpTOpNPcGzWRRunzKz7N5H76Y1LHnFr89oFU/Mdxj35wJ7piRvZKpOjsakau3HQzehwrBapzdK/cRp3Mo0R1JU/w20pT9ADbNoHxww7s0Tvmb8wM3SufWv0rBRi+gALnKNL4PmnE/j2YR7WxtGmtIrHu83R4IkTkdWV8s314So5qRDyRjdXjlsi9rbPpcGIQMn7gKUfCEtaMfCfZoC6FuiyA+NgUL3yVJfWeakBJP2/M73AUmEc1hLrM13XDlvtqxNz8FwINv/Y8RD08wK/QCdiD9ZAF8rfhFX+AC7jbnNrvUFN0MqbVH8hO0vAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2Rv2WQhCFC5oQZCZmpM3mbgOHgDQxhEkI3YawEEU5g=;
 b=S/q29C/984Azz3v9P+opVmyb7R3Jm67QkMXAGTcUHxn+DaClJR7e73Ik2vqjEcLQuzxNl/In7pMkjrcJLEEzkBX+/tdfT+Gi5bkzETQg4kwHs10thpbQQKo+DPMVNON00W4B7jcbIa6B4HXvXcRKhfD90O5bmY9sDyLVrXyu5WuLNyuPmRAGfv5MyAIIGCRxCUDah2omDepLrvFMoyUaVJ9l+PftyVwwt/ZxnAujUTl+qQNy9NDAVhmRkQG3ucyWj1/WGDBn0LLoZB6oAmfR5VFlPvZFaO8TxSL7jc9ZKwVon6N5lFWreYZ8HeAkZDUNSSJSj4JoUvWxMaX3MtdTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2Rv2WQhCFC5oQZCZmpM3mbgOHgDQxhEkI3YawEEU5g=;
 b=V5EIDtRuT3p1+iNziHIyTkrbL+/B/WZ+VFC9MC2JuCQBzoK8kOJD2msH15moRqo2OJvnqC0UzQmpiXX3OZ35nqJzXFZpSEdxIo5HjUx3DASKGU0v0gHTOA1+Rd3z4ibrFC0xRR01xyMZxAKd3SIPJAXXI5F1K4o5X9PxivZCU+A=
Received: from MN2PR02MB6703.namprd02.prod.outlook.com (52.135.48.83) by
 MN2PR02MB6224.namprd02.prod.outlook.com (10.255.7.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 11:37:24 +0000
Received: from MN2PR02MB6703.namprd02.prod.outlook.com
 ([fe80::524:774a:6751:7177]) by MN2PR02MB6703.namprd02.prod.outlook.com
 ([fe80::524:774a:6751:7177%5]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 11:37:24 +0000
From:   Rain Wang <Rain_Wang@Jabil.com>
To:     Jean Delvare <jdelvare@suse.de>
CC:     Guenter Roeck <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH] lm75: add lm75b detection
Thread-Topic: [PATCH] lm75: add lm75b detection
Thread-Index: AQHVjYQRSTbeqfkrsEiXG4VEtvamlQ==
Date:   Mon, 28 Oct 2019 11:37:24 +0000
Message-ID: <20191028113717.GB10006@rainw-fedora28-jabil.corp.jabil.org>
Reply-To: Rain Wang <Rain_Wang@Jabil.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.230.226]
x-clientproxiedby: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To MN2PR02MB6703.namprd02.prod.outlook.com
 (2603:10b6:208:1d2::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rain_Wang@Jabil.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 46c077de-e0e8-41b7-1e4a-08d75b9b33d3
x-ms-traffictypediagnostic: MN2PR02MB6224:
x-microsoft-antispam-prvs: <MN2PR02MB622499313117ECCB045FBE678D660@MN2PR02MB6224.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(52314003)(52116002)(102836004)(14454004)(6916009)(3450700001)(33656002)(8676002)(71190400001)(71200400001)(81166006)(6506007)(1076003)(26005)(386003)(2906002)(6512007)(229853002)(8936002)(316002)(81156014)(486006)(9686003)(4326008)(6246003)(6436002)(256004)(14444005)(6486002)(99286004)(66446008)(5660300002)(86362001)(66556008)(478600001)(66476007)(80792005)(25786009)(66946007)(64756008)(7736002)(186003)(103136001)(54906003)(305945005)(476003)(43066004)(3846002)(6116002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR02MB6224;H:MN2PR02MB6703.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: Jabil.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VpAd2diEHNHbOZQA9W/wRj1wo0uoizmt8QPiDBsen9bsXLer67HQhDT/vaS1ibFtOfUc7UkQSiOfWe5mwQNDG7Xu/0bMsx76tLFkWLovsQLMzncJTlvX/4P86MUZs5cSVke/SnjshfcLGE7ae4OUaQ5PdA8VrQGtaL7a+0z+EExklJfDcBj8z8sWpFalt0kFaxc+GOvQIFTrBdbchrZOSrbi6PrvqXeuHe9RX3HCJ5O5jojxjxIGGio7otgUaNMsVkpF3yldFEE58ZnbWq5Ra5Ets3PhDToUyENKACtXeAFIfdDo+tw0cowVIBfXvj/89sR4aQDbONvr+4LMJAUxnNuTava5KDKyl6tDHZyGLEPd1yC8Wv0GJW5e68d+tjqz1pT4WODlHjCRenE7ZXd2utrhZnv8Lzq285Ymac+tDk0UzgxtAov3sVGJLqpv03Ly
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB288F74DE738940A02A1E6305AFB442@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c077de-e0e8-41b7-1e4a-08d75b9b33d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 11:37:24.5837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLWMU+iLY1nUpTQaDpyXWwIgdUlVQu7tLoSx9+6UoS+t6bCYCox4pfDONipHLPXPPUNVvBLVR6tgn9pSofnNfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please send hwmon-related patches to the linux-hwmon list.

Sure, will do in future.

> I'm positively certain I don't want this. Ideally there should be no
> detection at all for device without ID registers. The only reason there
> are some occurrences of that is because there were no way to explicitly
> instantiate I2C devices back then, and we have left the detection in
> place to avoid perceived regressions. But today there are plenty of
> ways to explicitly instantiate your I2C devices so there are no excuses
> for more crappy detect functions. Ideally we would even get rid of
> existing ones at some point in the future.

I understand the concern, but there could be scenarios device tree doesn't
apply while some dynamic detection is still a valid requirement, not sure
maybe I'm wrong from beginning.

> This patch is bad anyway as it only changes the device name without
> implementing proper support for the LM75B.

This is only change we made just have our Intel C1516 board with LM75B sens=
or
working anyway, while majority common features of LM75 just work.

Regards
Rain
