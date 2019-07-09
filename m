Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A925C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488C82166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="PZQawhos";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="e+cJOtgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfGIEXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:23:23 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:5514 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbfGIEXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:23:22 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x694Liag004328;
        Mon, 8 Jul 2019 21:23:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=zTByOCxWaIfmsFYVt6D95AdErLMt9dt/jFCc6MhflAo=;
 b=PZQawhosllqsYq8RK/73pswLHxU4FIE7DUY6O4UDEDLqEEp3IitZUYEaOqKpdRWlDXk/
 rY6glstEp4SEmVj3nkDWHhaspCvRDCiQ6rmXfbdCxtpcIdkQxNXVAQArecXD9ziwdoCE
 mKin6uiEe9b/lcmbgGxylCmyXlilu6RUYJqPBzXb6Bgo+sQhU6Nx995F+Tuyt4MQj8ot
 /qnu3y1p12gMzmOOGp3ZF6x4NL8wnTHjQHeayQORfvtVD19Eu/449ro4GF0MraG0XW20
 ypUyP3cMhYW2wD9N6ez44aVWGqVExBHsQR8BWO2aQTK6RecH1Uk5HapPE7nfOo6D6a0C xA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2052.outbound.protection.outlook.com [104.47.37.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2tjr6vhsdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Jul 2019 21:23:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTByOCxWaIfmsFYVt6D95AdErLMt9dt/jFCc6MhflAo=;
 b=e+cJOtgMixFRyInIeUMlZ4DiMM+0FJQW9X6jOkosRc3BzCqt6NIcYcU/mxAxtEYRPmYt/L1rEeVJgyVrGd0p3XoYMcOuRXtw2Jpk6ciBQxt3os2VPaEwvQU8+rLz0MtrYLoky2BfdQmGgGUovRSKzAvvMTa0KS/d+w7TXY1GmpQ=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5814.namprd07.prod.outlook.com (20.179.90.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Tue, 9 Jul 2019 04:23:03 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 04:23:03 +0000
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
Thread-Index: AQHVMyCBLRb+XoB9zUqxphM8AIPBC6a76sKAgAN7ISCAAOC4gIAAeMvw
Date:   Tue, 9 Jul 2019 04:23:03 +0000
Message-ID: <BYAPR07MB47094B372CEC6DFD25FC78E1DDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-6-git-send-email-pawell@cadence.com>
 <87r274lmqk.fsf@linux.intel.com>
 <BYAPR07MB4709EF3753AC0B87606B1182DDF70@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87a7dpm442.fsf@linux.intel.com>
In-Reply-To: <87a7dpm442.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctM2I5ODdmZDQtYTIwMS0xMWU5LTg3NDItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDNiOTg3ZmQ1LWEyMDEtMTFlOS04NzQyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNTc5NCIgdD0iMTMyMDcxMTk3ODAwNDg2NTA4IiBoPSJWeUNCbWNPV1ltMWlMQzYxS01VYVNUTmZwWjg9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13f804cf-5165-43db-d096-08d70425226f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5814;
x-ms-traffictypediagnostic: BYAPR07MB5814:
x-microsoft-antispam-prvs: <BYAPR07MB581411FF1C23D7CAF683FB7EDDF10@BYAPR07MB5814.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(36092001)(189003)(199004)(74316002)(8936002)(71190400001)(14444005)(71200400001)(66446008)(6116002)(3846002)(478600001)(54906003)(8676002)(53936002)(81156014)(316002)(110136005)(66066001)(2906002)(81166006)(486006)(256004)(7416002)(305945005)(6506007)(76116006)(9686003)(66946007)(73956011)(7736002)(229853002)(64756008)(68736007)(66476007)(66556008)(7696005)(76176011)(6246003)(102836004)(33656002)(2501003)(5660300002)(186003)(11346002)(6436002)(26005)(99286004)(55016002)(446003)(14454004)(107886003)(25786009)(52536014)(4326008)(86362001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5814;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2BFx7WKMcREzENH1v++AwBXr07qlNoYBPv8C7fTzPjwq44Dvwl/us7+XpBPuvOWGmbmak64+YSHr6hh0N62UU7GbN45hJwQSVc8a5AlclQa7pSYrRWN1kV34Qjh8m1BD0ihYlLE9dXyz2o6hRZQdK7QnGdDhMhcFAAaNu2ohgODkoM/xts/n/ocXHX3boEjltkFHwWw70FVdl+AmhKPEAs7XopEBOrdPYtd86ZbWrj7WGBFFMxJId9CIm2Mm58zxXmobcVwbbI7HYJS2E538V6BkWlSCSbqmHtxwzMm7Ii/BYpNvJUrO2PlOoNqK7GIJOhE0DTOr0Y9Fa9Q4wL7/RNT4+Ru2Tvl9dUBmCEXQNtNTXmbgWouw7D1BKnfhe+s4wIV93se0ucph2r3JDx3Co25I5paXGoChbTwguO9Vf+0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f804cf-5165-43db-d096-08d70425226f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 04:23:03.1410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5814
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=669 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>Pawel Laszczak <pawell@cadence.com> writes:
>>>> +void cdns3_role_stop(struct cdns3 *cdns)
>>>
>>>not static? Why is it so that _start() is static but _stop() is not?
>>>Looks fishy
>>
>> This function is used in cdns3_role_stop in debugfs.c file so it can't
>> be static.
>
>it's still super fishy. Why don't you need _start() from debugfs.c? In
>any case, the role framework would remove the need for any of this, I
>suppose.

Yes, I'm going to use the role framework so it will be probably changed.=20
>
>>>> +static int cdns3_idle_role_start(struct cdns3 *cnds)
>>>> +{	/* Hold PHY in RESET */
>>>
>>>huh?
>>>
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void cdns3_idle_role_stop(struct cdns3 *cnds)
>>>> +{
>>>> +	/* Program Lane swap and bring PHY out of RESET */
>>>
>>>double huh?
>>>
>>
>> These functions were added for consistency with FSM described in control=
ler specification.
>> Yes, I know that you don't like empty functions :), but it could be help=
ful in
>> understanding how this controller work.
>
>frankly, it really doesn't. An empty function doesn't really help IMHO.

I will change it.
>
>>>> +static const char *const cdns3_mode[] =3D {
>>>> +	[USB_DR_MODE_UNKNOWN]		=3D "unknown",
>>>> +	[USB_DR_MODE_OTG]		=3D "otg",
>>>> +	[USB_DR_MODE_HOST]		=3D "host",
>>>> +	[USB_DR_MODE_PERIPHERAL]	=3D "device",
>>>> +};
>>>
>>>don't we have a generic version of this under usb/common ?
>>>
>> Yes, there is a similar array, but it is defined also as static
>> and there is no function for converting value to string.
>> There is only function for converting string to value.
>
>right. You can add the missing interface generically instead of
>duplicating the enumeration.

Patch adding such extension has posted.=20

>
>> There is also:
>> [USB_DR_MODE_UNKNOWN]		=3D "",
>> Instead of:
>> [USB_DR_MODE_UNKNOWN]		=3D "unknown",
>>
>> So, for USB_DR_MODE_UNKNOWN user will not see anything information.
>
>But that's what "unknown" means :-) We don't know the information.
>
>>>> +static irqreturn_t cdns3_drd_irq(int irq, void *data)
>>>> +{
>>>> +	irqreturn_t ret =3D IRQ_NONE;
>>>> +	struct cdns3 *cdns =3D data;
>>>> +	u32 reg;
>>>> +
>>>> +	if (cdns->dr_mode !=3D USB_DR_MODE_OTG)
>>>> +		return ret;
>>>> +
>>>> +	reg =3D readl(&cdns->otg_regs->ivect);
>>>> +
>>>> +	if (!reg)
>>>> +		return ret;
>>>> +
>>>> +	if (reg & OTGIEN_ID_CHANGE_INT) {
>>>> +		dev_dbg(cdns->dev, "OTG IRQ: new ID: %d\n",
>>>> +			cdns3_get_id(cdns));
>>>> +
>>>> +		ret =3D IRQ_HANDLED;
>>>> +	}
>>>> +
>>>> +	if (reg & (OTGIEN_VBUSVALID_RISE_INT | OTGIEN_VBUSVALID_FALL_INT)) {
>>>> +		dev_dbg(cdns->dev, "OTG IRQ: new VBUS: %d\n",
>>>> +			cdns3_get_vbus(cdns));
>>>> +
>>>> +		ret =3D IRQ_HANDLED;
>>>> +	}
>>>> +
>>>> +	if (ret =3D=3D IRQ_HANDLED)
>>>> +		queue_work(system_freezable_wq, &cdns->role_switch_wq);
>>>> +
>>>> +	writel(~0, &cdns->otg_regs->ivect);
>>>> +	return ret;
>>>> +}
>>>
>>>seems like you could use threaded irq to avoid this workqueue.
>>
>>
>> This function is also called in cdns3_mode_write (debugfs.c file),
>> therefor after changing it to threaded irq I will still need workqueue.
>
>Why? debugfs writes are not atomic. They run in process context, right?
>Just don't disable interrupts while running this and you should be fine.

Yes, It should work.=20

>
>>>> +	cdns->desired_dr_mode =3D cdns->dr_mode;
>>>> +	cdns->current_dr_mode =3D USB_DR_MODE_UNKNOWN;
>>>> +
>>>> +	ret =3D devm_request_threaded_irq(cdns->dev, cdns->otg_irq,
>>>> +					cdns3_drd_irq,
>>>> +					NULL, IRQF_SHARED,
>>>
>>>if you don't have a threaded handler, you should set IRQF_ONESHOT. I
>>>would prefer if you implement a threaded handler that doesn't require
>>>IRQF_ONESHOT, though.
>>>
>>
>> IRQF_ONESHOT can be used  only in threaded handled.
>> "
>>  * IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler f=
inished.
>>  *                Used by threaded interrupts which need to keep the
>>  *                irq line disabled until the threaded handler has been =
run.
>> "
>
>so?

I don't understand why If I don't have threaded handler why I need IRQF_ONE=
SHOT.=20
Why interrupt cannot be reenabled after hardirq handler finished ?
I do not use threaded handler so this flag seem unnecessary.=20

>
>>>> +	} else {
>>>> +		struct usb_request *request;
>>>> +
>>>> +		if (priv_dev->eps[index]->flags & EP_WEDGE) {
>>>> +			cdns3_select_ep(priv_dev, 0x00);
>>>> +			return 0;
>>>> +		}
>>>> +
>>>> +		cdns3_dbg(priv_ep->cdns3_dev, "Clear Stalled endpoint %s\n",
>>>> +			  priv_ep->name);
>>>
>>>why do you need your own wrapper around dev_dbg()? This looks quite unne=
cessary.
>>
>> It's generic function used for adding message to trace.log.  It's not wr=
apper to dev_dbg
>>
>> void cdns3_dbg(struct cdns3_device *priv_dev, const char *fmt, ...)
>> {
>> 	struct va_format vaf;
>> 	va_list args;
>>
>> 	va_start(args, fmt);
>> 	vaf.fmt =3D fmt;
>> 	vaf.va =3D &args;
>> 	trace_cdns3_log(priv_dev, &vaf);
>> 	va_end(args);
>> }
>
>oh. Don't do it like that. Add a proper trace event that actually
>decodes the information you want. These random messages will give you
>trouble in the future. I had this sort of construct in dwc3 for a while
>and it became clear that it's a bad idea. It's best to have trace events
>that decode information coming from the HW. That way your trace logs
>have a "predictable" shape/format and you can easily find problem areas.

Ok , I will change this.
I used such solution because I didn't want to create to many trace events.=
=20
I used it only for rely used messages.=20

Thanks,
Regards
Pawel

>
>--
>balbi
