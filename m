Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFEDC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6213222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iqwILVQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKHO1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:27:02 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:34754 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfKHO1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 09:27:02 -0500
Received: by mail-io1-f41.google.com with SMTP id q83so6567603iod.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 06:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U+gZ1iZyMycMyu4RO24BAjLSYNHz9sOObk4L5rAMf7c=;
        b=iqwILVQYZSgmH9OUII6SqeT4Drvw0j1zpDG2nt3rLVuYNmHI7uc2IUg7rI+JESGb7J
         VPdhKPgxjTYrje0kLVpESYLZeMPp32BZE9qQW3kRPV4A2Ov04mesqZ7YGidApVohuRQ/
         s1C0A+EmO3dMNP+YvKu0SHgwE9+YqcymXT1jRkDqwT8LaDVCEAmgQOau+ojwU/TOJyYv
         FbZ94VSTvKvxoN68eEF3O3bSY5UvDEhKkshv3g7CDh9e3NkSC6+y92JYNZfCRTv7UEh5
         OXRNey3HvzswzpyTOhU3rakgDLkDbiXKQQS/kgpE9zIr1d955aRiaB8CIeiks5cn7mXa
         +j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U+gZ1iZyMycMyu4RO24BAjLSYNHz9sOObk4L5rAMf7c=;
        b=CPASnPaQfPO7LRBJ1sdjpxHCb685r5y26z6IBRUKP1HbhgBCApnIrtFrWQuzdO8Rqp
         IwoTUdLipWb2jZxagvnOFSDoe7m70p62rSQpzfWEsA4zTZ1xrd2JXOMv79M0MypCgJBp
         zNHNJK9w1mYu2ytLKvYqkxwPQmHKTzY3S+QAJVYYRRu3k0DckO8VoWOh03S/xOdnnC4V
         9SO0EAIv3J52p51CF5zmxpRG8R7WjS2grw6q2EouR4VR4FrkEiXthz8eB/s3+GrLlWcD
         18Txn83QWNC6V2jY80Mh7Z9ULfwYp9bEiuh1p7SniSFEqAVBeeGJL6sztecd8zqqAPOO
         QwhQ==
X-Gm-Message-State: APjAAAU+j5gCTYhc6RKvOpZ3EEQhMhnCASh658fZ+q209oM0sQYeUG0i
        O2+9XWoEjVcNR1KBv43My0zwTQvpw08=
X-Google-Smtp-Source: APXvYqzwYZ+WipkYapK99X3KqatJkMZI+Jw2MzH942P7q0uMgKJc79YO5XDMV6HvnRPVP9zk3ee6lA==
X-Received: by 2002:a6b:f914:: with SMTP id j20mr11044257iog.223.1573223219271;
        Fri, 08 Nov 2019 06:26:59 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u9sm452653ior.46.2019.11.08.06.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 06:26:58 -0800 (PST)
Subject: Re: [PATCH][V2] ata: pata_artop: make arrays static const, makes
 object smaller
To:     Colin King <colin.king@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191006142956.23360-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5dae76cc-e71d-d295-7947-b7005a7f1af3@kernel.dk>
Date:   Fri, 8 Nov 2019 07:26:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191006142956.23360-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/19 8:29 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the const arrays on the stack but instead make them
> static. Makes the object code smaller by 292 bytes.
> 
> Before:
>     text	   data	    bss	    dec	    hex	filename
>     6988	   3132	    128	  10248	   2808	drivers/ata/pata_artop.o
> 
> After:
>     text	   data	    bss	    dec	    hex	filename
>     6536	   3292	    128	   9956	   26e4	drivers/ata/pata_artop.o
> 
> (gcc version 9.2.1, amd64)

Applied, thanks.

-- 
Jens Axboe

