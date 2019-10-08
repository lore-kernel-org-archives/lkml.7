Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0D9C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4074D206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="IjwewnL3";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="TxXGCrMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfJHICc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:02:32 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40932 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730177AbfJHICc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:02:32 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x987wgtD002251;
        Tue, 8 Oct 2019 01:01:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=uIk2I7iBQhnbrAUGxzIoBT4fgoupxQtv8d7an67WClM=;
 b=IjwewnL3ZG63SzDeFnh4RRvLR19K5Nzhd62/A6Gr93y6CURYeV8lPg2IOVf8/XNRmU64
 68Tt/rB+C5RVTYRMM9nP6gdYkN5jT0GPp7oKU9EXGdYDCgQnfYC+2FuvWPbHqUbNZeq8
 +T3cTEeiEtDyzMfRLkkj1usZ2huOmAhEdytPF7y9Gnj/kkBqclEhSIWmhlLIJnn3hzg4
 0HQ7hYFzPipyVbFno1AM5FW5iO6iJsNZHW1IjG7b+3wvw+qn6iRRG4IT65Z118tMdqIA
 nFGYuBlq6f6HPU2XvrXg1B8vTs/MMDflO2bv2/wTGljG+aNZdusaikLq+JwxQUZrKfyN cQ== 
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2050.outbound.protection.outlook.com [104.47.41.50])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2vepry9x4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 01:01:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQTCVG05wi4eHGvbixGVw2iISoNUz8jCjnQbxC4Rt1Rnue0fhpvWLPElsAMG2dOumIhovv6i3DOB9U5/OQzgI8xGzrXrioFzzhBowkrcwlEBRwAehJJIqIbO5ZI8ao06Py54lBZX9Vs6j+FQS+HXAQSV+H71KQDfHALUi7KnXE49rN2VRTNMB4bL/tZkUzlawL/TVJKudTz2pKLZNHcBSoKApW/6F6292OL3E+O54oaKFUJfaYdB76Gp36b/4AdtkuylkLPoEfrzE16/EMM+s5kMZ0JZyq2DMHjN2r3/n2w9enJDtY19Pp08q/xhMtsnX0XQLlgrIP6g4C3IILtSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIk2I7iBQhnbrAUGxzIoBT4fgoupxQtv8d7an67WClM=;
 b=gF53CBs3JIi3vkinAuOIGbplkN1kbColDITdiBDNgpv9a07CsMU0YLUsHqhPtTLLWFC88+i6ejzkSOpRF8Mm0zBbeuIkuIAUCJ3P+eJrxXnel1Qvu5ilbntZ4X+LCVBAdMMXtGX3gWsSPBtHoSDnYkrIlU1u9yufgwQgOCZnYWg9fcD2hkGLvydOimXyHDqUao+ykBqL1I/e7k4BuAjnn9TB6bk0UhLjg0dRjmlOlNIQ6/sVmTYMvodlGnZpQ3NmHGWkQ3kN4ElWiEHhXz2ibdBkz8SbG2cLbaBUs0ITsJA3tUgUeocRq1Qj2R0A/vhSnZ7tro3NwQ0W5R04b7gcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIk2I7iBQhnbrAUGxzIoBT4fgoupxQtv8d7an67WClM=;
 b=TxXGCrMONQ0uwN9/HzLUSZyaM9maMuDzZ9sZJb0QcGX3A9VAz/y/6yvWTSbiH98+M+RFLaU77H5x2lz2sBQg/1OyeKyL48VMlX2FlGgMxtgSKEEu/1XQXqkkIh2S4SXt+HlBjUX1MMv+kQ7UL9rm29BlTopuhgpTOadoCZCiEvg=
Received: from BN7PR07MB4705.namprd07.prod.outlook.com (52.135.250.156) by
 BN7PR07MB4355.namprd07.prod.outlook.com (52.135.247.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Tue, 8 Oct 2019 08:01:19 +0000
Received: from BN7PR07MB4705.namprd07.prod.outlook.com
 ([fe80::2898:cfa7:643b:34ed]) by BN7PR07MB4705.namprd07.prod.outlook.com
 ([fe80::2898:cfa7:643b:34ed%3]) with mapi id 15.20.2347.016; Tue, 8 Oct 2019
 08:01:19 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH] usb: cdns3: Fix dequeue implementation.
