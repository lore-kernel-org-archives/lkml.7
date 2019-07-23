Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128D2C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 04:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A042239E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 04:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="FpghFHAF";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="C8MjJBBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbfGWEds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 00:33:48 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:38612 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731403AbfGWEdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 00:33:47 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6N4TilS009193;
        Mon, 22 Jul 2019 21:32:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Dr7nMbnpEZrPKju+/FdMCSjM/re+fv2Yc+HGC+RJStI=;
 b=FpghFHAF0yI2e6Wqx4qBD5I3Vn++bjsZ8qaXIoO3jRUe1FxaWTXiZXEY4jBRhPKV3tpI
 AhX2KSdzpwLkO1OemdkDwmf+eBij3BWxE1b+DcSSLuDBUBrJLgkZ6MWB2dflGq2O2rWn
 MVQ7A45pyZsPm/f06xynlxwNFzZjwSQGhaLy/MCURwHndBtpGt5WEDPgigJADHS54k/7
 CLbl6/zxl7mgK4HHo3D5zMKx8eh7nX6SWJOB/Ol+sqLsKS2Z3kdnHFI0BlRgHwRkVZOc
 /zm6+zwGb0hWggFVZ846f/VSC8jVQifLDgH462siOm0HDU5zyMMtUfmmcCpTUYxwgXq5 7Q== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2054.outbound.protection.outlook.com [104.47.48.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2tuxhwhukj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 21:32:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu/bW/6muaIjjj2iVN+aRXSvPaMCq7npK0zLaFHeGSA/cq/3lvVHQRaKcdqrw0V4Gq0H5Mp2T3X9sv54MRApOKJP/+QCfxOQNQEYO8nqEpH6M+tF49gvEQG/HRGjTDyN+0HSa0guaoyu0BP99zx64fUzNSBB5e6JLJ3DfQQyC42YZmsw+hrpL9XIzCK/oTtAVlgDoHEW5VaLPZhHDjAE/8Oggr9G5hCUcrbRar4wuBooKDhSwwU+2PPM68FuEv/DCIgH5WQQAsbqshYfxnfzJDf5pfa8Tr8DXNlZ13MjTaRRrRhZB0cFE1lvtE38xjhxlz4ZZUVwMRk46fRumyq5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr7nMbnpEZrPKju+/FdMCSjM/re+fv2Yc+HGC+RJStI=;
 b=ioq/F4kiP7bW3xThABY/A899tnvBHl8Gs/zNPXk72i/fw8SFhtilU1r0hiJvyu0VBaUsDv+jQWsZRypVuvjmJQVKenkuFNRhcdQF3cGvtPTZeqTpV9HWpjbD9p0imAVXPJjqACvLcH3hTBme0qaQbnahD4wTfQ/Ni3YbiA/M4P5MIoSYBghGgxcqmGWXlPj9qVupoGr1fCX6Utv6Qq+Pjkr5HzAEYTx/mvMv9wBfDsOcKs3i26x2qcPim7GvRiVZSXuFPqTGoEEFNHL/wXd+o8O/2yamsbzKFvP6liMaX4RlQbxeXdjLlgsKdsFct0O8KtiY90AcJTAbw/Qn5MS+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=cadence.com;dmarc=pass action=none
 header.from=cadence.com;dkim=pass header.d=cadence.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr7nMbnpEZrPKju+/FdMCSjM/re+fv2Yc+HGC+RJStI=;
 b=C8MjJBBoMBNPKV1iEBBtcUMwO080+A3VUONMfNt7d7d5HScEQJ+ee5axyQRhXl668RyyHV873s6z0ISAs/LI/JPZIdJd02/4DTSWXP0i6jkHfOK1B6g+VWoO8xOW23h+oMEDK69Q62ndsXL3WxWGoS2uMgfGEeoH1sH+O8XAFkg=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5960.namprd07.prod.outlook.com (20.179.92.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Tue, 23 Jul 2019 04:32:36 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::41f8:6c26:5cc9:743d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::41f8:6c26:5cc9:743d%3]) with mapi id 15.20.2094.013; Tue, 23 Jul 2019
 04:32:36 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Pavel Machek <pavel@denx.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
Subject: RE: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
Thread-Topic: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
Thread-Index: AQHVP/K3++/PZvX91EKpHiAZrLktoabVbhiAgAD3BZCAACHLgIAAAkOAgACX4oCAAH1soA==
Date:   Tue, 23 Jul 2019 04:32:35 +0000
Message-ID: <BYAPR07MB470966850323EE3003B3097ADDC70@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <20190721190335.GA19831@xo-6d-61-c0.localdomain>
 <BYAPR07MB470904ACCD1ED91B10BB6BEFDDC40@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20190722114839.GA10515@kroah.com> <20190722115644.GA12069@amd>
 <20190722210021.GA25235@amd>
