Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D58C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E092075C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="r9EpZ81+";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="6pu4hbsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfIKPFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 11:05:10 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:47720 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727873AbfIKPFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:05:09 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8BExB6M010648;
        Wed, 11 Sep 2019 08:04:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=proofpoint;
 bh=XKF/hQK9j2HSFIXn4AJeiDIdzr6FQZRV7grdxzwssss=;
 b=r9EpZ81+9T6Prpj76YShOaALWGUSF5CUGFW1PcnBJqR+s6Cq6BBHlBslMDT1MSBDj2oX
 j8n9bm81MVadxbWC3hVe5l1jTSUoIM4p04p+AYyGZnNf503PM9FAjsHfnytatCJysPZG
 bup7g5c2g3JcNYHS5vtZHkL/UxmwTfz3TkHayDK9p3ZLJR+yvUYIHundESiw38SHRvS0
 7lxl/uwHZhGGkwTzt8Ms8Q1olVzya7syFVZe+E1fEf+NDicyxCy1/MJOimd7F1ciTGYl
 U+y1SCiqgdlqnoc+kzZWN1+tm2ia9Xg6StfT8SSUQ+rLpJ/x8bNmYAyNpED0I+QeAOeV LA== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2059.outbound.protection.outlook.com [104.47.33.59])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2uxhm7v069-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 08:04:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgmBWaZPuBH1oVtGidromc9snSGhppqmaMFUBfEIxjrLB/HDgiJLnAhv+V/hHCA5YpDOES4WrfmNh1OZkqr1J/bL8aUqa7BsgvKq71LPJlNNQLARBm0TICX+HayQGgomcSto/ZOpC9PIAO5vy5O3EO6lk6YNTPN5RDH+5tT+5f44iTXrsrhOLEWFdcS5q3DK/7bJ+eob93qW2pkOrn6dZ0mpwBFzjScRC6OtKlgEgxynxv2OhCNjz9y76imEVD9Bkb9mGFK+v632E04lWMvC5eUmgw60TtT8PVC447H/aAIg+1YM5eGffcjQnlFYK9WxfYNlB5/WwJvZJ3Z69myEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKF/hQK9j2HSFIXn4AJeiDIdzr6FQZRV7grdxzwssss=;
 b=C155skpN0wKtL2mYLT2Dv4HsksaoPVWcMmEVIxXuB27pe87Mw5qLzdnAJnziGk5uEEFJ2a79cscfE9UhaqY1lg26n5ELggN8+7soCVJyCyBWkROBucB+QQkQYxGLbKFnFWprlCrSVIzb3+j1c1PRe0bkvnHwlz93c11RmNmxgv+Ye11Z2qn5908ddxRrROBScnTKnm0jvH6OMTWqtrIIAQ/04asOIjgWFhbhwmATd0BHwh0UPTnHx6q17EmSzDTmUmnwU4bpkbIQOizvYBIU/YHA81cp3TqXRSuVMKOzBMTI/K+bZh8ElAyAhvri07qVncvvYIwXYaTsiYGH71b+RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKF/hQK9j2HSFIXn4AJeiDIdzr6FQZRV7grdxzwssss=;
 b=6pu4hbsJJavOK/sCA1gOm21wqCFDPZS/Zm0OqbG7pBbSOYycMaO84T5BrrgaD8yebIkBhvWc/p1EXxfMsR8DgBozBw0hMuIUe3WUb6zW4TpN/5Jt/L/NlW/XK3gqlVu77pTY9+PiRJq1/O5JiYhQan2g9U9k++tTXA/qr7xRNlU=
