Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URG_BIZ autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA7DC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3DD2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvuniversity.onmicrosoft.com header.i=@nuvuniversity.onmicrosoft.com header.b="gUz9DB25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfI3KIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:08:54 -0400
Received: from mail-bo1ind01hn2021.outbound.protection.outlook.com ([52.103.201.21]:33529
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727497AbfI3KIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:08:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGaARyUicUU1h9ssMw/XpfwapUDRwBsyMYBGcqePl1Gv9v7GhDji0v7rdhiZdJzXHoVj8ekrF40DutsA6P/1EkSgVeW1CvKq2MA6hTJE9INxLEK15QYfMLyljb2zxBb4xCv17SH9msmhqJZ0npc0rn6pqqNkZuB5brt9xQs14+/PMUjCaGVoO9UkdVIpLvC7fms2yF449/Dzm80Jc1p88nBHgyAqPdiXX1hRNshZGbUz1DH3pcwjNcu7nwBD5ris2FHJeM3+/knkweM4sLV1xdM3fRxHTYOM1i9qB9rPPVZiz4NpXr4xz1V3ktiREiGXds+8CkDawRr0XDAfcBZM7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcZnUrw3zYry0Z5sedFDqSXc4fmr6Ho1+pPY+jZ3CV4=;
 b=UlNeZJNXUAmPo940bgS3U6LbwApLX9raPtZCg+9NYzVlFp/cvZshoGYYSREg/eEh3Eo43fJfbvOV1Tk+WxAU5LNLuDIL62o3OVmnTgdwuKU+VSUT6QFk7g/ZTrMuKSCkI1de5V7NRBQAvNUPAVtBDqWKdzy94+3a4qRECZw+ZlTRh6sxDA9M6AUdQCCszd0neokagqpGFrlyncGoqu/WdiIMsJDEF4oC/llyB1Ap/9QU+EG3TWb6HyvzImvpCbu9utC3WbAY3xA4uChB1zaX9tGhDJgIUkvTObwOIcBAzNpdw3TlCU4Bm9m2eH9UGmiaRBotETU/y36F27mkPZvung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuv.ac.in; dmarc=pass action=none header.from=nuv.ac.in;
 dkim=pass header.d=nuv.ac.in; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvuniversity.onmicrosoft.com; s=selector2-nuvuniversity-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcZnUrw3zYry0Z5sedFDqSXc4fmr6Ho1+pPY+jZ3CV4=;
 b=gUz9DB25xIyOk8nN4b95RAtLPzS+qat3GnVy+6qu2prnMFv5Mdti9lALCGB+9ZSQvio7IQP0uBvhRitO3mmfLJABaGDQk2rqE9oxGkqCfMNioPK0WmJvH7wb6ewYV3+kcWUAINoVFQxl25S5zCh0lXPDMnyaW7UDDSSeM5CguGk=
Received: from PN1PR0101MB1742.INDPRD01.PROD.OUTLOOK.COM (52.134.160.10) by
 PN1PR0101MB1534.INDPRD01.PROD.OUTLOOK.COM (52.134.165.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 10:08:48 +0000
Received: from PN1PR0101MB1742.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::dda9:cf77:9046:cd7e]) by PN1PR0101MB1742.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::dda9:cf77:9046:cd7e%9]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 10:08:48 +0000
From:   18163082 <18163082@nuv.ac.in>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Urgent Response
Thread-Topic: Urgent Response
Thread-Index: AQHVd3GmRsX6UP8MdEKDEX/RWGgJTA==
Date:   Mon, 30 Sep 2019 09:30:08 +0000
Message-ID: <PN1PR0101MB1742F3F5ED8F570401AFC7A295820@PN1PR0101MB1742.INDPRD01.PROD.OUTLOOK.COM>
Reply-To: "mr.johnharold@yahoo.ca" <mr.johnharold@yahoo.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR19CA0006.namprd19.prod.outlook.com
 (2603:10b6:610:4d::16) To PN1PR0101MB1742.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:10::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=18163082@nuv.ac.in; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.93.201.160]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6367eb24-a0df-456c-95c8-08d74588c8ac
x-ms-traffictypediagnostic: PN1PR0101MB1534:
x-microsoft-antispam-prvs: <PN1PR0101MB1534CFA23319E34950C9817195820@PN1PR0101MB1534.INDPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39850400004)(136003)(199004)(189003)(7116003)(4270600006)(5640700003)(55016002)(6436002)(6666004)(6246003)(508600001)(25786009)(2501003)(9686003)(7736002)(305945005)(33656002)(74316002)(2351001)(2906002)(6916009)(14454004)(8676002)(66066001)(81156014)(81166006)(8936002)(8796002)(221733001)(3846002)(6116002)(316002)(786003)(43066004)(52536014)(558084003)(476003)(486006)(14444005)(186003)(2860700004)(26005)(5660300002)(5003540100004)(256004)(52116002)(7696005)(71190400001)(71200400001)(99286004)(86362001)(66476007)(66556008)(64756008)(66946007)(102836004)(3480700005)(386003)(229853002)(66806009)(6506007)(66446008)(89113002)(80872003)(81782002)(81742002);DIR:OUT;SFP:1501;SCL:1;SRVR:PN1PR0101MB1534;H:PN1PR0101MB1742.INDPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nuv.ac.in does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cAkSi6I9Cu1lwjEAvTUX5ad6WszCX5Y9tkW4BOuV0+A2/XEmBI069fmb1fIldd8EzSocuIuZwwxSqkGZI3DbXsfZJvf3ese5d6w8YaGKGGXmpOzEhM7EBH61omGfFDvmnPRcurax2jTh9vPmG57uQvCGENdyl0XEf9L45crKIh9zp5iorr/l8WJxWhcNHR8NYVP+zafhysnDnyOUm0xFkJNcZ1Td2gq83qmZ9iYe83mhTkYvl1Pys9HrZh7zp+mF8+dOkzPFdAj2bFymhwevJ9cSE4jzcxqiqDPGXShd/kfofdxfz+4rDgKAt9Cdk5+BcGpm/NRo0qQ+k//7RCHGACKB8FWabbhzkqcvW9bX+YfD7xy3asj0uiBT1hNH9RXY9ITEXlm2438w4ayQ/Kq5MIKP8fuoYP+twO52gfGMxGI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <DDC53130D99C2A49AC444B8F7B7C1293@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nuv.ac.in
X-MS-Exchange-CrossTenant-Network-Message-Id: 6367eb24-a0df-456c-95c8-08d74588c8ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 09:30:08.2006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d1b99a31-59dc-4039-b9c4-f6166b6bf0a4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8YqFx52CeZvC9IVOZMQ4L1A7dobtBDdaJ5mBfzZXhULitM7xTldx5QQViP2GqyQP/PTXulO5l8M8rH2Qoa7oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1PR0101MB1534
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Greetings.. pls get back to me i have an important information to share.

