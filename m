Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4075C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE7520652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfD3Gls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 02:41:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbfD3Gls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 02:41:48 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 63D569E02EAB98E9051E;
        Tue, 30 Apr 2019 14:41:46 +0800 (CST)
Received: from [127.0.0.1] (10.67.78.74) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Apr 2019
 14:41:43 +0800
Subject: Re: [RFC] Question about reset order for xhci controller and pci
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.1904291002290.1632-100000@iolanthe.rowland.org>
From:   "Tangnianyao (ICT)" <tangnianyao@huawei.com>
Message-ID: <b4176223-e44f-5454-0a02-b75a65384fa6@huawei.com>
Date:   Tue, 30 Apr 2019 14:41:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1904291002290.1632-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.78.74]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/29 22:06, Alan Stern wrote:

Hi, Alan

> On Mon, 29 Apr 2019, Tangnianyao (ICT) wrote:
> 
>> Using command "echo 1 > /sys/bus/pci/devices/0000:7a:02.0/reset"
>> on centos7.5 system to reset xhci.
>>
>> On 2019/4/26 11:07, Tangnianyao (ICT) wrote:
>>> Hi,all
>>>
>>> I've meet a problem about reset xhci and it may be caused by the
>>> reset order of pci and xhci.
>>> Using xhci-pci, when users send reset command in os(centos or red-hat os),
>>> it would first reset PCI device by pci_reset_function. During this
>>> process, it would disable BME(Bus Master Enable) and set BME=0, and
>>> then enable it and set BME=1.
>>> And then it comes to xhci reset process. First, it would send an
>>> endpoint stop command in xhci_urb_dequeue. However, this stop ep command
>>> fails to finish. The reason is that BME is set to 0 in former process and
>>> xhci RUN/STOP changes to 0, and when BME is set to 1 again, RUN/STOP doesn't
>>> recover to 1.
>>> I've checked BME behavior in xhci spec, it shows that "If the BME bit is set to 0
>>> when xHC is running, the xHC may treat this as a Host Controller Error, asserting
>>> HCE(1) and immediately halt(R/S=0 and HCH=1). Recovery from this state will
>>> require an HCRST." It seems that the stop ep command failure is reasonable.
>>> Maybe I've missed something and please let me know.
> 
> Your email subject says "Question about...".  What is the question?
> 
Sorry I didn't descibe it clearly.
When sending a reset command, now the reset order is first BME and then xhci.
BME reset would make xhci controller stop, resulting in xhci reset failure,
because it can't finish stop ep command in xhci_urb_dequeue.
I'm not sure if this situation is in expectation.

> Also, given that your question concerns what happens when you write to
> /sys/bus/pci/..., perhaps you should consider mailing it to some PCI
> maintainers as well as to the USB maintainers.
> ok, I will mailing it to PCI maintainer as well.

> Perhaps the reset was not meant to be used the way you are doing it.  
> A more conservative approach would be to unbind xhci-hcd from the 
> device before doing the reset and then rebind it afterward.
> 
> Alan Stern
>
>
> .
>

I think this approach not work. When reset BME, xhci controller is stopped and
can't recover even BME is set enable later. According to xhci spec, it's appropriate.
When rebind it afterward, with xhci stop, xhci driver would consider the
xhci controller already died and it fails to work again.

To recover xhci, now I rmmod xhci-pci.ko and then insmod it again.

Thanks,
Tang


