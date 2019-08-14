Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFA1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0CA2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="tbbYvH5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfHNUTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:19:41 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:17526 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbfHNUTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:19:40 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EKEmq7016364
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 16:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=WcSC1bSopTVeFcc/5wNxd5IcewwWd/Pxa+GV9dQeI3o=;
 b=tbbYvH5Ni4mSUoHcuNg+wYTTLc7o1GvAfc4SszqSuQbd3rHgB2Q8hRYOOYYJ9a8IGM/c
 eeLmWpOYQV21Q2kNOXHOHdt76An7Ab+JX4vQ0gWaPF69GNW+eHIOagW4882YdL19MfS+
 QnvVVsLcGbbRe/s5rk3jNH319X2yMQhwiEFUUUMFpvhtJ4XnMuV/0AS+oFyrqsXYfPtw
 YMC5kg+yytagPsH/GzdTjB8RCLzxrUib7kFE2UaeMCvvfcplQ6AGqyWh8u5m+FwnkiNV
 j8Bh+rvMjUWAoLfxZlDmYAyPzq69Q1ELvm6I67GQVGkjqi8rH98MOqEGSvuWa7QFDh+g 3w== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2ubydm6su1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 16:19:39 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EKHr8O039394
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 16:19:38 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 2ucqw196qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 16:19:38 -0400
X-LoopCount0: from 10.166.132.55
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="408454404"
From:   <Mario.Limonciello@dell.com>
To:     <sagi@grimberg.me>, <kbusch@kernel.org>
CC:     <axboe@fb.com>, <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Ryan.Hong@Dell.com>,
        <Crag.Wang@dell.com>, <sjg@google.com>,
        <Charles.Hyde@dellteam.com>, <Jared.Dominguez@dell.com>
Subject: RE: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
Thread-Topic: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
Thread-Index: AQHVUtwQRoMvFWyQNUuquaDdHeAiWqb7Z/MA//+sqmA=
Date:   Wed, 14 Aug 2019 20:19:34 +0000
Message-ID: <3e38dce0c1ae406496af3a70dfd36077@AUSX13MPC105.AMER.DELL.COM>
References: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
 <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
In-Reply-To: <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-08-14T20:19:32.9806728Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140185
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYWdpIEdyaW1iZXJnIDxzYWdp
QGdyaW1iZXJnLm1lPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAxNCwgMjAxOSAzOjE1IFBN
DQo+IFRvOiBMaW1vbmNpZWxsbywgTWFyaW87IEtlaXRoIEJ1c2NoDQo+IENjOiBKZW5zIEF4Ym9l
OyBDaHJpc3RvcGggSGVsbHdpZzsgbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOyBMS01M
OyBIb25nLA0KPiBSeWFuOyBXYW5nLCBDcmFnOyBzamdAZ29vZ2xlLmNvbTsgSHlkZSwgQ2hhcmxl
cyAtIERlbGwgVGVhbTsgRG9taW5ndWV6LCBKYXJlZA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
XSBudm1lOiBBZGQgcXVpcmsgZm9yIExpdGVPTiBDTDEgZGV2aWNlcyBydW5uaW5nIEZXDQo+IDIy
MzAxMTExDQo+IA0KPiANCj4gW0VYVEVSTkFMIEVNQUlMXQ0KPiANCj4gTWFyaW8sDQo+IA0KPiBD
YW4geW91IHBsZWFzZSByZXNwaW4gYSBwYXRjaCB0aGF0IGFwcGxpZXMgY2xlYW5seSBvbiBudm1l
LTUuND8NCg0KSXQgbG9va3MgbGlrZSBudm1lLTUuNCBpcyBtaXNzaW5nIHRoZSBjb21taXQgY29t
aW5nIGluIGZyb20gUmFmYWVsJ3MgbGludXgtbmV4dCB0cmVlIHRoYXQgaXQncyBkZXBlbmRlbnQg
dXBvbjoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Jh
ZmFlbC9saW51eC1wbS5naXQvY29tbWl0L2RyaXZlcnMvbnZtZS9ob3N0P2g9bGludXgtbmV4dCZp
ZD00ZWFlZmU4YzYyMWM2MTk1YzkxMDQ0Mzk2ZWQ4MDYwYzE3OWY3YWFlDQoNCkNvdWxkIHlvdSBj
aGVycnkgcGljayB0aGF0IGludG8gbnZtZS01LjQgYXMgd2VsbD8gIEl0IHNob3VsZCBhcHBseSBj
bGVhbmx5IHRoZW4uICBPdGhlcndpc2UsIHdvdWxkIHlvdSBwcmVmZXINCnRoaXMgdG8gY29tZSBp
biBSYWZhZWwncyB0cmVlIHRvbz8NCg==
