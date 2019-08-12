Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E6DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B635A2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="eHb+W0ex";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="1ZnFruQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfHLJQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:16:14 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:19438 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727170AbfHLJQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:16:14 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7C997UK012808;
        Mon, 12 Aug 2019 02:14:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=TEN89MwqriwykkFu6W2Gua5APpB8sMveuFB64GPXbEA=;
 b=eHb+W0exf0dDnjLI/w7/cLjQBjDLQeHm5NXTdKcgfQI66J5yNmRUcpcE3Ph6OhjQ/3sK
 242p4ec0vWvNJ1qRbKneBXIl+0ikFptlTHekppaddNOpc+tbx3cQoz4OX3jkwXUNBb9p
 MA6SzNyZ1anps7D396zD2WEL7Ca89DdeJw7QohtnFHy0DA2OcJGOugQJ9T2jwEe9VLz9
 q7ah3CSCbfRZRRM7D446G6HKvqgzlsImiEAILxGcLW41gqmutODm57s2qFxKQTo7pNwk
 hfduBO7V/pahyjl7830cSxCep1kAwAzkPhKspye+/yswM1UCq/eT15OaMm9KIaqCSBT9 UQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2058.outbound.protection.outlook.com [104.47.41.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2u9sgyw9cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 02:14:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSAp+RY0nhQoWezkh0JYHX7qbzz3v/sY2f+B/k2XEvE4EdAQ+tglf/6n+BEQ7aKpUz41slxQwwoLZTsA45Ks1xr+z+Z4Qa6j4D/kvSCbfsCKUePnVnLVD/9UM1wCO6ju7PRo2Sng83pbmA27Uf1KcmZYl/tTQzg4wYVhIOtA66s8plfIMF5R09Z2whlEaDXTAZ1OcLgB22mR+6lkYfgE8utBoEyiVFOia+rBbrwuOsaxkwL/nj5VHPqUqgWov5OIQ51dBX5sUnz1BBiH+bZvD6qid63NsZZz2oE+ecm+8oeQx4/uarsq1ytE+WfyPm9v6x/+W0NPTXix63rQzMsc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEN89MwqriwykkFu6W2Gua5APpB8sMveuFB64GPXbEA=;
 b=Tq/1IuXqra+j/xkXSXz03+wDcBLFNZhoZqOr/M2r+nGk6D9Fhrd/WXOqyQy1oApH5CL4QNM2hwbLYeEVUyMb4nbM4hgKmtsxrsYdaz15zpbAYpTV9kg/L/1/3FeXMg6MQfRmLjPNUMsXQQP89IorgVfgK9jdzZGkwKBYt86C/XXaUaDasm5c9IZbdnmEvqVjIg+NccO2FIs9dbxaLuNS9m1ypQqGfMoQRXsPf0T9hqNsaU8cBt7Pg2u+tqI0jnspW5ZgGwdFide0qi6loqYf2UE+bGLW0aiM7HUT9fVbVgY8529xrPCdRAkXOyPjNu6HwXOM8h1jsf2fiyFZqhznrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEN89MwqriwykkFu6W2Gua5APpB8sMveuFB64GPXbEA=;
 b=1ZnFruQXvqd2bmzVDH6bvmy1FcuDl8snUOPBbT7Wl+6Y/9+aNfIa29GEZzGU9D/u1p1n9xKejEC16PTgScClAsRY6v0p6V1oshW3EoeGSBQzJvLgN+1d/4ULqPBbL30Q7Kd+qI8NUXrbELlplwWZw+Gehb2G16505asuyIAoFds=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB6389.namprd07.prod.outlook.com (20.179.89.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Mon, 12 Aug 2019 09:13:57 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e%7]) with mapi id 15.20.2136.022; Mon, 12 Aug 2019
 09:13:57 +0000
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
Thread-Index: AQHVMyCBLRb+XoB9zUqxphM8AIPBC6bAUmQAgAroVsCAJHZ6gIAFRjxwgAI+roCAAAREAIAALKOAgAAG8gA=
Date:   Mon, 12 Aug 2019 09:13:56 +0000
Message-ID: <BYAPR07MB4709C07ED94C952886858F14DDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-6-git-send-email-pawell@cadence.com>
 <877e8tm25r.fsf@linux.intel.com>
 <BYAPR07MB4709152CB29B6B027ABEB688DDCF0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <8736idnu0q.fsf@gmail.com>
 <BYAPR07MB4709B0A4FADFB76183D651DCDDD10@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87k1bjvtvi.fsf@gmail.com>
 <BYAPR07MB470926DA6241B54FC5AF3C2ADDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87imr2u77c.fsf@gmail.com>
