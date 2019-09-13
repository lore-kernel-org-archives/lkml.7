Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE6EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B0520717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="BM4JCaPW";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VssIR/9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387911AbfIMOmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:42:25 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:10170 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729708AbfIMOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:42:24 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8DEch3p020197;
        Fri, 13 Sep 2019 07:41:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=proofpoint;
 bh=duyz2Dwm08NgnJrpTrXi8XpLm1p3CgA80hr2CwvNyPc=;
 b=BM4JCaPWFJaH4cNlDqblUQcYu0Td8ueNkqvN3B+F4zgs72AoqxGB9oBlLBGWhrcsuJ7J
 amuJ0nifsUJYL6F0FLlKCkTGDdrsl8TgBuNUcVEdad8UopsxxfvqTLiOHvHenpoYlVnj
 VLJiU141K1JzLhSfYF6U85l2CG0/wNpR/+pO6vcfS58BFWAp41CufpfR3RGAK0rltLkf
 FnyzXZ6DkylaQznXYxXQ1fy42fgVNqpYYW75aXU6EA0WBGHWJRDAtlGY+QaOBwtKejRZ
 TIwbaANNuUnqGOEN1M+vLb/lMSkVGBuRYMgBiFSAKLt5WRYbQWG6mt65twEk3a4hRAuo qQ== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2052.outbound.protection.outlook.com [104.47.37.52])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2uytddkydn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 07:41:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGx0Ao/75qgXSAy5ufcvN8+Ym93OsNnbLxmotCz+mY75vZSzeVxvqQ3CUwcwmlR9CdKBxt4ks1DoC/qUKKezf2oLIRm2Lol1VDCqyShhwIFjZ8sLeJ34RN2jjUCq5wY0ueQS6MWflW9B17ine5SLknzq3igy6EFwmFiyNThEDVnZ3y3cTGi3JRbVGWklPe7WBsO3NwZEnIApRMcntCk5dtb7eVl59jGTIB79on0ScGw4htrSZQ0t1D2msRvafLxJcR9oX/EgzoN40IY/7ekSXfCdApow4YNL9fVCk3//rxrWOUOfwq1psKptRzSB/Ef7dnqijR7lQhtWpBr4cmGVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duyz2Dwm08NgnJrpTrXi8XpLm1p3CgA80hr2CwvNyPc=;
 b=ea70RoyC5QOYXuTCafv+ww42f28kSGEa6tvxGGtTkG5+2yO1kT9i6DvMHMRGBZmgijdjA7axHtuQ4f93S6UggoeMNXWiTPakm0a8ejIaPt81MSQmCnLvnXtnAetpcHQe6mEaTBgim7IdgExKyTkUDy0KqkaEEKWjq4lNZjRFGh1eSmOMUBrHAez8fGg+Ol/sYXv8RxKSM260/1vEijFSiHcQU7h3UL4wbrK1Jz6cq3w6UbZ+JcUuciW9+QSuqtMCV9ZdITVS3U0Y1U1A9ckFBcxMiCs0vJyKk96wEAGuUs1SWLCktirRUWJfhjIt64h7Va3IJHAdxAYD1jfzVI2iGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duyz2Dwm08NgnJrpTrXi8XpLm1p3CgA80hr2CwvNyPc=;
 b=VssIR/9pEZBlQfqfRyMFSpw0lNiiXSBmXBpMHsjoHhExP1XqSo49suFe1bmrGdOGJjoztpUKZB3xOke6Q6Ykqny5n9kSHCh0lBuLkTrxaANKq63m0K2/p+vAan56CVEtjElltyVnPc8/jORcBRwnJqKbxjSKVKZ6/ZNN3DvXClU=
