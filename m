Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EEEC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B0A217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="EQXLQFhn";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="gYbn6SXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfGQK7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:59:25 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:52742 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbfGQK7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:59:25 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6HAveav021805;
        Wed, 17 Jul 2019 03:58:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=proofpoint;
 bh=k5a0nbgCGii4YyS6eGeL9qKquO//93AyQ+mY231zwi0=;
 b=EQXLQFhnzL5eLpswgKhxnlX5RAzFMmLaB+zwJlHqgG2SbQxoPr6EucGB4Au6nv7diQTz
 o7IZA5Gsv9Unim+M0XpUylRiTrB/D3AnFkCLSWxqub62YmTXDw44C8DfEjlPs4r0S3yh
 CA/PFglHX/bTYCGEjUMd/u+kJxHytZ2jfRUiZG8l8pLlmF/6g9kLVHvH+WWDdD8JM6J6
 A948PKnl/4xxmgp2pn302aZP6uTSQ8AvJN7BJkMQ6OfBhR23c4PJIxsH6pstE8BMSvEi
 leX78rjFdcFPPs1BIPhSrlRGHn5+FREnCFyXRKECmnT+3K4MR/HyZzruHUdnFg8afX5z dA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=piotrs@cadence.com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2052.outbound.protection.outlook.com [104.47.49.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2tqbuw785b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Jul 2019 03:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALN8HtknUraVPpZWEz8qsoVbqiTzWrHiT4eu1rsIvAoYuU6rcEQHCSSxMp7hp2KpstdCAebiySYf1wF3nUwFnNPo2XInbt+8dR5Wmo+ir5Zea9MqwImxeqMVMIjyd5+I0audTuOhyAOtPfdebyfUqlm+pjgMwGDPY0ML8i+CQ71X+sAqx+Z+XfokmCUlNh5Has8RQEsKAOxLB2PleYHt9Qou42FeIKGh4oSoA2VuKUOaMVLwSVu0ZTeE/qWPCV9EmvzlLzr6z4R8mfvpe3XBU9LWsN3LwR9UKhFvoM0h1b2+faj2wca3uBQauOnJmHM8G0Lm02rFdhG8rbYwm7feIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5a0nbgCGii4YyS6eGeL9qKquO//93AyQ+mY231zwi0=;
 b=Sn8Ix4NjWn5ARwojpaK3tQYoQGiGc01n7wWLZcJDz0ekrLoqnwIvPMLoNiBi2dkhP2oxU2LXytqp4jFTqTZlFsQ1gnqTvvKzY5HshijVYbzmwZ1zXVOXpo7zrNmXySJRSkv4t99DvuZUHAZ/iAZTJnTjss3A19wmIqaU4I8J4w6FPUEOuSRpjR8B7OTK7T057TMjzLoUHlcdBZdMfrmgaek4G763F8t1r253u2zmYkvfQhugs8cxoT7UJ5rTJUoHgz0KFlZKZgMtDb/k/zOWumYcwx05eYIV96m0hYdrirB+FCKml4Ua5TphJ3yJI/KeNHudEaTPBrlOagBMSgMaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=softfail (sender ip is
 199.43.4.28) smtp.rcpttodomain=gmail.com smtp.mailfrom=cadence.com;dmarc=fail
 (p=none sp=none pct=100) action=none header.from=cadence.com;dkim=none
 (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5a0nbgCGii4YyS6eGeL9qKquO//93AyQ+mY231zwi0=;
 b=gYbn6SXq4DCpvBdWc+9vvACuyuUnRNED7E7kdtA/w9M/dXhTEpgLfcv3OQ9DDXW4P0iv0302UhKVtXa40yS/YWJ3NzDtKucSVVEjXXTA3cY9jvz3NNXsJCMWHPkPjMpl1do6V/bdHWlM58meJpLugabxDjvn7OcDlP/Puh3Gqjk=
Received: from DM5PR07CA0055.namprd07.prod.outlook.com (2603:10b6:4:ad::20) by
 BN6PR07MB2994.namprd07.prod.outlook.com (2603:10b6:404:a7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 10:58:45 +0000
Received: from DM3NAM05FT046.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::209) by DM5PR07CA0055.outlook.office365.com
 (2603:10b6:4:ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2073.14 via Frontend
 Transport; Wed, 17 Jul 2019 10:58:44 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT046.mail.protection.outlook.com (10.152.98.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.8 via Frontend Transport; Wed, 17 Jul 2019 10:58:43 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x6HAwa2j006017
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 17 Jul 2019 06:58:39 -0400
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from global.cadence.com (158.140.32.37) by
 mailsj6.global.cadence.com (158.140.32.112) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 17 Jul 2019 03:58:33 -0700
Date:   Wed, 17 Jul 2019 11:58:27 +0100
From:   Piotr Sroka <piotrs@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        BrianNorris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "Richard Weinberger" <richard@nod.at>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: [v3 2/2] dt-bindings: nand: Add Cadence NAND controller driver
Message-ID: <20190717105825.GA11796@global.cadence.com>
References: <20190614150956.31244-1-piotrs@cadence.com>
 <20190614151301.5371-1-piotrs@cadence.com>
 <20190709144853.GA23699@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20190709144853.GA23699@bogus>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj7.global.cadence.com (158.140.32.114) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(36092001)(199004)(189003)(426003)(54906003)(23676004)(55016002)(11346002)(126002)(58126008)(336012)(2486003)(3846002)(476003)(67846002)(956004)(16586007)(53416004)(26005)(6116002)(186003)(76176011)(6666004)(386003)(316002)(16526019)(81156014)(446003)(70206006)(7696005)(1076003)(76130400001)(8936002)(356004)(6286002)(53936002)(47776003)(68736007)(7416002)(81166006)(486006)(6246003)(50466002)(478600001)(66066001)(4326008)(33656002)(26826003)(69596002)(2906002)(305945005)(5660300002)(86362001)(6916009)(229853002)(8676002)(70586007)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2994;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f15a167-4e23-4599-0855-08d70aa5bc96
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR07MB2994;
X-MS-TrafficTypeDiagnostic: BN6PR07MB2994:
X-Microsoft-Antispam-PRVS: <BN6PR07MB2994D4D34A81799A6817A9CFDDC90@BN6PR07MB2994.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 01018CB5B3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: enLAcxIdBvmK3OmsZO92prmJXwNN/iqzszJY1erJWO79sXaAr1VNUdEiYyDPAI8FSPWuY0Md5u/jugx3aDwUG+X9YkG/CtFo3geIiNunJKQQvdIInwzTKnQyxQrNOS1sccks4RjUd6B82pbO/Qp6Wd2Nl+DE71qjvd1WwVw0mw9ySB3APLAbJ2vsPbC9MS9yTyQjWETsZIr/neH28Sdv6/OCKWXBke942coOOZAjse082FAsP4rlIPQAdupoX9T9R5eFmCnB9KOPF9H1eWmOMcfnj8S0aGO07vQHsJxJ1Q4qfE+uN/WmdopXEVniXYafinUD9JA14ObFRs2W7uDDzPNVRPGaGM/ehiazcn5gMxs+5V8ItfdJW4i0kSNNRHbEd67O3kykDnJslzxfbTOUSZgGAdeOqwXo12Y3cAaPXjs=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2019 10:58:43.9760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f15a167-4e23-4599-0855-08d70aa5bc96
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2994
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/09/2019 08:48, Rob Herring wrote:
>EXTERNAL MAIL
>
>
>On Fri, Jun 14, 2019 at 04:13:01PM +0100, Piotr Sroka wrote:
>> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
>> ---
>> Changes for v3:
>> - add unit suffix for board_delay
>> - move child description to proper place
>> - remove prefix cadence_ for reg and sdma fields
>> Changes for v2:
>> - remove chip dependends parameters from dts bindings
>> - add names for register ranges in dts bindings
>> - add generic bindings to describe NAND chip representation
>> ---
>>  .../bindings/mtd/cadence-nand-controller.txt       | 51 ++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
>> new file mode 100644
>> index 000000000000..e485b87075bd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
>> @@ -0,0 +1,51 @@
>> +* Cadence NAND controller
>> +
>> +Required properties:
>> +  - compatible : "cdns,hpnfc"
>
>Only 1 version of h/w features and bugs?
>
At the moment, yes.

>'hp-nfc' would be a bit more readable IMO.
>
I will replace it.

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
>> +  - cdns,board-delay_ps : Estimated Board delay. The value includes the total
>
>s/_/-/
>
>> +    round trip delay for the signals and is used for deciding on values
>> +    associated with data read capture. The example formula for SDR mode is
>> +    the following:
>> +    board_delay = RE#PAD_delay + PCB trace to device + PCB trace from device
>> +    + DQ PAD delay
>> +
>> +Children nodes represent the available NAND chips.
>
>Child nodes...
>
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
>
>remove space                       ^
>
>> +
>> +	  compatible = "cdns,hpnfc";
>> +	  reg = <0x60000000 0x10000>, <0x80000000 0x10000>;
>> +	  reg-names = "reg", "sdma";
>> +	  clocks = <&nf_clk>;
>> +	  cdns,board-delay_ps = <4830>;
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
>> --
>> 2.15.0
>>
Thanks
Piotr
  


