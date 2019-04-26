Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0349FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C0120869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="pEN49oHx";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ICZAMWV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfDZTGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:06:24 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:58260 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726455AbfDZTGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:06:24 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QIwGu0021093;
        Fri, 26 Apr 2019 12:05:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=proofpoint;
 bh=9wJCgWkjsAsdMtrE+sa7u/JOuabCf4iJLIZIMWrcnAw=;
 b=pEN49oHxUUr1nOSXwyYv9su8EQnMvjzilBvGX+BJv1xudS7J567XB+/XW1Q0v/PQmgUx
 yEkTfYxF8MpinE/NCl05+TMgdlFmnI+Oa2lpQw9bAEwr71k/CAxyEIFG3MShvtOxCTQN
 CRjyJWjNHJMARowQJCq/nosIax7x0hFYHPg1K9AGguKsNrfcr0ch/uKJLNxKGSYB1aSL
 h+wDE2n1I1CiAoB5R7S8dt57ffGIeGLcsH9DvS6zuJYtJyOoifk5BeDVJv/S9XdNM1XR
 EIbuMn1KivNvHiE7ZZVcf/4OuQbrKpmCHIj+C/OtGSmhRYBRYZZaJDfkkAFA2qYdlqZ9 Cg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=huffman@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2059.outbound.protection.outlook.com [104.47.38.59])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2s3fdydstv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Apr 2019 12:05:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wJCgWkjsAsdMtrE+sa7u/JOuabCf4iJLIZIMWrcnAw=;
 b=ICZAMWV2x+nf5qptA5xI/iUV2e+pNlFkoRyYShM7ROYeAduh2AG3qR8tJ3HDdkjOx8n+rWub37D71Rzk2YDN1G1ILbYafYP7vwND7A2tmVnnCS6n5wAqjjCknczzK+CukR1vZ/KdTZL8HKQWFYGVYs09RHWr5LoCvL6zH/XOsHU=
