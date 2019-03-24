Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60644C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1CD20870
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zvz4k86a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfCXRKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:10:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40724 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbfCXRKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:10:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so4718066pfc.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 10:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zxh3xmEkbPdmArWEujPWMEU70B2WqHPJu68wJwp9cLg=;
        b=zvz4k86aaf1dmk8ATnzMmMJXORfkdAN8CciBAKwg0lNi/3d7OFUB6WBo9ISHb4sUy/
         o+YF+G4jQPxUAEMnPvQ5MQyhMa7FhzpVlxKnAClIot5hLbZ6WfDzu2WteBPcV53twv47
         ZlXiwkYNl6GOiQy7cvoshgW5WUNZ8FXx8G+a4p2EgnkfpC79OQdUh+lOhHvvcNDI+mjT
         COJz6eY8/1+gahkLgLlLHfhEbZl4csRRXFz+VJu3I3xtiqCBhgUFS64DywLWFZkFjkZs
         EG0lEge8Pi51XBYat3WPlvAQGLHxMM85KtwgI2MFf/Ulq2B5bDGYINNom5O/A7plvSOu
         sd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zxh3xmEkbPdmArWEujPWMEU70B2WqHPJu68wJwp9cLg=;
        b=IwAJUQ4kaLMj2wyzSAS6XooFHzKoN+4rl1dEDlZR5ziXUxfb8MWtL7jRoNMEgSqISF
         HcRBXBzkZrey2OWU3Hlfheca+vrQq7tI0aLQEd7ZTuro08gbiM6mFc400yo3+ameN2RP
         bv2DDOtjN96ZTjSJMXLEeM87bzT1LCCRgq1Jl0A2MUXPU2BSwwSeCqRBHKrK7g3j0ghI
         SPVctFwEG0CoV5jlUE6+HZWlulFUHR2b/RsApF5VTzYYRFWe9c8Y7O9bonpD+5nBhs0M
         yueP99zJRdhysYVtF8yrJLj6ICseByoEvyeJlqrosCoJeJVGupKYBdZXz2n/fhvNxGDt
         Leuw==
X-Gm-Message-State: APjAAAUjqLOkqRgBk8KSgR2xJIqukZIPRcG1cTWB6Wzo7wIZCgGFlQLw
        l/o+X/pTsWvqx8wUcO85RlZ/NSIWMxdhHMz6
X-Google-Smtp-Source: APXvYqxNFTgABlCbBPdjlL2UBQzISCIRiEJfIkmHi8sZoGz4Xr/bWWmfa8LKiFr1HyozH8v3Rnz2KQ==
X-Received: by 2002:a65:510c:: with SMTP id f12mr19683081pgq.40.1553447404685;
        Sun, 24 Mar 2019 10:10:04 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id w68sm20526193pfb.176.2019.03.24.10.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 10:10:03 -0700 (PDT)
Subject: Re: [PATCH] ata: dwc_460ex: Avoid potential NULL pointer dereference
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190304230858.13387-1-pakki001@umn.edu>
 <66403341-fa27-4b80-ab6b-2413b6b6fb98@kernel.dk>
 <17a6d83b-c57e-b709-7443-302b84692a6d@umn.edu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <438179a3-6fd2-c277-7b00-5f1a12d8df72@kernel.dk>
Date:   Sun, 24 Mar 2019 11:10:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <17a6d83b-c57e-b709-7443-302b84692a6d@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/19 10:47 AM, Aditya Pakki wrote:
> On 3/24/19 11:28 AM, Jens Axboe wrote:
>> On 3/4/19 4:08 PM, Aditya Pakki wrote:
>>> dma_async_tx_descriptor can contain a NULL variable and using
>>> it in dmaengine_submit without checking can crash the process.
>>> This patch avoids such a scenario.
>>>
>>> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>>> ---
>>>  drivers/ata/sata_dwc_460ex.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
>>> index 6f142aa54f5f..44a0d7a1ef54 100644
>>> --- a/drivers/ata/sata_dwc_460ex.c
>>> +++ b/drivers/ata/sata_dwc_460ex.c
>>> @@ -1052,8 +1052,10 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
>>>  					SATA_DWC_DMACR_RXCHEN);
>>>  
>>>  		/* Enable AHB DMA transfer on the specified channel */
>>> -		dmaengine_submit(desc);
>>> -		dma_async_issue_pending(hsdevp->chan);
>>> +		if (desc) {
>>> +			dmaengine_submit(desc);
>>> +			dma_async_issue_pending(hsdevp->chan);
>>> +		}
>>>  	}
>>>  }
>>
>> Hmm, if desc == NULL, is that an error condition?
>>
> Jens,
> In dmaengine_submit, the desc variable is dereferenced without a check for NULL.

Yes, that's not my point. My point is if desc is NULL, and you just work around it
by not issuing the DMA, are you just going to hang the drive/box? Should you be
erroring the IO at that point instead?

-- 
Jens Axboe

