Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60404C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5A42075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfCEVpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:45:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726347AbfCEVpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:45:19 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x25Lciug039144
        for <linux-kernel@vger.kernel.org>; Tue, 5 Mar 2019 16:45:18 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r1xwmf48j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 16:45:17 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Tue, 5 Mar 2019 21:45:17 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Mar 2019 21:45:14 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x25LjD7318219118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Mar 2019 21:45:13 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA12F28060;
        Tue,  5 Mar 2019 21:45:13 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34AE92805A;
        Tue,  5 Mar 2019 21:45:13 +0000 (GMT)
Received: from [9.80.227.125] (unknown [9.80.227.125])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  5 Mar 2019 21:45:13 +0000 (GMT)
Subject: Re: [PATCH 2/6] drivers/misc: Add Aspeed XDMA engine driver
To:     Arnd Bergmann <arnd@arndb.de>
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
From:   Eddie James <eajames@linux.ibm.com>
Date:   Tue, 5 Mar 2019 15:45:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0eS11_T9wk4iLRT7A94Lh9gSf5QNGH4--pdA5HdEGMCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19030521-0072-0000-0000-000004050CCA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010711; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01170134; UDB=6.00611523; IPR=6.00950768;
 MB=3.00025847; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-05 21:45:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030521-0073-0000-0000-00004B639F55
Message-Id: <84551e54-0382-6042-48cb-842d79214a98@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903050139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/5/19 2:01 AM, Arnd Bergmann wrote:
> On Mon, Mar 4, 2019 at 10:37 PM Eddie James <eajames@linux.ibm.com> wrote:
>> The XDMA engine embedded in the AST2500 SOC performs PCI DMA operations
>> between the SOC (acting as a BMC) and a host processor in a server.
>>
>> This commit adds a driver to control the XDMA engine and adds functions
>> to initialize the hardware and memory and start DMA operations.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Hi Eddie,
>
> Thanks for your submission! Overall this looks well-implemented, but
> I fear we already have too many ways of doing the same thing at
> the moment, and I would hope to avoid adding yet another user space
> interface for a specific hardware that does this.
>
> Your interface appears to be a fairly low-level variant, just doing
> single DMA transfers through ioctls, but configuring the PCIe
> endpoint over sysfs.

Hi, thanks for the quick response!

There is actually no PCIe configuration done in this driver. The two 
sysfs entries control the system control unit (SCU) on the AST2500 
purely to enable and disable entire PCIe devices. It might be possible 
to control those devices more finely with a PCI endpoint driver, but 
there is no need to do so. The XDMA engine does that by itself to 
perform DMA fairly automatically.

If the sysfs entries are really troublesome, we can probably remove 
those and find another way to control the SCU.

>
> Please have a look at the drivers/pci/endpoint framework first
> and see if you can work on top of that interface instead.
> Even if it doesn't quite do what you need here, we may be
> able to extend it in a way that works for you, and lets others
> use the same user interface extensions in the future.
>
> It may also be necessary to split out the DMA engine portion
> into a regular drivers/dma/ back-end to make that fit in with
> the PCIe endpoint framework.

Right, I did look into the normal DMA framework. There were a couple of 
problems. First and foremost, the "device" (really, host processor) 
address that we use is 64 bit, but the AST2500 is of course 32 bit. So I 
couldn't find a good way to get the address through the DMA API into the 
driver. It's entirely possible I missed something there though.

The other issue was that the vast majority of the DMA framework was 
unused, resulting in a large amount of boilerplate that did nothing 
except satisfy the API... I thought simplicity would be better in this case.

Let me know what you think... I could certainly switch to ioctl instead 
of the write() if that's better. Or if you really think the DMA 
framework is required here, let me know.

Thanks,

Eddie

>
> If you have already tried this without success, please let us
> know in the description what problems you have hit, and why you
> decided to create a new framework instead.
>
>> +/*
>> + * aspeed_xdma_op
>> + *
>> + * upstream: boolean indicating the direction of the DMA operation; upstream
>> + *           means a transfer from the BMC to the host
>> + *
>> + * host_addr: the DMA address on the host side, typically configured by PCI
>> + *            subsystem
>> + *
>> + * len: the size of the transfer in bytes; it should be a multiple of 16 bytes
>> + */
>> +struct aspeed_xdma_op {
>> +       __u8 upstream;
>> +       __u64 host_addr;
>> +       __u32 len;
>> +} __packed;
> Side-note: packed structures are generally not great user space
> interfaces. Regardless of where we end up with this, I'd recommend
> naturally aligning each member inside of the structure, and using
> explicit padding here.

Understood, thanks.

>
>
>       Arnd
>

