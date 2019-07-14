Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D56C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 06:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7332064A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 06:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="mvN0i43t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfGNGSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 02:18:14 -0400
Received: from mail-eopbgr690046.outbound.protection.outlook.com ([40.107.69.46]:19035
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbfGNGSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 02:18:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/sXfHUWVHPCK1XQWImSi7DguQw1tzDydvLBPCUfkMOFS5CiICkJBrRVBPfihjsPLs1dEGH5bl75ILBfFu6x5zuemmaFRcxFrqMwwy8vOS0E2xVXusxaU6K1l0BW50CQaFYR4eJW59uF2Qoy02twz7QjoL3ReCt+58/p9p4v61zsGlsEMN82pygAgm7iqwrG71Lr78AQA4xKfn7i4kFU8/DTGFXZtdhayRCfR2tiLYD4EeD36lad53YuhEtd7W5eG99F/Fw4cDWDlEy5tTMDM4kAc+nync+SbG2XUImJAWZWAfR57HH53s1jfEawiYHMv/0r8i6R2SWLxx1ARpmQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSUfX3PBid/14xFSIzXf+EReEjy75c+f7SpOMPpWhTQ=;
 b=b3OzSsxm9Y1XKceyr9pmHeNwO3et5kto2lCug8aM6NWqEwNYhhKZeTBUhUQxjMn4pd6Qfuh9aL/efXz8hLg6NurllokjEVrmlw1zpaD4LYJmjKWH8A12hgzU3Q5oQG5Vgv+o51dlp2ZhDoWn0pqsWw7Y665Xx9lp1zrFSAO50gIOi6TVHdOtERgFmGlBp5cmewDu6mXJNy/nKT5fW3YlG1iRxiY24Ix4jAR46WMagFZ3uZMrDJIz1p9cFS5fixbh1zW1cVKsX4ATmFH98vwA89WcLfH8TJImQL8/h6++chMy4TavEoIPe0vLYtPKo/wRWMSceYq50o+2USNx+rKnFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSUfX3PBid/14xFSIzXf+EReEjy75c+f7SpOMPpWhTQ=;
 b=mvN0i43t6wmYtzMjTzmuRI9ivMj4vX1z3xAzZwCknw8PqMJdq3ybBm2V+RSkTh38sG9NNUzM8GubrNidvkYgCIDYtBgBoMUMlO/O3CkzMiQVgkjkgZLJINpO0BtPcFWmo1mVx51Ri3pWnx/5CBDIOqCLPvUPEyecb6vU8BUeDoc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4055.namprd05.prod.outlook.com (52.135.199.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.9; Sun, 14 Jul 2019 06:18:07 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2073.012; Sun, 14 Jul 2019
 06:18:07 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Julien Freche <julienfreche@icloud.com>
CC:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] vmw_balloon: Remove Julien from the maintainers list
Thread-Topic: [PATCH] vmw_balloon: Remove Julien from the maintainers list
Thread-Index: AQHVMPt0L6ZZyVuj50Kj0VV7uF8wRqbIslcAgAEDfYA=
Date:   Sun, 14 Jul 2019 06:18:06 +0000
Message-ID: <AF1518AA-309B-466F-ACD2-1CAD04A72716@vmware.com>
References: <20190702100519.7464-1-namit@vmware.com>
 <20190713144920.GA7495@kroah.com>
In-Reply-To: <20190713144920.GA7495@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4580:b719:e4b7:ae28:b76b:fe24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddafbebc-8e22-42d4-8504-08d70823095f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4055;
x-ms-traffictypediagnostic: BYAPR05MB4055:
x-microsoft-antispam-prvs: <BYAPR05MB4055E47F9199E91042FC20F2D0CC0@BYAPR05MB4055.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:534;
x-forefront-prvs: 0098BA6C6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(189003)(199004)(36756003)(14444005)(486006)(53546011)(6116002)(102836004)(76176011)(4744005)(2906002)(99286004)(6506007)(71200400001)(71190400001)(316002)(54906003)(2616005)(11346002)(446003)(476003)(186003)(46003)(256004)(66446008)(64756008)(66476007)(66556008)(66946007)(91956017)(4326008)(76116006)(68736007)(5660300002)(305945005)(7736002)(8676002)(81156014)(81166006)(14454004)(229853002)(6436002)(86362001)(33656002)(6916009)(6486002)(478600001)(25786009)(53936002)(6246003)(8936002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4055;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5l8sHLrnyPwxX2/FUvmccl+dMdn1kK5AGuN5vibCIOkMPTHJaceab5s4I14FYIjoYGBkgi1AejWQndLFmD7YrQT9msJgKs0b3STPT9UCdCRgyH1gFYVoSp6AAet6oswR3MdKk0SLZm1WTSsN4EeCPE/+IdsbSCdohOj4vUMXwDbTvRLvBZu+FtBdvSVxQizy+ISrWJnVCVRM6F0CstJjMpHjyqFgINC48MBYJF0YL0aAHe3YtH4kSaE1eA1o0IhFLaYBtGo4soveIkUgdqrqTohgb46/ed30zwEL/BYy3oxaa5KvemUwEKq80Hud5cb+12Em94vht5MYFINHOoUfl2FOqTWPJNTvszms83FyN+1ZLrsJzhgL6EKfLMO+4pBLf+9O8wpy7F8L04QBp3UGfFmHi1kPSpaOsZL6jWHwoAo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F14C170831E01A4F84A6E68E2E86FF55@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddafbebc-8e22-42d4-8504-08d70823095f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2019 06:18:06.5569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 13, 2019, at 7:49 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.o=
rg> wrote:
>=20
> On Tue, Jul 02, 2019 at 03:05:19AM -0700, Nadav Amit wrote:
>> Julien will not be a maintainer anymore.
>>=20
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> MAINTAINERS | 1 -
>> 1 file changed, 1 deletion(-)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 01a52fc964da..f85874b1e653 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16886,7 +16886,6 @@ F:	drivers/vme/
>> F:	include/linux/vme*
>>=20
>> VMWARE BALLOON DRIVER
>> -M:	Julien Freche <jfreche@vmware.com>
>=20
> I need an ack/something from Julien please.

Julien, can I please have you Acked-by?