Received: from SN4PR0701CA0018.namprd07.prod.outlook.com
 (2603:10b6:803:28::28) by MWHPR07MB3437.namprd07.prod.outlook.com
 (2603:10b6:301:63::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.13; Wed, 11 Sep
 2019 15:04:37 +0000
Received: from DM3NAM05FT040.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::202) by SN4PR0701CA0018.outlook.office365.com
 (2603:10b6:803:28::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.15 via Frontend
 Transport; Wed, 11 Sep 2019 15:04:37 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT040.mail.protection.outlook.com (10.152.98.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.6 via Frontend Transport; Wed, 11 Sep 2019 15:04:36 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x8BF4XRf006971
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Sep 2019 08:04:33 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from global.cadence.com (158.140.32.37) by
 mailsj6.global.cadence.com (158.140.32.112) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Sep 2019 08:04:31 -0700
Date:   Wed, 11 Sep 2019 16:04:24 +0100
From:   Piotr Sroka <piotrs@cadence.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>,
        BrianNorris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Subject: Re: [v5 2/2] dt-bindings: mtd: Add Cadence NAND controller driver
Message-ID: <20190911150422.GA4973@global.cadence.com>
References: <20190725145804.8886-1-piotrs@cadence.com>
 <20190725145955.13951-1-piotrs@cadence.com>
 <20190830114638.33dc4eb2@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190830114638.33dc4eb2@xps13>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj7.global.cadence.com (158.140.32.114) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(36092001)(199004)(189003)(356004)(336012)(478600001)(55016002)(4326008)(26005)(386003)(6286002)(6246003)(186003)(16526019)(8676002)(8936002)(6666004)(66066001)(53416004)(2870700001)(33656002)(26826003)(426003)(11346002)(446003)(47776003)(956004)(14444005)(3846002)(70586007)(126002)(476003)(2906002)(486006)(70206006)(7416002)(7696005)(2486003)(6916009)(54906003)(23676004)(305945005)(6116002)(76130400001)(86362001)(229853002)(50466002)(246002)(5660300002)(58126008)(1076003)(66574012)(7736002)(76176011)(7636002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3437;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1b9373c-36fe-4885-dc63-08d736c95ce4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR07MB3437;
X-MS-TrafficTypeDiagnostic: MWHPR07MB3437:
X-Microsoft-Antispam-PRVS: <MWHPR07MB3437DF50C0423A4A80AEFA42DDB10@MWHPR07MB3437.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0157DEB61B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /9O4EWH9vS9NCZ08hdFLHHV4H1PdkEOg82JC5prpSFSNHQC6omZYeilwqNXh/JLiQAdDw7i7s/g4dovjWV/UKU1w8wf0zd7j+sScb6Y1ndMdV8Ca0F0XVCt9N2hRFIApg3Mc8lh3guYEvDgQJ3fox6RLqra2B3QSt7cRNxBKoYbMcNc/dKqIDFcTf6rLUDCl86TXLzK2nGIXlbeYumOBF9CZZwHhH1dSTgu+rQpUigK05R7O27SOUtgDnwgYFnZzfV55Y7P33YYjoHbcgmoaFQljtFBoiPl94BX0UCWZ3Y+tCZaMxBnVMgMAttSEXKB9tfMrR72rcBPQB0p6n4F85UnnH3CAgOAorv+HixzuAiOOdSQZ3SoTt8kPg+M2YdVqw9p4yMJ73kyDlwphjbbjs/2CAPJRZt5113/QytRD5AM=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2019 15:04:36.5008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b9373c-36fe-4885-dc63-08d736c95ce4
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3437
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-11_08:2019-09-11,2019-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909110139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel

The 08/30/2019 11:46, Miquel Raynal wrote:
>EXTERNAL MAIL
>
>
>Hi Piotr,
>
>Piotr Sroka <piotrs@cadence.com> wrote on Thu, 25 Jul 2019 15:59:55
>+0100:
>
>> Document the bindings used by Cadence NAND controller driver
>>
>> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
>> ---
>> Changes for v5:
>> - replace "_" by "-" in all properties
>> - change compatible name from cdns,hpnfc to cdns,hp-nfc
>> Changes for v4:
>> - add commit message
>> Changes for v3:
>> - add unit suffix for board_delay
>> - move child description to proper place
>> - remove prefix cadence_ for reg and sdma fields
>> Changes for v2:
>> - remove chip dependends parameters from dts bindings
>> - add names for register ranges in dts bindings
>> - add generic bindings to describe NAND chip representation
>> ---
>>  .../bindings/mtd/cadence-nand-controller.txt       | 50 ++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
>> new file mode 100644
>> index 000000000000..423547a3f993
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
>> @@ -0,0 +1,50 @@
>> +* Cadence NAND controller
>> +
>> +Required properties:
>> +  - compatible : "cdns,hp-nfc"
>> +  - reg : Contains two entries, each of which is a tuple consisting of a
>> +	  physical address and length. The first entry is the address and
>> +	  length of the controller register set. The second entry is the
>> +	  address and length of the Slave DMA data port.
>> +  - reg-names: should contain "reg" and "sdma"
>> +  - interrupts : The interrupt number.
>> +  - clocks: phandle of the controller core clock (nf_clk).
>> +
>> +Optional properties:
>> +  - dmas: shall reference DMA channel associated to the NAND controller
>> +  - cdns,board-delay-ps : Estimated Board delay. The value includes the total
>> +    round trip delay for the signals and is used for deciding on values
>> +    associated with data read capture. The example formula for SDR mode is
>> +    the following:
>> +    board delay = RE#PAD delay + PCB trace to device + PCB trace from device
>> +    + DQ PAD delay
>> +
>> +Child nodes represent the available NAND chips.
>> +
>> +Required properties of NAND chips:
>> +  - reg: shall contain the native Chip Select ids from 0 to max supported by
>> +    the cadence nand flash controller
>> +
>> +
>> +See Documentation/devicetree/bindings/mtd/nand.txt for more details on
>> +generic bindings.
>> +
>> +Example:
>> +
>> +nand_controller: nand-controller @60000000 {
>> +	  compatible = "cdns,hp-nfc";
>> +	  reg = <0x60000000 0x10000>, <0x80000000 0x10000>;
>> +	  reg-names = "reg", "sdma";
>> +	  clocks = <&nf_clk>;
>> +	  cdns,board-delay-ps = <4830>;
>
>Are you sure you want to export this to the user? Not sure it is easily
>understandable and tunable... I'm not against but I would have troubles
>tuning it myself, unless using the documented value. Maybe you should
>explain more how to derive it?
I need to export this parameter somehow. The default value may not be
valid for other platforms. 
This value depends on platform, and may be different on different SoCs. 
So I think the DTS is the best place to put such configuration
parameter.

>
>The rest looks fine, let's see if Rob agrees. Maybe he will request a
>yaml schema; in this case you can check sunxi NAND bindings which
>already have been converted.
>
>> +	  interrupts = <2 0>;
>> +	  nand@0 {
>> +	      reg = <0>;
>> +	      label = "nand-1";
>> +	  };
>> +	  nand@1 {
>> +	      reg = <1>;
>> +	      label = "nand-2";
>> +	  };
>> +
>> +};
>
>Thanks,
>Miquèl


Thanks
Piotr 
