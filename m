Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FC4C04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC3B20854
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="oefuz6On"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfD3WZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:25:47 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43810 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfD3WZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:25:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id u15so13414871otq.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 15:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZmBG3hM4lGU6ZmXmSmggSOXpEizpcpagPEE7Vhmbuvs=;
        b=oefuz6OnRRxk8/mLQrXe07mu7tqQkeBedTZ2WiHugxjObG+KoJLqG9xkKKJgGuLx9A
         IjhB+nR8q5tGG1e1wd5ogRlqNAKvr9Nn59vrrHCM5YFM3X8OWThLAEKBsWXqgtdBFaPS
         9BAYNcoJ21xdnceaUmFwkit60XJJ3YioEEVPzoj9Rezrl8xQxH/h0Mz9YHFtQ3gsq3Ik
         K3g2NGXpRRGgHmEG7WCgvpAUfJXsrnmwbZKYCMYa3Hy32Qb8SK9oQSwxahwvbPfmNSMN
         H7cUOj+g9C/p+ikMDEA336PQDwJoX8USUwgrgjF6Zocmuee8a8CpqbXFAf8y3F9eA84v
         o9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZmBG3hM4lGU6ZmXmSmggSOXpEizpcpagPEE7Vhmbuvs=;
        b=uECFwg23yAxQ0Ikngf6FqxLd+1ta8h5Lao8vvP0HgIZpHxVyR6H3lP8tIfDFkYdtE3
         OoTe8ObJ/+OY4irJAY6zSPuwQ3dCsniffxvrqO+02VxXyzWqPhLOdgXjFiJN1u6qIR2k
         QVuGjVoEmbMKjcaM4cExB0EOqj+tVhBW2TOa7uz0Yx3E7Farjth0b1Zk4w7DcCp9xxjS
         0+beyiJ84lr/ifhj3+/QRl0yEyWqEf0FxXW519blsS3T4bN68/5jCjAf9d2xHtAnipsw
         iSXzlmbF5DQUSfqcvTuNI7fPCY6JugTomgKdgaZuwhLf05t6KIw0Q57c8oRgKXGL87K8
         qlCQ==
X-Gm-Message-State: APjAAAVEJGYKwLRMUIZH2kcRBi+y3o62oGnlzGNKMCcpvDDvM4Suae2v
        bwPbg2zSOPd8rT1HcQU54bVURg==
X-Google-Smtp-Source: APXvYqz1gCRDHfb1sDmOtyctdeSQ9SceBv6EjONrVNfjJC0L/rdUvcgkuDj3iKUf2l3hH9D78aWeQQ==
X-Received: by 2002:a9d:5d0b:: with SMTP id b11mr4169059oti.80.1556663146354;
        Tue, 30 Apr 2019 15:25:46 -0700 (PDT)
Received: from Fredericks-MacBook-Pro.local ([2600:1700:18a0:11d0:99ba:d92:93c8:8fb9])
        by smtp.gmail.com with ESMTPSA id h8sm15482635oti.64.2019.04.30.15.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 15:25:45 -0700 (PDT)
Subject: Re: [PATCH 1/4] PCI: Replace dev_*() printk wrappers with pci_*()
 printk wrappers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com
References: <20190427191304.32502-1-fred@fredlawl.com>
 <20190427191304.32502-2-fred@fredlawl.com>
 <20190429000258.GK14616@google.com> <20190429005222.GO14616@google.com>
From:   Frederick Lawler <fred@fredlawl.com>
Message-ID: <d68b1e74-dc52-28dc-0e14-de17594f39ca@fredlawl.com>
Date:   Tue, 30 Apr 2019 17:26:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 PostboxApp/6.1.14
MIME-Version: 1.0
In-Reply-To: <20190429005222.GO14616@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

Bjorn Helgaas wrote on 4/28/19 7:52 PM:
> On Sun, Apr 28, 2019 at 07:02:58PM -0500, Bjorn Helgaas wrote:
>> On Sat, Apr 27, 2019 at 02:13:01PM -0500, fred@fredlawl.com wrote:
>>> From: Frederick Lawler <fred@fredlawl.com>
>>>
>>> Replace remaining instances of dev_*() printk wrappers with pci_*()
>>> printk wrappers. No functional change intended.
>>>
>>> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
>>> ---
>>>   drivers/pci/pcie/aer.c        | 13 ++++++-------
>>>   drivers/pci/pcie/aer_inject.c |  4 ++--
>>>   drivers/pci/pcie/dpc.c        | 27 ++++++++++++---------------
>>>   3 files changed, 20 insertions(+), 24 deletions(-)
> 
>>>   	aer_enable_rootport(rpc);
>>> -	dev_info(device, "AER enabled with IRQ %d\n", dev->irq);
>>> +	pci_info(pdev, "AER enabled with IRQ %d\n", dev->irq);
>>
>> And this, and many others below.  *This* patch should only convert
>>
>>    - pci_printk(KERN_DEBUG, pdev, ...)
>>    + pci_info(pdev, ...)
>>
>> and
>>
>>    - dev_printk(KERN_DEBUG, pcie_dev, ...)
>>    + dev_info(pcie_dev, ...)
> 
> Just to clarify, I do *want* both changes, just in separate patches.
> So we'd have
> 
>    1) Convert KERN_DEBUG uses to pci_info() for pci_dev usage and to
>       dev_info() for pcie_device usage.  I think pciehp is probably an
>       exception to this; this patch shouldn't touch ctrl_dbg().
> 
>    2) Convert "dev_info(pcie_device)" to "pci_info(pci_dev)".  It might
>       be worth doing this in separate patches for each service.  If we
>       decide they're simple enough to combine, that's trivial for me to
>       do.  It's a little more hassle to split things up afterwards.
> 
>       In pciehp, if you do this in the ctrl_*() definitions, it will
>       make the patch much smaller.
> 
>    3) In pciehp, ctrl_dbg() could probably be changed to use pci_dbg()
>       so we'd use the standard kernel dynamic debug stuff instead of
>       having the pciehp-specific module parameter.
> 
> Thanks a lot for working on all this.  I think it will make the user
> experience significantly simpler.
> 
> Bjorn
> 

Will do, thanks!

Frederick Lawler

