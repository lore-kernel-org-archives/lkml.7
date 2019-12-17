Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C14C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA59206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="V5YOZEqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfLQSPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:15:09 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37268 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLQSPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:15:08 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so10429035ioc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 10:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IYOnLbjfqVUNsL9yjx7UYabtfGTPEkQFBGBcs9P+PFo=;
        b=V5YOZEqc+LhElvEJ1CLgoSXyp3KFjFgplAFSkTwhxdmbyvyi2unBcPZnUHzXECY02j
         2xbAzAjlqS6i4GbgIl05Z/ZLoJ3wkST3LAFwkhbwsCAIjmGKPF9e6hXAGhsngf4sZFqJ
         yZHAvWptuceonSa7i+3DvsSy3QS/u7bdlbO/5mJQaWldTtES7rWjeJw65eXGWCH1ccaa
         +jcLrT3da6hhhd10pVXq/hLTQEOZ1pzXbPy+1KR07NUH0DltJfVFOlbjr696hMqTk452
         uvjXxI5loCArOFnVjOg3xYfDpKd1RJAmsduClO4HeSM1udj2lrt7xXbr5Dx9PbIJhhJI
         nN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IYOnLbjfqVUNsL9yjx7UYabtfGTPEkQFBGBcs9P+PFo=;
        b=m+dAmq74DZ5ZriqwwVI3ONtW+/il68ysU/JfUIoxUwFsu+2ktINi7BA6g1XcwSWVNm
         I/EZpRhds7pGfiWFnE+6Xox8HbsKDg4K1NsZfp5DoL2sPJXT2orOgCsARuL8Z+JtSFRg
         73yo+z6LAEGPGiagFp21UILFp7ju6wOL3I/QDPlNVZ1MTABI1ombeD4v72MsZuTqt2Rt
         HZrNbYjs3Jjn8F3G31iFZyQi9wvOQf+VWrOUguhX5clb9icQA+69KiVLG2kupA5UrKRO
         cX9p0nP7Q8SVC6valEmyoPUftxhge0CmFh5NoMWm/Oyp427a0qe8cGLNs7HDx+ctHKCm
         lshg==
X-Gm-Message-State: APjAAAV393XWm3aNIFQ+NfL1IT3dZEqpsmCl9VYoH5zuAaxiv6qZKp09
        d407Xg7pjxlhv34MDqyZSPoWRWj2GrIUsA==
X-Google-Smtp-Source: APXvYqzRdxUbXr5Cz+thENMP2uqMCy/0gAwaYW5gt5+I4SIh3kmHveNNlhjJOPQjxHwCYv3KDFofxA==
X-Received: by 2002:a6b:b606:: with SMTP id g6mr5066154iof.114.1576606507861;
        Tue, 17 Dec 2019 10:15:07 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n20sm5320406ioj.83.2019.12.17.10.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 10:15:07 -0800 (PST)
Subject: Re: [PATCH 0/3] io_uring: submission path cleanup
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1576538176.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <de7f6412-c031-1a0b-faa1-45e210ce5274@kernel.dk>
Date:   Tue, 17 Dec 2019 11:15:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <cover.1576538176.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/19 4:22 PM, Pavel Begunkov wrote:
> Pretty straighforward cleanups. The last patch saves the exact behaviour,
> but do link enqueuing from a more suitable place.
> 
> Pavel Begunkov (3):
>   io_uring: rename prev to head
>   io_uring: move trace_submit_sqe into submit_sqe
>   io_uring: move *queue_link_head() from common path
> 
>  fs/io_uring.c | 47 +++++++++++++++++++++--------------------------
>  1 file changed, 21 insertions(+), 26 deletions(-)

Can you respin this on top of the hardlink patch?

-- 
Jens Axboe

