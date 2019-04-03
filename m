Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26994C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9ADA2133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="bGGhwX0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDCWDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:03:25 -0400
Received: from mail-eopbgr10103.outbound.protection.outlook.com ([40.107.1.103]:53127
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbfDCWDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vAULeLgq+Ms2OEpP7NQGwWc2YUuxN/XnHS6HXuSTbI=;
 b=bGGhwX0DCHj4IF1UimUUPuOsekjBu/tXHH2gW5pvyCIlneZ1lGWju+YqV85IjiO7q31PeC3KkSbR2mxejyxNyq/pByYjCym/H6uWKzuCHrJHE6TBeKVbtOsn3X2ahF6wzsMOlHn/S9tUe5fouvCSSkNRo1vJWeT0XPJHRhS6rsM=
Received: from HE1PR07MB3337.eurprd07.prod.outlook.com (10.170.247.12) by
 HE1PR07MB0954.eurprd07.prod.outlook.com (10.162.27.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Wed, 3 Apr 2019 22:03:21 +0000
Received: from HE1PR07MB3337.eurprd07.prod.outlook.com
 ([fe80::cd23:d96f:5d94:cee6]) by HE1PR07MB3337.eurprd07.prod.outlook.com
 ([fe80::cd23:d96f:5d94:cee6%6]) with mapi id 15.20.1771.006; Wed, 3 Apr 2019
 22:03:21 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH] axxia-i2c: use auto cmd for last message
Thread-Topic: [PATCH] axxia-i2c: use auto cmd for last message
Thread-Index: AQHU5VgPpbApEJ95DUuTTHU23c304KYq9AsAgAATTAA=
Date:   Wed, 3 Apr 2019 22:03:20 +0000
Message-ID: <20190403212822.GA29824@localhost.localdomain>
References: <20190328111858.GA17086@localhost.localdomain>
 <20190403205402.dr2uolmpew45xoxd@ninjato>
In-Reply-To: <20190403205402.dr2uolmpew45xoxd@ninjato>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0002.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::12) To HE1PR07MB3337.eurprd07.prod.outlook.com
 (2603:10a6:7:2d::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.2.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 989d07b9-c4ab-4c8c-409c-08d6b8802f28
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:HE1PR07MB0954;
x-ms-traffictypediagnostic: HE1PR07MB0954:
x-microsoft-antispam-prvs: <HE1PR07MB09540D1D9FBDC5A16C7BBF35EF570@HE1PR07MB0954.eurprd07.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(396003)(39860400002)(376002)(189003)(199004)(476003)(66066001)(6116002)(11346002)(446003)(25786009)(486006)(102836004)(186003)(6246003)(2906002)(97736004)(106356001)(76176011)(52116002)(68736007)(6506007)(6486002)(386003)(26005)(81156014)(8676002)(81166006)(107886003)(61506002)(86362001)(14454004)(5660300002)(6436002)(229853002)(53936002)(4326008)(9686003)(478600001)(6512007)(33656002)(8936002)(1076003)(14444005)(6916009)(3846002)(105586002)(71200400001)(71190400001)(256004)(54906003)(7736002)(15650500001)(305945005)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB0954;H:HE1PR07MB3337.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WueZv+oQglOJgyJtD/0p8QhKEM7kfqc2hWu2v+qizhzk4gppUmdLwRGaxLo+4zszu8z4dyAzSXUG4+QyyvUMTMXrY9Cnk/hx3GZUAJot+QOxcvGw+Y1+CdEJvjtACP5FeF7GbhS6iGd5rlWZcsoYDSp6jNzxfFxNuJvIcD8wGScxIA38BmrgjpztiH5rB/5XU0JUgEeEre9rfiduhODxHDwAU0OQgVwcXNxWxuDBKSZObwJNhHkWVl4xKaRpSKZZBt8nggbiEDWTJqhVhi5ATSCWdZe02re2XGLDdTUCTLtg4/0AVLqxlbdne5xP1st0faeSRVNSJQKpZmxnnZAgjq5pcpEIDJw7BDn5BqZVLcQehb8w74+Tzv8uB9yjVoAljeBlmtcLX3aFIjruBE+5r+dvvPl7wiAWeTWYLks2WXc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4AE3D2750551D94AA9766AD6B62EE8DD@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989d07b9-c4ab-4c8c-409c-08d6b8802f28
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 22:03:20.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB0954
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:54:02PM +0200, Wolfram Sang wrote:
>Hi,
>
>On Thu, Mar 28, 2019 at 11:19:45AM +0000, Adamski, Krzysztof (Nokia - PL/W=
roclaw) wrote:
>> Some recent commits to this driver were trying to make sure the TSS
>> interrupt is not generated on busy system due to 25ms timer expiring
>> between commands. It can still happen, however if STOP command is not
>> issued on time at the end of the transmission. If wait_for_completion in
>> axxia_i2c_xfer_msg() would not return after 25ms of getting an
>> interrupt, TSS will be generated and idev->err_msg will be set to
>> -ETIMEDOUT which will be returned from the axxia_i2c_xfer_msg(), even
>> though the transfer did actually succeed (STOP is automatically issued
>> when TSS triggers).
>>
>> Fortunately, apart from already used manual and sequence commands, the
>> controller also has so called auto command. It works just like manual
>> mode but it but an automatic STOP is issued when either transfer length
>> is met or NAK is received from slave device.
>>
>> This patch changes the axxia_i2c_xfer_msg() function so that auto
>> command is used for last message in transaction letting hardware manage
>> issuing STOP. TSS is disabled just after command transferring last
>> message finishes. Auto command, just like sequence, ends with SS
>> interrupt instead of SNS so handling of both had to be unified.
>>
>> The axxia_i2c_stop() is no longer needed as the transfer can only end
>> with following conditions:
>> - fully successful - then last message was send by AUTO command and STOP
>>   was issued automatically
>> - NAK received - STOP is issued automatically by controller
>> - arbitration lost - STOP should not be issued as we don't control the
>>   bus
>> - IP interrupt received - this is sent when transfer length is set to 0
>>   for auto/sequence command. The check for that is done before START is
>>   send so no STOP is required
>> - TSS received between commands - STOP is issued by the controller
>
>I am not sure. Is this a bugfix (=3D for-current) or more a new feature (=
=3D
>for-next)?

Good question. I wouldn't say it is a clear bugfix and I think it would
require more creativity to justify this as a bugfix than a feature. So I
would go feature route. I might have based that in for-current, indeed
but I think it should be easily applicable on for-next as well. Or do
you want me to resubmit?

>
>> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>
>I trust you that Alexander gave the review, but it would be a tad more
>'open development' if he could give it as a reply to your patch on the
>mailing list.

Fair enough. To explain myself - the patch was first reviewed and tested
inhouse before submitting it here - this is where this Reviewed-by comes
from. But lets Alexander confirm that officially.

Best regards,
Krzysztof Adamski
