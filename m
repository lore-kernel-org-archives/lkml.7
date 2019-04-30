Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08CAC04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE67320854
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="nFOLQnmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfD3WYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:24:35 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35640 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfD3WYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:24:35 -0400
Received: by mail-oi1-f196.google.com with SMTP id w197so12637454oia.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 15:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uZ1PM87ohnji9r872rj74D6Fq0/brGlUbTKwwr5a4q4=;
        b=nFOLQnmPRb0/JY/yvlCkC3oJJBGeUK8FlyZN3L1GY5xyfkwe9bli7sUi3VEPO0lwe2
         mUvOrBq5ZhzEytWPtts8NVsji1tKsp9ntb1GB2V94eNJFLbmJcM2nzBUFMoXykIJqvXm
         DNLV4wmm4WP9NaQX8R5aHTil2Wmo7jbh9D0/eg3OcAm7oQGfPcVHnuMKVPV7ZyAz0Qe0
         /aWIjUnObS1IiTkkwNenowUmzwYGwnYi+Y05WmQG+MPEfQvE20qs1AWTaAiUdHOk2m9a
         LRg0JdbAzKMXlJs9AkugORRXVQi03QBKd3aKOrm2Jo9GSe2PeFnNh6aEAHgbJ11WeQwe
         nTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uZ1PM87ohnji9r872rj74D6Fq0/brGlUbTKwwr5a4q4=;
        b=Zj9j+MxRrNGz4cI2kKGRpgMgx1Gn22N62EYRsuPuuNjaQ0A/TDRr8CGsuCZzLXtN6s
         yXLZO2S2gWoYc/LLYVJsMR+ZPaLVLm8shi1ksL0qAkB0tNfWj7uS2xkQE1lnhZki++di
         uThjzjKkVpinEOn7TE5ij6/r7ddo2JQE8CYRMW8YXW3rzoCZhasVVLCf/4dq0JvCYiQI
         6g45KqWk4xp5jssIjfPKrLOYT0/JC7AwfgkWYuDWgFe1h+EnnLrEYoFJTYYrDJruENK9
         VJ593pY85zUmqSaG6JoBZE5t0bCxf9az56ss+SyG0U06R44mMWJYxfwTBi7AWRAHjxdq
         Hk2g==
X-Gm-Message-State: APjAAAXz2q5atj1f1Ad/BIjmV1MJINiwmnFX/MkXkU5Rtm5TReS+MSW5
        SB9QFRCfEfVE+npiahO63rX7jg==
X-Google-Smtp-Source: APXvYqyz6UUC1VeOH+MU0VesR8d3jpajolEW8TlyLuBJR+0sciV/7J3SsuS7ITWRFimevejVWQBOVg==
X-Received: by 2002:aca:c696:: with SMTP id w144mr1836254oif.126.1556663074332;
        Tue, 30 Apr 2019 15:24:34 -0700 (PDT)
Received: from Fredericks-MacBook-Pro.local ([2600:1700:18a0:11d0:99ba:d92:93c8:8fb9])
        by smtp.gmail.com with ESMTPSA id k65sm16084979oia.16.2019.04.30.15.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 15:24:33 -0700 (PDT)
Subject: Re: [PATCH 1/4] PCI: Replace dev_*() printk wrappers with pci_*()
 printk wrappers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        lukas@wunner.de, keith.busch@intel.com, mr.nuke.me@gmail.com,
        liudongdong3@huawei.com, thesven73@gmail.com
References: <20190427191304.32502-1-fred@fredlawl.com>
 <20190427191304.32502-2-fred@fredlawl.com>
 <20190428154339.GT9224@smile.fi.intel.com>
From:   Frederick Lawler <fred@fredlawl.com>
Message-ID: <a15490fb-3afc-868a-117e-351cd9726bf2@fredlawl.com>
Date:   Tue, 30 Apr 2019 17:25:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 PostboxApp/6.1.14
MIME-Version: 1.0
In-Reply-To: <20190428154339.GT9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

Andy Shevchenko wrote on 4/28/19 10:43 AM:
> On Sat, Apr 27, 2019 at 02:13:01PM -0500, fred@fredlawl.com wrote:
>> From: Frederick Lawler <fred@fredlawl.com>
>>
>> Replace remaining instances of dev_*() printk wrappers with pci_*()
>> printk wrappers. No functional change intended.
> 
>> -		pci_printk(KERN_DEBUG, parent, "can't find device of ID%04x\n",
>> -			   e_info->id);
>> +		pci_dbg(parent, "can't find device of ID%04x\n", e_info->id);
> 
> These are not equivalent.
> 
>> -		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
>> +		pci_dbg(pdev, "alloc AER rpc failed\n");
> 
> Ditto.
> 
>> -		dev_printk(KERN_DEBUG, device, "request AER IRQ %d failed\n",
>> -			   dev->irq);
>> +		pci_dbg(pdev, "request AER IRQ %d failed\n", dev->irq);
> 
> Ditto.
> 
> And so on.
> 

Thanks for the review. Clearly this was an oversight on my part and I'll 
have that corrected. Thanks!


Frederick Lawler

