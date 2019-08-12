Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328B7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB43A2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ESZ5ZBEZ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="TT6uM6P3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfHLEnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 00:43:42 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:24774 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725822AbfHLEnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 00:43:41 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7C4go8q002262;
        Sun, 11 Aug 2019 21:43:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=LPHDMKrWb3YwzkRZieLbAD2SEf5plTuilZx/nH0mNG0=;
 b=ESZ5ZBEZTpc8Qj1QU/jrcpgh2HquqTtXYg1x0UiuiILaCYPq+b4/lKaBhSOU5kqbH0Ne
 /SfNZgkuqz1mirJbvrqgodH1sSbZ0bsl/U6/MhGp0xBG26Ojw01WhPHkneDRfUQdjJPY
 2A6OCh4aaM2I80gxE/Y5FUz3aTdmdYI82GQkmquwd/VgKz2KDM9ug30jHBqyVOrVx8Lc
 XQTP421cCz77/sqRDCpzMxgTYoxMSmUcPHOjnVe4vJ0sX0MxcIbOT0fNvctsTqL+uOvt
 0Z6CvbyuB3ADfCp278GzdOqNdKePHp5vBo6J27m2PWAwg8YCmZMKWJ0HpXCmDXAfaGoh qA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2050.outbound.protection.outlook.com [104.47.36.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2u9tfs4f10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 21:43:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZC+JZdQSMVwaEt3y8ZInUGB+uabzn6uk7r9JJawl0jDJALIVcsNPNBfTXNyltPGlX5aR6QKSLqdIwZ7ziw0HINRuk7+4ngSbqv+xkaxdvlSU3MOkVTHnwaEWYnlppYhQbJGHdRedvq1wMbXHQBDNwqC117DiE54bTpUJxS3B4CE9IpOmri3LlBSZmJOqFLmcQPmKbrvfvVg4QMW8G3GsEcPGz0sE2P1eIiLPQ/OywRSgWbr3V2zRvmNtgq3+q7lOQ1CXdjgCyAFGm8YxWnP3G9Vd9f7QjijO9tyDMLKcbNE0cbWXsXd8FrnfpbspNg/HhPoFXCS9qrhiq51xcwZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPHDMKrWb3YwzkRZieLbAD2SEf5plTuilZx/nH0mNG0=;
 b=GR0tqaUICF8QMaRi71k/CKz/j/See5xtH2Rwo127/tloLF2OmJA34SbPmE1uqQMyeCPh2zYfYVFM9wE+0JRiCg07KDeTafUBij4orT35Vj2RyenB7oMQvi2zyEaVbadqvvtqk0F/F07otzkBIu3Dpsr1MCBCcWOBKrszK5kSehN6/C89r9/T17L7hDhtCJ12SuySfj7JcI6wO71THZIcokkEoQNd7BQZXx0VtIJfeM19RsxvYwwq58gnKeWh2Hb0x7DqTpuJZfCFkmB6PdpeZ57QSWp718Bz74QoIt7MRtiqwZy1U4YtUApP/XR83G84z/suSnVXskqNvSIq7uBIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=cadence.com;dmarc=pass action=none
 header.from=cadence.com;dkim=pass header.d=cadence.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPHDMKrWb3YwzkRZieLbAD2SEf5plTuilZx/nH0mNG0=;
 b=TT6uM6P3qyDODEPBK5klQVxV3phseGVoJVHGXDhoN98RBp67P8gJU5UvsJA3N24xFMQeSvSq7O0wZbIWRYHXpAoeQfci1nlVhQeRjbq6tf7cMngeJZUBw9ZvrDA6TvmWgttTdmZtSIWS3lXN61KdYjSr7u3Oxt8M0AGDUGomb8c=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4549.namprd07.prod.outlook.com (52.135.225.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 12 Aug 2019 04:43:16 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e%7]) with mapi id 15.20.2136.022; Mon, 12 Aug 2019
 04:43:16 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
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
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHVMyCBLRb+XoB9zUqxphM8AIPBC6bAUmQAgAroVsCAJHZ6gIAFRjxwgAIEXoCAAC01IA==
Date:   Mon, 12 Aug 2019 04:43:16 +0000
Message-ID: <BYAPR07MB4709E993145DE80AD24D2E36DDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-6-git-send-email-pawell@cadence.com>
 <877e8tm25r.fsf@linux.intel.com>
 <BYAPR07MB4709152CB29B6B027ABEB688DDCF0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <8736idnu0q.fsf@gmail.com>
 <BYAPR07MB4709B0A4FADFB76183D651DCDDD10@BYAPR07MB4709.namprd07.prod.outlook.com>
 <VI1PR04MB53279117788B7D7CC3080B398BD30@VI1PR04MB5327.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB53279117788B7D7CC3080B398BD30@VI1PR04MB5327.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOGE4NDAzNjItYmNiYi0xMWU5LTg3NDUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDhhODQwMzY0LWJjYmItMTFlOS04NzQ1LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjAxNCIgdD0iMTMyMTAwNTg1MjkwNjMxMjY4IiBoPSIvaW1xdmdkSnBiV20veEcvTjZCNGhQQkw1NWM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [158.140.1.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcb03664-4e3b-46f4-8d2a-08d71edf978b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB4549;
x-ms-traffictypediagnostic: BYAPR07MB4549:
x-microsoft-antispam-prvs: <BYAPR07MB45491E1380A0D8690A4C7564DDD30@BYAPR07MB4549.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(36092001)(199004)(51444003)(54906003)(102836004)(74316002)(256004)(66066001)(71200400001)(76116006)(6506007)(71190400001)(110136005)(6436002)(5660300002)(6116002)(316002)(7696005)(66476007)(229853002)(55016002)(86362001)(2906002)(64756008)(14444005)(66556008)(446003)(107886003)(14454004)(99286004)(66946007)(11346002)(66446008)(52536014)(3846002)(476003)(7416002)(26005)(53936002)(6246003)(8936002)(9686003)(81166006)(76176011)(25786009)(33656002)(4326008)(8676002)(478600001)(2501003)(486006)(81156014)(305945005)(7736002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4549;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RVi9vov1wQFgIkcaZmYeXmsaugr16+jc8ukTeaUQZ2LaLFDOZ896JS86R9DIGQ5/Leeydqbn/0gNZqT/uNu1TOmSorGi5LsbQgWN1xkOqHQYVAmVzgFb41mnr/i4rC0z+HmjbJcY7FBFSudtXPC9XBGPWCRsO1WRgU3LtNecGX+iZATgTb0DKA6fbMfZYDnMD2layRnC6OQ68Ln2BBcXWrrwPMO91kFpGRdISQOHCmrLciRAHEnNdufw1lYhYhMCs/+Mes18cC/wfzGG9FJ7GhEcq1SuNqbbdX6RyI+VWGFjdNLK94xkY4lbWVowmLyfWTISq/vA7YU0ZxJ8yj3iyYbvCY9oOpfX1dd7glS4cQwlpdPp83oBW3LU+i9uy1B+TRkraytT47oh+0y6fAWoio2TGrpL5jZ+XHN3W6ofjWM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb03664-4e3b-46f4-8d2a-08d71edf978b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 04:43:16.3730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4549
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=870 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
>>
>> Yes, driver frees not used buffers here.
>> I think that it's the safest place for this purpose.
>>
>> >
>> >>>> +				dma_free_coherent(priv_dev->sysdev, buf-
>> >size,
>> >>>> +						  buf->buf,
>> >>>> +						  buf->dma);
>> >>>> +				spin_lock_irqsave(&priv_dev->lock, flags);
>> >>>> +
>> >>>> +				kfree(buf);
>> >>>
>> >>>why do you even need this "garbage collector"?
>> >>
>> >> I need to free not used memory. The once allocated buffer will be
>> >> associated with request, but if request.length will be increased in
>> >> usb_request then driver will must allocate the  bigger buffer. As I
>> >> remember I couldn't call dma_free_coherent in interrupt context so I
>> >> had to move it to thread handled. This flag was used to avoid going t=
hrough
>> whole  aligned_buf_list  every time.
>> >> In most cases this part will never called int this place
>> >
>> >Did you try, btw, setting the quirk flag which tells gadget drivers to
>> >always allocate buffers aligned to MaxPacketSize? Wouldn't that be enou=
gh?
>>
>> If found only  quirk_ep_out_aligned_size flag, but it align only buffer =
size.
>>
>> DMA used by this controller must have buffer address aligned to 8.
>> I think that on most architecture kmalloc should guarantee such aligned.
>> The problem was detected on NXP testing board.
>> On my board all buffer address are alignment at least to 8.
>>
>
>This un-aligned request buffer address for 8 occurs for Ethernet Gadget (e=
g, NCM),
>it allocates socket buffer with NET_IP_ALIGN, so the last byte of buffer a=
ddress
>is always 2. Although this can be workaround by setting quirk_avoids_skb_r=
eserve,
>but we are not sure if all gadget request buffers can be 8 or Max Packet S=
ize aligned.
>

Thanks Peter for explanation.=20
I will add quirk_avoids_skb_reserve to avoid using this extra buffers, but =
I leave this=20
code for safety.=20

--
Cheers,
Pawell