In-Reply-To: <20190722210021.GA25235@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZTI1MmU2NDgtYWQwMi0xMWU5LTg3NDMtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGUyNTJlNjRhLWFkMDItMTFlOS04NzQzLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTk0MSIgdD0iMTMyMDgzMjk5NTIwNDA3NTMzIiBoPSJsdW9rcmhWMEtpZk1YUVNLQU1tK1ZlT3NGdGs9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea60ff5f-9ebc-41c0-4117-08d70f26c98b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5960;
x-ms-traffictypediagnostic: BYAPR07MB5960:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR07MB5960C998827D7A62808D9527DDC70@BYAPR07MB5960.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(189003)(36092001)(199004)(76176011)(6436002)(52536014)(66066001)(6916009)(4326008)(6116002)(3846002)(5660300002)(14454004)(7696005)(14444005)(25786009)(316002)(33656002)(81156014)(81166006)(8936002)(53936002)(107886003)(66446008)(6246003)(55016002)(305945005)(74316002)(66556008)(64756008)(66946007)(446003)(66476007)(9686003)(476003)(11346002)(76116006)(6306002)(71190400001)(71200400001)(102836004)(86362001)(6506007)(26005)(229853002)(486006)(186003)(99286004)(68736007)(8676002)(2906002)(7736002)(256004)(966005)(478600001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5960;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zuyJBxO2eodYwvJNhUnBTR4kEuUrjwCcQBQaE101fAlfvuRHGQsAKx1sseLy+/J79lw0EUkMylFLkFtWN8jRsh0/ttpRYeX5FOm2AjA4gBB3Tc/Ahhtxew4pJrgSlHXy1huLrqhn+Aj2ikvr6cSHIFeCFF4TwIoQHaX5J6pjTAlkz2IHjRI+3snY02DZGWV3sVOrF9ycCPtLuH8vaTn2aAh8fL6vXnJpZuOUEeaLXKfV5+BDMnvCVlfgS+G/8QzOvdT549HAjAjoLJwMhUvow3C+XZSJEc7VXGGpliKoeuAebwiqt4BZQb80ESKkhL5vlb/OesFu8KlJOpQ4Q10NHJ95jJwdYoKVYIDC85APuUEHbRDEB8YPjnlkhbGoBf04OR2MRyHt1+Nbef+MCgS7s+4ZaTBzo8oju/a7AfLQutU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea60ff5f-9ebc-41c0-4117-08d70f26c98b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 04:32:35.9485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5960
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=585 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907230039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20

>On Mon 2019-07-22 13:56:44, Pavel Machek wrote:
>> Hi!
>>
>> > > >> This patch introduce new Cadence USBSS DRD driver to linux kernel=
.
>> > > >>
>> > > >> The Cadence USBSS DRD Controller is a highly configurable IP Core=
 which
>> > > >> can be instantiated as Dual-Role Device (DRD), Peripheral Only an=
d
>> > > >> Host Only (XHCI)configurations.
>> > > >
>> > > >I see you are using debugfs to select between DRD, peripheral-onlyh=
 and XHCI...
>> > > >
>> > > >Is that good idea?
>> > >
>> > > Yes driver allows selecting dr_mode by debugfs. Controller also supp=
ort such functionality
>> > > so I don't understand why would it not be a good idea.
>> > >
>> > > I personally use this for testing but it can be used to limit contro=
ller functionality without
>> > > recompiling kernel.
>> >
>> > debugfs is ONLY for debugging, never rely on it being enabled, or
>> > mounted, on a system in order to have any normal operation happen.
>> >
>> > So for testing, yes, this is fine.  If this is going to be the normal
>> > api/interface for how to control this driver, no, that is not acceptab=
le
>> > at all.
>>
>> It makes a lot of sense for end-user to toggle this... for example
>> when he is lacking right cable for proper otg detection. As it is
>> third driver offering this functionality, I believe we should stop
>> treating it as debugging.
>
>At least renesas usb controller seems to have variables in sysfs:
>drivers/phy/renesas/phy-rcar-gen3-usb2.c : functions role_show and
>role_store. See also
>Documentation/ABI/testing/sysfs-platform-phy-rcar-gen3-usb2 .
>
>I believe this driver should do same.
>

CDNS3 driver use the role framework and also has such variable defined=20
in role switch framework.

https://elixir.bootlin.com/linux/latest/source/drivers/usb/roles/class.c

Regards,
Pawel
