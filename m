Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B934C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D73F206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="T1vpOZKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKRNTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:19:47 -0500
Received: from mail-eopbgr80091.outbound.protection.outlook.com ([40.107.8.91]:9118
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbfKRNTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:19:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD8tx1PPQHPoYP/i6qMatDGSbOjXYxKoMK6v0j1ofVch0lQrRr/QN8MpU9iirrKLBHw6MjljtYU39lnLWO2NS+wXF57QQktTFdsnRz9q7zpMNJogGAqqnHi+nZ6Te/Rlslw/z1srBY8MlhXwNxEOpdhml0ocaufk2rjZuvUaavqaavkKl2aFXCXUaxBLZm8HK6FyW29x1t1suVCXSB7N8BPD+L3p/H9M4ylLixg/b79qxMKVxCWIrpXJIs4D5pbCrdjb7rZcKStXySgxGENpFIlK+iDAlxOEEycAiHnL85+Thn2w0224Rpp+J3ZcDbL2YMFIkDrAaKesXxHkClNnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVcdNUDdZzL9BISfjbK/iczkWbuKyLO8RhDdVXNUsQw=;
 b=NFXkotZlr+x8/gxcbCozi4gfHjh4QYBzEStXTDr55W8I1XYhNjO5lMjjR9fFzBCPpiG/DtC4tLOKqPmn+QddTME9Tipv8HQxJOAPFbWpMtb04sDHnLJ1NMxix/4N0g+OFNjr/VQFNcmBWxxMVD4tHR00U4fAdVVF4M5UrwqM0CpVFiA68GgtAkqPPO+mGFBbwwT9mdNjwjwoumFbclJN7I8g0V0BbusnejYMhpl1mZQODdIdWOAa9KWXq8rKslL1yNOXoiFNC58bt3ZLxG0UYEiQTFbGfr+0Izeh9R+gObEMPYQQtMEN+/1k11Dd/EesCie3PEAbatXOhkOZ8viLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVcdNUDdZzL9BISfjbK/iczkWbuKyLO8RhDdVXNUsQw=;
 b=T1vpOZKLmfDCRXgYJpohqGMwVoQZUsGiJEItBo7s5M4Y7dpDdab5vnUMJ6wl1eg7cYW7kHFzwRp6nDRzU6SewKiDnnzt2CzoDNaGXqOJDVm/tTrrLbS9Fy2YJ04VzaqZnjQttjjTXntpqV3KAw7M/y6TWqHuheghdEf4ISGTHzw=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.175.244.155) by
 VI1PR02MB3005.eurprd02.prod.outlook.com (10.170.237.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Mon, 18 Nov 2019 13:19:44 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::78f1:dc96:ee1a:bccd]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::78f1:dc96:ee1a:bccd%6]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 13:19:43 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: add more protection of device during reset
Thread-Topic: [PATCH] habanalabs: add more protection of device during reset
Thread-Index: AQHVnhEGcbqRgBUu/Uez1fvSqQxNzaeQ6CtQ
Date:   Mon, 18 Nov 2019 13:19:43 +0000
Message-ID: <VI1PR02MB3054A7F6C02671CD8B383BBFD24D0@VI1PR02MB3054.eurprd02.prod.outlook.com>
References: <20191118130639.22354-1-oded.gabbay@gmail.com>
In-Reply-To: <20191118130639.22354-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51e3f491-6b4e-46e6-a1bf-08d76c29f9f3
x-ms-traffictypediagnostic: VI1PR02MB3005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR02MB30052BB3F5B7165808ABE451D24D0@VI1PR02MB3005.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39850400004)(396003)(136003)(346002)(189003)(199004)(74316002)(64756008)(305945005)(11346002)(446003)(6246003)(86362001)(186003)(7736002)(229853002)(71190400001)(71200400001)(25786009)(2906002)(478600001)(6636002)(9686003)(7696005)(486006)(55016002)(476003)(256004)(81166006)(2501003)(5660300002)(76176011)(6436002)(52536014)(81156014)(99286004)(8676002)(8936002)(316002)(558084003)(53546011)(110136005)(4326008)(76116006)(66476007)(6506007)(102836004)(66446008)(66066001)(3846002)(14454004)(26005)(66946007)(33656002)(66556008)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3005;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lG9XmQNZ324uK3G0i0vrGrtbSsn4oGkuB0m22Gd2HpQUSN5vH+QFLTROioMSy9vxidpHHw4oSEnaKfTEUvx2y2+2Bt5OeGKA5GdQdTOR1kUedlx2GbECam6K0aL7+XsJ2cR72MzjFOyq29YQVg5HYi0U8EGCQMQi9HVhRMkjTYJbzNF+GuslDBVEeucHjWv226RwDrXQa6ZJ1/wulIllVKWwc7O9UrzcDLOxfjkxAUPyHMEviSLMrgVHZ2ScC6QPWY7lo+jU/npCOfNPCgeBn1iy6S7mQGesu50w3Mj2aIMSHPJBr1+GodC2KXbGRmT2Pd/97KIpsJqE1IqB5ovSol8pFa7EG8XxwXY+PFl0NJNMIy7l72DlqpJtpiVu5KCarRfosY9iQNZjy4gGkyk6e7s4x96HA/KgcUiZ6Qa8qQJ9zFDTT/JJ/yUWTrvQ7Gxq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e3f491-6b4e-46e6-a1bf-08d76c29f9f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 13:19:43.7667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLv/A6CWKMUB8c+mVUvFIXYD1MljjntM7XdzxDi420Di1kw+6usuIcJqgX3s0iZvn5auzZOISATjttjrPBPUCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 15:07 Oded Gabbay wrote:
> Prevent accesses to the device (register read/write) from debugfs entries
> during reset as that can cause the device to get stuck.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>

