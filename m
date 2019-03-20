Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F3BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A772175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oSK1tnCQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NdS78cv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfCTPuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:50:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33582 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfCTPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:50:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1D1D4608BA; Wed, 20 Mar 2019 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553097033;
        bh=/62Emp41/7n5hL2ZaGhpjwhqfjK28miXuyHNGDPfAyU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oSK1tnCQhTKhPOyjmsnZS5hqvI11cuuCRRR+xsp7Aw88OrbmdCubMOOjeReI1N32b
         4pjmMtIzswh2Y6kZqQc3rHXr9n/5XOC1hhPT/sBzv4ZaEelsP7iRlm5rp4FHmt7c7E
         U5Lh6x9iJDSkTYQESLoJxksve3zh+jk2r08+aOPU=
Received: from [192.168.1.4] (unknown [122.175.119.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B7B36030B;
        Wed, 20 Mar 2019 15:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553097032;
        bh=/62Emp41/7n5hL2ZaGhpjwhqfjK28miXuyHNGDPfAyU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NdS78cv6gc087QxLXU9HZo7UkmloJLaXFODXr0db/gaRUNeM3hOg61V8ZvX3+Kh01
         0pLaD/IhOkruq05fjzNuNID20PEb9Fb5xIhktdmwO6lgwYduuQsO375nWvGD6Qx2LG
         73DbKXJfZ0VXHVv+mvCKIJrZFIwmrXIxmkiaUrXw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B7B36030B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH v2] nvmem: core: Set no-read-write provider to avoid
 userspace read/write
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org
References: <1552831940-7327-1-git-send-email-gkohli@codeaurora.org>
 <48a71861-c60b-7fe7-d4af-5269cd7c20eb@linaro.org>
From:   Gaurav Kohli <gkohli@codeaurora.org>
Message-ID: <5f11070f-bf9b-c313-9a78-e412a2fb2908@codeaurora.org>
Date:   Wed, 20 Mar 2019 21:20:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <48a71861-c60b-7fe7-d4af-5269cd7c20eb@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 8:04 PM, Srinivas Kandagatla wrote:
>
>
> On 17/03/2019 14:12, Gaurav Kohli wrote:
>> Current nvmem framework allows user space to read all register space
>> populated by nvmem binary file, In case we don't want to expose value
>> of registers to userspace and only want kernel space to read cell
>> value from nvmem_cell_read_u32.
>>
>> To protect the same, Add no-read-write property to prevent read
>> from userspace.
>>
>
> Can you explain the real need of this?
> Is there any issue you are noticing while reading nvmem content from 
> userspace?
>
Hi Srinivas,


No, We are not observing any issue, nvmem is dumping the data properly.

But there are certain register, which we don't want to expose to user 
space and want kernel space can only read via nvmem_cell_read.

In existing design, even if we read cell from kernel space, nvmem binary 
files is still populated to user space unconditionally.

Regards

Gaurav


> I don't think this is the right way to do this, its misleading in many 
> ways. Also this should not be a part of DT binding.
>
> If we decide that we need this feature, then better way to do this 
> using a new Kernel config.
>
> thanks,
> srini
-- Qualcomm India Private Limited, on behalf of Qualcomm Innovation 
Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation 
Collaborative Project.
