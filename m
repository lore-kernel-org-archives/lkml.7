Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BD7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AA72147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfCLSq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:46:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726360AbfCLSq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:46:27 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CIjTxf142390
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 14:46:25 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r6ffjjynp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 14:46:25 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Tue, 12 Mar 2019 18:46:24 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Mar 2019 18:46:20 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2CIkJwd11993294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 18:46:19 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28612124058;
        Tue, 12 Mar 2019 18:46:19 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D358124054;
        Tue, 12 Mar 2019 18:46:18 +0000 (GMT)
Received: from [9.41.179.222] (unknown [9.41.179.222])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Mar 2019 18:46:18 +0000 (GMT)
Subject: Re: [PATCH 2/6] drivers/misc: Add Aspeed XDMA engine driver
To:     Arnd Bergmann <arnd@arndb.de>, Eddie James <eajames@linux.ibm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>, linux-aspeed@lists.ozlabs.org,
        Andrew Jeffery <andrew@aj.id.au>,
        gregkh <gregkh@linuxfoundation.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
References: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
 <1551735420-16202-3-git-send-email-eajames@linux.ibm.com>
 <CAK8P3a0eS11_T9wk4iLRT7A94Lh9gSf5QNGH4--pdA5HdEGMCw@mail.gmail.com>
 <84551e54-0382-6042-48cb-842d79214a98@linux.ibm.com>
 <CAK8P3a2kcaVGXifqrBLt9PfD1n2M6WCBxDDcaF8d7EdYxGRvVg@mail.gmail.com>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Tue, 12 Mar 2019 13:46:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2kcaVGXifqrBLt9PfD1n2M6WCBxDDcaF8d7EdYxGRvVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19031218-2213-0000-0000-0000036251B1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010746; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01173405; UDB=6.00613501; IPR=6.00954064;
 MB=3.00025950; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-12 18:46:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031218-2214-0000-0000-00005DA5901C
Message-Id: <2bc14947-1656-0819-c7a4-98548e50e945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903120127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/6/19 4:48 AM, Arnd Bergmann wrote:
> On Tue, Mar 5, 2019 at 10:45 PM Eddie James <eajames@linux.ibm.com> wrote:
>> On 3/5/19 2:01 AM, Arnd Bergmann wrote:
>>> On Mon, Mar 4, 2019 at 10:37 PM Eddie James <eajames@linux.ibm.com> wrote:
>>>> The XDMA engine embedded in the AST2500 SOC performs PCI DMA operations
>>>> between the SOC (acting as a BMC) and a host processor in a server.
>>>>
>>>> This commit adds a driver to control the XDMA engine and adds functions
>>>> to initialize the hardware and memory and start DMA operations.
>>>>
>>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>> Hi Eddie,
>>>
>>> Thanks for your submission! Overall this looks well-implemented, but
>>> I fear we already have too many ways of doing the same thing at
>>> the moment, and I would hope to avoid adding yet another user space
>>> interface for a specific hardware that does this.
>>>
>>> Your interface appears to be a fairly low-level variant, just doing
>>> single DMA transfers through ioctls, but configuring the PCIe
>>> endpoint over sysfs.
>> Hi, thanks for the quick response!
>>
>> There is actually no PCIe configuration done in this driver. The two
>> sysfs entries control the system control unit (SCU) on the AST2500
>> purely to enable and disable entire PCIe devices. It might be possible
>> to control those devices more finely with a PCI endpoint driver, but
>> there is no need to do so. The XDMA engine does that by itself to
>> perform DMA fairly automatically.
>>
>> If the sysfs entries are really troublesome, we can probably remove
>> those and find another way to control the SCU.
> I think the main advantage of tying this to a PCIe endpoint driver
> is that this would give us a logical object in the kernel that we
> can add the user space interface to, and have the protocol on
> top of it be portable between different SoCs.
>
>>> Please have a look at the drivers/pci/endpoint framework first
>>> and see if you can work on top of that interface instead.
>>> Even if it doesn't quite do what you need here, we may be
>>> able to extend it in a way that works for you, and lets others
>>> use the same user interface extensions in the future.
>>>
>>> It may also be necessary to split out the DMA engine portion
>>> into a regular drivers/dma/ back-end to make that fit in with
>>> the PCIe endpoint framework.
>> Right, I did look into the normal DMA framework. There were a couple of
>> problems. First and foremost, the "device" (really, host processor)
>> address that we use is 64 bit, but the AST2500 is of course 32 bit. So I
>> couldn't find a good way to get the address through the DMA API into the
>> driver. It's entirely possible I missed something there though.
> 32-bit ARM SoCs can be built with a 64-bit dma_addr_t. Would that
> help you here?

Yep, thanks, that's helpful.

>
>> The other issue was that the vast majority of the DMA framework was
>> unused, resulting in a large amount of boilerplate that did nothing
>> except satisfy the API... I thought simplicity would be better in this case.
> Simplicity is important indeed, but we have to weigh it against
> having a consistent interface. What the dmaengine driver would
> give us in combination with the PCIe endpoint driver is that it abstracts
> the hardware from the protocol on top, which could then be done
> in a way that is not specific to an AST2xxx chip.
>
>> Let me know what you think... I could certainly switch to ioctl instead
>> of the write() if that's better. Or if you really think the DMA
>> framework is required here, let me know.
> I don't think that replacing the ioctl() with a write() call specifically
> would make much of a difference here. The question I'd like to
> discuss further is what high-level user space interface you actually
> need in order to implement what kind of functionality. We can then
> look at whether this interface can be implemented on top of a
> PCIe endpoint and a dmaengine driver in a portable way. If all
> of those are true, then I'd definitely go with the modular approach
> of having two standard drivers for the PCIe endpoint (should be
> a trivial wrapper) and the dma engine (not trivial, but there are
> many examples), plus a generic front-end in
> drivers/pci/endpoint/functions/.

Hi Arnd,

Let me describe the top level interface we really need. The objective is 
just to transfer arbitrary data between the two memory spaces (memory on 
the AST2500 as the BMC, where the driver is running, and the memory on 
the host processor). The user on the BMC (in user space; I can't think 
of a use case for another driver needing to access this interface) has 
the host address, transfer size, and, if it's a write, the data. User 
needs to pass this into the driver and, if it's a read, retrieve the 
transferred data.

I did start trying to implement the dmaengine framework, and I think it 
could technically work. The addressing is no longer a problem, thanks to 
your tip. However, I realized there are some other issues.

The main problem is that the only memory that the XDMA engine hardware 
can access is the VGA reserved memory area on the AST2xxx. So I don't 
see how it can ever be a pure dmaengine driver; it would always need an 
additional interface or something to handle that memory area. If I 
completed the dmaengine framework, any and all users would be required 
to go through an additional step to get memory in the reserved area and 
copy in/out of there. The way the driver stands, this memory management 
is integrated, resulting in a fairly clean interface, though of course 
it is unique.

As for the PCIe endpoint part, I'm not sure it fits this driver. I could 
drop the sysfs entries and find another way to configure the SCU for 
now... this driver really doesn't have anything to do with PCIe, except 
for the fact that the XDMA hardware uses PCIe to do the actual work of 
the data transfer.

What do you think? One other thought I had was that the driver might be 
more suitable to go in drivers/soc/ as it is very specific to the 
AST2xxx. But, up to you.

Thanks,

Eddie

>
>       Arnd
>

