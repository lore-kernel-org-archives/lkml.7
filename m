Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B76C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283DA20679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aB2MSub4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfHMJne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:43:34 -0400
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:5280
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727129AbfHMJne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:43:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFTD64uHghqNzPErwXSZfcSENZaSl8ZttrswjA5fgzMD5z+xJeOSBBBJmcu4iN++rmHJklrbrMakYMO/wwf8y1XFAcNfIb0Qa71Lsho7FCgSL6o3ecNQbidFEOg/t9Xk8e0xOyb0mVQynysW/1lXMM8RMRk/ZPzQkXX/Io+3A7QvElp/OTSFmXnrsqclX8F8aBzicNx40DXmZynDYprC9R2dLgyCjmUyfMT6djdfDS0e9VPK0tqYgK4we5uzTUZaWsfDmV1mLScBxBBhoPQ4AKFaeCI3aoNXfK3WVhR2efc5eembBbwooh7IpDGTm5RscR2ZJTXz+xgdPYuNV7w5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cR7/OTTxRjkMUN9n8h1w5W+uNFKCWulxcJHq4CKXzI=;
 b=YeDjTYDMxxtYHmBSiIc9tOm1Bg/RuQBGdC+fPP0p8m0FRpTaWEdZAvKKlTf50NGzYxgqrCCKHXLoKEUZnj1cCCx/+JkBo6rAGdU39lECRK/JcONvTa06L8omihmT70mlKML0R9GpfG2Ph+C2MGlF3hsdIzAeTuNZisW5Te0oMrfEM1RVb9WJjDjitbncJg9VYXNJ4uYrC2V9pHQITIBwj7Q4YpodccRDPJ26tfy4I37VPcH6PfeWRDIpKufY5cmptKCO9BMXqpRlhooWd70jdlWcDP8JS+zGjOQXP5WthZ0w78vmsxm7L+nT9J0viJtjw32Rq9Lx0+UmVvUv2o3A6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cR7/OTTxRjkMUN9n8h1w5W+uNFKCWulxcJHq4CKXzI=;
 b=aB2MSub4mv/uRlMOq3shWqGCWaxvHGXDy38pTY+GE8Bn/9gdtS3yiNZQDCWCgqqoucqfruz/vL6OloH9zteMP1wj0bxNhxjc4rSKRWx0atFvZTKZP8D5w6HY0JXbChZvUoGmjsM5ba5R74PbE6yS4fC6nEu28B6PO5XxB4RLIk4=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.175.24.138) by
 VI1PR0402MB3376.eurprd04.prod.outlook.com (52.134.1.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 09:43:30 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::85d1:9f00:3d4c:1860]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::85d1:9f00:3d4c:1860%7]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 09:43:30 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "Razvan.Stefanescu@microchip.com" <Razvan.Stefanescu@microchip.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "joe@perches.com" <joe@perches.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Subject: Re: [PATCH v2 10/10] staging: fsl-dpaa2/ethsw: do not force user to
 bring interface down
Thread-Topic: [PATCH v2 10/10] staging: fsl-dpaa2/ethsw: do not force user to
 bring interface down
