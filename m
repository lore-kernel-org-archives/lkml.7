Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9256CC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B0E206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ABk+s767";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hNR4KpMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfGAKW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:22:28 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:15606 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbfGAKW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:22:27 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61ALjrl014560;
        Mon, 1 Jul 2019 03:21:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=proofpoint;
 bh=XrTaj9yCxa7DzuzbtG+ohG3nR8HkjedZTJgpqNJvwDQ=;
 b=ABk+s767kgWQ7YgMVSuqGNX5MBW8UU7ZTfFWxjcICrHkjH5wzSp4l4eLBF5VGrDZ1MDs
 tQEcs5/EsBDwHbbd0s91EgZoslSL2MSADAt1mcGSt6D1J2ubrFGjwzFdyQg4mN3GuZVg
 tzvR+adMOfkuiDMnYGJgR3y9K4ABWOxdMCoVFmIMJCQS1T+4s+AHwQUb3s2ZDLfzO5XS
 dCY+q4aJS1LI+VFlArpXeW69kyNgEZfossQZ5YKANUhMQVVGXwAB2U2sdB4wUzqPdvoR
 uCB73ySnlu0lhKh8EMoCLT2L34up1jNmCAstpVKksQQKilLNscDd3FsYYjkjyNSVkUk4 AQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=piotrs@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2055.outbound.protection.outlook.com [104.47.32.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2te4hweh0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 01 Jul 2019 03:21:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrTaj9yCxa7DzuzbtG+ohG3nR8HkjedZTJgpqNJvwDQ=;
 b=hNR4KpMvCcbSdkohGqIo3EVfeHC1w7gkBDJJM2k7smtA6FuQPFDQf+3waTB+FAjWkepnNs2ADlcEFroOJ1gLiAKtDeI//zCJuzOnlzl37PkPWAr/mwfpXfrABBXBcYTDzb3xmxpp53PZewmH/CjyOuOKWKoUM/aEItEUBe9d1Mw=
Received: from DM6PR07CA0027.namprd07.prod.outlook.com (2603:10b6:5:94::40) by
 MWHPR07MB3599.namprd07.prod.outlook.com (2603:10b6:301:64::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 10:21:48 +0000
Received: from DM3NAM05FT049.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::202) by DM6PR07CA0027.outlook.office365.com
 (2603:10b6:5:94::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.20 via Frontend
 Transport; Mon, 1 Jul 2019 10:21:48 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT049.mail.protection.outlook.com (10.152.98.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.8 via Frontend Transport; Mon, 1 Jul 2019 10:21:47 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x61ALkYg012269
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 1 Jul 2019 03:21:46 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from global.cadence.com (158.140.32.37) by
 mailsj6.global.cadence.com (158.140.32.112) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 1 Jul 2019 03:21:43 -0700
Date:   Mon, 1 Jul 2019 11:21:36 +0100
From:   Piotr Sroka <piotrs@cadence.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Marcel Ziswiler" <marcel.ziswiler@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Agner <stefan@agner.ch>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] mtd: nand: Add Cadence NAND controller driver
Message-ID: <20190701102135.GA20033@global.cadence.com>
References: <20190219161406.4340-1-piotrs@cadence.com>
 <20190219161823.22466-1-piotrs@cadence.com>
 <20190305190954.6c38d681@xps13>
 <20190321093356.GA19577@global.cadence.com>
 <20190512142426.11453a6c@xps13>
 <20190606151948.GA10565@global.cadence.com>
 <20190627181542.131aa061@xps13>
 <20190701095143.GA21903@global.cadence.com>
 <20190701120454.6c8ac48e@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190701120454.6c8ac48e@xps13>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj6.global.cadence.com (158.140.32.112) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(2980300002)(36092001)(199004)(189003)(246002)(7696005)(23676004)(7636002)(7736002)(386003)(229853002)(8936002)(8676002)(76176011)(186003)(2486003)(305945005)(26005)(16526019)(86362001)(66574012)(126002)(6916009)(1076003)(956004)(7416002)(476003)(67846002)(486006)(446003)(11346002)(2906002)(50466002)(6666004)(3846002)(6116002)(33656002)(426003)(2870700001)(4326008)(356004)(47776003)(316002)(5660300002)(66066001)(53416004)(54906003)(58126008)(6246003)(6286002)(478600001)(70206006)(70586007)(336012)(26826003)(55016002)(76130400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3599;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59558c44-7684-42a5-755d-08d6fe0decea
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR07MB3599;
X-MS-TrafficTypeDiagnostic: MWHPR07MB3599:
X-Microsoft-Antispam-PRVS: <MWHPR07MB35993B1CA4B5707003E17D20DDF90@MWHPR07MB3599.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 00851CA28B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: mavBlga0pxj3gvoZqeX9R9VXUA1XC7kN1gXkaOGOj3gsD3q+QA6j5J3cakp6jJ3ecweHkqYx1Aw6ZF1AR05I7VKZCPjm9xpb7Rb0kbDswOTySoPXFhIEA8F8QdNcIZ1HEe1BSJs/dW3QQgN18ZxQzS5P/T3ls7vpZPj0ZT2WeK0LrCho/w2YTv1AbLZP3ho9GPQTapoaBtiN+4cqR/u1I1p9vJQOQOIcX3AbckoB81qD/tCMfS7xoHtyujFFUzg6AGP31qNDDmTvtB+LxyOD0wRo0K7vTdsa38IgYVPZWcBQhkM/YEoo5bLZTn9UMKjcCLGBVovszEJxpf+LmlqpUEWKy/xApCF26EzXT4bdIAOkZ07DnqFWAuYZKQW6n9z+IlP3K0nNsxEUbbJmkvbaTUzjk8CbTIzQBmmqrFM6xZA=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2019 10:21:47.3985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59558c44-7684-42a5-755d-08d6fe0decea
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3599
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=849 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/01/2019 12:04, Miquel Raynal wrote:
>EXTERNAL MAIL
>
>
>Hi Piotr,
>
>Piotr Sroka <piotrs@cadence.com> wrote on Mon, 1 Jul 2019 10:51:45
>+0100:
>
>
>[...]
>> >> >> >
>> >> >> >This driver is way too massive, I am pretty sure it can shrink a
>> >> >> >little bit more.
>> >> >> >[...]
>> >> >> >
>> >> >> I will try to make it shorer but it will be difucult to achive. It is because - there are a lot of calculation needed for PHY      - ECC are interleaved with data (like on marvell-nand or gpmi-nand).
>> >> >>    Therefore:    + RAW mode is complicated    + protecting BBM increases number of lines of source code
>> >> >> - need to support two DMA engines internal and external (slave) We will see on next patch version what is the result.      That page layout looks:
>> >> >
>> >> >Maybe you don't need to support both internal and external DMA?
>> >> >
>> >> >I am pretty sure there are rooms for size reduction.
>> >>
>> >> I describe how it works in general and maybe you help me chose better solution.
>> >>
>> >> HW controller can work in 3 modes. PIO - can work in master or slave DMA
>> >> CDMA - needs Master DMA for accessing command descriptors.
>> >> Generic mode - can use only Slave DMA.
>> >>
>> >> Generic mode is neccessery to implement functions other than page
>> >> program, page read, block erase. So it is essential. I cannot avoid
>> >> to use Slave DMA.
>> >
>> >This deserves a nice comment at the top.
>> Ok I will add the modes description to cover letter. >
>
>Not only to the cover letter: People read the code. Interested people
>might also read the commit log which is quite easy to find. The cover
>letter however will just disappear in the history of the Internet. I
>would rather prefer you explain how the IP works at the top of the
>driver.
So I will add the modes description to both cover letter and 
at the top of the driver. 
>
>
>Thanks,
>Miquèl

Thanks,
Piotr 
