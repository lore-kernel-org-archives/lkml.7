Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E25C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB1420863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="K4PQOiae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfCDHTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:19:46 -0500
Received: from mail-eopbgr810107.outbound.protection.outlook.com ([40.107.81.107]:9210
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfCDHTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 02:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhU0yoGX6f2rpDwZxJvcn4/p5cqNg1FA/gXO1bwwqXA=;
 b=K4PQOiaeZPP321cVyPQ+Sx2o9e0YPCF8/ghyawuFhmpuWSqltID9E9msdZ/Mjr5qAYgLMYqfwyT2nmaf99HjKCXm5hxhKEI5ZtJNaY7l5aqH49PfFyqauA57I+RGrswsqB0XM5hjSp2ic5CVHwsYC7j03SDKwMnF/6rz3lvgaXE=
Received: from BN4PR13CA0014.namprd13.prod.outlook.com (2603:10b6:403:3::24)
 by DM5PR13MB1466.namprd13.prod.outlook.com (2603:10b6:3:124::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.11; Mon, 4 Mar
 2019 07:19:41 +0000
Received: from BL2NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BN4PR13CA0014.outlook.office365.com
 (2603:10b6:403:3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1686.5 via Frontend
 Transport; Mon, 4 Mar 2019 07:19:41 +0000
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.106 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.106; helo=ap.sony.com;
Received: from ap.sony.com (117.103.190.106) by
 BL2NAM02FT005.mail.protection.outlook.com (10.152.76.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1643.11 via Frontend Transport; Mon, 4 Mar 2019 07:19:41 +0000
Received: from APYOKXHT104.ap.sony.com (117.103.191.217) by
 APYOKXEG102.ap.sony.com (117.103.190.106) with Microsoft SMTP Server (TLS) id
 14.3.435.0; Mon, 4 Mar 2019 07:19:30 +0000
Received: from APYOKXMS108.ap.sony.com ([169.254.3.61]) by
 APYOKXHT104.ap.sony.com ([117.103.191.217]) with mapi id 14.03.0435.000; Mon,
 4 Mar 2019 07:19:29 +0000
From:   <Jacky.Cao@sony.com>
To:     <gregkh@linuxfoundation.org>
CC:     <oneukum@suse.com>, <stern@rowland.harvard.edu>,
        <linux-usb@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>, <Jacky.Cao@sony.com>
Subject: RE: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Topic: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Index: AdTSLgpzOGdRpj0zQCK34IH7me4SXgAJLt2AAAFgBQA=
Date:   Mon, 4 Mar 2019 07:19:29 +0000
Message-ID: <16EA1F625E922C43B00B9D82250220500869697D@APYOKXMS108.ap.sony.com>
References: <16EA1F625E922C43B00B9D8225022050086961B5@APYOKXMS108.ap.sony.com>
 <20190304062325.GA2686@kroah.com>
In-Reply-To: <20190304062325.GA2686@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [43.82.16.93]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.106;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(136003)(396003)(2980300002)(40134004)(199004)(189003)(13464003)(7696005)(76176011)(106002)(50466002)(86362001)(53546011)(33656002)(6246003)(102836004)(6346003)(107886003)(6116002)(3846002)(4326008)(478600001)(23726003)(5660300002)(11346002)(66066001)(37786003)(446003)(47776003)(16586007)(54906003)(476003)(316002)(126002)(486006)(356004)(106466001)(2351001)(6916009)(2876002)(186003)(336012)(14444005)(97756001)(229853002)(426003)(2906002)(72206003)(8936002)(55846006)(55016002)(246002)(8676002)(26005)(77096007)(7736002)(7636002)(305945005)(46406003)(86152003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1466;H:ap.sony.com;FPR:;SPF:Pass;LANG:en;PTR:apyokxeg102.ap.sony.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14b6c606-0e9b-415b-e566-08d6a071c4eb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7193020);SRVR:DM5PR13MB1466;
X-MS-TrafficTypeDiagnostic: DM5PR13MB1466:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR13MB1466;20:0pi2jw4lVsHpMF0PQkERaIbvMHXZB3nkv8/hsD70PDZ0hxpKbrPnFaUbzxXkOyx2AB/PK+eD/KAyR5qkK3dL1n7Fp2e+BaNbvcp0wVOfFHhrRe/13qEnzWJFEddrNGaz/wQ2tkjuOeMU890DYb86SxIM11gCcfqf0HTX00F4fckMASqjIS/248jEtkB2r45tpssopfhluBaABYgdEcSq8ZgOUKBI7pTUcnfcJIk7diIY5/8Rhv8k6nQ8KgJR7KnGY9ZM+gr2Etcgmw20MtHXNbUW10MsWML6NvejVGIx/NS3vkLLQ2aCT9OUrVDhN6qnqTYmwW4pSQ22tXvKCkoKjsiliSzbk3/knMSjIrCWU/gGFAhqetX4n0ESZ5xGm7i6Yt6F6cJy2gxdIdQ79gI/tJpfHhTjrBAx/a19dclVG06nOsgqV+ioT0JypunJnPNeWxWPv/vDP3WUGEogyVeOw8osIW6a/BM3pDx3RiRtY5pPUk50oQKM+N9CBKxGOneX
X-Microsoft-Antispam-PRVS: <DM5PR13MB1466E7BF4217221F80D99BCE87710@DM5PR13MB1466.namprd13.prod.outlook.com>
X-Forefront-PRVS: 09669DB681
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR13MB1466;23:Q+tJQ/WancYxXKakvYePLgYRBpFndDxCK2sWhCdUw?=
 =?us-ascii?Q?FeNbmh7USmCSzsk7KTY5FLNlmAkTMoLdLAsQxuAyHIiJMcuAW+3No4HlVOJ6?=
 =?us-ascii?Q?PP99CJtPpGZmo/2OvdxXuqPWdekevSCPEAH5zYCQoRo7JzgLshE7LTRWH17h?=
 =?us-ascii?Q?6z/Z7hSN1w+XS87iTDPlGQL11w6PIK2Q34chUXUmbCgXP5IOP+ofCPNJcgeN?=
 =?us-ascii?Q?5VEdygg1RSTVVnNBUESuidU4gB3KGQGBZnusRsQkDdcsEtCSbCXB/PH74QWI?=
 =?us-ascii?Q?jJIJAJWf0ieyEdGCbvLRLF1QYr7v4Lhl8U4wCaWIMtwd9okGHmGFNBux8/iI?=
 =?us-ascii?Q?ywBLEtWwI0OWJKjCSuUqZxwlRkxmti6XIfdFHg41cMCsGmIaUR0nkgK5JV/3?=
 =?us-ascii?Q?5yQg8fsjmd/8oSvbeH3JCXedx5RvRpx0iBDHgQ3Mr6HzVf5t5umBo9EbbUD+?=
 =?us-ascii?Q?t46DoR6E90QKeAfDUfNGs4E7hoxAVbp4+fD3UYKDVUXxxPJjZx+zcPQdPHK+?=
 =?us-ascii?Q?OIow0aqXiGYPT0j+EWf2jLe/CiHHoIFHhGRwcXRVChykBv965Y/W3/NuE8bn?=
 =?us-ascii?Q?d+bt7C2P2h4iYuUbQ+Az12hrOwLUSFkB2mdfrAYvwQcMFaQUlyr/z+TPDqy2?=
 =?us-ascii?Q?T5uJP2WsF12SP8CrhKqc9Lqo0W85ba900DvU5OQbPfhgXv/9T4jY/2E5wkhm?=
 =?us-ascii?Q?5wkKKIfOpFJc1le0k7zsbXc9TSFRMCaC0XT8xL1g5xtXAIdMbvbiWIHSWC4C?=
 =?us-ascii?Q?zrEzpNMm9YLIUmSnqGYTVwdTFrx6Xq9iRw6oqF+fyMds4M/agiKUM6OTTYcw?=
 =?us-ascii?Q?JGmo+yuxFRjaBPWdldQ3BOQ07EV080y6wrvCKKq3DqbTsKOPR/Pd0ql033GR?=
 =?us-ascii?Q?ualwskEUm9SouL8RpToFFutPEwnh4zdQnnmiDkFCyVT8R1tMspahdOUSyP0z?=
 =?us-ascii?Q?qP7dPwZiE33IjZKwwRKPp6H709EahEEmWtO9fkVUt8nzkwdHKVwPOSTUUWTg?=
 =?us-ascii?Q?JUY/oi4m40vdGkf+w60wNXrmDQkMKcPeaL3MbSeVXlajhr3WUtp68rOmUL7F?=
 =?us-ascii?Q?kis4c2mhqcr3ZEbDtmb7HOnMyDiXRnuZbCNfYoKFXcC5JL2IZ2ub/IWzOTEJ?=
 =?us-ascii?Q?yB45DekXKOiKyBC6Z/iulfeAOaiM7LoZhy8uw2X5D3Bcn375+wMQ0BxR0qUQ?=
 =?us-ascii?Q?jwvmnOix4C3VOoitsobiLfYwDGwFDYm/Rf3CauFrZQRuWZRArPY99t3ZUQI6?=
 =?us-ascii?Q?rpf9ezwx2RaEaMFpWpsk2gLNiJ+aXqrJ4+Q96zUG1ni4jyIqkv/rVXEzAkxk?=
 =?us-ascii?Q?f1szijNKNb+KD31ZZ4AceiScsVz5735bPflNybEY8I/v9XHqO7VmsIvee+XG?=
 =?us-ascii?Q?J9k3A=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: AK8RZgqQ27xWZxpaJLtqswnUmkHR1OFfX6KZYLR8pe1iACCSdmIJeNcxcusO6uC/wkLXmLgdbGzdca95DzUIs7oE0EQ1XHLaUci15Gv9+TE7R+n09i4d8AVnwaV7yQJ/NOBgS5HfqWklnIs+Nn0aRerDgwAQUuEbhsjcJOHymZXPc2i7CWg1qD5y4EFC0FjCt3PPcCWx/3nSYL6woAPxFA1fCXZU8tj43Fj1Ot30jncO0Dj8berQsTwgBKBtIUv7JUZcIyU7Qcxh0LUo0tOGRmSrICxbfy6HrDDhUkMbpzA6f98PQgeA8FZd0wcs7celm5Irdgm03+xrIktpGzUEyxkw0vLVg3gMaot9H6qECwokVptLcAolfobtoVnq2U8kBVxm1S9Qk4cnladLxPzqq6KqNs25YV0Z4uIWmAWZlms=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2019 07:19:41.0171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b6c606-0e9b-415b-e566-08d6a071c4eb
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.106];Helo=[ap.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg-san:

I confirmed our company email related counter person that below footer is added automatically
after we send email to who doesn't work in our company.
I am very sorry that I didn't notice this issue and make you confuse.
Now I am confirming with our counter person whether there is solution to not add below footer.
After that, I will re-send patch mail to you.

Best Regards
Jacky

-----Original Message-----
From: Greg KH [mailto:gregkh@linuxfoundation.org]
Sent: Monday, March 04, 2019 2:23 PM
To: Cao, Jacky
Cc: oneukum@suse.com; stern@rowland.harvard.edu; linux-usb@vger.kernel.org; linux-scsi@vger.kernel.org; usb-storage@lists.one-eyed-alien.net; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: uas: fix usb subsystem hang after power off hub port

On Mon, Mar 04, 2019 at 02:08:54AM +0000, Jacky.Cao@sony.com wrote:
> ________________________________
>
> This email is confidential and intended only for the use of the individual or entity named above and may contain information that is privileged. If you are not the intended recipient, you are notified that any dissemination, distribution or copying of this email is strictly prohibited. If you have received this email in error, please notify us immediately by return email or telephone and destroy the original message. - This mail is sent via Sony Asia Pacific Mail Gateway..

This footer requires me to delete this email as it is not compatible
with doing Linux kernel development.

greg k-h

________________________________

This email is confidential and intended only for the use of the individual or entity named above and may contain information that is privileged. If you are not the intended recipient, you are notified that any dissemination, distribution or copying of this email is strictly prohibited. If you have received this email in error, please notify us immediately by return email or telephone and destroy the original message. - This mail is sent via Sony Asia Pacific Mail Gateway..
