Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66819C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238DD20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="OheWp6br";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="BbwTQftl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfHLK1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:27:04 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:18854 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727678AbfHLK1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:27:03 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CAM72L030010;
        Mon, 12 Aug 2019 03:26:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=rAaqBJw3QtHyTYAXsn/aIsUwBCktT6oFG0kU7VejlY8=;
 b=OheWp6brGQYirShwElly4iVfQOhALTn0BB2wmSCJ+sY7qCfKp3dD+dEQ7Jv3QN9zP9MZ
 tAeMmyR6sKTaFQ5EWpOzgPjwVinPYQzGdGIRgHQ7eQOcX9U00UFd8hDVP/zaG/uVcgBP
 WoQJWNxa8CmE4C3DrqUSkmla5SVFU0DYI0tZiM8iMqwIxU+bFb5maYR2ojsp6zlDH46r
 pVorRjzjI6qPh0Vk1rX9m2RO1+IWOEYFF1fEUJP/U6yShWe8dyptymkjrScFXyIumTE+
 jIF87oHGNM9MFJOXKvKRki9au/32NPpYYtbfvX9HU3cIpLRUqFdlff+/Vj+Ei3bE/aBd RQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2051.outbound.protection.outlook.com [104.47.36.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2u9tfs5akk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 03:26:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEq28/v18nsJuZRvzvn7YdkR+gZQxARxttg+ha4h+rTGJG91VBdhKZ2iTIyux6ciVHEcFgSPW4OzyLQpeuG6+hycyU7ZWcdVwwJuVRB3Nifg58sACQoSINaggqb6mAQnsH9LXqU1DstAw887eWEs4eWmKPROF8TgFVIlF4noFS2Hoatj558aojgAeoxKfSrFJ2qpSXqvXFuAfc8y/HEz1P5Y+haRvRbaeVTCCbvfVXjsaKueFsM+Oo3S2UvMvYSvZKCzSZ0rmuqZPbapwOfSg4qI6e4ondG7u721w3mSK+j8fMf+F4RxWFtSx4UbtcuTj2aeBdFe+Gksz5tajJiftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAaqBJw3QtHyTYAXsn/aIsUwBCktT6oFG0kU7VejlY8=;
 b=BOsc0ZbmFqaYTsah02ug7f4kahlGyQ7+2xMTIioVNha1DLOJT8A2o4A1IiR2BEKlVC3el1TyV2vGa92yA31vJAdxLYzHarI3oR3ycAbtZnmG6utqfdHAyXrALXtOc2OcgH7m4TuWaPRzoNHIJfgeTIa934JG6iadhy3cGsSzs/2YY+L3vN+pLBGC/yC7eL7sTB8Bbc5gCOCXT/ncy7imE0C0y2yiP6uJli09NuyTRwrS0MLzewqyfqkiGmmklP5m8wvQScjWihTvBHwIZj9nNMDnoHKnCdZ69NruQYba2pGBNxcOpA1sddOrEf30dX1zcy5tTZFTUK0fnFbghDS7GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAaqBJw3QtHyTYAXsn/aIsUwBCktT6oFG0kU7VejlY8=;
 b=BbwTQftlXCsZezC7JE0ea6EW9v447j3oz5SOR/bfqRSPX6stLgbyAdtrqYRJIjn3yM7d53xyt4dZsUxT+8okrIXcwbxdF0IEc+gpZBs5zEnd0blKqm1JTiQP1NOxmsiYY0FxEmdAWFSV9W8uv8V8sWWZeN50nldMHK66v+RNFcA=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4998.namprd07.prod.outlook.com (52.135.238.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Mon, 12 Aug 2019 10:26:49 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e%7]) with mapi id 15.20.2136.022; Mon, 12 Aug 2019
 10:26:49 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHVMyCBLRb+XoB9zUqxphM8AIPBC6bAUmQAgAroVsCAJHZ6gIAFRjxwgAI+roCAAAREAIAALKOAgAAG8gCAABEiAIAABvIA
Date:   Mon, 12 Aug 2019 10:26:49 +0000
Message-ID: <BYAPR07MB470931F8C699784CC88E21CBDDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-6-git-send-email-pawell@cadence.com>
 <877e8tm25r.fsf@linux.intel.com>
 <BYAPR07MB4709152CB29B6B027ABEB688DDCF0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <8736idnu0q.fsf@gmail.com>
 <BYAPR07MB4709B0A4FADFB76183D651DCDDD10@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87k1bjvtvi.fsf@gmail.com>
 <BYAPR07MB470926DA6241B54FC5AF3C2ADDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87imr2u77c.fsf@gmail.com>
 <BYAPR07MB4709C07ED94C952886858F14DDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87d0hau37p.fsf@gmail.com>
