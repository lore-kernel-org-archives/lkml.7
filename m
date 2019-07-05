Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE422C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712A221721
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="YXPmKNX/";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="mF/jvPM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfGEEnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 00:43:24 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:47826 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbfGEEnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 00:43:23 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x654dhxP013948;
        Thu, 4 Jul 2019 21:43:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=3LlTIG62iXMukB/pC9Ojrv8056jtwJqifDHYCvkxMrk=;
 b=YXPmKNX/pdq3SCy85seN/4vXhOEjrAkR62snykO6RInqz8gwclrHDJEq3WQLiYwwuPR5
 K9w5+JkeTtPYE6GgkKo9eT+LB8dH9dLuO8HdwUbkVEBkXpAoLQXsLkdiUAdroaMAJKwY
 tg1563sWYQrhI/a4TlzyJp8XBqYqJ74JPJ6ZkIRLl3vpnfqOqgoW523RbKgri7+EGjA0
 XYTsXWCdRkYlWwkUwVEmy9s1umrecrH4ZGqIq9Zy34I6q7qxso/FrzGadHxlAV5oeKKn
 Qo+L5V1M3qWpE5EzmHewqgJ6oi+MKoY/LD2dMq3wo7A6s1g9s1kwBVodJr8kMudZR23p Ag== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2058.outbound.protection.outlook.com [104.47.48.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2tgwvj6te2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 21:43:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LlTIG62iXMukB/pC9Ojrv8056jtwJqifDHYCvkxMrk=;
 b=mF/jvPM7xuEYL6BwMFI7iv3P5o9C8jAlyBKKz3gpRRlE0lfZ1CrpoQMpGjiC74VSE4ZRB1oyhugsIqcchzJP7Hlu90DpuJzt6DnfifcergKDe84NtNpft62+p7dLOGRo041EP2f9NnpXwusRgnB9Kc1+xqJYhZ0ZMObxRTh35DQ=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5479.namprd07.prod.outlook.com (20.177.229.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 5 Jul 2019 04:42:58 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2%6]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 04:42:58 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Felipe Balbi <balbi@kernel.org>, Greg KH <greg@kroah.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>
Subject: RE: linux-next: build failure after merge of the usb and usb-gadget
 trees
Thread-Topic: linux-next: build failure after merge of the usb and usb-gadget
 trees
Thread-Index: AQHVMjKg7+jonhPbpUSjvye7Qm/1waa6B76AgAAICQCAAAlA8IAABpcAgAAIkzCAAA12AIAAFjGAgAAAvICAASRaIA==
Date:   Fri, 5 Jul 2019 04:42:57 +0000
Message-ID: <BYAPR07MB4709344EED0561D7F4DD879FDDF50@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20190704163458.63ed69d2@canb.auug.org.au>
 <20190704065949.GA32707@kroah.com>
 <CAH8TKc_4ggxOPgii8gLGo2d7nvx08cbTk8_xDUQfA2Ckcxb_Aw@mail.gmail.com>
 <BYAPR07MB470946609232100714B3EA29DDFA0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87imsiyzo3.fsf@linux.intel.com>
 <BYAPR07MB4709076903F55352193FC78FDDFA0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <877e8y6snr.fsf@linux.intel.com> <20190704110333.GB1404@kroah.com>
 <87sgrm9hzw.fsf@linux.intel.com>
In-Reply-To: <87sgrm9hzw.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNWE4ZGYyZmMtOWVkZi0xMWU5LTg3NDItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDVhOGRmMmZkLTllZGYtMTFlOS04NzQyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzU3MCIgdD0iMTMyMDY3NzUzNzU2MDk0MDk3IiBoPSJFc05RdzBkeTdvNjNORlRyYlRZVGFmQ3crQ2c9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b3baee3-b94f-4ab4-b70d-08d7010340e3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5479;
x-ms-traffictypediagnostic: BYAPR07MB5479:
x-microsoft-antispam-prvs: <BYAPR07MB5479FFE00B78F084FAD51915DDF50@BYAPR07MB5479.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(53754006)(36092001)(199004)(189003)(102836004)(52536014)(7736002)(66446008)(7696005)(76176011)(26005)(64756008)(6506007)(446003)(2906002)(66556008)(11346002)(55016002)(74316002)(110136005)(54906003)(476003)(6246003)(305945005)(99286004)(25786009)(73956011)(4326008)(76116006)(66946007)(86362001)(66476007)(81166006)(53936002)(316002)(3846002)(66066001)(6116002)(71190400001)(486006)(478600001)(71200400001)(5660300002)(186003)(229853002)(8936002)(68736007)(33656002)(6436002)(81156014)(14444005)(256004)(9686003)(8676002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5479;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z6awYDhMHsxJ0H76Pp+X94kOhSLibysSrIzpEaW8BnXks4l/bNP9Tv9NiVwCPih1szRvkzvJQTsFodQbzb6ZBsNSqoQdHY+EAC8HFrLatw87XMoY46WjpOrMqBhBi0S4XzmY52dwuZrWciAZ+/5OOwrshS+LkgT2SeFzt+BbNsS0bi69YHB/RK9e20m5wPb1A5CWy7IZiKr4cfJRObDEEtOnyMFB0p+yr6SLoMflEuF6/mTvOYTTgV+lP3s29u888OCsbNYPBUheR1TtFIXgEviDZOAq10I3nGLTdkijTIiRF/SnTkcNAaRNLFRik4DFYdzEVuPLqBIypip0YimktbMgGpOzYwUUQ8EgvKe7qwaiBwdYhnJq1OhOwDiQRXqTi91aHZqJlvUbmP1hMlCAUukCkp3xQnRWy3b4b4l8wQs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3baee3-b94f-4ab4-b70d-08d7010340e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 04:42:57.9740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5479
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>
>Hi,
>
>Greg KH <greg@kroah.com> writes:
>
>> On Thu, Jul 04, 2019 at 12:44:08PM +0300, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Pawel Laszczak <pawell@cadence.com> writes:
>>>
>>> >>
>>> >>
>>> >>Hi,
>>> >>
>>> >>Pawel Laszczak <pawell@cadence.com> writes:
>>> >>
>>> >>>>
>>> >>>>Hi,
>>> >>>>
>>> >>>>On Thu, Jul 4, 2019 at 9:59 AM Greg KH <greg@kroah.com> wrote:
>>> >>>>>
>>> >>>>> On Thu, Jul 04, 2019 at 04:34:58PM +1000, Stephen Rothwell wrote:
>>> >>>>> > Hi all,
>>> >>>>> >
>>> >>>>> > After merging the usb tree, today's linux-next build (arm
>>> >>>>> > multi_v7_defconfig) failed like this:
>>> >>>>> >
>>> >>>>> > arm-linux-gnueabi-ld: drivers/usb/dwc3/trace.o: in function `tr=
ace_raw_output_dwc3_log_ctrl':
>>> >>>>> > trace.c:(.text+0x119c): undefined reference to `usb_decode_ctrl=
'
>>> >>>>> >
>>> >>>>> > Caused by commit
>>> >>>>> >
>>> >>>>> >   3db1b636c07e ("usb:gadget Separated decoding functions from d=
wc3 driver.")
>>> >>>>> >
>>> >>>>> > I have used the usb tree from next-20190703 for today.
>>> >>>>> >
>>> >>>>> > This also occurs in the usb-gadget tree so I have used the vers=
ion of
>>> >>>>> > that from next-20190703 as well.
>>> >>>>>
>>> >>>>> Odd, I thought I pulled the usb-gadget tree into mine.  Felipe, c=
an you
>>> >>>>> take a look at this to see if I messed something up?
>>> >>>>
>>> >>>>This looks like it was caused by Pawel's patches.
>>> >>>>
>>> >>>>I'll try to reproduce here and see what's causing it.
>>> >>>
>>> >>> Problem is in my Patch. I reproduced it, but I don't understand why=
 compiler
>>> >>> complains about usb_decode_ctrl. It's compiled into libcomposite.ko=
 and
>>> >>> declaration is in drivers/usb/gadget.h.
>>> >>
>>> >>That's because in multi_v7_defconfig dwc3 is built-in while libcompos=
ite
>>> >>is a module:
>>> >>
>>> >>CONFIG_USB_DWC3=3Dy
>>> >>CONFIG_USB_LIBCOMPOSITE=3Dm
>>> >>
>>> >>
>>> >>I remember that when you were doing this work, I asked you to move
>>> >>functions to usb/common. Why did you deviate from that suggestion? It=
's
>>> >>clear that decoding a ctrl request can be used by peripheral and host
>>> >>and we wouldn't have to deal with this problem if you had just follow=
ed
>>> >>the suggestion.
>>> >
>>> > Some time ago Greg wrote:
>>> > " It's nice to have these in a common place, but you just bloated all=
 of
>>> > the USB-enabled systems in the world for the use of 2 odd-ball system
>>> > controllers that almost no one has :) "
>>> >
>>> > So I moved these functions to gadget directory.
>>> >
>>> > It was mistake that I added debug.c file to libcomposite.ko.
>>>
>>> The plan is to use this decoding function for xHCI as well. Other host
>>> controllers can use it as well.
>>>
>>> The biggest mistake was to put this under gadget. What you should have
>>> done was create a file under usb/common that only gets compile in if
>>> tracing is enabled.
>>>
>>> Then there's no bloating unless you have a kernel purposefuly built for
>>> debugging and tracing.
>>>
>>> Greg, does that work for you?
>>
>> I guess, but I'd like to see patches before answering that :)
>
>Sure, understandable. I should've done a better job at filtering that
>out. Sorry about htat

I will return debug.c again to usb/common directory.=20
I made it as suggested by Felipe.
I will try correct this patches on Monday.=20

I apologize for my mistake and for wasting your time.

Regards,
Pawel.
 =20
