Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218E8CA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC9521852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BSDRVgdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439183AbfJRA4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:56:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34079 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfJRA4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:56:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id k7so1994167pll.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=piordRZ1nU8k7NcSWkmMDNrtoXqPkolhwk8bUAWjXiM=;
        b=BSDRVgdOVbMgXeh+wBCQNm2nwqNZsUaduoldjj3vYu1tLADexMs8j3VaxJVfmgst+e
         sV8wMsOtkRhLkKnMpzwoXhCs4cRQwA0rVUc93yBpJTk7lhcFKcs5ZBahgS8R6KZbVC7p
         FwvkiLECClqget1obmNExStAR5XqHOQBRifXbjGponSIy951t5Uvk7OrweyfXTKXyXiI
         M9+mK2kWd4yIIfDjvKfvEW17xjLqAfKsFvJ9h5UCSAVxnm8nojzgLizlC9k/UdBVzOy+
         Nj530dsX/dc0jfNbzSB7uO3pUPKbIuLbtmBV9q5JZzMAljIhLX/PRqrshhEhti42jpsH
         l/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=piordRZ1nU8k7NcSWkmMDNrtoXqPkolhwk8bUAWjXiM=;
        b=VU+V3r7uBDVlC/aBNamAt6iQqvwQWGwA0xoOZDX5W4/ZS5DQTnEVgsxdIUcj7mAjJB
         ZT9uenZNibqE8qOnlq4O2FMiC9+O4wQdQcX8BFhPtwdWZiQCgeouiLRJ17VSUJyHDPLo
         Q8J+sgR0twdf2yaB9lLivcLrsmImLoKCyaIVGt8vgsa18COsMgMna3ou5Eq12lLOK1Lp
         SJo9tX4eHaOud+cuPkxf5as5qngtCbi5kU/NznfKXhC7GaE89rA50LOTRwmK2SfiEg2T
         e4MDTEl6t/GmnYDuLbHVaCWvNMIRleMZWhzHHW72vyLvxh+8gKuvgCMSY/xNrtVBqIa9
         6OHA==
X-Gm-Message-State: APjAAAXWaa0mSZ2HiC7VdYe9R3btNGDqKgM7//kilZB1YSHFtH+JTXBn
        6zaF+QCzENcZl8v8xUY5yO6VAWEmiCjltA==
X-Google-Smtp-Source: APXvYqwn+1Qvz5kkzPB/24j6MgY8cwiKJazXYX9FwNrubcESYGgECbUV+NIUv1VED3o5/6kBL7zYEg==
X-Received: by 2002:a17:902:bcc2:: with SMTP id o2mr7087913pls.281.1571360202876;
        Thu, 17 Oct 2019 17:56:42 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id h14sm3884505pfo.15.2019.10.17.17.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 17:56:41 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191018115126.6263a3e3@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5a9bf632-2466-bc73-45d3-104c4bb0245a@kernel.dk>
Date:   Thu, 17 Oct 2019 18:56:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018115126.6263a3e3@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/19 6:51 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> fs/io_uring.c: In function 'io_accept':
> fs/io_uring.c:1729:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   1729 |  addr = (struct sockaddr __user *) READ_ONCE(sqe->addr);
>        |         ^
> fs/io_uring.c:1730:13: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   1730 |  addr_len = (int __user *) READ_ONCE(sqe->addr2);
>        |             ^
> 
> Introduced by commit
> 
>    d674c2b9335f ("io_uring: add support for IORING_OP_ACCEPT")
> 
> addr and addr2 are __u64 ...

I'll fix these warnings up, guessing it's 32-bit?

-- 
Jens Axboe

