Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DACC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B9E20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="hjgDuB73";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="CP3PoJN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393952AbfIWMOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:14:43 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:63636 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726212AbfIWMOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:14:42 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8NC9JgB030945;
        Mon, 23 Sep 2019 05:14:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=proofpoint;
 bh=ueEAepJsk6iB8zdgMQedWvIrCGnLn5GAbw5vkakjyuc=;
 b=hjgDuB73QMmhdKqJVH9Mk/0iZHeUBMHcenINx3XRCS1uK6ACqQn2SqZW9q7tLyqAXy6g
 fPp09RLo2kgn/RbrDYfrO33zz7oNePIQsI2/o0Y27deXzeX4oPG83GCRuh5glLteSBbx
 y/2FGZ6kGtxhS4/2KHUuixJefInyRuU4vc9PIAsbRg3hlinlgx0SnoeAfw73kzuE+aVI
 hB7xAbuG45bR81elLcm2Cu1A00Z2KhEwDTQWdHO8Bl0POc5M8DyviqIlDAN0PLHq5wf+
 NVT4s98VIbBKpD7OyuOmBQXJZJQyml7O21jAY7j3QF88vu3gNCSzx7nmWmk2VUNVHx54 Dg== 
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2051.outbound.protection.outlook.com [104.47.50.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2v5fewf3y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 05:14:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqqML6Lm6AKqaRXXpNjPqkEw5A1cUl0aXV2oxkq84E/50170UejFJtXKxe62vPo4n1TlVIGo5mxcPFvtDT4WbXLZVKs4th66tAYN5zuXr/9Eb1OwgpCSl/a7EmsselaTgsBTsQgYMXms1j5ZB61/WB4jYyzq3NVVkfOD0mhlF7p69ELxgu328gA7wDOpG7x6dWHzKXMh6jWkGwg/kL0cms2oTfzxfF0HBES4AkcDlxFau48TJ++/D71rwuUFa/LA+zZ7vfeKZtOMPe/X52EfRiGtmMSlVb6tAGANuBSVqahPJe1sznsRajrVZh62CVClMx7rVJvC3ynS+62QBMuOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueEAepJsk6iB8zdgMQedWvIrCGnLn5GAbw5vkakjyuc=;
 b=GiPfevih8rmtNyMERVzdoBudWldJgEzZkNQUczyvKXZumZhqefq0g3x9sdqN5/JJ499QbaLeIbY6UMFGgW5NyKAQaa9AsEELuusoySsKCeqErTaBd2U5xEd1TKWrDA/IY1RNVQcCPrBYbsA+HH3qhVGAWk/pjs8tD24OxkkoPqmEsk3SYulhtPpb7LbM9s7FuZKedtSlLkN0pEuRLOO/slUn7N3dakGbAftdLAWIvp0bjTZ6WCFrCvqZKJhdyUZF9fzQyimG3wE5lWr3DIbXhnxf34eNf4+erHWV7Mp141uswLKverqGnZ4/pGbiepdqQzYS9DbhjGWdj2UdSNQUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 199.43.4.28) smtp.rcpttodomain=infradead.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueEAepJsk6iB8zdgMQedWvIrCGnLn5GAbw5vkakjyuc=;
 b=CP3PoJN1KiNDG/CvlHZU72v0YD3s3tgt6URDtp01tJlRzTujN+rKF34xB0jItrv3MK3PZDQbve4a/GwgmZmoGkIHR0bdk4o0EM+++bNwU8sbDwphIUXO34cRlekIsDQdH5SErBwpnUD3RWNUh4e+LpFyLmByrU9FyKRZReYtgMM=
