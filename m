Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899EFC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5980C21882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="fCWjOqVr";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="pLCBEvJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfGDJIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:08:30 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:51794 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727092AbfGDJI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:08:29 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64949Nj019166;
        Thu, 4 Jul 2019 02:08:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Uulk9jfDKVY+nDPJVMCTg42Zt8+2QqHBezJ5UVkOWUs=;
 b=fCWjOqVrDCm4sPTC/jEDOyujEuMSBCOlO+bQvLtixY6MDq87Oy/qeXwCv+4Yf3V5n0Bz
 0BntlsE2+B5nTaYcvh9O8I2fcURIiGt8XxAkylaKdocazS+Z5TzERVjkqR0HgBkde77F
 Fh+ryciGP4Wj4GJjjAJCR1Hes6J1v9WdtABGVp/2EpwNX10D4uW53nwW3j3kfcedwlbc
 P1j8EQUWSTBlnGpXUkL7IVUSuyLYQgfWXKmbwj5Sg5BuMfHDiBA2Ph1QFVmU9qvh2l/R
 EDNw/1cmi9b2hNNqC6bYUM5WtO3JjRf4hDvLf3e6vCFdakTqiSvm++z6gdse6+yRvj8y KQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2053.outbound.protection.outlook.com [104.47.33.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2tgwvj3qn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 02:08:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=NSvEVeVaQqRZZ9/+v3el4YjtxBCmYAUUwCeGHNNVR3ptVnPGJnJAfWqWtDzMctx6pAL0tQl57p1VBJGM8WmYIOf7YF0W8PTU/yWDyTNPy4CnhDMJzLVZs1krXVRNK2cg9hSPsk1a9MoycHzDvP1zGqh644pPIkD0x8vt7TJu3eI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uulk9jfDKVY+nDPJVMCTg42Zt8+2QqHBezJ5UVkOWUs=;
 b=Rj/xEhasfCj0Lfv+g0oar8ZPLaMKXNI1q72RwHwl4sGIrQeu+bun46HM54U02717nvXA3nO0RUqMHgl7tDYC34FCz/En27xE4Iie0ZrW2QZgoyesBBZ3iqhuhuhv55RXGEv3Jqse+p+BpVIhUg5UXSnTOecL2SEsJTAh2f/VaSw=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uulk9jfDKVY+nDPJVMCTg42Zt8+2QqHBezJ5UVkOWUs=;
 b=pLCBEvJXM9veSiVhm6M3euYxB80Hk94GOQmmQz6k+i3zVd7aqwXoBJiNKnZEdmGXVpZcNB7Nn5ljhFY1BYg4hlEjib2LoZlXp9qwrRCYKkhnRowkmCfPexJvyQ9bYkgW6uyJ7mL5UsTmdiW9kxZz2raIRKADz0+vGBFrO7i5F6I=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4488.namprd07.prod.outlook.com (52.135.225.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Thu, 4 Jul 2019 09:08:07 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2%6]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 09:08:06 +0000
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
Thread-Index: AQHVMjKg7+jonhPbpUSjvye7Qm/1waa6B76AgAAICQCAAAlA8IAABpcAgAAIkzA=
Date:   Thu, 4 Jul 2019 09:08:06 +0000
Message-ID: <BYAPR07MB4709076903F55352193FC78FDDFA0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20190704163458.63ed69d2@canb.auug.org.au>
 <20190704065949.GA32707@kroah.com>
 <CAH8TKc_4ggxOPgii8gLGo2d7nvx08cbTk8_xDUQfA2Ckcxb_Aw@mail.gmail.com>
 <BYAPR07MB470946609232100714B3EA29DDFA0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87imsiyzo3.fsf@linux.intel.com>
In-Reply-To: <87imsiyzo3.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctM2E1MDZlODYtOWUzYi0xMWU5LTg3NDItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDNhNTA2ZTg4LTllM2ItMTFlOS04NzQyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzIwOSIgdD0iMTMyMDY3MDQ4ODQwMzQ5MjE5IiBoPSJjaHBudVl6VHM3NkJrZGFWV2hJOTVYTlljT0E9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58550bc8-4866-4215-501e-08d7005f20e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB4488;
x-ms-traffictypediagnostic: BYAPR07MB4488:
x-microsoft-antispam-prvs: <BYAPR07MB4488940415EB8822147EFB19DDFA0@BYAPR07MB4488.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(36092001)(199004)(189003)(53754006)(9686003)(102836004)(2906002)(6506007)(71200400001)(3846002)(73956011)(66946007)(6436002)(71190400001)(14444005)(8936002)(66066001)(6116002)(110136005)(5660300002)(54906003)(52536014)(76116006)(55016002)(68736007)(86362001)(316002)(256004)(66446008)(66556008)(64756008)(66476007)(11346002)(486006)(8676002)(446003)(478600001)(14454004)(33656002)(26005)(305945005)(229853002)(81156014)(81166006)(74316002)(7736002)(6246003)(25786009)(76176011)(7696005)(4326008)(476003)(186003)(53936002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4488;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MONgNTC6O7ifF9Puv8/1jUQmrSPnmVQOh6KzjNzNnaQjRXSuYAXre1AOH2q6HAyoBRVAxAhjB3+zASGqbo4m/DQz6kyRiv9oedlOTSzznmzNHnjj6I+0bCcfsFgfO5BRJ2MAcGA8ijtmKOm3jbDChvZLWas8Dej2m4YjAC4WhAn4wWKm/FGIfD48s5SaeyWfGsCyRtmrQfAbKsrAZwbCgMaeijuX7s5D7eNvuXFMTY2ZAiKDiDqh02mXl5f1EH8fy6wq7y4ScCdfG2DZyZTSjXD3VPVQHfTJkz1LsOCE70U1aj4VMFTmut5R4O+jYU/Up3EkNvuxnXrXHAVtsMRE2BbDoeb2Vh/yoIyRnes1RUn7zY8M/eKSOMAwlqzHs7JXAR/PlV2wDPbPr/sCdq77JRtiIXgAYbQYvtT2QJq8gk0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58550bc8-4866-4215-501e-08d7005f20e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 09:08:06.8565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4488
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
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Hi,
>
>Pawel Laszczak <pawell@cadence.com> writes:
>
>>>
>>>Hi,
>>>
>>>On Thu, Jul 4, 2019 at 9:59 AM Greg KH <greg@kroah.com> wrote:
>>>>
>>>> On Thu, Jul 04, 2019 at 04:34:58PM +1000, Stephen Rothwell wrote:
>>>> > Hi all,
>>>> >
>>>> > After merging the usb tree, today's linux-next build (arm
>>>> > multi_v7_defconfig) failed like this:
>>>> >
>>>> > arm-linux-gnueabi-ld: drivers/usb/dwc3/trace.o: in function `trace_r=
aw_output_dwc3_log_ctrl':
>>>> > trace.c:(.text+0x119c): undefined reference to `usb_decode_ctrl'
>>>> >
>>>> > Caused by commit
>>>> >
>>>> >   3db1b636c07e ("usb:gadget Separated decoding functions from dwc3 d=
river.")
>>>> >
>>>> > I have used the usb tree from next-20190703 for today.
>>>> >
>>>> > This also occurs in the usb-gadget tree so I have used the version o=
f
>>>> > that from next-20190703 as well.
>>>>
>>>> Odd, I thought I pulled the usb-gadget tree into mine.  Felipe, can yo=
u
>>>> take a look at this to see if I messed something up?
>>>
>>>This looks like it was caused by Pawel's patches.
>>>
>>>I'll try to reproduce here and see what's causing it.
>>
>> Problem is in my Patch. I reproduced it, but I don't understand why comp=
iler
>> complains about usb_decode_ctrl. It's compiled into libcomposite.ko and
>> declaration is in drivers/usb/gadget.h.
>
>That's because in multi_v7_defconfig dwc3 is built-in while libcomposite
>is a module:
>
>CONFIG_USB_DWC3=3Dy
>CONFIG_USB_LIBCOMPOSITE=3Dm
>
>
>I remember that when you were doing this work, I asked you to move
>functions to usb/common. Why did you deviate from that suggestion? It's
>clear that decoding a ctrl request can be used by peripheral and host
>and we wouldn't have to deal with this problem if you had just followed
>the suggestion.

Some time ago Greg wrote:=20
" It's nice to have these in a common place, but you just bloated all of
the USB-enabled systems in the world for the use of 2 odd-ball system
controllers that almost no one has :) "

So I moved these functions to gadget directory.=20

It was mistake that I added debug.c file to libcomposite.ko.

>
>Now we have to come up with a way to fix this that doesn't involve
>reverting my part2 tag in its entirety because there are other important
>things there.
>
>This is what I get for trusting people to do their part. I couldn't even
>compile test this since I don't have ARM compilers anymore (actually,
>just installed to test). Your customer, however, uses ARM cores so I
>would expect you to have at least compile tested this on ARM. How come
>this wasn't verified by anybody at TI?
>
>TI used to have automated testing for many of the important defconfigs,
>is that completely gone? Are you guys relying entirely on linux-next?
>
>Greg, if you prefer, please revert my part2 tag. If you do so, please
>let me know so I can drop the tag and commits from my tree as well.
>
>Pawel, please make sure this never happens again. It's pretty simple to
>avoid this sort of thing. I'll keep ARM compiler installed for
>build-testing as well.
>
>--
>balbi