Received: from BN8PR07CA0001.namprd07.prod.outlook.com (2603:10b6:408:ac::14)
 by SN1PR07MB2303.namprd07.prod.outlook.com (2a01:111:e400:7a45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.16; Fri, 26 Apr
 2019 19:05:38 +0000
Received: from CO1NAM05FT064.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::205) by BN8PR07CA0001.outlook.office365.com
 (2603:10b6:408:ac::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1835.12 via Frontend
 Transport; Fri, 26 Apr 2019 19:05:37 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT064.mail.protection.outlook.com (10.152.96.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.4 via Frontend Transport; Fri, 26 Apr 2019 19:05:29 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x3QJ5PgS004986
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 26 Apr 2019 12:05:25 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from [10.202.45.38] (158.140.32.37) by mailsj6.global.cadence.com
 (158.140.32.112) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Apr
 2019 12:05:23 -0700
Subject: Re: [tech-privileged] [PATCH] riscv: Support non-coherency memory
 model
To:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Gary Guo <gary@garyguo.net>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Andrew Waterman <andrew@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Xiang Xiaoyan <xiaoyan_xiang@c-sky.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Scott Wood <swood@redhat.com>,
        "tech-privileged@lists.riscv.org" <tech-privileged@lists.riscv.org>
References: <20190423001348.GA31639@guoren-Inspiron-7460>
 <20190423055548.GA12365@lst.de> <20190423154642.GA16001@guoren-Inspiron-7460>
 <d1988350-7da9-37bb-3d8b-93bedea0b732@garyguo.net>
 <20190424020803.GA27332@guoren-Inspiron-7460>
 <LO2P265MB0847C9F08481E25DABC77335D63C0@LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM>
 <20190424055703.GA3417@guoren-Inspiron-7460>
 <4e6b0816-3fe9-8c0b-a749-f7f6ef7e5742@garyguo.net>
 <20190424142306.GB20974@lst.de>
 <CAK8P3a36V93mKLuR-6hZzNX+j0HVpR_9bM41653PQuD+1xMTVw@mail.gmail.com>
 <20190426160558.GA10540@guoren-Inspiron-7460>
 <CAK8P3a2CvvBMZ8UkkgyrczgUccSGZ35RpG8V2dGUXbuOh9AZ5A@mail.gmail.com>
From:   Bill Huffman <huffman@cadence.com>
Message-ID: <84539a72-3fa7-2aad-330b-fb9b15b9cd61@cadence.com>
Date:   Fri, 26 Apr 2019 12:05:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2CvvBMZ8UkkgyrczgUccSGZ35RpG8V2dGUXbuOh9AZ5A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj7.global.cadence.com (158.140.32.114) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(189003)(199004)(36092001)(76176011)(2616005)(246002)(6116002)(50466002)(426003)(7416002)(11346002)(77096007)(186003)(126002)(65956001)(16526019)(66066001)(476003)(386003)(8936002)(956004)(6246003)(229853002)(478600001)(8676002)(65826007)(26005)(446003)(486006)(31686004)(356004)(65806001)(966005)(26826003)(6666004)(47776003)(230700001)(5660300002)(4326008)(36756003)(76130400001)(2906002)(54906003)(16576012)(58126008)(316002)(23676004)(3846002)(110136005)(53546011)(64126003)(31696002)(86362001)(67846002)(70586007)(93886005)(6306002)(2486003)(336012)(70206006)(7736002)(305945005)(7636002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2303;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae7a4f10-cd94-43ba-8e82-08d6ca7a2a78
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN1PR07MB2303;
X-MS-TrafficTypeDiagnostic: SN1PR07MB2303:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <SN1PR07MB2303B31D0477F9FBAA030B19A13E0@SN1PR07MB2303.namprd07.prod.outlook.com>
X-Forefront-PRVS: 001968DD50
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: OeVcORVmuc3J73heh+9xvIwYocUavXEXmZmukJHHF+cgdQwrpnbyu7UPLdsN43SVnd0CCSpsCd2c2re74mRk8R/eMZYJVFe5ggp2HVsiYeGLTSxzKUeoXAk/spZPHP/zjNXnUwT2pj521WR1/ib57eXT30nsM+N09nSzmM60swcEeiIIkx7+ffe8eZkLF+I6/H7Juw0Amqe1Y7tterorcHyYRvFIK5hl+MrsOxxp4i3UJVVtmYiY/TA3JR1LTXJhF2kcJ0ti7oDx2WtRGp1/fkPZyDQGRUZhzRcZBNKPcN8SZGd511W88EwFz0CTLM3kbO7ta87Ss/NW9I+fEW2tVVUsfGnkGb0TQwdmHBkvFC+Z6sK4K/+f9/VRBgSle+6jVbSixzAUNpNSNFlg6IKc6QLXwtI3MMQDPz1LgaBJMsc=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2019 19:05:29.7782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7a4f10-cd94-43ba-8e82-08d6ca7a2a78
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2303
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=913 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/19 11:42 AM, Arnd Bergmann wrote:
> EXTERNAL MAIL
> 
> 
> On Fri, Apr 26, 2019 at 6:06 PM Guo Ren <guoren@kernel.org> wrote:
>> On Thu, Apr 25, 2019 at 11:50:11AM +0200, Arnd Bergmann wrote:
>>> On Wed, Apr 24, 2019 at 4:23 PM Christoph Hellwig <hch@lst.de> wrote:
>>>
>>> You could probably get away with allowing uncached mappings only
>>> for huge pages, and using one or two of the bits the PMD for it.
>>> This should cover most use cases, since in practice coherent allocations
>>> tend to be either small and rare (device descriptors) or very big
>>> (frame buffer etc), and both cases can be handled with hugepages
>>> and gen_pool_alloc, possibly CMA added in since there will likely
>>> not be an IOMMU either on the systems that lack cache coherent DMA.
>>
>> Generally attributs in huge-tlb-entry and leaf-tlb-entry should be the
>> same. Only put _PAGE_CACHE and _PAGE_BUF bits in huge-tlb-entry sounds
>> a bit strange.
> 
> Well, the point is that we can't really change the meaning of the existing
> low bits, but because of the alignment contraints on hugepages, the extra bits
> are currently unused for hugepage TLBs.
> There are other architectures that reuse the bits in clever ways, e.g.
> allowing larger physical address ranges to be used with hugepages than
> normal pages.
> 
>> The gen_pool_alloc only 256KB by default, but a huge tlb entry is 4MB.
>> Hardware couldn't setup vitual-4MB to a phys-256KB range mapping in TLB.
> 
> I expect the size would be easily changed, as long as there is sufficient
> physical memory. If the entire system has 32MB or less, setting 2MB aside
> would have a fairly significant impact of course.
> 
> 
>>> - you need to decide what is supposed to happen when there are
>>>    multiple conflicting mappings for the same physical address.
>>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> What's the mulitple confilcing mappings ?
> 
> I mean when you have the linear mapping as cacheable and another
> mapping for the same physical page as uncacheable, and then access
> virtual address in both. This is usually a bad idea, but architectures
> go to different lengths to prevent it.
> 
> The safest way would be for the CPU to produce a checkstop as soon
> as there are TLB entries for the same physical address but different
> caching settings. You can also do that if you have a cache-bypassing
> load/store that hits a live cache line.

The second one is probably do-able in most systems.  But the first one 
usually isn't.  The TLB usually can't be looked up by physical address.

       Bill

> 
> The other extreme would be to not do anything special and try to come
> up with sane behavior, e.g. allow accesses in both ways but ensure that
> a cache-bypassing load/store always flushes and invalidates cache
> lines for the same physical address before its access.
> 
>         Arnd
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> 
> View/Reply Online (#395): https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.riscv.org_g_tech-2Dprivileged_message_395&d=DwIBaQ&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=AYJ4kbebphYpRw2lYDUDCk5w5Qa3-DR3bQnFjLVmM80&m=zf51zm7BmTNIb87ycEVTpGbwXV6ovRb4Rqy-BVXZ2F4&s=IWaqMk0fwM69syrjjmqzm5u3GeI_wWUYTJfBXCbxnWA&e=
> Mute This Topic: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.riscv.org_mt_31344322_1677293&d=DwIBaQ&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=AYJ4kbebphYpRw2lYDUDCk5w5Qa3-DR3bQnFjLVmM80&m=zf51zm7BmTNIb87ycEVTpGbwXV6ovRb4Rqy-BVXZ2F4&s=BwJEwbhCkTjHFPfiAQs7CBgG1U6kqM7yZbpSWXPTOoU&e=
> Group Owner: tech-privileged+owner@lists.riscv.org
> Unsubscribe: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.riscv.org_g_tech-2Dprivileged_unsub&d=DwIBaQ&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=AYJ4kbebphYpRw2lYDUDCk5w5Qa3-DR3bQnFjLVmM80&m=zf51zm7BmTNIb87ycEVTpGbwXV6ovRb4Rqy-BVXZ2F4&s=vSG91zravGfrVN9_elxveQPGPYaNew0MyETUvHfKSEk&e=  [huffman@cadence.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
