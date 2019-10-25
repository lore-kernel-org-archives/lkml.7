Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36648CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6E92070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="L01rlG7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505115AbfJYQJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:09:46 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39870 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732660AbfJYQJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:09:46 -0400
Received: by mail-io1-f66.google.com with SMTP id y12so3030938ioa.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Dz0z7UVAhXaZ2nhvm3ocuonZIUSL4pst5GiKI/ZhGtE=;
        b=L01rlG7zsE0qvXGgPDCS0+sPo58JpVpzg8Bue+LfRnE7SLWrrvtmNxaMaktJbE9rlr
         P6dbojoa+RJR2Po0fG4VVLiZlM35lo17A2OXtzJW6e3FHZmgwLkz9j9GcCoMNX/aDPNQ
         uEkjsBDCzPzgPzcHROspcDP7JADhrcZU1L0lvb12Vzs0x9ElpDDjmEghW25qyqC3KERy
         wTUlQcaH0EvVdyQ/y58MYE36tKJkZDbdlzAHk6RgsgQvlORGtUCLfLUhDaO2VCy82Ivs
         zvn1YKdpzrBYSpqW7fIMRcQjDNaA0DvQd5JBoaGdVx5CinEz7atmXkx/XVAWqsWy6skz
         ZCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dz0z7UVAhXaZ2nhvm3ocuonZIUSL4pst5GiKI/ZhGtE=;
        b=jwOfncUvh98gMHac22BxigEPmhN+VAsY+KL3ijBHDhn8NLWpX0aPvW99Fz1+uHXqPF
         xDsY2IvtK3uIuRXGKm6oBf80YnPh71NiMWlHDrnjO6bUky5IC2hEljaGqm9aknATQ6pQ
         D+fu9jTqRPTMMNByfQdGsnxrxUj/jtNXTkXBXlNtpBBSZV0QYUrouawF2VJTCGCrcQSj
         x/XRM9t2aGM+QWZGJaAYgfr69+3PIGV0dm9GzKyJkaej9ax2kk3Si2r70vEJGh8eOL0s
         v/iof5BUae2ojOg6vOXitBaibga/cHV00IDt8PYqAU5jbqYjOcKbSjja9xUBppZdJ1El
         a0qA==
X-Gm-Message-State: APjAAAV1rI3qRKCKLSl3xFvu/hzNYOU3WwYQlllpx5iOgSuzuzj+ClDX
        xCoe/L7fTAIm84MvwzdiQ523N3dFu6Jj4w==
X-Google-Smtp-Source: APXvYqzOZUhzbeEKJ5g6jFEYeljYX/YeQgv5uN7hCHqgyJ91neZSYbfRbbMAA8q9lMX7dcoREkWlmA==
X-Received: by 2002:a02:704b:: with SMTP id f72mr4637699jac.125.1572019783542;
        Fri, 25 Oct 2019 09:09:43 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h82sm419959ild.1.2019.10.25.09.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 09:09:42 -0700 (PDT)
Subject: Re: [BUG] io_uring: defer logic based on shared data
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
 <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
Message-ID: <dfd21591-5187-0a8b-cc55-cfe5d57dd471@kernel.dk>
Date:   Fri, 25 Oct 2019 10:09:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/19 10:03 AM, Jens Axboe wrote:
> On 10/25/19 3:55 AM, Pavel Begunkov wrote:
>> I found 2 problems with __io_sequence_defer().
>>
>> 1. it uses @sq_dropped, but doesn't consider @cq_overflow
>> 2. @sq_dropped and @cq_overflow are write-shared with userspace, so
>> it can be maliciously changed.
>>
>> see sent liburing test (test/defer *_hung()), which left an unkillable
>> process for me
> 
> OK, how about the below. I'll split this in two, as it's really two
> separate fixes.

Patch 1:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=9a9a21d9cf65cb621cce4052a4527868a80009ad

and patch 2:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=ed348662f74c4f63537b3c188585e39cdea22713

Let me know what you think, and if/when I can add your reviewed/test-by
to them.

-- 
Jens Axboe

