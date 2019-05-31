Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20692C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE082075B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="hAeTSCig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEaKMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:12:39 -0400
Received: from mail-eopbgr140137.outbound.protection.outlook.com ([40.107.14.137]:39399
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfEaKMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqeTImFFf4i/bc1dGTvqHx46bQCjhNR+wAJfGNK5vM8=;
 b=hAeTSCig4/icri35goTlfxvJapiXdSdvmHuLJT4tCLcacjJNMRFzFtardWXv62iRBNiQCYavEQG+oPQbNbIFdEsTsvNSguM6Llj7yVPWi6P4+USD/BZF4aeY9uR5j0ZnMb3apGsfGcKndtFx1sDJ+EK8rcpf52tQwkwtT/XCe1M=
Received: from DB6PR07MB3336.eurprd07.prod.outlook.com (10.170.223.150) by
 DB6PR07MB3206.eurprd07.prod.outlook.com (10.170.220.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.15; Fri, 31 May 2019 10:12:35 +0000
Received: from DB6PR07MB3336.eurprd07.prod.outlook.com
 ([fe80::8c1c:dbc5:e07b:2cf9]) by DB6PR07MB3336.eurprd07.prod.outlook.com
 ([fe80::8c1c:dbc5:e07b:2cf9%6]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 10:12:35 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: pmbus: protect read-modify-write with lock
Thread-Topic: [PATCH] hwmon: pmbus: protect read-modify-write with lock
Thread-Index: AQHVFwwdZFrZN6Tas0+vUHeunvtgIKaFBHOA
Date:   Fri, 31 May 2019 10:12:35 +0000
Message-ID: <20190531091531.GA10821@localhost.localdomain>
References: <20190530172120.GA22145@roeck-us.net>
In-Reply-To: <20190530172120.GA22145@roeck-us.net>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0341.eurprd05.prod.outlook.com
 (2603:10a6:7:92::36) To DB6PR07MB3336.eurprd07.prod.outlook.com
 (2603:10a6:6:1f::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b250ead7-b3c4-4b83-0781-08d6e5b08056
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB6PR07MB3206;
x-ms-traffictypediagnostic: DB6PR07MB3206:
x-microsoft-antispam-prvs: <DB6PR07MB320665261FBBEE38E180F949EF190@DB6PR07MB3206.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39860400002)(376002)(136003)(189003)(199004)(1076003)(486006)(8676002)(316002)(9686003)(5660300002)(6512007)(81166006)(508600001)(33656002)(4326008)(52116002)(81156014)(66066001)(476003)(86362001)(11346002)(14454004)(61506002)(99286004)(305945005)(446003)(54906003)(7736002)(8936002)(6246003)(186003)(76176011)(73956011)(6436002)(66946007)(386003)(229853002)(6486002)(66556008)(6116002)(6916009)(26005)(64756008)(2906002)(14444005)(25786009)(71200400001)(6506007)(53936002)(68736007)(256004)(66476007)(102836004)(66446008)(71190400001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR07MB3206;H:DB6PR07MB3336.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VUknB35yhhWsFzIcRTJftEpAv5tky6Jc5AVbzjAgjMOsyePVk9fVN7whMKoIHO90BuhgiPLiaoqdj8TNjB1CqvoGBPJO5vsxz6rHXBmobdFWygy3f1PPwSINRi+Y7d4ucw9SSfYw8ChqAixRrmRQ5DKuqs3jRLBsJDNy7OK+7bYWPL+P6m8pJdh2dZCf+lsIY3drV8S57AKO8NX8LKvE6EgTqGnJm1nPNJvJg50a9yRhpMxLJ+rAS78ytCferWRhOeNXlNPpvLxjSevCKgM0ij7xpB1EjLwQEikEjN2DEKOCuEVTFb6mugj2Isg9Tu7snbxmTIrjdb2wLhoJ3oA8AT9++md4rwrPaqbTFRUwh+YuWPIcYtIwnhAC6F9RIr5ujjC+mPhzknQjTUnC2C7xleHGwtd4Mm/mqkXjx5Ay4jI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <624C1B792687DF42A750D67C4D778AD3@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b250ead7-b3c4-4b83-0781-08d6e5b08056
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 10:12:35.1799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krzysztof.adamski@nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 10:21:20AM -0700, Guenter Roeck wrote:
>Hi,
>
>On Thu, May 30, 2019 at 06:45:48AM +0000, Adamski, Krzysztof (Nokia - PL/W=
roclaw) wrote:
>> The operation done in the pmbus_update_fan() function is a
>> read-modify-write operation but it lacks any kind of lock protection
>> which may cause problems if run more than once simultaneously. This
>> patch uses an existing update_lock mutex to fix this problem.
>>
>> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>> ---
>>
>> I'm resending this patch to proper recipients this time. Sorry if the
>> previous submission confused anybody.
>>
>>  drivers/hwmon/pmbus/pmbus_core.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbu=
s_core.c
>> index ef7ee90ee785..94adbede7912 100644
>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>> @@ -268,6 +268,7 @@ int pmbus_update_fan(struct i2c_client *client, int =
page, int id,
>>  	int rv;
>>  	u8 to;
>>
>> +	mutex_lock(&data->update_lock);
>>  	from =3D pmbus_read_byte_data(client, page,
>>  				    pmbus_fan_config_registers[id]);
>>  	if (from < 0)
>> @@ -278,11 +279,15 @@ int pmbus_update_fan(struct i2c_client *client, in=
t page, int id,
>>  		rv =3D pmbus_write_byte_data(client, page,
>>  					   pmbus_fan_config_registers[id], to);
>>  		if (rv < 0)
>> -			return rv;
>> +			goto out;
>>  	}
>>
>> -	return _pmbus_write_word_data(client, page,
>> -				      pmbus_fan_command_registers[id], command);
>> +	rv =3D _pmbus_write_word_data(client, page,
>> +				    pmbus_fan_command_registers[id], command);
>> +
>> +out:
>> +	mutex_lock(&data->update_lock);
>
>Should be mutex_unlock(), meaning you have not tested this ;-).
>
>Either case, I think this is unnecessary. The function is (or should be)
>always called with the lock already taken (ie with pmbus_set_sensor()
>in the call path). If not, we would need a locked and an unlocked version
>of this function to avoid lock recursion.

You've got me :) I did not test that as I do not have a workflow using
this. I just stumbled opon this when looking at the code related to my
other patches. So it was more like a - "hey, shouldn't there be a lock
here?". But I was wrong, thanks.

Krzysztof

