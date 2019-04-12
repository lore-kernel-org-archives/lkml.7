Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FF1C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0952082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="eLAk2tPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfDLNMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:12:10 -0400
Received: from mail-eopbgr20108.outbound.protection.outlook.com ([40.107.2.108]:15782
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726714AbfDLNMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruN11Sy0YBjPXUzCTl4G3Y7Vq8w9BFSn2q2wg2Fo0E0=;
 b=eLAk2tPkiZtma/xtf+Q6xYcNvZ+J5CZ9b49P/CO7sCfqBi1PWXMDz8TB5zD/I4uBb1KMTB5BuOSJwrpHM/aPWlDBDLvMatbqvR9T35wTdvZ8A/IE69u0f6Ur9fu/KkkrUemeY5KVJI7jFh2TllzTNhCLW0ALUqLOEBMLLXCx2RI=
Received: from HE1PR07MB3337.eurprd07.prod.outlook.com (10.170.247.12) by
 HE1PR07MB3369.eurprd07.prod.outlook.com (10.170.247.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.11; Fri, 12 Apr 2019 13:12:06 +0000
Received: from HE1PR07MB3337.eurprd07.prod.outlook.com
 ([fe80::cd23:d96f:5d94:cee6]) by HE1PR07MB3337.eurprd07.prod.outlook.com
 ([fe80::cd23:d96f:5d94:cee6%7]) with mapi id 15.20.1792.007; Fri, 12 Apr 2019
 13:12:06 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
CC:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: Add NULL TTY driver
Thread-Topic: [PATCH] tty: Add NULL TTY driver
Thread-Index: AQHU8GcuXTQLfjbFSk+VcCO84+l+y6Y4HsMAgAADgoCAAEYbAIAAGW0A
Date:   Fri, 12 Apr 2019 13:12:05 +0000
Message-ID: <20190412131156.GB28707@localhost.localdomain>
References: <20190403113327.3628-1-vincent.whitchurch@axis.com>
 <20190403131213.GA4246@kroah.com> <20190403141109.3mdmqbt3mjxrie6k@axis.com>
 <e8b1618a-545b-ee35-ec51-f831cbdff7fa@metux.net>
 <20190405090043.vnsftwpdm56cx2hr@axis.com>
 <de23cde3-c77f-cdbf-0968-d7f44c723120@metux.net>
 <20190411130458.GA11390@localhost.localdomain>
 <c77474fd-96d6-392b-9a54-fd7e6a29b72d@metux.net>
 <0a50343e-6ebe-f725-82f7-5c127b5ce2e6@nokia.com>
 <eb11752c-7c20-2a39-d4a7-3be7282b4144@metux.net>
In-Reply-To: <eb11752c-7c20-2a39-d4a7-3be7282b4144@metux.net>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::34) To HE1PR07MB3337.eurprd07.prod.outlook.com
 (2603:10a6:7:2d::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12d542f8-20ca-4aa7-35aa-08d6bf4875f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:HE1PR07MB3369;
x-ms-traffictypediagnostic: HE1PR07MB3369:
x-microsoft-antispam-prvs: <HE1PR07MB33693EE5278AA622B0E9DEBBEF280@HE1PR07MB3369.eurprd07.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(6486002)(386003)(476003)(71190400001)(26005)(14454004)(93886005)(305945005)(7736002)(6246003)(256004)(186003)(9686003)(99286004)(53936002)(54906003)(106356001)(2906002)(446003)(6116002)(6436002)(97736004)(5660300002)(11346002)(6916009)(486006)(6506007)(3846002)(33656002)(6512007)(105586002)(76176011)(61506002)(4326008)(81166006)(229853002)(316002)(478600001)(71200400001)(8676002)(81156014)(86362001)(52116002)(25786009)(68736007)(102836004)(8936002)(66066001)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB3369;H:HE1PR07MB3337.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: piPwVZ8v0m5Q34Hd/UoyEmLmdi8V2LTAEcIw60jKdWXnbbwHEHbzCI81fsL06FtJV18YaWPrrEmLW8ySG4a9OC1pX50Ly+PVVoVUCTRJcI0FyjtLP1mYkg8mNp8/XjfXps6Ub1N9Zys4uMhsfbtuDWAeu6wE0NGSTzR0UPRvuuIE7q0EYWeOnqGYW+7OxD1s72iPm9ViBFdQtCBlxxHR7dRrFXmqHLJnAIjk2RNZ/cB07h+dIO8uZOpd/OKKSZ9smmZVeECYRbv7EpKOyxVZ+9APB561OWwixH4AG1veisSOJUjc4LAumP7WvNfH7Z4S2ofIQQecVTWPeqRSccZh05Ex87jNKLCItPEmOxccQ3/vKFSl3Uh9tv5HvVDb+RnE2+/23sgX0to+10n3tXatBDGylj3/dpgeo1CDO2E9sUM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BBAE46D9D76A044983E8749303605763@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d542f8-20ca-4aa7-35aa-08d6bf4875f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 13:12:06.0003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB3369
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 01:40:56PM +0200, Enrico Weigelt, metux IT consult =
wrote:
>On 12.04.19 09:30, Adamski, Krzysztof (Nokia - PL/Wroclaw) wrote:
>
>> Well, that depends. If the program doing those writes expects /dev/conso=
le
>> to be a tty device, then it cannot be any file.
>
>According to Vincent's mail, the actual problem is just systemd.
>Changing the kernel just for making one specific userland program
>(which happens to be written by somebody, who even doesn't know the
>semantics of rm -R) happy, sounds pretty strange for me.
>
>I'm not opposed to the general idea of having a dummy tty driver,
>but please for some actually sane usecases, not just working around
>broken userland :p

I don't want to start a flame but if that userspace would be written by
somebody else, would that change anything? :) Anyways, historically we
did not have many convinence usitlities in the kernel and now we do. So
does the fact that "this might be convinient but is not strictly
necessary" a blocker to get something into the kernel?

Krzysztof