Received: from SN4PR0701CA0024.namprd07.prod.outlook.com
 (2603:10b6:803:28::34) by BN7PR07MB4562.namprd07.prod.outlook.com
 (2603:10b6:406:aa::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.21; Fri, 13 Sep
 2019 14:41:33 +0000
Received: from DM3NAM05FT059.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::205) by SN4PR0701CA0024.outlook.office365.com
 (2603:10b6:803:28::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2263.21 via Frontend
 Transport; Fri, 13 Sep 2019 14:41:33 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT059.mail.protection.outlook.com (10.152.98.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.10 via Frontend Transport; Fri, 13 Sep 2019 14:41:33 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x8DEfSfS025862
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 07:41:29 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from global.cadence.com (158.140.32.37) by
 mailsj6.global.cadence.com (158.140.32.112) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Sep 2019 07:41:26 -0700
Date:   Fri, 13 Sep 2019 15:41:22 +0100
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
Message-ID: <20190913144121.GB11985@global.cadence.com>
References: <20190725145804.8886-1-piotrs@cadence.com>
 <20190725145955.13951-1-piotrs@cadence.com>
 <20190830114638.33dc4eb2@xps13>
 <20190911150422.GA4973@global.cadence.com>
 <20190913144903.0323a23a@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190913144903.0323a23a@xps13>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj7.global.cadence.com (158.140.32.114) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(189003)(199004)(36092001)(53416004)(126002)(50466002)(486006)(426003)(8676002)(76130400001)(246002)(336012)(76176011)(58126008)(33656002)(4326008)(7696005)(23676004)(2486003)(54906003)(386003)(7636002)(305945005)(7736002)(55016002)(6246003)(6286002)(356004)(6666004)(6916009)(229853002)(7416002)(26005)(47776003)(16526019)(26826003)(5660300002)(6116002)(316002)(8936002)(478600001)(3846002)(66066001)(956004)(186003)(70206006)(1076003)(2906002)(476003)(446003)(11346002)(2870700001)(86362001)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4562;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a11f57d3-6135-4c97-d45d-08d7385878f7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN7PR07MB4562;
X-MS-TrafficTypeDiagnostic: BN7PR07MB4562:
X-Microsoft-Antispam-PRVS: <BN7PR07MB45627BEE1B451A6349E296D9DDB30@BN7PR07MB4562.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: gjkPqEaX3nnxgxe+4X8MH1JYsQjJ2Hxr5BADJWE0+ij6+XNtO7jO57qghHZzHAp8W7loLqGWcNqdW1+wC26KEMCY0mJ/M/yAj3GFr6pngORJIwPPwLCCymrskAXty/ASkn90Jsvmd9zcURvjQ7km0iusS3FKkzaGDlEyEJ+03D/Xjfj9Mxega4lEWMHQN32QkosGDMmfcQCDY56PJJ1lq/WZ8Zm5mGyphjQyWQ8XIzPpP2OhMECXNRM8fHVgQyEla15itaGU/MYBpQpOH4mUdyaejz1pgLIjJEyzf98HW8t022oNAkJbGh2MC7UCBs71XMty4a5gvIgT0s3atZAanm+y7QpY0B2R8sLUDv/ExU9X6Xwjm0gxRNKLkyqMzohNBMkk4A/qX05DsBMm8ALhQetyTdru1zwVwpoRbPWWSeA=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 14:41:33.2678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a11f57d3-6135-4c97-d45d-08d7385878f7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4562
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_07:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 09/13/2019 14:49, Miquel Raynal wrote:
>EXTERNAL MAIL
>
>
>Hi Piotr,
>
>Piotr Sroka <piotrs@cadence.com> wrote on Wed, 11 Sep 2019 16:04:24
>+0100:
>
>> Hi Miquel
>>
>> The 08/30/2019 11:46, Miquel Raynal wrote:
>> >EXTERNAL MAIL
>> >
>> >
>> >Hi Piotr,
>> >
>> >Piotr Sroka <piotrs@cadence.com> wrote on Thu, 25 Jul 2019 15:59:55
>> >+0100:
>> >
>> >> Document the bindings used by Cadence NAND controller driver
>> >>
>> >> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
>> >> ---
>> >> Changes for v5:
>> >> - replace "_" by "-" in all properties
>> >> - change compatible name from cdns,hpnfc to cdns,hp-nfc
>> >> Changes for v4:
>> >> - add commit message
>> >> Changes for v3:
>> >> - add unit suffix for board_delay
>> >> - move child description to proper place
>> >> - remove prefix cadence_ for reg and sdma fields
>> >> Changes for v2:
>> >> - remove chip dependends parameters from dts bindings
>> >> - add names for register ranges in dts bindings
>> >> - add generic bindings to describe NAND chip representation
>> >> ---
>> >>  .../bindings/mtd/cadence-nand-controller.txt       | 50 ++++++++++++++++++++++
>> >>  1 file changed, 50 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
>> >> new file mode 100644
>> >> index 000000000000..423547a3f993
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
>> >> @@ -0,0 +1,50 @@
>> >> +* Cadence NAND controller
>> >> +
>> >> +Required properties:
>> >> +  - compatible : "cdns,hp-nfc"
>> >> +  - reg : Contains two entries, each of which is a tuple consisting of a
>> >> +	  physical address and length. The first entry is the address and
>> >> +	  length of the controller register set. The second entry is the
>> >> +	  address and length of the Slave DMA data port.
>> >> +  - reg-names: should contain "reg" and "sdma"
>> >> +  - interrupts : The interrupt number.
>> >> +  - clocks: phandle of the controller core clock (nf_clk).
>> >> +
>> >> +Optional properties:
>> >> +  - dmas: shall reference DMA channel associated to the NAND controller
>> >> +  - cdns,board-delay-ps : Estimated Board delay. The value includes the total
>> >> +    round trip delay for the signals and is used for deciding on values
>> >> +    associated with data read capture. The example formula for SDR mode is
>> >> +    the following:
>> >> +    board delay = RE#PAD delay + PCB trace to device + PCB trace from device
>> >> +    + DQ PAD delay
>> >> +
>> >> +Child nodes represent the available NAND chips.
>> >> +
>> >> +Required properties of NAND chips:
>> >> +  - reg: shall contain the native Chip Select ids from 0 to max supported by
>> >> +    the cadence nand flash controller
>> >> +
>> >> +
>> >> +See Documentation/devicetree/bindings/mtd/nand.txt for more details on
>> >> +generic bindings.
>> >> +
>> >> +Example:
>> >> +
>> >> +nand_controller: nand-controller @60000000 {
>> >> +	  compatible = "cdns,hp-nfc";
>> >> +	  reg = <0x60000000 0x10000>, <0x80000000 0x10000>;
>> >> +	  reg-names = "reg", "sdma";
>> >> +	  clocks = <&nf_clk>;
>> >> +	  cdns,board-delay-ps = <4830>;
>> >
>> >Are you sure you want to export this to the user? Not sure it is easily
>> >understandable and tunable... I'm not against but I would have troubles
>> >tuning it myself, unless using the documented value. Maybe you should
>> >explain more how to derive it?
>> I need to export this parameter somehow. The default value may not be
>> valid for other platforms. This value depends on platform, and may be different on different SoCs. So I think the DTS is the best place to put such configuration
>> parameter.
>
>What about a different compatible if it depends on the SoC?
I considered it but this dealy consists of PADs delay and PCB trace
delay. PAD delays are SoC dependent. Unfortunatelly PCB delay not.
What can I do I can split it on two delays, PAD_delay and trace_delay.
Then handle PAD_delay by compatible and trace_delay by dts. But I am not
sure whether it changes anythig. Still a delay need to passed by dts.
>
>This way you can retrieve a different driver data structure and avoid
>the pain for the user.

>
>Thanks,
>Miquèl


Thanks
Piotr
  
