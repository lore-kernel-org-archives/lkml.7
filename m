Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C209C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAA6206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TLNJgIMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfLQVP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:15:59 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42063 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfLQVP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:15:59 -0500
Received: by mail-io1-f65.google.com with SMTP id f82so12685645ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 13:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xbAkSu6f1FSOslLya3pTTccEqoCnU4AjqEM/vMBrMyE=;
        b=TLNJgIMJynuhiwVr1/XlYoykNt9D99M2LRmTmoeZKuT+fGTHSBOtQvEQGBrSY93YWe
         LENtrKEX67EIvXBHGclFKGlMv8momP86nTJXhudBEVQTN0TiWYbk2d61WmLcUkW3TrbJ
         uTDgcP0yPb3hDGhgWyCmOl1OCG4ZO3vfEnkDXjRkip3m11glDIrL18JiDBC65w2HV7rP
         cnkQCIdZqFAOJT4/9c4EWzmBKgpdOBAvfT4/PfxFFQzBL4tLba8VNikgBcbt+zx4RxK+
         1VYXvawDr+4td1qvdPZaaH1Az2jhug0IhWNu1s5g4hxnWB2/19ptSJEurfcm2NBTotVY
         /NEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xbAkSu6f1FSOslLya3pTTccEqoCnU4AjqEM/vMBrMyE=;
        b=WGpV9deUQTb/MQPQUZGBSNzXQFrY3btS0uS3/k01/TPsb8LsGOjFICXMj5PtGVYRJ+
         S1nfqdIW+8e3JE+/kPCT+RIOAP8VX2jhvLS/hCGxPyZmR0Dv+Qi4/xStw5y+3/5sJCJ/
         oJOuPrzb1EA72owddAAP5mg1KfX2bH0Ajd2wArKxULWxyS3gRAuDQGqVRdJmP4BRZlNb
         n9dhM1LSX4bypZ6yEfwlyO+gcMMxkx56GCTJKfSD08U8IMfA95FVIXMhQMEzSmyIbBwR
         34pz/EnNhNB7Xy6i67c2J+lAjDGjax+k0vNmQLed3u4K3DiheU22Q9oDmvW1Ob0MisW0
         aInQ==
X-Gm-Message-State: APjAAAXYc9jpwYDZ1Akm/Ko1nWjrVbotrEgSWRqLv5Tsc84Liq35FONQ
        1G7+rIp0yU90KvcrhSHUEb274o+BIg2lHA==
X-Google-Smtp-Source: APXvYqy0MlEoUx4H8cdLwfMVyi9Q6OhXqJUbWIVNTr7vmIKTkHeZfPGz32+NaXqhNDofDU6EhUxOHg==
X-Received: by 2002:a05:6602:101:: with SMTP id s1mr5431540iot.262.1576617358453;
        Tue, 17 Dec 2019 13:15:58 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o70sm1421442ilb.8.2019.12.17.13.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 13:15:58 -0800 (PST)
Subject: Re: [PATCH v2 0/3] io_uring: submission path cleanup
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1576538176.git.asml.silence@gmail.com>
 <cover.1576610536.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a81b3a8f-562c-02f4-522e-9c2dd51e33f8@kernel.dk>
Date:   Tue, 17 Dec 2019 14:15:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <cover.1576610536.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 12:26 PM, Pavel Begunkov wrote:
> Pretty straighforward cleanups. The last patch saves the exact behaviour,
> but do link enqueuing from a more suitable place.
> 
> v2: rebase
> 
> Pavel Begunkov (3):
>   io_uring: rename prev to head
>   io_uring: move trace_submit_sqe into submit_sqe
>   io_uring: move *queue_link_head() from common path
> 
>  fs/io_uring.c | 47 +++++++++++++++++++++--------------------------
>  1 file changed, 21 insertions(+), 26 deletions(-)

Applied, thanks.

-- 
Jens Axboe

