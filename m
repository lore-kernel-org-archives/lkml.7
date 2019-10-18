Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A33CA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F347C2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NyID+tj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439279AbfJRA7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:59:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34418 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439238AbfJRA7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:59:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so2754436pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jyoE4KVkMv5Wgl4RjrS4sWj56ltH5kNIoDRtIAtTAIQ=;
        b=NyID+tj/Aq4Ln2vNbwK6HI4ebzmtdQlfIjHFHZ1ct/uwHsOtHWBsYetkMuJJE+FyL5
         iRcCB2TaBBLeRiuG+PabIeXZI/+y8H7GkfaSiUCwLGwTcF3snG2JH7qQ85r94YVYzADF
         D/Ijj/oa7APSC/bKl6VkTi4TaZYtI9HGhz2BdPPJi0ezOnQPWmtRtfoRH8TpT1h3b8aB
         qlfDjrTuucGQOcYq3E4WBm+26OPSc0ikw9zf0Sxg+D+7eQgxFCb1vQxYcdaVmQkyxxqB
         vDuRlti2io7S1cz+z7fE3S/D0S9Vdb/wIdPlggxhpHN5ZXP4DSYc8Q0Fr6bbNREkuhTS
         FI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jyoE4KVkMv5Wgl4RjrS4sWj56ltH5kNIoDRtIAtTAIQ=;
        b=RjrgFS3H2v/eeSCzRRpqp5ZDuJFWcfV6/pa36GzfLb/JqvZR+qNT1RxSDA8V/3bcBE
         AdmaJVi+bFGiTeAdGNyXJD4ElAkje8ktOGL2Y3K08PdTRt/ZUupRRLK3Yz29n8XWX45i
         eHoEievlcprx5bbsQ5VqJ2JMvxWI3i6zFQaS7exb0sWcHgroLyBoM/XHRqn7QNVRAVF8
         /uywzBfoC1CvLWwkExpAcI1gmBwNqdx1gkdP/BVPDiNgiTvYOZCyvN5PsLUYd8m3GdnJ
         EGSrN0jfXQu/v2oWvqnIbVWCVeQnPy7S+huOGUe3EkFEKxJ5dKlDvL79VqbvLfmuW/Td
         3RCQ==
X-Gm-Message-State: APjAAAWlKqnQgugwpEy1eZyLBJT1rllq3Io4Scp5LCtBmwniocszJcQ8
        oXm+VTLVDnmYQL53mOaiwK2SPCsJbHtJjw==
X-Google-Smtp-Source: APXvYqzgkj4XfSgBfXBRzo5q3sDWxYZIHC5aZ8pyT6z46BQiLRcrNu3Td6IirlRlUf/aFY4DfidGLA==
X-Received: by 2002:a62:b616:: with SMTP id j22mr3257841pff.201.1571360378152;
        Thu, 17 Oct 2019 17:59:38 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id z13sm4719956pfq.121.2019.10.17.17.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 17:59:37 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the block tree
From:   Jens Axboe <axboe@kernel.dk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191018115126.6263a3e3@canb.auug.org.au>
 <5a9bf632-2466-bc73-45d3-104c4bb0245a@kernel.dk>
Message-ID: <4b23ff4f-9692-6bfb-c904-772b3c5e0907@kernel.dk>
Date:   Thu, 17 Oct 2019 18:59:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5a9bf632-2466-bc73-45d3-104c4bb0245a@kernel.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/19 6:56 PM, Jens Axboe wrote:
> On 10/17/19 6:51 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the block tree, today's linux-next build (arm
>> multi_v7_defconfig) produced this warning:
>>
>> fs/io_uring.c: In function 'io_accept':
>> fs/io_uring.c:1729:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>    1729 |  addr = (struct sockaddr __user *) READ_ONCE(sqe->addr);
>>         |         ^
>> fs/io_uring.c:1730:13: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>    1730 |  addr_len = (int __user *) READ_ONCE(sqe->addr2);
>>         |             ^
>>
>> Introduced by commit
>>
>>     d674c2b9335f ("io_uring: add support for IORING_OP_ACCEPT")
>>
>> addr and addr2 are __u64 ...
> 
> I'll fix these warnings up, guessing it's 32-bit?

Should be fixed up and pushed out now.

-- 
Jens Axboe

