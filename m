Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADBCC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EC0214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565017648;
	bh=9M4E65v8ZxtfmG6qLjTi0p0PEhQAU1mHK32ZAmHQCNY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Pbn03GrVc9alZ+BKq5JKjAjXRhTYZJUKH9tcw/AdIAyB14hzPy+9nhG0d9EEkXvW9
	 WVAf0/M0QpurtebeXP8qyy1pL3GVdLuG3qQd+MsMqcYNCAa0/A2VEBYkAmpZzfWgai
	 eqN0R69igeN38lRieHT+msPE/08qmVtMZRPFRyvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfHEPH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEPH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:07:26 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1108A214C6;
        Mon,  5 Aug 2019 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565017645;
        bh=9M4E65v8ZxtfmG6qLjTi0p0PEhQAU1mHK32ZAmHQCNY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fHKXsQmmVRNP+DwBO05m08ihZT8r8HqxgNyzTCBsK6BY7vrbY7mWpkwB6+0V9DEYy
         8qWoqjAbUz1hAbBGABurVSO3ITLLhekfSFjI+owm9s4O1F72qIYYRqsM+Le6eLHUcC
         RWb8yrMv36sSj7v3LWuC9IS9rEJxfGfi9+SjR3B0=
Subject: Re: [PATCH v3 2/2] usbip: Implement SG support to vhci-hcd and stub
 driver
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190802173651.22247-1-suwan.kim027@gmail.com>
 <20190802173651.22247-3-suwan.kim027@gmail.com>
 <43f32889-0117-cd94-2494-23ab29be6ca8@kernel.org>
 <20190805080451.GB8904@localhost.localdomain>
From:   shuah <shuah@kernel.org>
Message-ID: <9490fd7e-b5e7-21fb-4094-ab9c9e0e0aa5@kernel.org>
Date:   Mon, 5 Aug 2019 09:07:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805080451.GB8904@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/19 2:04 AM, Suwan Kim wrote:
> On Fri, Aug 02, 2019 at 04:41:52PM -0600, shuah wrote:
>> Hi Suwan,
>>
>> On 8/2/19 11:36 AM, Suwan Kim wrote:
>>> There are bugs on vhci with usb 3.0 storage device.
>>
>> This sentence doesn't make sense to me. What bugs? Ca you eloborate?
> 
> Alan's patch description "usb-storage: Set virt_boundary_mask to
> avoid SG overflows" elaborates the problem. In USB, each SG list
> entry buffer should be divisible by the bulk maxpacket size. But
> with native SG support, this problem doesn't matter because the
> SG buffer is treated as contiguous buffer. But without native SG
> support, storage driver breaks SG list into several URBs and each
> URB is sparate transfer.
> 
> Let's assume that driver request 31.5 KB data and has SG list which
> has 3584 bytes buffer followed by 7 4096 bytes buffer for some
> reason. USB Storage driver splits this SG list into several URBs
> because VHCI doesn't support SG and send them separately. So the
> first URB buffer size is 3584 bytes. When receiving data from device,
> USB 3.0 device sends data packet of 1024 bytes size because the max
> packet size of BULK pipe is 1024 bytes. So device sends 4096 bytes.
> But the first URB buffer has only 3584 bytes buffer size. So host
> controller terminates the transfer even though there is more data
> to receive.
> 
> Please also reference the mail thread
> https://marc.info/?t=155449209600003&r=1&w=2
> https://marc.info/?l=linux-usb&m=155482317722223&w=2
> 

I am asking you to elaborate and add it to the commit log instead of
just saying "There are bugs on vhci with usb 3.0 storage device."

thanks,
-- Shuah
