Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439B9CA9EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17706205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="E15rO6N9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfJ0Q4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:56:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40089 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfJ0Q4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 12:56:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so4118391pll.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WMklfu5SAQV6R0CPDuoC7Wh6fDlyi/L1KoUw5s6wFWk=;
        b=E15rO6N9GSrjCyUNUBa+ms4uSI5E1+gtIw4EMgfQzpaTXKaEtXyWk4/WJxndmJUEjJ
         p9S3G3K4R7tyyBcvsxLwAeDJG3/JcqEBBSGfol1EP2t1vnv7BKOxZEPLyGRTcEnwmm3B
         C3lXvqSdk9QrqMx/TSXUWsdu5qPDs23Gb8ZDu2nzZxmDL5Y88TVe/le+ODBWdsSInrnD
         IWQpv0ehoZQC1KqzqlMQzjC590gxmtCaxt91BKTOkUeHzdxqEUOocfeWlaFZ9WKC9Bxn
         bkfrz8TIJVTa6KTxNXl7mBMIpNXeERU6F2rR0Ebc9tqzFH8pb/RFREABGOw74FZ8XQ+9
         cawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WMklfu5SAQV6R0CPDuoC7Wh6fDlyi/L1KoUw5s6wFWk=;
        b=rzY/TzVmDOszDp8th5MtRGePwyyHyRzHlremlCsw/U7VxZFgG15pnF6/1vvpMt4sru
         Ze0RO6iVq7GLLIwlQwjduWV+9lLZjjGqOeNmuTNsPNJaOHHa1Y48xZ6eS6+6zxgHoNgb
         OY4zo0KJtr3RUPH39RdC1CwVdHtoPoNkiVFB4eWVUqH6DE0IHzQ/1y2Bq4QyJMqiwVo8
         JukgpYTuiutEnrtkE7+uuQ32t2b78gir73z7sFxZ15C8Nv2Mm+C5i7N1tBrronF7ek2N
         51GD9J6HKlx9/PJ6JTbNErrT/HpQ2zWvN/YD8G7wOPfW8uHGz1JpYHxnGxlrHw6sJ8+T
         0a5w==
X-Gm-Message-State: APjAAAU4Mq9XhPWTIbt4ncVNTY0dTJhNb7kgCZUy1BztHfaMarwLFJsV
        /E8XtRXb9HFFE8EBUZxXcPH4EfBLiSw8iQ==
X-Google-Smtp-Source: APXvYqw50ovreOQnkJXW3WyEtOsvQE7TKxOXPEBJzCfr7N/2ysDMw8uqKhLejub+aSi/lWWbyHRB6w==
X-Received: by 2002:a17:902:122:: with SMTP id 31mr15001368plb.257.1572195409808;
        Sun, 27 Oct 2019 09:56:49 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id j11sm5085244pfa.127.2019.10.27.09.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 09:56:48 -0700 (PDT)
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1572189860.git.asml.silence@gmail.com>
 <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
 <5ec9bd14-d8f2-32e6-7f25-0ca7256c408a@gmail.com>
 <aac65fe2-6c51-3baf-eee7-af5a8f633bf2@kernel.dk>
Message-ID: <d39a878f-9dac-1457-6bba-01afc6268a84@kernel.dk>
Date:   Sun, 27 Oct 2019 10:56:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <aac65fe2-6c51-3baf-eee7-af5a8f633bf2@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/19 10:49 AM, Jens Axboe wrote:
> On 10/27/19 10:44 AM, Pavel Begunkov wrote:
>> On 27/10/2019 19:32, Jens Axboe wrote:
>>> On 10/27/19 9:35 AM, Pavel Begunkov wrote:
>>>> A small cleanup of very similar but diverged io_submit_sqes() and
>>>> io_ring_submit()
>>>>
>>>> Pavel Begunkov (2):
>>>>      io_uring: handle mm_fault outside of submission
>>>>      io_uring: merge io_submit_sqes and io_ring_submit
>>>>
>>>>     fs/io_uring.c | 116 ++++++++++++++------------------------------------
>>>>     1 file changed, 33 insertions(+), 83 deletions(-)
>>>
>>> I like the cleanups here, but one thing that seems off is the
>>> assumption that io_sq_thread() always needs to grab the mm. If
>>> the sqes processed are just READ/WRITE_FIXED, then it never needs
>>> to grab the mm.
>>> Yeah, we removed it to fix bugs. Personally, I think it would be
>> clearer to do lazy grabbing conditionally, rather than have two
>> functions. And in this case it's easier to do after merging.
>>
>> Do you prefer to return it back first?
> 
> Ah I see, no I don't care about that.

OK, looked at the post-patches state. It's still not correct. You are
grabbing the mm from io_sq_thread() unconditionally. We should not do
that, only if the sqes we need to submit need mm context.

-- 
Jens Axboe