In-Reply-To: <87d0hau37p.fsf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOGExMTQ0MjAtYmNlYi0xMWU5LTg3NDUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDhhMTE0NDIxLWJjZWItMTFlOS04NzQ1LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNTYyMiIgdD0iMTMyMTAwNzkxNDQxODQ1MDAwIiBoPSJSa2UrckFNMzVmYzhvWEN0SHBMRng5VEdPVTg9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-paste: 
x-dg-rorf: 
x-originating-ip: [158.140.1.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7588da68-400b-4c07-3e76-08d71f0f95b6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB4998;
x-ms-traffictypediagnostic: BYAPR07MB4998:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB4998FF275C2F23D71FF59EE4DDD30@BYAPR07MB4998.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(189003)(199004)(36092001)(51444003)(305945005)(71190400001)(71200400001)(76176011)(7696005)(74316002)(6506007)(25786009)(478600001)(7416002)(7736002)(64756008)(45080400002)(66446008)(66946007)(76116006)(66476007)(66556008)(229853002)(6436002)(99286004)(54906003)(110136005)(316002)(3846002)(52536014)(107886003)(6116002)(8936002)(86362001)(81166006)(26005)(81156014)(53936002)(9686003)(2501003)(66066001)(33656002)(186003)(14444005)(256004)(6246003)(5660300002)(2906002)(55016002)(446003)(8676002)(11346002)(476003)(4326008)(102836004)(486006)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4998;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zqJQo/SLlyM88qWfrHho6VujtVrsChYGGzjMOHiqgSp4Wsx5lT3Q/9lTyPxej6tfUzi4Nk+mk60rR9++xJKZzwE85dmMet4mlKMK82aHyBFyTXV9wefkYdyo1IIKj1i0mYi4+xAhnM+kBF6oihjRHODoE8z1CXpf4FI8uBi0NS3Bmhw/OSI5pSGjdv5hM+2E3Iy1XfJmvoem7f4mvX15C248SdbuMibJV5laVdZ2MKkMV7idhLKyAh9pKqGmBSnaQnlS8i36Qp08bifHBeqLW5vrIJB5uCE0PB5bj5yxCoUtLQy6a0HLpNhO7kqUFqCeR7b4veoXKenfRWQWOkkGydQE/oSZOadiHogTeTjOeztbwbHTpJ3DXDd2Uno0WeVsiG9SLa8wrPT1QmDJ+dxTtRX5qfsaOKcb41+HsSCsNeY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7588da68-400b-4c07-3e76-08d71f0f95b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 10:26:49.1254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4998
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=987 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hi,
>
>Pawel Laszczak <pawell@cadence.com> writes:
>>>>>>>Quick question, then: these ISTS registers, are they masked interrup=
t
>>>>>>>status or raw interrupt status?
>>>>>>
>>>>>> Yes it's masked, but after masking them the new interrupts will not =
be reported
>>>>>> In ISTS registers. Form this reason I can mask only reported interru=
pt.
>>>>>
>>>>>and what happens when you unmask the registers? Do they get reported?
>>>>
>>>> No they are not reported in case of USB_ISTS register.
>>>> They should be reported in case EP_ISTS, but I need to test it.
>>>
>>>okay, please _do_ test and verify the behavior. The description above
>>>sounds really surprising to me. Does it really mean that if you mask all
>>>USB_ISTS and then disconnect the cable while interrupt is masked, you
>>>won't know cable was disconnected?
>>
>> Yes, exactly.
>>
>> Initially I've tested it and it's work correct.
>> I can even simply write 0 to EP_IEN in hard irq and ~0 in thread handler=
.
>> It's simplest and sufficient way.
>
>okay. Just to be sure I understand correctly. If you mask USB_IEN, then
>we would miss a cable disconnect event. Right?
>
>>>>>>>>>> +		struct cdns3_aligned_buf *buf, *tmp;
>>>>>>>>>> +
>>>>>>>>>> +		list_for_each_entry_safe(buf, tmp, &priv_dev->aligned_buf_lis=
t,
>>>>>>>>>> +					 list) {
>>>>>>>>>> +			if (!buf->in_use) {
>>>>>>>>>> +				list_del(&buf->list);
>>>>>>>>>> +
>>>>>>>>>> +				spin_unlock_irqrestore(&priv_dev->lock, flags);
>>>>>>>>>
>>>>>>>>>creates the possibility of a race condition
>>>>>>>> Why? In this place the buf can't be used.
>>>>>>>
>>>>>>>but you're reenabling interrupts, right?
>>>>>>
>>>>>> Yes, driver frees not used buffers here.
>>>>>> I think that it's the safest place for this purpose.
>>>>>
>>>>>I guess you missed the point a little. Since you reenable interrupts
>>>>>just to free the buffer, you end up creating the possibility for a rac=
e
>>>>>condition. Specially since you don't mask all interrupt events. The
>>>>>moment you reenable interrupts, one of your not-unmasked interrupt
>>>>>sources could trigger, then top-half gets scheduled which tries to wak=
e
>>>>>up the IRQ thread again and things go boom.
>>>>
>>>> Ok, I think I understand.  So I have 3 options:
>>>> 1. Mask the USB_IEN and EP_IEN interrupts, but then I can lost some US=
B_ISTS
>>>> events. It's dangerous options.
>>>
>>>sure sounds dangerous, but also sounds quite "peculiar" :-)
>>>
>>>> 2. Remove implementation of handling unaligned buffers and assume that
>>>>     upper layer will worry about this. What with vendor specific drive=
rs that
>>>>     can be used by companies and not upstreamed  ?
>>>>     It could be good to have such safety mechanism even if it is not c=
urrently used.
>>>
>>>dunno. It may become dead code that's NEVER used :-)
>>>
>>>> 3. Delegate this part of code for instance to separate thread that wil=
l be called
>>>>    In free time.
>>>
>>>Yet another thread? Can't you just run this right before giving back the
>>>USB request? So, don't do it from IRQ handler, but from giveback path?
>>
>> Do you mean in:
>> 	if (request->complete) {
>> 		spin_unlock(&priv_dev->lock);
>> 		if (priv_dev->run_garbage_collector) {
>> 			....
>> 		}
>> 		usb_gadget_giveback_request(&priv_ep->endpoint,
>> 					    request);
>> 		spin_lock(&priv_dev->lock);
>> 	}
>> ??
>
>right, you can do it right before giving back the request. Or right
>after.
>
>> I ask because this is finally also called from IRQ handler:
>>
>> cdns3_device_thread_irq_handler
>>     -> cdns3_check_ep_interrupt_proceed
>>         -> cdns3_transfer_completed
>>             -> cdns3_gadget_giveback
>>                 -> usb_gadget_giveback_request
>
>Did you notice that it doesn't reenable interrupts, though?

I noticed that there is a lack of reenabling interrupts :)

The problem is that If I have disabled interrupt the kernel complains
for using dma_free_coherent function in such place.=20

Here you have a fragment of complaints:=20
[ 7420.502863] WARNING: CPU: 0 PID: 10260 at kernel/dma/mapping.c:281 dma_f=
ree_attrs+0xa0/0xd0
[ 7420.502866] Modules linked in: usb_f_mass_storage cdns3(OE) cdns3_pci_wr=
ap(OE) libcomposite
		...
[ 7420.502965]  cdns3_gadget_giveback+0x159/0x2a0 [cdns3]
[ 7420.502975]  cdns3_transfer_completed+0xc5/0x3c0 [cdns3]
[ 7420.502986]  cdns3_device_thread_irq_handler+0x1b1/0xab0 [cdns3]
[ 7420.502991]  ? __schedule+0x333/0x7e0
[ 7420.503001]  irq_thread_fn+0x26/0x60
[ 7420.503006]  ? irq_thread+0xa8/0x1b0
[ 7420.503011]  irq_thread+0x10e/0x1b0
[ 7420.503015]  ? irq_forced_thread_fn+0x80/0x80
[ 7420.503021]  ? wake_threads_waitq+0x30/0x30
[ 7420.503029]  kthread+0x12c/0x150
[ 7420.503034]  ? irq_thread_check_affinity+0xe0/0xe0
[ 7420.503038]  ? kthread_park+0x90/0x90
[ 7420.503045]  ret_from_fork+0x3a/0x50
[ 7420.503061] irq event stamp: 2962
[ 7420.503065] hardirqs last  enabled at (2961): [<ffffffffb252672c>] _raw_=
spin_unlock_irq+0x2c/0x40
[ 7420.503070] hardirqs last disabled at (2962): [<ffffffffb25268f5>] _raw_=
spin_lock_irqsave+0x25/0x60
[ 7420.503074] softirqs last  enabled at (2918): [<ffffffffb2800340>] __do_=
softirq+0x340/0x451
[ 7420.503079] softirqs last disabled at (2657): [<ffffffffb1aa02b6>] irq_e=
xit+0xc6/0xd0
[ 7420.503082] ---[ end trace d02652af11011c3b ]---

Maybe it's a bug in implementation of this function.  I allocate memory wit=
h flag GFP_ATOMIC with=20
disabled interrupt, but I can't free such memory.=20

--
pawell
