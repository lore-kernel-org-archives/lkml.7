Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F854C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72F620857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="BJcZBF0j";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="kL24jBRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbfDAHts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:49:48 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36194 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731769AbfDAHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:49:48 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x317lpjv007458;
        Mon, 1 Apr 2019 00:49:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=proofpoint;
 bh=ZNmd8atgtXp82qhy+kUa5fZQhxBpNMZaEqpjAgCpON0=;
 b=BJcZBF0jmD3/MQkZOLJLjw/cKtG9DO5Gr4rhgoDcHv6vFvS7tFX60btddiHHkB+t9zjZ
 vPsTqqN8P3zXH244y2BCPwLKPxvXCkNuFdnTuJEHvgp4TDomht9jzrxiXeE6oh7cI5Dt
 uKLU1dzNkd0S6YKW98W74nd9U6iaihw8o2/XqXqkQglDV523djCOngBtV58wSEwucEj2
 Ugfl6iNwAIBfiH92iXp3yGw/JLFUfFwcMK/JKq6aUULSbb62frIL/SQOMWf7OtE2zQd0
 vJgb3Nu+kh680yJUX46hc/rV/1ekeqsOEGhAZutcYKAbJIiS3DUIe2BeWVoK307eGmxK 8g== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2059.outbound.protection.outlook.com [104.47.46.59])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2rj50w7h0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 01 Apr 2019 00:49:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNmd8atgtXp82qhy+kUa5fZQhxBpNMZaEqpjAgCpON0=;
 b=kL24jBRN+Vh9PqKB5swcS+B9+AzVxz5W5hhZl2p7gJzySCIikR18Ri9v+4REgf2ZKWmAudXK3QG7zWaLk1K41Y/+d66NPGXTlEIbB/0qMT5kSAqeEZR2IH8nDvsbYPUReo8SoQt6eOUSnIrCbkJWA1s2jlIIF3Ismh16EloT/t4=
