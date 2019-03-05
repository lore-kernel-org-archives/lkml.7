Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C04C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00A22075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RBNWZUpu";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BdYSe4hz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfCEUCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:02:50 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43498 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbfCEUCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:02:50 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x25K1OLl012880;
        Tue, 5 Mar 2019 12:02:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WwtA9msDoxaKPjQgylPz7d3y3iWQwNSTNvGNgMGPpu8=;
 b=RBNWZUpuP59ZSYnEQTLzQrpHTGeovSXyrN79AwN9sya7Z0lK8LLo8TkOIJPdPYJ2TTlG
 UM7yxsu4PaP3as75aXWOeqUMuW2z/bX+4keEz6Zj0LKREenlcM1gY+HjQriEuqnmEsvW
 zvieWbDS3Do8vkdwjz/AdwBA02m6pyFDUbc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r1wmprj01-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Mar 2019 12:02:13 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 5 Mar 2019 12:01:17 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 5 Mar 2019 12:01:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwtA9msDoxaKPjQgylPz7d3y3iWQwNSTNvGNgMGPpu8=;
 b=BdYSe4hzk3lqNORq+qP6KWPntTUgol5u3NMbqPb8yXYVD5h4Rf62DX9tL6+s5WRILX7jubO0J7m3wM5O+5HJs0ZxtvOIsWHiOJJM0JFX138bTiQC1mLEaCuCUX8f8+1CR6YEU4wpZuIZ+OSjMm1mLQfnH4c1TlBjLg09KRCL39k=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.177.11) by
 CY4PR15MB1608.namprd15.prod.outlook.com (10.175.119.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Tue, 5 Mar 2019 20:01:02 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c47c:32d3:4b03:adea]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c47c:32d3:4b03:adea%3]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 20:01:02 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] ARM: dts: aspeed: tiogapass: Enable VUART
Thread-Topic: [PATCH] ARM: dts: aspeed: tiogapass: Enable VUART
Thread-Index: AQHUuMemZJYThVA8H0+uGcmnPW39RKX9JKSA
Date:   Tue, 5 Mar 2019 20:01:02 +0000
Message-ID: <DAA424C9-E096-40A3-8287-CE4C8E9ABD61@fb.com>
References: <20190130181427.2469674-1-vijaykhemka@fb.com>
In-Reply-To: <20190130181427.2469674-1-vijaykhemka@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::3:907c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb85a199-3401-4d93-17ff-08d6a1a54b49
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1608;
x-ms-traffictypediagnostic: CY4PR15MB1608:
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1608;20:1hwXr6e8UcOEKkdoEzSzpIpfpXpVPdkzLSwxSXe8i/ZLOo/PbDpiCWOESuiyDKCFSs86sHN+vYxEj90SWyFP2dDDP4qx4a+jZTu5KUY2ZSj9BYzMEN714m8cFxc5oB6nujHqGr+fUmaw1UaL+E6XaCmO42zH0hmVobK7+jzgfbw=
x-microsoft-antispam-prvs: <CY4PR15MB1608FB69D795F4D37CF441F6DD720@CY4PR15MB1608.namprd15.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(2906002)(68736007)(106356001)(6436002)(105586002)(6486002)(256004)(186003)(46003)(14454004)(2501003)(486006)(476003)(2616005)(229853002)(446003)(11346002)(53936002)(6512007)(5660300002)(6506007)(6116002)(81156014)(2201001)(305945005)(8676002)(81166006)(478600001)(110136005)(36756003)(82746002)(316002)(86362001)(8936002)(76176011)(7736002)(71200400001)(6246003)(33656002)(102836004)(99286004)(71190400001)(97736004)(4326008)(83716004)(6346003)(25786009)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1608;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y+m1ZOAyIbaLjAxLDEC6BypFEewJU8ynbvVtYqpLMZ0QUgoGti+yVxNYX7feZlULsFKSaZgxtHRYwwMDmoBexeM81GP4Sl1YcFE2HmPBucBPSKuGfkrYFYBI8kxmPAi6kUGKh0ffUkozwfN6/x85n8jR3RVoFEhJMpuwJwE+H92tIe2I0tw0f7DQwbKOCUtACtXEHQU7anpE6o1Seqcds55uGk35aJ1jw1/vcrtjW7CuJcyFL/OtICIfkdsGuH8ahHuBMBdQN4X+DxDcUdDp+0U7OQf/X+c0iQA3F/+tBZsXtjgA9o8AKfeTrsbCQl443L9AAia/7nr8xnvaQWl1a+loBCqPIgHB9aWCV18CjOF2fXawuQY6re0hvc4RMUiW6ItFNhr4uzunEMcz7hlDHyEez3m+6Dqe3Sk0Mv1gZ8A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C26BD7655BD783459EAE8B3F04F3AEA3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cb85a199-3401-4d93-17ff-08d6a1a54b49
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 20:01:02.3280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1608
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGxlYXNlIHJldmlldyBiZWxvdyBwYXRjaC4NCg0KUmVnYXJkcw0KLVZpamF5DQoNCu+7v09uIDEv
MzAvMTksIDEwOjE0IEFNLCAiVmlqYXkgS2hlbWthIiA8dmlqYXlraGVta2FAZmIuY29tPiB3cm90
ZToNCg0KICAgIEVuYWJsaW5nIHZ1YXJ0IGZvciBGYWNlYm9vayB0aW9nYXBhc3MNCiAgICANCiAg
ICBTaWduZWQtb2ZmLWJ5OiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNvbT4NCiAgICAt
LS0NCiAgICAgYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay10aW9nYXBhc3Mu
ZHRzIHwgNSArKysrKw0KICAgICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQogICAg
DQogICAgZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2st
dGlvZ2FwYXNzLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stdGlv
Z2FwYXNzLmR0cw0KICAgIGluZGV4IDQyZTBkN2E4ZThkMC4uYTA1OGZiMjk4NWY3IDEwMDY0NA0K
ICAgIC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stdGlvZ2FwYXNz
LmR0cw0KICAgICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stdGlv
Z2FwYXNzLmR0cw0KICAgIEBAIC02NCw2ICs2NCwxMSBAQA0KICAgICAJc3RhdHVzID0gIm9rYXki
Ow0KICAgICB9Ow0KICAgICANCiAgICArJnZ1YXJ0IHsNCiAgICArCS8vIFZVQVJUIEhvc3QgQ29u
c29sZQ0KICAgICsJc3RhdHVzID0gIm9rYXkiOw0KICAgICt9Ow0KICAgICsNCiAgICAgJnVhcnQx
IHsNCiAgICAgCS8vIEhvc3QgQ29uc29sZQ0KICAgICAJc3RhdHVzID0gIm9rYXkiOw0KICAgIC0t
IA0KICAgIDIuMTcuMQ0KICAgIA0KICAgIA0KDQo=
