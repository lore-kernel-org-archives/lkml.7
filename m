Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C174C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4350A222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OhfwT2Kk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbfJDNEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:04:50 -0400
Received: from mail-eopbgr780083.outbound.protection.outlook.com ([40.107.78.83]:32000
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727587AbfJDNEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:04:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjB8B7/lKpLXqmdXwNFtzg7VtCplw1P1a2oO0xMhnrhMuRqqZCA8HJ6WdgPFfJgPcAmfZ/LKlayP1mR7hkIPEyaBnfv85F2saAwefdFaDriF6HaaYUfOpskO/RLPpLevQFTn1Vyqi980hXP6E+kdIKrdju3+1Ugslm7Kir2M5+NLkuIr6He1REd61uUxx2ONnd0GahXQTlm04OI57OKc3yZ5fbRur1CCHfpsBaNu1C3bny+TL93th6zmmimG/zr5fUEEPCZqNK5uEi9fRrD0K1cqBFFrvgp8fxLFob1ntPDDsIQgV/+Bw4m0xfg+IshGDBcQmspTnCMkc4ld5usXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3ydWf3WnhbAozKQX4tMOe3X6oRNSgHSqdWY20QEbRY=;
 b=gTKeHF16b1x516yoHG5DvMLT8zwyUGLXWQjDq8EEPnA/2uA0sWoC3b38ZqdWMnn3izmqnePFbldk4Rx7i3g+LXZuGKRgNbCR/DPv8yc/gG8beGYwW+zs4dw6F/ItSIUbLMoTHkV2Hj+qpj83R1aVCTelFa+ZuCaez6E+IgINo6nUFxqxF0kqdJlYyGU0r0mtnmhNebSjF7x3LulyBlhIFabkytpdsIV4nhuc/luwuOGIktI6G/shXnJsPRlwsI0DGDCajqKvScpD2UGT3XdVw07LzcAK7XO+j2z5fQQCouhQvqlRHtHFxK0Tqvt0SPprQhDGtCxlUkruIV2vc5IRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3ydWf3WnhbAozKQX4tMOe3X6oRNSgHSqdWY20QEbRY=;
 b=OhfwT2KkPm3KRzCQX28cMz3HWjiCyRv3BR9enLyo0j/nT/lcS6BJovVcybnr5hTM2/LU4GrihjSTxxKCvfVC/5Yfk1qj0MXvWy27Y/tf9gQTeN2UEp7uDe+zFF/RwfHko3lWxI9ykHms9rcc5r6Lsl9rfgVYF05jW1Hr8p/VEJQ=
Received: from MWHPR0201CA0048.namprd02.prod.outlook.com
 (2603:10b6:301:73::25) by SN6PR02MB5343.namprd02.prod.outlook.com
 (2603:10b6:805:71::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.23; Fri, 4 Oct
 2019 13:04:48 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by MWHPR0201CA0048.outlook.office365.com
 (2603:10b6:301:73::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2263.20 via Frontend
 Transport; Fri, 4 Oct 2019 13:04:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Fri, 4 Oct 2019 13:04:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iGNGI-0007Pz-PE; Fri, 04 Oct 2019 06:04:46 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iGNGD-0006P8-Kw; Fri, 04 Oct 2019 06:04:41 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x94D4TL2027467;
        Fri, 4 Oct 2019 06:04:29 -0700
Received: from [172.30.17.123]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iGNG1-0006NB-0E; Fri, 04 Oct 2019 06:04:29 -0700
Subject: Re: [PATCH] serial: uartps: Fix uartps_major handling
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Paul Thomas <pthomas8589@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
References: <00a269bc15c4f8c0a73c14958c5d7a5d37ff70ce.1568359707.git.michal.simek@xilinx.com>
 <20191004125203.GA583048@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <bcc281df-0fcc-f870-842b-213d1539dbca@xilinx.com>
Date:   Fri, 4 Oct 2019 15:04:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004125203.GA583048@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(76176011)(31696002)(356004)(336012)(229853002)(47776003)(2486003)(6246003)(6666004)(65956001)(31686004)(65806001)(2616005)(4326008)(81156014)(8676002)(81166006)(476003)(126002)(486006)(8936002)(23676004)(9786002)(110136005)(36386004)(11346002)(2906002)(4744005)(478600001)(426003)(50466002)(70586007)(5660300002)(36756003)(446003)(305945005)(70206006)(26005)(54906003)(58126008)(230700001)(316002)(106002)(186003)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5343;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3387fd84-9e05-481a-53a2-08d748cb6efc
X-MS-TrafficTypeDiagnostic: SN6PR02MB5343:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR02MB5343BB62668D75D173BC9164C69E0@SN6PR02MB5343.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 018093A9B5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W706tP76a99NMCkIkLmTFJL0CAhtuWRrFGMP0kPEwI5jpzaEo/oxj6J1zyHv2LfTkCeIXuJrKx9VrZTJ1R7jFca0/b37ZGAhwZubosRL6M7A1ZvMl30/UbkuR7KyMVc9ggLfmqvFwC9CC1LaogBvGoO76gj7DpLY1v118r76BR4g/rfLA2itzuzS21RxE15JYwdNUw21A5Nx6L7ZRMYhD6zZh2hDxe4xM+Rzqd8JCdAL6+Ei2PSexf9BAfTjcSka1ds2BMNTjojKJhGh0Em4rodK2iO1fD47YstLKo11zkOB7uhF/UnhoFQ/MlJyQsIf509+i28Xmzeo1fcucsD1BhiMCKtZUIJ7dbCjtWMDfEiQBChNRwTA4m8SiWQcs+irx3axl47htlEWmqR8q1ZK+vaVvM+YhI1fehpOR+M6IUA=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2019 13:04:47.2274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3387fd84-9e05-481a-53a2-08d748cb6efc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 10. 19 14:52, Greg Kroah-Hartman wrote:
> On Fri, Sep 13, 2019 at 09:28:29AM +0200, Michal Simek wrote:
>> There are two parts which should be fixed. The first one is to assigned
>> uartps_major at the end of probe() to avoid complicated logic when
>> something fails.
>> The second part is initialized uartps_major number to 0 when last device is
>> removed. This will ensure that on next probe driver will ask for new
>> dynamic major number.
>>
>> Fixes: c9712e333809 ("serial: uartps: Use the same dynamic major number for all ports")
> 
> This is not a valid sha1 in Linus's tree :(
> 
> Please fix up and resend.

grr. It is sha1 from stable tree. Will resend.

Thanks,
Michal


