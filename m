Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36D9C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 04:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A99E20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 04:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="OCnVYcmw";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="e7l8ixo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbfJPEgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 00:36:52 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:4008 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728189AbfJPEgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 00:36:51 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G4X24W011970;
        Tue, 15 Oct 2019 21:35:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=onIgYJVbVN2LApoxLItSSy4BxIBnppE3SR3R3Ef9Omw=;
 b=OCnVYcmwKkibAPVWhUNYTrJ5zsOXHeQX1KvKW+NX4jnyVCBPNEwKy/FpMpqVAZmfP8TZ
 jinEijzATB6gfklzo6z0jRsd3DJjd5RsmIhsSLl50ONE8jI5qTVcfdP5tNg9McZSBBiZ
 9kqYD0qW+869gq1HdG+jYFRTRi0nuEJanTnCQVa+UMUoxJ7RDThFR69E0UGTMzbQxD+B
 8nTBKXGGFc5aIP2EAH5jb1DWvu2d2KgptB7JM7QA15eo1cwwSbAEaAeaVFILX36nXMzE
 +/G2ENfd87+1hmjXzRD4kqGC+hufNag5MoXZqggiZYnZu2z25NZ/rDPKrXh2q4hIob4v Dw== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2059.outbound.protection.outlook.com [104.47.38.59])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2vkbd26ckq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Oct 2019 21:35:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwR4tln1EYk42OO5cSQ+6bj4FaXluGZJx4lP72iPz9zGzXkuNOMySrTxn9jQfwWgdlkPyEby0XUSHeDJt4Bo/tC0FCvz1IglFI28rPRGymra2uBS9S4h7NhDKYvvUUjuMeHnhj6PmxG6NqZl4KUzcl36O8OWNz3wDXLEMkR1Yss5902JBJqCLPBiZPsMsVhVuXgDAzPE7eHkQBAKWWwQHamqhtDLDKre3IG41PTZMsC6LrmxcGf7ZWd8imBa0xemPq8in0rqtPp3XDnqke5dcsillr4r44qSoxGa2TjY/pDj0UAUgkAWLG8XYEqGODaSSh9n4jyAXL52fsOvHgOQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onIgYJVbVN2LApoxLItSSy4BxIBnppE3SR3R3Ef9Omw=;
 b=Nh6DwowMNjQJy4kNJDr1eKhCp9dwQMpffeUJOBXeRzanR/VSBvTrBJpuCWyD04YPVK2tSmJvmSE+gcAYJarW///2f5jOJDXysowM/Jq7KqFn3Myj4AlHW7nAgctZqhICvVhEMeqtfKhqgI6jor7IluNuE4tQUdoyHtcV7kMkBhkgO3D+r9VQN5g/kXsdPAp5rReXg1QqzSsxaehYmt89vgQT7EJXte+7X9WfNDICb0wNu/9gOJmd+feXG54EflaoJkdKic6GWmjsAgnmcqfr44GsPi86r3xzhZTVF/+2nlW8kTsrU45SdRsZ/bJevbsmP+YTSqj8rO+p+4ItutMZ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onIgYJVbVN2LApoxLItSSy4BxIBnppE3SR3R3Ef9Omw=;
 b=e7l8ixo/X4RecbxyAZDlvJRIAF+xGcVB6geCAAI/7xuQXUJytAWE1tFNI7pogNR92qNwrtasOKU1kRVVu0OuEZ8uyDxtzBfuKidAi38VG98LIok3yo8TT8owIHursGECHpyCuhrpbkf9Ro5qqekJLXI1GksGuezhPH125LXK4MI=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4565.namprd07.prod.outlook.com (52.135.224.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 16 Oct 2019 04:35:40 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770%6]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 04:35:40 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>, Roger Quadros <rogerq@ti.com>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] usb: cdns3: gadget: Fix full-speed mode