Thread-Index: AQHVUbTHyjGcqRlAKEevkuFP/1mSKQ==
Date:   Tue, 13 Aug 2019 09:43:30 +0000
Message-ID: <VI1PR0402MB28002A870C6EBA30DBA8EBD7E0D20@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1565686479-32577-1-git-send-email-ioana.ciornei@nxp.com>
 <1565686479-32577-11-git-send-email-ioana.ciornei@nxp.com>
 <9f932adb-fb6d-2973-f5af-6ba9a83be454@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [188.25.91.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 569fa08f-7adb-4e71-255f-08d71fd2b360
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3376;
x-ms-traffictypediagnostic: VI1PR0402MB3376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3376A97DF6BC891A8A7D06E6E0D20@VI1PR0402MB3376.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(189003)(199004)(76116006)(81156014)(66556008)(66476007)(478600001)(81166006)(64756008)(6246003)(7736002)(66946007)(305945005)(86362001)(14454004)(66446008)(8676002)(14444005)(53936002)(2906002)(3846002)(2201001)(256004)(71190400001)(71200400001)(33656002)(74316002)(6116002)(4326008)(25786009)(66066001)(9686003)(55016002)(99286004)(476003)(54906003)(76176011)(316002)(486006)(229853002)(7696005)(26005)(6436002)(446003)(110136005)(53546011)(6506007)(2501003)(52536014)(186003)(8936002)(102836004)(5660300002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3376;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z5RVLEIL4GNuKkJtE9zsSLhLiuLysCyDbY5i1A72uOKV/cnRzoIBHKamVll5jW6xprjq1PIS0+Qh1ehTu6eDgMTEVTpBlGvL+zRyCo0UU+1SGoVUGKK9ogxaMNK9vtWQsjFeCgC8eh005QebgXmgRXMrSPXk2wy8oj1e3MbnfiA3YdbSqaPgku+A7LbdwlylWgfrktrJDlVWMdrEj1XUsBHiCvpVsvEhS1SZWKa4qlpJ6+1JLJV28IODdEbgoBb2DcizAgza+HIcIDxS6zZ36CX+yLiTfFv3oVvGeBTVS9T59PkSqgXqBo9xYGE4D7m96KDkCRZm2U4tMOzFHHykD5EqNILt717vRFMlfHjeC8ulwWfXEzYcUIvIIvtiGEtXO0i3FhOeP/wQZfpihp/9AR2EU6mRql6OjfyL9zzb66o=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569fa08f-7adb-4e71-255f-08d71fd2b360
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 09:43:30.7561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2EE5x+ptT5qJGm5vBiZIwFcCSfy4UWbwAU9HvOCQ2BGbYJlzXeVx4TObwBi/6FxhQ9mg1bA77EQy+iBeSySjiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/19 12:38 PM, Razvan.Stefanescu@microchip.com wrote:=0A=
> =0A=
> =0A=
> On 13/08/2019 11:54, Ioana Ciornei wrote:=0A=
>> Link settings can be changed only when the interface is down. Disable=0A=
>> and re-enable the interface, if necessary, behind the scenes so that we =
do=0A=
>> not force users to an if down/up sequence.=0A=
>>=0A=
>> Reported-by: Andrew Lunn <andrew@lunn.ch>=0A=
>> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>=0A=
>> ---=0A=
>> Changes in v2:=0A=
>>    - added Reported-by tag=0A=
>>=0A=
>>    drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c | 32 ++++++++++++++++=
++-------=0A=
>>    1 file changed, 23 insertions(+), 9 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c b/drivers/s=
taging/fsl-dpaa2/ethsw/ethsw-ethtool.c=0A=
>> index 0f9f8345e534..99d658fefa14 100644=0A=
>> --- a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c=0A=
>> +++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c=0A=
>> @@ -88,16 +88,21 @@ static void ethsw_get_drvinfo(struct net_device *net=
dev,=0A=
>>    			 const struct ethtool_link_ksettings *link_ksettings)=0A=
>>    {=0A=
>>    	struct ethsw_port_priv *port_priv =3D netdev_priv(netdev);=0A=
>> +	struct ethsw_core *ethsw =3D port_priv->ethsw_data;=0A=
>>    	struct dpsw_link_cfg cfg =3D {0};=0A=
>> -	int err =3D 0;=0A=
>> -=0A=
>> -	/* Due to a temporary MC limitation, the DPSW port must be down=0A=
>> -	 * in order to be able to change link settings. Taking steps to let=0A=
>> -	 * the user know that.=0A=
>> -	 */=0A=
>> -	if (netif_running(netdev)) {=0A=
>> -		netdev_info(netdev, "Sorry, interface must be brought down first.\n")=
;=0A=
>> -		return -EACCES;=0A=
>> +	bool if_running;=0A=
>> +	int err =3D 0, ret;=0A=
>> +=0A=
>> +	/* Interface needs to be down to change link settings */=0A=
>> +	if_running =3D netif_running(netdev);=0A=
>> +	if (if_running) {=0A=
>> +		err =3D dpsw_if_disable(ethsw->mc_io, 0,=0A=
>> +				      ethsw->dpsw_handle,=0A=
>> +				      port_priv->idx);=0A=
>> +		if (err) {=0A=
>> +			netdev_err(netdev, "dpsw_if_disable err %d\n", err);=0A=
>> +			return err;=0A=
>> +		}=0A=
>>    	}=0A=
>>    =0A=
>>    	cfg.rate =3D link_ksettings->base.speed;=0A=
>> @@ -115,6 +120,15 @@ static void ethsw_get_drvinfo(struct net_device *ne=
tdev,=0A=
>>    				   port_priv->idx,=0A=
>>    				   &cfg);=0A=
>>    =0A=
>> +	if (if_running) {=0A=
>> +		ret =3D dpsw_if_enable(ethsw->mc_io, 0,=0A=
>> +				     ethsw->dpsw_handle,=0A=
>> +				     port_priv->idx);=0A=
>> +		if (ret) {=0A=
>> +			return ret;=0A=
>> +			netdev_err(netdev, "dpsw_if_enable err %d\n", ret);=0A=
> Hello, >=0A=
> These last two lines need to be swapped.=0A=
> =0A=
> Best regards,=0A=
> Razvan=0A=
> =0A=
=0A=
Oops, my bad. Will fix.=0A=
=0A=
Thanks for pointing this out,=0A=
Ioana=0A=
=0A=
=0A=
