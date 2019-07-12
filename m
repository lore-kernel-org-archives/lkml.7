Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77DFC742A6
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 02:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF9E21019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 02:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UvlCPM1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfGLCCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 22:02:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45600 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbfGLCCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 22:02:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so3570655pfq.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 19:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IytNEniq3sMnByAGgXf0cRvqrc82SOfcIoRvX/hkdvM=;
        b=UvlCPM1C+T6ixM31KUt6lyU57sA6wLZKv2eEgvTgo0gzUgc7tjxMbBZtXHVtmgS5oT
         2jey3NXwEXMUl145GeSxp/k6eJgXpS2PzALrxnXdvrE0Lio8AlAK7LAwLv5jR7zunOs3
         suL8YfxlBlg8T2YtynpSyPb8WFVPufg6aC1JDdl41/bCyDkjiI+dtmxKnILU/y7ZDSTc
         ImKs+3lG/m6rx7bpuIoGkKOt0/wucD7FeE6SbGhfmnHLxDZxVqn0ZrbqODVZh/yfhDJ0
         xkG8ybrk4fpcCps+J7fLbcbcWuo4cohF1/wpGQmWhDmrVstBNATAIE2qVUHczdTgI7Vd
         Grpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IytNEniq3sMnByAGgXf0cRvqrc82SOfcIoRvX/hkdvM=;
        b=phNUe9npz76bxOi7ik8EaDKoCD0JsmBla6rRfLNU/al4gnaLxAFGg9iY1CAjFr4Nw9
         +mwqNZjiJ+L4Ao5zrSJXxkMNwIlu40LJ40YXwAJFozK5IKbjmca0jPXT6jW2U9xAaDe1
         BnugRTgcqE38gHPM8Sm2hUsvxtq9P04VdCU0vhf7QDtV/tPLk2blRen0Sk5mN6RiUtUj
         foB0NYhdjSqjXfia2KifRVhyEzWKiqA/9u/+nv+jhUrJAaug8bC0k52ASWyHBjhEibrK
         lSvOUrS7Tvsw6OaF2BfWDFQAoZTzOMtRxHASkuGxxzqKhgPtjI7tKVihX6KY/8NE3b8E
         /vSw==
X-Gm-Message-State: APjAAAXiat+79yxEA6kHFz4ucE2jH7Ekhiufms1zG6VOZzY7zttjgN2q
        dyGQU4sS2qQNVgw5Ia035iNp1ACa9ak=
X-Google-Smtp-Source: APXvYqwFIeNRVSnQCRPaIfPzZ7zCi0J96LN0zfRue3sASUXmw83nN/z9MxwYKR57U91yUUjzVbgSpw==
X-Received: by 2002:a63:f118:: with SMTP id f24mr8000722pgi.322.1562896932792;
        Thu, 11 Jul 2019 19:02:12 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id k16sm6410180pfa.87.2019.07.11.19.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 19:02:11 -0700 (PDT)
Subject: Re: [PATCH v2] block/bio-integrity: fix a memory leak bug
To:     Wenwen Wang <wang6495@umn.edu>, Wenwen Wang <wenwen@cs.uga.edu>
Cc:     "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1562872923-2463-1-git-send-email-wang6495@umn.edu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <956286e2-06fc-4d43-e78e-8f2059292aab@kernel.dk>
Date:   Thu, 11 Jul 2019 20:02:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562872923-2463-1-git-send-email-wang6495@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/19 1:22 PM, Wenwen Wang wrote:
> From: Wenwen Wang <wenwen@cs.uga.edu>
> 
> In bio_integrity_prep(), a kernel buffer is allocated through kmalloc() to
> hold integrity metadata. Later on, the buffer will be attached to the bio
> structure through bio_integrity_add_page(), which returns the number of
> bytes of integrity metadata attached. Due to unexpected situations,
> bio_integrity_add_page() may return 0. As a result, bio_integrity_prep()
> needs to be terminated with 'false' returned to indicate this error.
> However, the allocated kernel buffer is not freed on this execution path,
> leading to a memory leak.
> 
> To fix this issue, free the allocated buffer before returning from
> bio_integrity_prep().

Applied, thanks.

-- 
Jens Axboe

