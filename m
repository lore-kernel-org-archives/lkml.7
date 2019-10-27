Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E287CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53479205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AAwmCSHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfJ0QcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:32:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45873 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfJ0QcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 12:32:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id y24so4086983plr.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bs2SjWSFOmSDRO8IdoMZpHMPqP3d7IxK89dWrHU3ttI=;
        b=AAwmCSHMTfWdNBSGiXVez7q/KUsaYY0UtStbu0Ih3kRlSzUx3A82a3dQVTQrC6OfAb
         sfCW6bJ/dHLuQKn0xHRAA2B6hj/4AriwEOEoREaPAhWEnjVCVe67CvRnegD6cDtyWHcg
         1e3LpOLksdH7k6S2gB/+Gb8jlIs/Wx3I6P6Xpe4fAGWVTPn2ytunNhjFfbdCep6ExGn3
         SlGfhz0uxIKfKSg0ybi5jimVDjloVh8xURZJYNEFtcOGs+H7b6/GchTbUVvp4LSjLhwl
         NrnTJRL0i4m1N8inhGK5LV8lsB0A9H2OFiQ2M4OOX/RjgDuZFNa5WuGkOSY38b7ctbZD
         KdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bs2SjWSFOmSDRO8IdoMZpHMPqP3d7IxK89dWrHU3ttI=;
        b=LNE5VYLqYN5A68FP4N5dr5s/CeJZKvUZIEsnEoV328NVy8hiMfWlNnHfnu+eqqaffy
         LPY27IPoBlxs1kcQY8xYXQ4/WcTegEA1WsbIf6+E+cxt6khWEzTfHRyZWnE3LyE6JU51
         zF9ajQj5+Nf8ND65QEk09Hg5Pq8S3uH5vlo2OuE1K9aT32edMSeT0HTYwXzDyWhjAaqZ
         4AXl7nJXXgSKJtXZcWjIrP6/ApjnVKK9+KWi0eG75lrYSR7FlIMkP8s4PsGFBGziEscC
         JLoe/30eSK09N7bM6fgdaeOC1yQpFXnfvjGy1NEm15aWXhjv0znOYSX3EaQQgCXTYm76
         xaxw==
X-Gm-Message-State: APjAAAXJfBf4oIK230TLk+mEW2yQtZBE64AQ7Rflo9cKzBKTAdEEqhRr
        O0/lL/7ber8FiJdnA27z1PPNBL2lsMsl7Q==
X-Google-Smtp-Source: APXvYqwhO/0jkTJpR1pX3HlXBFwvjVVpk5az/keU1AHeINk3poeCtcxalOsc/QyR37yBfHb8kU7T/A==
X-Received: by 2002:a17:902:142:: with SMTP id 60mr15186161plb.38.1572193927324;
        Sun, 27 Oct 2019 09:32:07 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id v2sm7620245pjr.14.2019.10.27.09.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 09:32:06 -0700 (PDT)
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1572189860.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
Date:   Sun, 27 Oct 2019 10:32:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1572189860.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/19 9:35 AM, Pavel Begunkov wrote:
> A small cleanup of very similar but diverged io_submit_sqes() and
> io_ring_submit()
> 
> Pavel Begunkov (2):
>    io_uring: handle mm_fault outside of submission
>    io_uring: merge io_submit_sqes and io_ring_submit
> 
>   fs/io_uring.c | 116 ++++++++++++++------------------------------------
>   1 file changed, 33 insertions(+), 83 deletions(-)

I like the cleanups here, but one thing that seems off is the
assumption that io_sq_thread() always needs to grab the mm. If
the sqes processed are just READ/WRITE_FIXED, then it never needs
to grab the mm.

-- 
Jens Axboe