Received: from CH2PR07CA0020.namprd07.prod.outlook.com (2603:10b6:610:20::33)
 by DM6PR07MB6844.namprd07.prod.outlook.com (2603:10b6:5:159::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.19; Mon, 23 Sep
 2019 12:13:57 +0000
Received: from BY2NAM05FT050.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::202) by CH2PR07CA0020.outlook.office365.com
 (2603:10b6:610:20::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.20 via Frontend
 Transport; Mon, 23 Sep 2019 12:13:57 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 BY2NAM05FT050.mail.protection.outlook.com (10.152.100.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.8 via Frontend Transport; Mon, 23 Sep 2019 12:13:56 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x8NCDnOr020068
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 23 Sep 2019 08:13:50 -0400
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from global.cadence.com (158.140.32.37) by
 mailsj6.global.cadence.com (158.140.32.112) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Sep 2019 05:13:46 -0700
Date:   Mon, 23 Sep 2019 13:13:39 +0100
From:   Piotr Sroka <piotrs@cadence.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] - change calculating of position page containing BBM
Message-ID: <20190923121337.GA15230@global.cadence.com>
References: <20190919124139.10856-1-piotrs@cadence.com>
 <20190919145819.66e74aef@xps13>
 <f03d93a5-4393-2405-b597-80b762059f01@kontron.de>
 <20190919151820.2bb8313d@xps13>
 <7a9675e4-8bcc-f822-6028-f78d0d12c3bf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a9675e4-8bcc-f822-6028-f78d0d12c3bf@kontron.de>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj7.global.cadence.com (158.140.32.114) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(36092001)(189003)(199004)(54094003)(1076003)(6916009)(33656002)(66574012)(336012)(5660300002)(53546011)(386003)(16526019)(26005)(186003)(7696005)(2486003)(23676004)(446003)(11346002)(476003)(76176011)(53416004)(956004)(7416002)(426003)(81166006)(305945005)(81156014)(4326008)(7736002)(6246003)(70586007)(70206006)(2906002)(6286002)(8676002)(6116002)(3846002)(14444005)(26826003)(8936002)(55016002)(50466002)(6666004)(356004)(229853002)(2870700001)(478600001)(86362001)(486006)(66066001)(58126008)(316002)(126002)(76130400001)(47776003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB6844;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9127f97c-a3f4-4c81-f504-08d7401f824f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR07MB6844;
X-MS-TrafficTypeDiagnostic: DM6PR07MB6844:
X-Microsoft-Antispam-PRVS: <DM6PR07MB6844056AF27D471146E33A63DD850@DM6PR07MB6844.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0169092318
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: iQavoL+ESTE/CSyIS0H0rD+Z5bXyE6R0Q65mNea3/GlEYwv9swTLfbjrNC6TJPGF/PySizGLnb9J3Sl6cboIDBMyFOScjYf/6RIBGsx/hAgoYwX6yVUEzAyn1GONUGvdeTGU7PomtmXax0PctBtR2bU2P2IVKZ1TuJ4vtPLAs7WpcI85bJtcceRqMY8Y2aGwW0ZHNHiRSXD6t8hXJxUuB9q2K49TI4VQz8VE378q3HXEnvAVVSSqE2TRZ/3K1k6xCgwWMnImqYE/vEBvpczQ4WtccvYS5B4mEYM9KztWQUaIPVwY6EXig7GRPw9Bmgvj0eek4ffgBoS7LniLkS/V99fw4zZu9cMJY3efTE6YzplHqfnfILSH0aNHSZttrbI/cp7Zl8mfFlrJePi+XSIXYp+s8DinJzIMu5543w9+Mes=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2019 12:13:56.9045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9127f97c-a3f4-4c81-f504-08d7401f824f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6844
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-23_04:2019-09-23,2019-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909230123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The 09/19/2019 13:33, Schrempf Frieder wrote:
>EXTERNAL MAIL
>
>
>On 19.09.19 15:18, Miquel Raynal wrote:
>> Hello,
>>
>> Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Thu, 19 Sep
>> 2019 13:15:08 +0000:
>>
>>> On 19.09.19 14:58, Miquel Raynal wrote:
>>>> Hi Piotr,
>>>>
>>>> Piotr Sroka <piotrs@cadence.com> wrote on Thu, 19 Sep 2019 13:41:35
>>>> +0100:
>>>>
>>>>> Change calculating of position page containing BBM
>>>>>
>>>>> If none of BBM flags is set then function nand_bbm_get_next_page
>>>>> reports EINVAL. It causes that BBM is not read at all during scanning
>>>>> factory bad blocks. The result is that the BBT table is build without
>>>>> checking factory BBM at all. For Micron flash memories none of this
>>>>> flag is set if page size is different than 2048 bytes.
>>>
>>> I wonder if it wouldn't be better to fix the Micron driver instead:
>>>
>>> --- a/drivers/mtd/nand/raw/nand_micron.c
>>> +++ b/drivers/mtd/nand/raw/nand_micron.c
>>> @@ -448,6 +448,8 @@ static int micron_nand_init(struct nand_chip *chip)
>>>
>>>           if (mtd->writesize == 2048)
>>>                   chip->options |= NAND_BBM_FIRSTPAGE |
>>>                                    NAND_BBM_SECONDPAGE;
>>> +       else
>>> +               chip->options |= NAND_BBM_FIRSTPAGE;
>>
>> That's what I forgot in my last answer to this thread, I think I only
>> told Piotr privately: I would like both. I think it is important to fix
>> the bbm_get_next_page function but for clarity, setting the FIRSTPAGE
>> flag in Micron's driver seems also pertinent.
>
>Indeed, that sounds reasonable. Piotr, can you send another patch with
>the diff above? And by the way: thanks for fixing my code ;)
>
>Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
Thanks Frieder and Miquel for the very quick reply. I will send next
version containing Micron driver fix.

>>
>>>
>>>           ondie = micron_supports_on_die_ecc(chip);
>>>
>>>
>>>>
>>>> "none of these flags are set"
>>>>
>>>>>
>>>>> This patch changes the nand_bbm_get_next_page function.
>>>>
>>>> "Address this regression by changing the
>>>> nand_bbm_get_next_page_function."
>>>>
>>>>> It will return 0 if none of BBM flag is set and page parameter is 0.
>>>>
>>>>                         no BBM flag is set
>>>>
>>>>> After that modification way of discovering factory bad blocks will work
>>>>> similar as in kernel version 5.1.
>>>>>
>>>>
>>>> Fixes + stable tags would be great!
Ok I will add fixes tag and "Cc: <stable@vger.kernel.org>". 

>>>>
>>>>> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
>>>>> ---
>>>>>    drivers/mtd/nand/raw/nand_base.c | 8 ++++++--
>>>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
>>>>> index 5c2c30a7dffa..f64e3b6605c6 100644
>>>>> --- a/drivers/mtd/nand/raw/nand_base.c
>>>>> +++ b/drivers/mtd/nand/raw/nand_base.c
>>>>> @@ -292,12 +292,16 @@ int nand_bbm_get_next_page(struct nand_chip *chip, int page)
>>>>>    	struct mtd_info *mtd = nand_to_mtd(chip);
>>>>>    	int last_page = ((mtd->erasesize - mtd->writesize) >>
>>>>>    			 chip->page_shift) & chip->pagemask;
>>>>> +	unsigned int bbm_flags = NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE
>>>>> +		| NAND_BBM_LASTPAGE;
>>>>>
>>>>> +	if (page == 0 && !(chip->options & bbm_flags))
>>>>> +		return 0;
>>>>>    	if (page == 0 && chip->options & NAND_BBM_FIRSTPAGE)
>>>>>    		return 0;
>>>>> -	else if (page <= 1 && chip->options & NAND_BBM_SECONDPAGE)
>>>>> +	if (page <= 1 && chip->options & NAND_BBM_SECONDPAGE)
>>>>>    		return 1;
>>>>> -	else if (page <= last_page && chip->options & NAND_BBM_LASTPAGE)
>>>>> +	if (page <= last_page && chip->options & NAND_BBM_LASTPAGE)
>>>>>    		return last_page;
>>>>>
>>>>>    	return -EINVAL;
>>>>
>>>> Lookgs good otherwise.
>>>>
>>>> Thanks,
>>>> Miquèl
>>>>
>>
>> Thanks,
>> Miquèl
>>

Thanks,
Piotr
