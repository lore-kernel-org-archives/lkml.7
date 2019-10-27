Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5DBCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B79920679
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LJSZ+OLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfJ0Qt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:49:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33144 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfJ0QtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 12:49:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id c184so4982525pfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 09:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8n++wD5/6NxxNZrfUyrDCMF9nFv+oO8Is6pr+NQ2vc8=;
        b=LJSZ+OLDM/VdGmMyVSOBACyZfslq6n6qQUFyVshxSQSMrtou/6JvdNv3hpP8Pj7SIW
         B3DtOxdkJFnGgC+XWlkSOLvx6PXVCDAFAPVvWswXjE9DMC7s6kvDB/C4Vo3FLLmEHW2s
         48kRsKlP0IH45sqi8M5EfsCRLEtP9PC6kgCBQL7BhSw1HNY2I27icDvqjq235YnAWS3j
         5htcDA774lBUXBINA1j9hWxwLysgLeCyDpKjUCf9ppWcmk909CtrNIFZXHWxnT6SeiUJ
         IB12iesABZdNEDK7SZuVEB8Y6KLqN65om9lMt1lU374agzRJmg9j46Ru4bR7wIZl/X7V
         +Uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8n++wD5/6NxxNZrfUyrDCMF9nFv+oO8Is6pr+NQ2vc8=;
        b=X99hmWjm/jjI0VKBpewCP16vIXAJaAwHerlLzBOWw5jmWcfMSaI0tPK0JwbIgurVpH
         14x0sOFEzOnygfyX7m0Lcb1UK/lSDPfsOh+kc/nnDYiw63+NVcmL+oF9tQLZPp6R3JMI
         aOyW0au6mg/6nTQIb/iwK9Q8qplyLbvPYcGpNtTU2Arl6utTK4K36mB7lR194P8p31FW
         3OK29iVKD/G3v/SqpBjzcvufLi8kbeZfS2N/Cuubgz2v6MtfCaQYgHPW++elVky1xZ2F
         sTg69W5Q7RUf4RRM7yRgi82EYy02eo/vrchV/plIN1w7uPuiAqvB5etEmgH3VaLForfa
         Df6A==
X-Gm-Message-State: APjAAAUuWYKQzUSSyvZ2TBptva6+4BXcUD1qaVbVxyAZhdJLEzbcY3ul
        DLLGtUpSft/cWpl+Tx7oOAAB/4TXOWg5Yw==
X-Google-Smtp-Source: APXvYqwDOraOE5lBRWgCaRKUiO3QTcqmUcsqakQ6qe0tcratki5eAw5O61ceyWxh/YWg0gu4iIwUlQ==
X-Received: by 2002:a63:ab49:: with SMTP id k9mr13831866pgp.34.1572194964287;
        Sun, 27 Oct 2019 09:49:24 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 13sm9713407pgq.72.2019.10.27.09.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 09:49:23 -0700 (PDT)
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1572189860.git.asml.silence@gmail.com>
 <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
 <5ec9bd14-d8f2-32e6-7f25-0ca7256c408a@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aac65fe2-6c51-3baf-eee7-af5a8f633bf2@kernel.dk>
Date:   Sun, 27 Oct 2019 10:49:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5ec9bd14-d8f2-32e6-7f25-0ca7256c408a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/19 10:44 AM, Pavel Begunkov wrote:
> On 27/10/2019 19:32, Jens Axboe wrote:
>> On 10/27/19 9:35 AM, Pavel Begunkov wrote:
>>> A small cleanup of very similar but diverged io_submit_sqes() and
>>> io_ring_submit()
>>>
>>> Pavel Begunkov (2):
>>>     io_uring: handle mm_fault outside of submission
>>>     io_uring: merge io_submit_sqes and io_ring_submit
>>>
>>>    fs/io_uring.c | 116 ++++++++++++++------------------------------------
>>>    1 file changed, 33 insertions(+), 83 deletions(-)
>>
>> I like the cleanups here, but one thing that seems off is the
>> assumption that io_sq_thread() always needs to grab the mm. If
>> the sqes processed are just READ/WRITE_FIXED, then it never needs
>> to grab the mm.
>> Yeah, we removed it to fix bugs. Personally, I think it would be
> clearer to do lazy grabbing conditionally, rather than have two
> functions. And in this case it's easier to do after merging.
> 
> Do you prefer to return it back first?

Ah I see, no I don't care about that.


-- 
Jens Axboe

