Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981ECC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639EF20650
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CqX5mg23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfJJKs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:48:26 -0400
Received: from mail-eopbgr680045.outbound.protection.outlook.com ([40.107.68.45]:9154
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfJJKsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:48:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dgo9EPlgyXRUJT71NULD7gORquSoMzkgo/0NSsFH5hAem3/IrB7dL1/vo9p2S21teME7Wwga+MOdSzU00wjwX5EzKtUyNZCuL/b55FPXndDO2ZI4WPKBehKFQk+yqJIiV50795Fzx5TpI5ajhrUJipsMTYFZ4bIPhJn+MpNWt8jHZo0p1G12S8BwoA3J+6U/qwS397zs18QBhvjD5630U3kk9WerDC1xGtBSFnzuJ8TUNB72eISWBQga7wmjMJYmgntlFNRcQXeFDzufXwkgQb1dkweMVckW7Q4WyzXjHNQI+oAyQpMiq+aXRiytU9+w4Rzgk5sIKXYOKUbxYl2vaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3LCIZDd4pB5DzLOKe1B7hoA/wL9h0O2zAQelrTkvyI=;
 b=YLQm5P0JUI834Vz+zA8wpmC7DG0jZzdHJCfOmC8x/EiavcJD9tF9l1b+51+mbA9/43Hzg+XKil59iiN+ef07GC83Lxs5GK/B03fNQTXur5jcfcDFmNGsI9dxbYLxCYQAXG+LFjra4aAdE+ArZm9764wSGuxNieCtpCM67a6Zk5exBG6TEbifZV4pyaD5LzbribERQx2J1gVoM5Xl5YeCGC3LLvznJrErEFPWoTan6nKaLaWCH9r6m9Z4D1vs3JoxRraSuK9Cyxeyw+aa6Uwc+Nyfq/FR8IdSzx5KvpdjTq9kNk+ONVAeqXZAp6ysRQ1y7S42h99jgVfSgctJ+dyVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3LCIZDd4pB5DzLOKe1B7hoA/wL9h0O2zAQelrTkvyI=;
 b=CqX5mg23oRmPdM7hzMLwsUaiqIb1B1QNCv8ZIhxCor/8S4NVkBS74YM9DehyKWZ9e1W7WCKzU02O+n/8neKBf28XXajxDt/eQR3ifAddzp3COfWnvHI3PA6gx2S8v7MoTU6HuzCzxrr175noyDNs/c4hRAoWlt2cRToffHO+KIY=
Received: from CH2PR02CA0024.namprd02.prod.outlook.com (2603:10b6:610:4e::34)
 by DM6PR02MB5178.namprd02.prod.outlook.com (2603:10b6:5:50::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.23; Thu, 10 Oct
 2019 10:47:43 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by CH2PR02CA0024.outlook.office365.com
 (2603:10b6:610:4e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18 via Frontend
 Transport; Thu, 10 Oct 2019 10:47:43 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Thu, 10 Oct 2019 10:47:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iIVyw-00055q-5a; Thu, 10 Oct 2019 03:47:42 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iIVyr-0001FR-1s; Thu, 10 Oct 2019 03:47:37 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9AAlZXM019650;
        Thu, 10 Oct 2019 03:47:35 -0700
Received: from [172.30.17.123]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iIVyo-0001F5-Vd; Thu, 10 Oct 2019 03:47:35 -0700
Subject: Re: [PATCH] microblaze: Include generic support for MSI irqdomains
To:     Christoph Hellwig <hch@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kuldeep Dave <kuldeep.dave@xilinx.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org
References: <aa6dd855474451ff4f2e82691d1f590f3a85ba68.1570530881.git.michal.simek@xilinx.com>
 <20191008154604.GA7903@infradead.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <c558db03-1199-275d-3e42-612c71cbf736@xilinx.com>
Date:   Thu, 10 Oct 2019 12:47:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191008154604.GA7903@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(81166006)(81156014)(186003)(230700001)(26005)(2906002)(6666004)(11346002)(9786002)(106002)(356004)(36386004)(70586007)(70206006)(446003)(4326008)(8936002)(336012)(305945005)(7416002)(36756003)(8676002)(426003)(31696002)(58126008)(54906003)(47776003)(44832011)(126002)(110136005)(65956001)(478600001)(31686004)(486006)(4744005)(2616005)(2486003)(6246003)(229853002)(76176011)(476003)(5660300002)(50466002)(316002)(65806001)(23676004)(41533002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5178;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a219ea7-dda4-42dd-fd98-08d74d6f473c
X-MS-TrafficTypeDiagnostic: DM6PR02MB5178:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR02MB51781417C2FD68E5F4C5B274C6940@DM6PR02MB5178.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 018632C080
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZYQgjgKB/J7kX3KvApRvEfRiwZ/HKuyXra+fBqRzMFM6V3l9KPpYilfDOlxt6IeVkVf67txiE2Gz9udA/fyh2gaxrhG0Ln/bzKkNvUxxzszXbKIV9IgiQ7nuq/xm0/t01Frl78Dz/HZDnpybk28zmi7xuYZ7/IVwrpiiNupjMW9Wq8chT+mbvxlqmE5IRtNvvJm9jIFjoSc5PQGHEGnt93/nlGzKUcaRKyKYI1Ul36YX3n05S7QffvVFZYb8cZqPpAHcK8fT5zDWK1Psh/uyRMWMQd0Fs1DKkY06WW+CprP4HDi28j6VlyX9p3+aBos91D+xBVKmeQlmM2f56ppJcAc67f0Y3J2YweL9II9Ug/VH0GXqO+8shWP4cziDqvdQ2ccDY1iKTi0NGqBX3Hy2gOPXcZ4Rw5vzwJVGCKPBng=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2019 10:47:42.6691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a219ea7-dda4-42dd-fd98-08d74d6f473c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 10. 19 17:46, Christoph Hellwig wrote:
> On Tue, Oct 08, 2019 at 12:34:47PM +0200, Michal Simek wrote:
>> index e5c9170a07fc..83417105c00a 100644
>> --- a/arch/microblaze/include/asm/Kbuild
>> +++ b/arch/microblaze/include/asm/Kbuild
>> @@ -25,6 +25,7 @@ generic-y += local64.h
>>  generic-y += mcs_spinlock.h
>>  generic-y += mm-arch-hooks.h
>>  generic-y += mmiowb.h
>> +generic-y += msi.h
> 
> Please just mark it as mandatory-y in the asm-generic makefile
> instead of requiring a sniplet for every architecture.
> 

But is it really mandatory for all architectures?

Thanks,
Michal