Received: from CY1PR07MB2521.namprd07.prod.outlook.com (10.167.16.12) by
 CY1PR07MB2443.namprd07.prod.outlook.com (10.166.195.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Mon, 1 Apr 2019 07:49:24 +0000
Received: from CY1PR07MB2521.namprd07.prod.outlook.com
 ([fe80::74e1:243f:458d:9e61]) by CY1PR07MB2521.namprd07.prod.outlook.com
 ([fe80::74e1:243f:458d:9e61%5]) with mapi id 15.20.1750.014; Mon, 1 Apr 2019
 07:49:24 +0000
From:   Jan Kotas <jank@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jan Kotas <jank@cadence.com>, Mark Rutland <mark.rutland@arm.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: scsi: ufs-cdns: Update Cadence UFS
 compatibility list
Thread-Topic: [PATCH 1/2] dt-bindings: scsi: ufs-cdns: Update Cadence UFS
 compatibility list
Thread-Index: AQHU5Ku7sYTkHASvFkidSwhS/GGDG6YlUJEAgAGk74A=
Date:   Mon, 1 Apr 2019 07:49:24 +0000
Message-ID: <BEE57023-51AA-4513-929E-00855D282DB9@global.cadence.com>
References: <20190327144405.5716-1-jank@cadence.com>
 <20190327144405.5716-2-jank@cadence.com> <20190331025745.GA28612@bogus>
In-Reply-To: <20190331025745.GA28612@bogus>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c1b4b90-4b44-429a-de38-08d6b6768f40
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY1PR07MB2443;
x-ms-traffictypediagnostic: CY1PR07MB2443:
x-microsoft-antispam-prvs: <CY1PR07MB2443B64FC1D894F326CF3AA7D0550@CY1PR07MB2443.namprd07.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39850400004)(346002)(136003)(396003)(199004)(189003)(36092001)(316002)(76176011)(97736004)(5660300002)(14454004)(83716004)(6506007)(256004)(102836004)(66066001)(476003)(33656002)(6916009)(71200400001)(8936002)(8676002)(11346002)(99286004)(82746002)(446003)(53546011)(486006)(26005)(186003)(71190400001)(81156014)(53936002)(6116002)(6512007)(6486002)(106356001)(68736007)(54906003)(478600001)(3846002)(6246003)(81166006)(6436002)(105586002)(25786009)(86362001)(7416002)(2906002)(7736002)(229853002)(4326008)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2443;H:CY1PR07MB2521.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CmY0BjlYi+gmy4LOlamy8nKSluWPcDf9HiKD/Ymjm8QrPRQh5u1xXhSah0dOn2HKxu2EAq2xNi1GYYjLz10HUTJHCPlqNDa+MOq/KUOZfGJzg1i0pXVp/pds9XuSrli3YEkmoiyCjiCo1WpwiHGCYImkElnfsTTGwyOAXbEGg6Z41UWJRb5lllsThiVOng3JrPfipvO3u76gq77jdJwHx16p/dlqyfcAr/KWav27MA8uspY+PvBvfAN9XOdmrZEIkn80pWBU4R/Xu92/VerSj1R2Daul1O/cA2lS7Zclfc8JG31UCHSicFLiea6d7h2lObeDDeQzhscKY8zlTbp1mnyu5eEa7cFQlxitU+4akRnDXBj0R5f6mjp4KkaIZpWAjRVhHMMnuRtv7w0MBNb2xsd/5zZioyM+TUTKWvIgRy4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <58C45F487B911442824B33EEA05EF36E@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1b4b90-4b44-429a-de38-08d6b6768f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 07:49:24.4662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2443
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904010058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 31 Mar 2019, at 08:42, Rob Herring <robh@kernel.org> wrote:
>=20
> On Wed, Mar 27, 2019 at 02:44:04PM +0000, Jan Kotas wrote:
>> This patch adds a new compatible string description for
>> CDNS UFS HCD + M31 16nm PHY.
>=20
> The phy is not a separate block?=20

In this case PHY is controlled by some extra registers
in the controller's address space, accessible via its
hardware register interface.

Having an extra compatible also makes it consistent with
others controllers, which are already in the kernel.

ufs-qcom.txt:
- compatible        : compatible list, contains one of the following -
			"qcom,ufs-phy-qmp-20nm" for 20nm ufs phy,
			"qcom,ufs-phy-qmp-14nm" for legacy 14nm ufs phy,
			"qcom,msm8996-ufs-phy-qmp-14nm" for 14nm ufs phy
			 present on MSM8996 chipset.

tc-dwc-g210-pltfrm.txt:
- compatible	: compatible list must contain the PHY type & version:
			"snps,g210-tc-6.00-20bit"
			"snps,g210-tc-6.00-40bit"

Regards,
Jan

>=20
>>=20
>> Signed-off-by: Jan Kotas <jank@cadence.com>
>> ---
>> Documentation/devicetree/bindings/ufs/cdns,ufshc.txt | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt b/Docu=
mentation/devicetree/bindings/ufs/cdns,ufshc.txt
>> index a04a4989e..02347b017 100644
>> --- a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
>> +++ b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
>> @@ -5,8 +5,9 @@ Each UFS controller instance should have its own node.
>> Please see the ufshcd-pltfrm.txt for a list of all available properties.
>>=20
>> Required properties:
>> -- compatible	: Compatible list, contains the following controller:
>> -			"cdns,ufshc"
>> +- compatible	: Compatible list, contains one of the following controlle=
rs:
>> +			"cdns,ufshc" - Generic CDNS HCI,
>> +			"cdns,ufshc-m31-16nm" - CDNS UFS HC + M31 16nm PHY
>> 		  complemented with the JEDEC version:
>> 			"jedec,ufs-2.0"
>>=20
>> --=20
>> 2.15.0
>>=20
>=20

