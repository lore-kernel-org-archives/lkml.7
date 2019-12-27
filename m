Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0649C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 20:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54D721582
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 20:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NrlQUp55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfL0Uou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 15:44:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34691 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfL0Uot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 15:44:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so14984354pgf.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 12:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K3t/ohIv/1G+WXqJcypJAaEvLAckbPW2YDllGhef+jg=;
        b=NrlQUp55qjuTWmG4zxNnwmGiH2cbRYVQAgaYI8viwPpkM5MD2dELR+DWGHj7w4qopD
         GxnJoKs89NmUZaRvdbJn/aQX9DMAizGCQ8g3C99/OMiwMWFLCnZq0zd6q1w9FZVA3xOF
         yCViPNnFTfXbnTAb5ucJE8DrUGeOFMgdbPW39KPBqKf02YYKoqkJ6D83F+ujHqBwNP69
         lwUFEXxXKXAbo55h5PPwMpvx4JyHEnb8EkeXz0DYT4dQFRfBKFRXaDCDCdvP6gSPyglM
         YmplgRBUnNvouwHmt3mpy41e7xJtnEG6+g+YAyOGglg4fG3B0GWIMefVB8yM493tYfS8
         sMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K3t/ohIv/1G+WXqJcypJAaEvLAckbPW2YDllGhef+jg=;
        b=rE1L9BOW2P4Mmzny2Py/guaa4KG7PHStpPtvQooukU+KHPlfFiBdu4nsDqo45CQf+3
         DVbXw8orQ9wZ0Wa09/m1xNoMbpQmJH/6GRZiBWnFzHTBzIgI1ERWQ/7F1FIW+tFY1irr
         DHHmdvoj41i3GrKEjRm4NM1UHc8sNjFSVJJUBmRcTdoQonCMHLmdpddlMb/GBRbyvQKU
         1r+ddWkiyTs6iQadoxrZ/CmkMMklCqNZ9i+uD+URC6GBxg5Hs/T9s6cFvuDi5pnJW6jf
         ANgt4LA+tsQ5bf4F1jVac1Jx+dpXecVyhOZwDrSppiOP5Ngkyz2EkiiTqQhbL3b2vi/y
         hLmA==
X-Gm-Message-State: APjAAAWGHDXIppmiHe5YcMpoJZQ4I4LBnaugMME64KA9PlcprQkFU2Mj
        ngtgG4w+X3ohW/+MFr5C6IjUXMqD4S4r3A==
X-Google-Smtp-Source: APXvYqxc7C7eewp3ErxbsMZ6Knsx+oorqN/G7EpqO42ipWXz2vQtGfB+8BkiA1RjIp9yu8Fyby/fyg==
X-Received: by 2002:a63:6946:: with SMTP id e67mr55167556pgc.181.1577479488986;
        Fri, 27 Dec 2019 12:44:48 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id r37sm15855702pjb.7.2019.12.27.12.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 12:44:48 -0800 (PST)
Subject: Re: linux-next: Fixes tags need some work in the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaedon Shin <jaedon.shin@gmail.com>
References: <20191228065553.6ba5d28f@canb.auug.org.au>
 <45665759-a76f-5631-51bd-488b04f6bf03@gmail.com>
 <d3ae7893-9b60-ecc2-4a31-65d009ecbb95@kernel.dk>
 <20191228073959.5b3e73b5@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3e6975e8-0509-c888-5b90-489ca0f40456@kernel.dk>
Date:   Fri, 27 Dec 2019 13:44:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191228073959.5b3e73b5@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/19 1:39 PM, Stephen Rothwell wrote:
> Hi Jens,
> 
> On Fri, 27 Dec 2019 13:29:40 -0700 Jens Axboe <axboe@kernel.dk> wrote:
>> On 12/27/19 1:27 PM, Florian Fainelli wrote:
>>> On 12/27/2019 11:55 AM, Stephen Rothwell wrote:  
>>>>
>>>> In commit
>>>>
>>>>   1a3d78cb6e20 ("ata: ahci_brcm: BCM7425 AHCI requires AHCI_HFLAG_DELAY_ENGINE")
>>>>
>>>> Fixes tags
>>>>
>>>>   Fixes: 9586114cf1e9 ("ata: ahci_brcmstb: add support MIPS-based platforms")
>>>>   Fixes: 423be77daabe ("ata: ahci_brcmstb: add quirk for broken ncq")
>>>>
>>>> have this problem:
>>>>
>>>>   - Target SHA1s do not exist
>>>>
>>>> Perhaps you meant
>>>>
>>>> Fixes: 1980eb9bd7d7 ("ata: ahci_brcmstb: add support for MIPS-based platforms")
>>>> Fixes: 7de3244530bf ("ata: ahci_brcmstb: disable NCQ for MIPS-based platforms")  
>>>
>>> Yes, those are the two that should have been used, the two commits were
>>> extracted from a downstream tree where the upstream commits ended up
>>> looking slightly different, my script does not (yet) rewrite those, Jens
>>> would you want me to resubmit or can you rewrite the commit message in
>>> place?  
>>
>> It's too late unfortunately, Linus already pulled it. So we'll have to
>> live with it, at least the commit titles are correct so it should be
>> manageable.
> 
> Unfortunately, even the titles are not correct, so they took me a
> little time to find the correct commits :-(  This means it will also
> take the stable maintainers a bit of time.

Yeah I see, the 2nd one is not. Gah, that really sucks. I'll let stable
know.

Florian, please ensure that future submissions have both the right titles
and shas.

-- 
Jens Axboe