In-Reply-To: <87imr2u77c.fsf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNWM4ODIxN2YtYmNlMS0xMWU5LTg3NDUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDVjODgyMTgwLWJjZTEtMTFlOS04NzQ1LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNTkxOCIgdD0iMTMyMTAwNzQ3NzI4MzU5OTAwIiBoPSJ5QThMeitjM0dtTjduLzZjYjVWTENFK0pHb1E9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-paste: 
x-dg-rorf: 
x-originating-ip: [158.140.1.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6695c21e-e8c7-4083-b36e-08d71f0567c9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB6389;
x-ms-traffictypediagnostic: BYAPR07MB6389:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB6389FA91BBA874BD56326AE9DDD30@BYAPR07MB6389.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(51444003)(36092001)(199004)(189003)(476003)(76176011)(11346002)(2906002)(446003)(7416002)(14454004)(66476007)(25786009)(9686003)(7736002)(53936002)(4326008)(478600001)(6246003)(71190400001)(71200400001)(64756008)(76116006)(6116002)(66946007)(6506007)(66556008)(66446008)(102836004)(3846002)(186003)(52536014)(33656002)(55016002)(5660300002)(26005)(74316002)(256004)(99286004)(81166006)(486006)(7696005)(305945005)(107886003)(14444005)(2501003)(86362001)(8936002)(316002)(66066001)(6436002)(81156014)(229853002)(54906003)(8676002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6389;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ho51/7RLSd8sizr8YGj89tVwMN6e/bgPZ3jqgxr2KZXfB61EQlFNc1WrgxvJoL1a8mIf3TAK/9nElkKx5E13SJUrnr7b1EZAMMPZLIAtFFYskJ4F63n0oKwyo2aFiE69ySsGqJOnogSnqEHJ36xlY6wwtW9eXyMb9g68TeX+coEYKvndw16V3o7Ouzeof2I8a1o6liaGBnCGSSfVJSJrWWW7+A4ORDiuOUQsvIkujOde3KvCdR3dgqpslc4LI4kzhdc+6hNZZCIF/of2DUHnehFHVdfptA4Mz9i/vbYzcnGHabmrFd87spmjF+uBY86N/5Col5EEKh6WV4mFxN5QGDqq1GPx5WWfMbxo1roXN9tNjel+EOByoCXDHVjbAOchVoZbKWt48jsLkVRHHZmYAA4mQDBj+GMpW/azBlRozsk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6695c21e-e8c7-4083-b36e-08d71f0567c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 09:13:57.0075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6389
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
>Pawel Laszczak <pawell@cadence.com> writes:
>>>> I have such situation in which one interrupt line is shared with ehci =
and cdns3 driver.
>>>> In such case this function returns error code.
>>>
>>>which function returns error code?
>>
>> devm_request_threaded_irq, of course if I set IRQF_SHARED | IRQF_ONESHOT=
.
>> As I remember it was EBUSY error.
>
>oh, right. That's probably because the handlers must agree on IRQ flags.
>
>>>> So probably I will need to mask only the reported interrupts.
>>>
>>>you should mask all interrupts from your device, otherwise you top-halt
>>>may still end up reentrant.
>>>
>>>> I can't mask all interrupt using controller register because I can mis=
s some of them.
>>>
>>>why would you miss them? They would be left in the register until you
>>>unmask them and the line is raised again.
>>
>> I consult this with author of controller.
>> We have:
>> USB_IEN  and USB_ISTS for  generic interrupts
>> EP_IEN and EP_ISTS for endpoint interrupts
>>
>> Both these group works different.
>> For endpoint I can disable all interrupt and I don't miss any of them.
>> So it's normal behavior.
>>
>> But USB_ISTS work little different. If we mask all interrupt in USB_IEN
>> then when new event occurs the EP_ISTS will not be updated.
>
>wait a minute. When you mask USB_ISTS, then EP_ISTS isn't updated? Is
>this a quirk on the controller or a design choice?
>
>> It's not standard and not expected behavior but it works in this way.
>
>Yeah, sounds rather odd.
>

Oh no. My mistake.  Of course I mean USB_ISTS.

If we mask all interrupt in USB_IEN
then when new event occurs the USB_ISTS will not be updated.

>>>>>>>> +	/* check USB device interrupt */
>>>>>>>> +	reg =3D readl(&priv_dev->regs->usb_ists);
>>>>>>>> +
>>>>>>>> +	if (reg) {
>>>>>>>> +		writel(reg, &priv_dev->regs->usb_ists);
>>>>>>>> +		cdns3_check_usb_interrupt_proceed(priv_dev, reg);
>>>>>>>> +		ret =3D IRQ_HANDLED;
>>>>>>>
>>>>>>>now, because you _don't_ mask this interrupt, you're gonna have
>>>>>>>issues. Say we actually get both device and endpoint interrupts whil=
e
>>>>>>>the thread is already running with previous endpoint interrupts. Now
>>>>>>>we're gonna reenter the top half, because device interrupts are *not=
*
>>>>>>>masked, which will read usb_ists and handle it here.
>>>>>>
>>>>>> Endpoint interrupts are masked in cdns3_device_irq_handler and stay =
masked
>>>>>> until they are not handled in threaded handler.
>>>>>
>>>>>Quick question, then: these ISTS registers, are they masked interrupt
>>>>>status or raw interrupt status?
>>>>
>>>> Yes it's masked, but after masking them the new interrupts will not be=
 reported
>>>> In ISTS registers. Form this reason I can mask only reported interrupt=
.
>>>
>>>and what happens when you unmask the registers? Do they get reported?
>>
>> No they are not reported in case of USB_ISTS register.
>> They should be reported in case EP_ISTS, but I need to test it.
>
>okay, please _do_ test and verify the behavior. The description above
>sounds really surprising to me. Does it really mean that if you mask all
>USB_ISTS and then disconnect the cable while interrupt is masked, you
>won't know cable was disconnected?

Yes, exactly.=20

Initially I've tested it and it's work correct.=20
I can even simply write 0 to EP_IEN in hard irq and ~0 in thread handler.=20
It's simplest and sufficient way. =20

>
>>>>>>>> +		struct cdns3_aligned_buf *buf, *tmp;
>>>>>>>> +
>>>>>>>> +		list_for_each_entry_safe(buf, tmp, &priv_dev->aligned_buf_list,
>>>>>>>> +					 list) {
>>>>>>>> +			if (!buf->in_use) {
>>>>>>>> +				list_del(&buf->list);
>>>>>>>> +
>>>>>>>> +				spin_unlock_irqrestore(&priv_dev->lock, flags);
>>>>>>>
>>>>>>>creates the possibility of a race condition
>>>>>> Why? In this place the buf can't be used.
>>>>>
>>>>>but you're reenabling interrupts, right?
>>>>
>>>> Yes, driver frees not used buffers here.
>>>> I think that it's the safest place for this purpose.
>>>
>>>I guess you missed the point a little. Since you reenable interrupts
>>>just to free the buffer, you end up creating the possibility for a race
>>>condition. Specially since you don't mask all interrupt events. The
>>>moment you reenable interrupts, one of your not-unmasked interrupt
>>>sources could trigger, then top-half gets scheduled which tries to wake
>>>up the IRQ thread again and things go boom.
>>
>> Ok, I think I understand.  So I have 3 options:
>> 1. Mask the USB_IEN and EP_IEN interrupts, but then I can lost some USB_=
ISTS
>> events. It's dangerous options.
>
>sure sounds dangerous, but also sounds quite "peculiar" :-)
>
>> 2. Remove implementation of handling unaligned buffers and assume that
>>     upper layer will worry about this. What with vendor specific drivers=
 that
>>     can be used by companies and not upstreamed  ?
>>     It could be good to have such safety mechanism even if it is not cur=
rently used.
>
>dunno. It may become dead code that's NEVER used :-)
>
>> 3. Delegate this part of code for instance to separate thread that will =
be called
>>    In free time.
>
>Yet another thread? Can't you just run this right before giving back the
>USB request? So, don't do it from IRQ handler, but from giveback path?

Do you mean in:
	if (request->complete) {
		spin_unlock(&priv_dev->lock);
		if (priv_dev->run_garbage_collector) {
			....
		}
		usb_gadget_giveback_request(&priv_ep->endpoint,
					    request);
		spin_lock(&priv_dev->lock);
	}
??

I ask because this is finally also called from IRQ handler:

cdns3_device_thread_irq_handler
    -> cdns3_check_ep_interrupt_proceed
        -> cdns3_transfer_completed
            -> cdns3_gadget_giveback
                -> usb_gadget_giveback_request

--
Pawell