Thread-Topic: [PATCH 2/2] usb: cdns3: gadget: Fix full-speed mode
Thread-Index: AQHVfQkFJQBIV6DW50mc96mlxAV/BKdQZMgAgAxXN3A=
Date:   Wed, 16 Oct 2019 04:35:39 +0000
Message-ID: <BYAPR07MB470974072BDED3F032E35F80DD920@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20191007121601.25996-1-rogerq@ti.com>
 <20191007121601.25996-3-rogerq@ti.com> <20191008080711.GH5670@b29397-desktop>
In-Reply-To: <20191008080711.GH5670@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjYzY2E1NmEtZWZjZS0xMWU5LTg3NGItYTQ0Y2M4YzMwYmQ0XGFtZS10ZXN0XDY2M2NhNTZjLWVmY2UtMTFlOS04NzRiLWE0NGNjOGMzMGJkNGJvZHkudHh0IiBzej0iMTEwMSIgdD0iMTMyMTU2NzQxMzc5MjU4MTcwIiBoPSJjOXd1TS8zMC90THBMcjlZMThyTmVoZjIrYms9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42dd3db1-9c7c-43d8-45fc-08d751f24c50
x-ms-traffictypediagnostic: BYAPR07MB4565:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB4565D62D85661E4B19DF4C5EDD920@BYAPR07MB4565.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(36092001)(189003)(199004)(66476007)(81156014)(476003)(11346002)(99286004)(86362001)(186003)(4744005)(7696005)(3846002)(6116002)(66946007)(66446008)(446003)(64756008)(76176011)(71200400001)(6506007)(71190400001)(66556008)(52536014)(8676002)(8936002)(81166006)(2906002)(4326008)(102836004)(25786009)(486006)(6436002)(7736002)(6246003)(9686003)(305945005)(66066001)(76116006)(229853002)(33656002)(74316002)(478600001)(5660300002)(26005)(316002)(110136005)(54906003)(55016002)(14454004)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4565;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cpbo7ISjIruxR8LoEXxTkd3BNKOWg9/bd5jsKdTKrbsnKo52lC1HHRj6a6QdI9+owB7+6ptXCI9yMZybNNP6T02LsYN6cUfQ9IUzxUszj7VqpMocfgJS9QG7pnDqbq3CF6d127a7WosX1j9FjcCk30hU3k7pkvQVvPh0FByBxGBLQaLH7wFu4hCtC0nzP6SBMtrCEMR97BfwRvd+uNJhlhxXEInDm4eWe2t81IaL0l99QhMK8fu34BVOnNVOLcDyBz+92F/Txm+ax5DnJ34OWZ8y/4xGGIPZugPCUQ3Mqc81FiBioN9hlG3EQ2lKKxgDLp58M6gwNV936ALtFGZnoaKoOmLUOayXaUQzfBd8po5dApC5MpGYfeyZhqBKrtYqYHKteZ2Diwk04+KceaQaoNk1FUHFjq/ynixAD1xk4Iw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dd3db1-9c7c-43d8-45fc-08d751f24c50
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 04:35:39.8490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPuB8O1DNNS9FwiHUVey1QQp+RCDKzpmFgaxnfPMDqKaYOEYx+v8IgdmWq4agHxZFLqYFSKdR2a6IrgkykkrnLfNDm4/SVro0BB+4YnSL4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4565
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_01:2019-10-15,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 mlxlogscore=909 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910160041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 19-10-07 15:16:01, Roger Quadros wrote:
>> We need to disable USB3 PHY for full-speed mode else
>> gadget mode is broken.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>>  drivers/usb/cdns3/gadget.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>> index 228cdc4ab886..157536753b8c 100644
>> --- a/drivers/usb/cdns3/gadget.c
>> +++ b/drivers/usb/cdns3/gadget.c
>> @@ -2571,6 +2571,7 @@ static int cdns3_gadget_start(struct cdns3 *cdns)
>>  	switch (max_speed) {
>>  	case USB_SPEED_FULL:
>>  		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
>> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
>>  		break;
>>  	case USB_SPEED_HIGH:
>>  		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
>
>Reviewed-by: Peter Chen <peter.chen@nxp.com>

Reviewed-by: Pawel Laszczak <pawell@cadence.com>
>
>--
>
>Thanks,
>Peter Chen

Regards,
Pawell