Thread-Topic: [PATCH] usb: cdns3: Fix dequeue implementation.
Thread-Index: AQHVfQekfRknIN1IBke0BYrE5ibzAKdQW4qAgAAGl3A=
Date:   Tue, 8 Oct 2019 08:01:19 +0000
Message-ID: <BN7PR07MB4705E02D18AE939D16BDDBC0DD9A0@BN7PR07MB4705.namprd07.prod.outlook.com>
References: <1570449978-19145-1-git-send-email-pawell@cadence.com>
 <20191008073405.GF5670@b29397-desktop>
In-Reply-To: <20191008073405.GF5670@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b54a479a-1cee-45db-fb5e-08d74bc5b3c8
x-ms-traffictypediagnostic: BN7PR07MB4355:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR07MB4355F16D6E60C3654892EF17DD9A0@BN7PR07MB4355.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39850400004)(366004)(36092001)(199004)(189003)(13464003)(25786009)(14454004)(14444005)(74316002)(71200400001)(6246003)(71190400001)(256004)(76116006)(66946007)(81156014)(81166006)(8676002)(305945005)(7736002)(86362001)(66556008)(64756008)(66446008)(229853002)(52536014)(478600001)(66476007)(5660300002)(102836004)(476003)(9686003)(446003)(186003)(11346002)(316002)(8936002)(4326008)(6506007)(26005)(55016002)(486006)(6436002)(54906003)(76176011)(7696005)(2906002)(66066001)(107886003)(99286004)(6916009)(33656002)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4355;H:BN7PR07MB4705.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hwgK02CV7wPQPK+VlCUSozRtjPRx7R6qC3bYauqHiC3M8Rz61aiFerIrHuk6/kUGw7x78ExknRKtp+VYF7nHMwyfvPF7O9WgxYqhiXC5rsDK4kGwrBTgcPChi3hyQgLYErhX0aVDCuoOB+JcNUgR3Reoz0C8xALOgySdrF0XRFyP7o9EBp4cBYbugkVyRryz6tKM7YnbxJeKug2Qdk+1YogynJPytPmbnX30wy8CVVL7XvWaH9xatBlcgcEAYPOpVYryICqqxj/ivaxb1OA6qHTDcZYi0o3O/fy/ujEUj299O6I3I5U+Qo98wnUifYTDDu+3WQztC+0YVYdCEVywcsagtjUUbaHD+PrRgHnIxQdSO8AXnsBdQlKwaPXjR6yud5XngcTAbXLAVUvRxO+geGyZSdav64dPvF2kmR7jxkw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54a479a-1cee-45db-fb5e-08d74bc5b3c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 08:01:19.2608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fXSLSlET9R94cYwTV6e9wAW8g3A/4Mn3j2+gMfY2aLT16Ogc+pV6N+omhkvefCPp5WmsrUt0zun881dfChANAqtaRH2a/WtoVKHAMzfZ8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4355
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_03:2019-10-07,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910080081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Peter Chen <peter.chen@nxp.com>
>Sent: Tuesday, October 8, 2019 9:34 AM
>To: Pawel Laszczak <pawell@cadence.com>
>Cc: felipe.balbi@linux.intel.com; gregkh@linuxfoundation.org; linux-usb@vg=
er.kernel.org; rogerq@ti.com; linux-
>kernel@vger.kernel.org; jbergsagel@ti.com; nsekhar@ti.com; nm@ti.com; Sure=
sh Punnoose <sureshp@cadence.com>; Rahul Kumar
><kurahul@cadence.com>
>Subject: Re: [PATCH] usb: cdns3: Fix dequeue implementation.
>
>EXTERNAL MAIL
>
>
>On 19-10-07 13:06:18, Pawel Laszczak wrote:
>> Dequeuing implementation in cdns3_gadget_ep_dequeu gets first request fr=
om
>
>%s/cdns3_gadget_ep_dequeu/cdns3_gadget_ep_dequeue
>
>> deferred_req_list and changed TRB associated with it to LINK TRB.
>> This approach is incorrect because deferred_req_list contains requests
>> that have not been placed on hardware RING.  In this case driver should
>> just giveback this request to gadget driver.
>>
>> The patch implements new approach that first checks where dequeuing
>> request is located and only when it's on Transfer Ring then changes TRB
>> associated with it to LINK TRB.
>> During processing completed transfers such LINK TRB will be ignored.
>>
>> Reported-by: Peter Chen <peter.chen@nxp.com>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
>> ---
>>  drivers/usb/cdns3/gadget.c | 35 ++++++++++++++++++++---------------
>>  1 file changed, 20 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>> index 2ca280f4c054..9050b380ab83 100644
>> --- a/drivers/usb/cdns3/gadget.c
>> +++ b/drivers/usb/cdns3/gadget.c
>> @@ -1145,6 +1145,14 @@ static void cdns3_transfer_completed(struct cdns3=
_device *priv_dev,
>>  		request =3D cdns3_next_request(&priv_ep->pending_req_list);
>>  		priv_req =3D to_cdns3_request(request);
>>
>> +		trb =3D priv_ep->trb_pool + priv_ep->dequeue;
>> +
>> +		/* Request was dequeued and TRB was changed to TRB_LINK. */
>> +		if (TRB_FIELD_TO_TYPE(trb->control) =3D=3D TRB_LINK) {
>> +			trace_cdns3_complete_trb(priv_ep, trb);
>> +			cdns3_move_deq_to_next_trb(priv_req);
>> +		}
>
>If the request was dequeued, it should not be at request list, isn't it?

Yes
The dequeued request was removed from pending list but TRB associated with =
it=20
was changed to Link TRB so it should be ignored in cdns3_transfer_completed=
 function.=20

Pawel

>
>Peter
>> +
>>  		/* Re-select endpoint. It could be changed by other CPU during
>>  		 * handling usb_gadget_giveback_request.
>>  		 */
>> @@ -2067,6 +2075,7 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
>>  	struct usb_request *req, *req_temp;
>>  	struct cdns3_request *priv_req;
>>  	struct cdns3_trb *link_trb;
>> +	u8 req_on_hw_ring =3D 0;
>>  	unsigned long flags;
>>  	int ret =3D 0;
>>
>> @@ -2083,8 +2092,10 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
>>
>>  	list_for_each_entry_safe(req, req_temp, &priv_ep->pending_req_list,
>>  				 list) {
>> -		if (request =3D=3D req)
>> +		if (request =3D=3D req) {
>> +			req_on_hw_ring =3D 1;
>>  			goto found;
>> +		}
>>  	}
>>
>>  	list_for_each_entry_safe(req, req_temp, &priv_ep->deferred_req_list,
>> @@ -2096,27 +2107,21 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
>>  	goto not_found;
>>
>>  found:
>> -
>> -	if (priv_ep->wa1_trb =3D=3D priv_req->trb)
>> -		cdns3_wa1_restore_cycle_bit(priv_ep);
>> -
>>  	link_trb =3D priv_req->trb;
>> -	cdns3_move_deq_to_next_trb(priv_req);
>> -	cdns3_gadget_giveback(priv_ep, priv_req, -ECONNRESET);
>> -
>> -	/* Update ring */
>> -	request =3D cdns3_next_request(&priv_ep->deferred_req_list);
>> -	if (request) {
>> -		priv_req =3D to_cdns3_request(request);
>>
>> +	/* Update ring only if removed request is on pending_req_list list */
>> +	if (req_on_hw_ring) {
>>  		link_trb->buffer =3D TRB_BUFFER(priv_ep->trb_pool_dma +
>>  					      (priv_req->start_trb * TRB_SIZE));
>>  		link_trb->control =3D (link_trb->control & TRB_CYCLE) |
>> -				    TRB_TYPE(TRB_LINK) | TRB_CHAIN | TRB_TOGGLE;
>> -	} else {
>> -		priv_ep->flags |=3D EP_UPDATE_EP_TRBADDR;
>> +				    TRB_TYPE(TRB_LINK) | TRB_CHAIN;
>> +
>> +		if (priv_ep->wa1_trb =3D=3D priv_req->trb)
>> +			cdns3_wa1_restore_cycle_bit(priv_ep);
>>  	}
>>
>> +	cdns3_gadget_giveback(priv_ep, priv_req, -ECONNRESET);
>> +
>>  not_found:
>>  	spin_unlock_irqrestore(&priv_dev->lock, flags);
>>  	return ret;
>
>--
>
>Thanks,
>Peter Chen
