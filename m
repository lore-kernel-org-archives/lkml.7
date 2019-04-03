Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D120AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9056D20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aampusa.onmicrosoft.com header.i=@aampusa.onmicrosoft.com header.b="CgpntOIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDCRuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:50:13 -0400
Received: from mail-eopbgr800112.outbound.protection.outlook.com ([40.107.80.112]:6334
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726084AbfDCRuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aampusa.onmicrosoft.com; s=selector1-aampglobal-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLaUTHaEJoJ+lvFyUMO0Nzo17KMFGZ/COyY0TOUh7qQ=;
 b=CgpntOIi36I7PWDFeGt0bUW4ycd2mBQp3Ao/GlujiNbvupqFRxSNzd1L/YKh4KMzlZBO2kBV+suB8ye6BrRf7AmZvepEg2hzBD7D8nl6P60oASVWtYaK9cl489QODOv4ao9Zvg+Ub64ONLSPB4EQYTUFxdWenpf529+mScSrC4w=
Received: from BL0PR07MB4115.namprd07.prod.outlook.com (52.132.10.149) by
 BL0PR07MB4931.namprd07.prod.outlook.com (10.167.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Wed, 3 Apr 2019 17:50:09 +0000
Received: from BL0PR07MB4115.namprd07.prod.outlook.com
 ([fe80::e4fd:8f53:2484:46eb]) by BL0PR07MB4115.namprd07.prod.outlook.com
 ([fe80::e4fd:8f53:2484:46eb%5]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 17:50:09 +0000
From:   Ken Sloat <KSloat@aampglobal.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     "josephl@nvidia.com" <josephl@nvidia.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ken Sloat <KSloat@aampglobal.com>
Subject: [BUG REPORT] linux-input: keyboard: gpio_keys: False Button Press
 Event on Wake
Thread-Topic: [BUG REPORT] linux-input: keyboard: gpio_keys: False Button
 Press Event on Wake
Thread-Index: AdTqRLEh6tFvQPs7RTO9HSBOJGH4Ww==
Date:   Wed, 3 Apr 2019 17:50:09 +0000
Message-ID: <BL0PR07MB41151EC4B770F6A7396C152EAD570@BL0PR07MB4115.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=KSloat@aampglobal.com; 
x-originating-ip: [100.3.71.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7ab2680-adc5-45fd-441e-08d6b85cd086
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BL0PR07MB4931;
x-ms-traffictypediagnostic: BL0PR07MB4931:
x-microsoft-antispam-prvs: <BL0PR07MB49316380A69EDCE2C972C17FAD570@BL0PR07MB4931.namprd07.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39850400004)(376002)(366004)(199004)(189003)(5640700003)(9686003)(478600001)(99286004)(6116002)(55016002)(68736007)(71200400001)(3846002)(14454004)(53936002)(66066001)(4326008)(26005)(6506007)(107886003)(102836004)(6916009)(2501003)(476003)(186003)(7696005)(54906003)(1361003)(6436002)(52536014)(71190400001)(316002)(305945005)(486006)(2906002)(97736004)(7736002)(5660300002)(86362001)(106356001)(105586002)(72206003)(81166006)(80792005)(81156014)(8936002)(25786009)(8676002)(256004)(2351001)(14444005)(33656002)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR07MB4931;H:BL0PR07MB4115.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: aampglobal.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nW0HNUNNUsG/X/jfLYdmgFPPv0ACgpOMpjwemQkBqHNtSM6fG7sU2KLry8dm0BsLRd5zBSnsjTRb5CuRm+bCczL0tIyY8rbeivU5TCVHY9VnU0uQHwLWcYYlfVEKHViWQAwBMR42pEGFPQAdHoUCsupCvkqAf5vtxNRH4YgBiJPoI4qMaQA9empe9/CekX/I6pdSkLDYBGZC6KuHlmt2GeJ+AqQl7hE3A3Mt3J+ohF0S993b4cOkNrX+bcLDzsnJQ55oe4OHuu4KkGgl+TvZNiqOxgGFY5iDjXHhbbJScAqlzgBepSKZEWOXELX1kbqQ0WZM24dloakJmalDpCfPd32TRyIwsAdDjxwKDEgpBZQmaDVp/TIBpeyNHPnRGLg4yf4CqiYNtOg9Y341yxykVQEOWZRt614oNMBZbowbuOk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aampglobal.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ab2680-adc5-45fd-441e-08d6b85cd086
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 17:50:09.2794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e20e3a66-8b9e-46e9-b859-cb654c1ec6ea
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB4931
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: BL0PR07MB4115.namprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-TransportTrafficSubType: 
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC: 
X-MS-Exchange-CrossPremises-originalclientipaddress: 100.3.71.115
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-transporttrafficsubtype: 
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: BL0PR07MB4931.namprd07.prod.outlook.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

I may have found a potential bug in the "gpio_keys" driver. FYI, I am runni=
ng the 4.14 LTS kernel on my system, but from my understanding of the issue=
, it seems that this would still occur in the latest version of the kernel.

The problem:
In the 4.14 LTS kernel, both key press and release events can generate a wa=
ke event. In the 5.x kernel, wake events are configurable for press only, r=
elease only or "both" (see "wakeup-event-action" binding). The issue can oc=
cur in the "both" case or release/deasserted case. Let's imagine that a sys=
tem is suspended when a gpio key button is pressed, and subsequently resume=
d when the button is released. If we look at the sequence of actions and ev=
ents reported by the input system, we can see the potential problem:

Button Pressed
Event Value 1
System Suspend
Button Released
System Wake & Resume
Event Value 0
Event Value 1
Event Value 0

As you can see the input system will report an extra button event/press. Th=
is appears to be caused in gpio_keys_gpio_isr by the following statement:

if (bdata->suspended  &&
    (button->type =3D=3D 0 || button->type =3D=3D EV_KEY)) {
        /*
         * Simulate wakeup key press in case the key has
         * already released by the time we got interrupt
         * handler to run.
         */
        input_report_key(bdata->input, button->code, 1);
}

This code does not seem to take into account that the wake event may have b=
een caused by a button release action, and just assumes we must have a butt=
on press.

This can obviously be problematic in the use case I mentioned, as the syste=
m would be put in a constant loop between waking and sleeping. While there =
are other ways to deal with or react to this issue in the userspace, it see=
ms that the driver should probably take this into account.

Thoughts?

Thanks,
Ken Sloat=20
