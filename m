Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079ECC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65772084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LZQe1ebN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfDHRqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:46:07 -0400
Received: from mail-eopbgr140088.outbound.protection.outlook.com ([40.107.14.88]:55876
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfDHRqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbh/zzKlzWnsJKjm7NnORGJ6/vlYsNtf4rWcjHAkNd8=;
 b=LZQe1ebNqU7dQfkY51HAiQgzT10AtjwYg4mCtLdlChicX7J4He5Z+anVtXACEus4hQwIWp6H+v1fX/Ms6wQ9t8dcm09tZn5admIctjikJRixKO+zF5wTWJew1omgC0iPyI1yy3RDMs5P88mV1SCWVCTlIjNGJEveEQmKqamDitY=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.23.144) by
 VI1PR0402MB3901.eurprd04.prod.outlook.com (52.134.17.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Mon, 8 Apr 2019 17:46:02 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::b8b3:8509:a056:360e]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::b8b3:8509:a056:360e%2]) with mapi id 15.20.1771.011; Mon, 8 Apr 2019
 17:46:02 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/5] can: flexcan: add CAN FD mode support
Thread-Topic: [PATCH V2 2/5] can: flexcan: add CAN FD mode support
Thread-Index: AQHU7jLtjTghFqR720GjUH/3qPjtqQ==
Date:   Mon, 8 Apr 2019 17:46:02 +0000
Message-ID: <385f7948-d12b-1fc2-2ed2-23d1e76034a0@nxp.com>
In-Reply-To: <20190319051512.14950-3-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR08CA0017.eurprd08.prod.outlook.com
 (2603:10a6:803:104::30) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:b6::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c4a69f2-f921-4334-880b-08d6bc4a115d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3901;
x-ms-traffictypediagnostic: VI1PR0402MB3901:
x-microsoft-antispam-prvs: <VI1PR0402MB39017F2C411AA20E21C257B7DF2C0@VI1PR0402MB3901.eurprd04.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(366004)(376002)(39860400002)(54094003)(51444003)(189003)(199004)(14454004)(6436002)(97736004)(2616005)(476003)(11346002)(8676002)(6246003)(478600001)(8936002)(14444005)(26005)(102836004)(256004)(99286004)(186003)(66066001)(31686004)(7736002)(2501003)(68736007)(81156014)(81166006)(5660300002)(6512007)(6506007)(53936002)(386003)(36756003)(25786009)(305945005)(486006)(6116002)(52116002)(229853002)(2201001)(3846002)(2906002)(110136005)(106356001)(71190400001)(86362001)(31696002)(105586002)(316002)(71200400001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3901;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ieNaCaDstvWpft2ymsMCQYuJn5Mm1IV/M2S5Io/FxeQaNh8F+VX0DRX+9zlJW8PwgOAhX8W6S/C9fmyM/7Nz5PClJtKJlLYkzuH2AGyJApT3Pb3Tkcp1oyktRY7n//hOBLNfzg9/dA8WRcymQ8ug3HQbjcSEQU6r4WhZTNiNC/ROonqCCi6TpIjM5EkaTX5c2D0G1F/VNmNQ/1QM/EvGZA7LFytfYfKzHrEt5AVj1xO0eRfcqEbqKfkqfN6o5InGE3f7beDuR+yN716iCAiuBtZNqQN/5CPqjosrPH+itgZ4Ew7H0TvfeacAH1xnjCOiQtc6P0v1f2NHb01hUdofnvesIT1d5Jfzox1y8QDIzsUsz2tZVJk+QZE8yHj39BIoYUkIiStlIACCBQjhcxl9PKEnjVRv2JT/Eax29Qp10Ns=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <FBD65A23CD1BED428B72C287AF2E9DFA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4a69f2-f921-4334-880b-08d6bc4a115d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 17:46:02.7420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joakim,

I successfully validated your CAN FD support on an S32V234 based board.
Here are some points which are not very clear to me:

Joakim Zhang <qiangqing.zhang@nxp.com> writes:
> +		priv->write(reg_mcr | FLEXCAN_MCR_FDEN, &regs->mcr);

According to the S32V234 reference manual (not sure if this applies to
i.MX8QM as well), CAN_CTRL1[SMP] cannot be asserted when CAN FD is
enabled. Is it safe to configure the interface with both "fd on" and
"triple-sampling on"? If not, flexcan_open should return an error when
both CAN_CTRLMODE_FD and CAN_CTRLMODE_3_SAMPLES are set in ctrlmode.

Joakim Zhang <qiangqing.zhang@nxp.com> writes:
> +		priv->offload.is_canfd =3D true;

Shouldn't is_canfd be assigned false in the "else" branch? Otherwise,
is_canfd will stay true after the following sequence:

root@s32v234evb:~# ip link set can0 type can bitrate 500000 dbitrate
2000000 fd on
root@s32v234evb:~# ip link set can0 up
root@s32v234evb:~# ip link set can0 down
root@s32v234evb:~# ip link set can0 type can bitrate 500000 fd off
root@s32v234evb:~# ip link set can0 up

Moreover, I wonder if we even need is_canfd, because frames should be
fed to the kernel as classic or FD based only on the EDL bit in the C/S
word of the Rx MB, to keep their original format. That is, you may
either read EDL from within a new callback (but I think that
mailbox_read should remain the only one which both locks and unlocks the
mailboxes) or let mailbox_read call alloc_can(fd)_skb itself.

Regards,
Stefan
