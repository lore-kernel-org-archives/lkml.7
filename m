Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FEBC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01E8218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="gl8OONJB";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="n310WPAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfGDJZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:25:35 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:15584 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727204AbfGDJZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:25:34 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x649NdkQ004093;
        Thu, 4 Jul 2019 02:25:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=+WLYQS+5Y2lnoJdw2ct1wgm/lHaA0FbKTLe9IBP7JEA=;
 b=gl8OONJBfSTj2xrQ1g0P8v6f5A+gClUbwG2rEHiy45v8o/85TwtVQcmgOwOcnMumNHp1
 iQeUY377+F7ABb7RApWwbC2fUdijWr+jYEc/4Yt3bgMhPVofZZujx5o/WUdEWN27Tm/m
 t3SQ1FoUWShvF30qWeeCmONLkkwOpXIPIqWQmXG0SvqyxOv+m3xMUhduksaZnJZT5nge
 tMb32wmV4gZLdXwAZVnb5nB5lATUmEuyCbgaatH4X9s7sAyYm/F/4w3ZwKfeVR1sBoRz
 wbOi30JSOSHZGSH7RCSijwbi8W+phviTLobxLjkdfvbNiTMqrm8lRidOSmW5p6ms2BEx zw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2051.outbound.protection.outlook.com [104.47.41.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2tgwvj3sjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 02:25:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WLYQS+5Y2lnoJdw2ct1wgm/lHaA0FbKTLe9IBP7JEA=;
 b=n310WPARd7ktY8MBIEIlb+UbI6h1AaPEtILUgJ3tVqcimPcs3rj9sIYrpur/Buwz8Wnbk+b3VYOgzzDOfZNcYcVPDncZ0l90mbtN2Ad0mWAULVjg6dQJeicigvD0Jb6msAZRw0NY4oWIx1yTSv/l98lOur6fzW5Ht3mP78gB1n0=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5703.namprd07.prod.outlook.com (20.178.0.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 09:25:12 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2%6]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 09:25:12 +0000
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
Thread-Index: AQHVMjKg7+jonhPbpUSjvye7Qm/1waa6B76AgAAICQCAAAlA8IAABpcAgAAIkzCAAAYBoA==
Date:   Thu, 4 Jul 2019 09:25:12 +0000
Message-ID: <BYAPR07MB4709BB98AE258C4AC4EE6F60DDFA0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20190704163458.63ed69d2@canb.auug.org.au>
 <20190704065949.GA32707@kroah.com>
 <CAH8TKc_4ggxOPgii8gLGo2d7nvx08cbTk8_xDUQfA2Ckcxb_Aw@mail.gmail.com>
 <BYAPR07MB470946609232100714B3EA29DDFA0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87imsiyzo3.fsf@linux.intel.com>
 <BYAPR07MB4709076903F55352193FC78FDDFA0@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB4709076903F55352193FC78FDDFA0@BYAPR07MB4709.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOWQ4MzNkMGEtOWUzZC0xMWU5LTg3NDItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDlkODMzZDBjLTllM2QtMTFlOS04NzQyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzY2MyIgdD0iMTMyMDY3MDU5MDk0NTI3MzYwIiBoPSJpMmU1YlNGc0UwczJ5TzlOa0s2QjNIUzQ3MEk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9550f2e0-443f-40d0-b140-08d700618441
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5703;
x-ms-traffictypediagnostic: BYAPR07MB5703:
x-microsoft-antispam-prvs: <BYAPR07MB57036014FC3973AF44B84AC0DDFA0@BYAPR07MB5703.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(36092001)(53754006)(199004)(189003)(51444003)(86362001)(66066001)(316002)(14454004)(74316002)(305945005)(25786009)(54906003)(2940100002)(6246003)(66556008)(33656002)(64756008)(53936002)(66476007)(66446008)(7736002)(2906002)(110136005)(478600001)(186003)(229853002)(8676002)(81166006)(9686003)(99286004)(26005)(11346002)(73956011)(76176011)(6116002)(52536014)(4326008)(8936002)(5660300002)(68736007)(7696005)(81156014)(476003)(6436002)(256004)(6506007)(14444005)(55016002)(66946007)(71200400001)(3846002)(486006)(102836004)(446003)(76116006)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5703;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0ZJEiP/le4+20LfkJEil17XkljovgjI23v9+hKjiATF9FJhMtHmGQAY2aQkB/HchIQ5qfFVl3+/t2kTykyC4bOd98N3L9gK4/B1lSsfsAdN6uK01vvnq2uqQJZyBGXwpqD3oRw0ZmXVmi4vXQmLFprz3kXW+2Cf1PTaHPXxNrHeAjqy/0SXW9PCmJXjIBe2lvI0fM77RTAdtMaU5YPU6c0dRrKBlTMRjihry/eqClE8yKs4T40D3j/LK5egJJk/hVkKZPv1xvwglYPlcgOQjXmsJWxZx1MoxWGr3pBpkywpVdtw7+2zm7OZvIPVWa2KAiH7B3XC4vURSeeKBvKcWPPhmLV4cxy36jbYCiPd5cKJZ2nW7zo0xzm+vPw8NRWGQTx4qcT6yJJitbBA8UweNMaDhlCGpBPGmgUbwXJPhc9A=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9550f2e0-443f-40d0-b140-08d700618441
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 09:25:12.5980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5703
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>>
>>Hi,
>>
>>Pawel Laszczak <pawell@cadence.com> writes:
>>
>>>>
>>>>Hi,
>>>>
>>>>On Thu, Jul 4, 2019 at 9:59 AM Greg KH <greg@kroah.com> wrote:
>>>>>
>>>>> On Thu, Jul 04, 2019 at 04:34:58PM +1000, Stephen Rothwell wrote:
>>>>> > Hi all,
>>>>> >
>>>>> > After merging the usb tree, today's linux-next build (arm
>>>>> > multi_v7_defconfig) failed like this:
>>>>> >
>>>>> > arm-linux-gnueabi-ld: drivers/usb/dwc3/trace.o: in function `trace_=
raw_output_dwc3_log_ctrl':
>>>>> > trace.c:(.text+0x119c): undefined reference to `usb_decode_ctrl'
>>>>> >
>>>>> > Caused by commit
>>>>> >
>>>>> >   3db1b636c07e ("usb:gadget Separated decoding functions from dwc3 =
driver.")
>>>>> >
>>>>> > I have used the usb tree from next-20190703 for today.
>>>>> >
>>>>> > This also occurs in the usb-gadget tree so I have used the version =
of
>>>>> > that from next-20190703 as well.
>>>>>
>>>>> Odd, I thought I pulled the usb-gadget tree into mine.  Felipe, can y=
ou
>>>>> take a look at this to see if I messed something up?
>>>>
>>>>This looks like it was caused by Pawel's patches.
>>>>
>>>>I'll try to reproduce here and see what's causing it.
>>>
>>> Problem is in my Patch. I reproduced it, but I don't understand why com=
piler
>>> complains about usb_decode_ctrl. It's compiled into libcomposite.ko and
>>> declaration is in drivers/usb/gadget.h.
>>
>>That's because in multi_v7_defconfig dwc3 is built-in while libcomposite
>>is a module:
>>
>>CONFIG_USB_DWC3=3Dy
>>CONFIG_USB_LIBCOMPOSITE=3Dm
>>
>>
>>I remember that when you were doing this work, I asked you to move
>>functions to usb/common. Why did you deviate from that suggestion? It's
>>clear that decoding a ctrl request can be used by peripheral and host
>>and we wouldn't have to deal with this problem if you had just followed
>>the suggestion.
>
>Some time ago Greg wrote:
>" It's nice to have these in a common place, but you just bloated all of
>the USB-enabled systems in the world for the use of 2 odd-ball system
>controllers that almost no one has :) "
>
>So I moved these functions to gadget directory.
>
>It was mistake that I added debug.c file to libcomposite.ko.
>

I think that the best choice is leaving debug.c file=20
In drivers/usb/gadget/ directory.=20

But to do this I must to add this file to drivers/usb/dwc3/Makefile file an=
d=20
drivers/usb/cdns3/Makefile. The code will be compiled into both drivers,
It will increase the size of kernel only when these driver will be enabled.

What do you think about such solution ?=20

>>
>>Now we have to come up with a way to fix this that doesn't involve
>>reverting my part2 tag in its entirety because there are other important
>>things there.
>>
>>This is what I get for trusting people to do their part. I couldn't even
>>compile test this since I don't have ARM compilers anymore (actually,
>>just installed to test). Your customer, however, uses ARM cores so I
>>would expect you to have at least compile tested this on ARM. How come
>>this wasn't verified by anybody at TI?
>>
>>TI used to have automated testing for many of the important defconfigs,
>>is that completely gone? Are you guys relying entirely on linux-next?
>>
>>Greg, if you prefer, please revert my part2 tag. If you do so, please
>>let me know so I can drop the tag and commits from my tree as well.
>>
>>Pawel, please make sure this never happens again. It's pretty simple to
>>avoid this sort of thing. I'll keep ARM compiler installed for
>>build-testing as well.
>>
>>--
>>balbi
