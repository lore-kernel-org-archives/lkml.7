Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246C9C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FC8216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="08g8m3Jg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfETTfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:35:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37286 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfETTfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:35:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id g3so7717357pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 12:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dFqj4tLCgiBQUtGZVHwWP+zJlKPONLLxZEsZ/GuSe/k=;
        b=08g8m3JgTcimfqsdI9OHNIExEdoeAPv+HFoBmPDfbRPb8+FpyWLNCSdwZ5kWpc3QYI
         a6Z4ZtaJ9WLtpZytk2dOjv8ts7ujSCmMuRHoyMhSPFoP/aY1K0BZQAPH3RDDgeDJXNGO
         kjvyf/1HSSGmWWH57ZHiqcBG+AnG6rhV8k8LJ7pDYmx9iWKQG0BXLCJJaxTl+VhZ6fsd
         571pY3YT8i72aXlsUN6+GMe/YL7ZzEflPWlk4eg4xz6olm/sH9zem7kV1hActcC33UzN
         t7LNmLZgJO0WRr2Ytaw/NPaTZdvMcmsM11lo3Kfl1pukU8v7uAA+8CJyi1F7wDekiK3q
         NcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dFqj4tLCgiBQUtGZVHwWP+zJlKPONLLxZEsZ/GuSe/k=;
        b=iAxqmFZUOwwiezAq0LkwC8hQR/+SXozceKfFq0sKZFq51Qa7hZ8tzZYQQyW2Gf9v8B
         64jpmWPzW1oAKjvAO7iXWh8ZLLnWOu7NbBcUN+NjrO5KgYo3v5RzFZz6vL6P/F6BSjgB
         3QhjJlBmsOH4NGg0J12A1117eIkw7yYxUZlWYW5YfcaVFKaiSc/Yjgzv22IzKEFlL3bI
         omECKUMPl1tdYZOQ/0Qfanh8Uq+zPecXQnB6xT38h7NZxde+tFFUjLRi85xA5qCjbrWv
         PWHlQV4GlIi+SeZYIGBO2F1T/aHLfVc4Em5CAQVvqC7KR4tXy6wTh8Fwd+vEdZ67to8p
         Ywrw==
X-Gm-Message-State: APjAAAU1bNUZ8Q3a7i0/ndLNI6E6QNo620Aq4BHbWo+G6VcWNoaEgP9g
        YMvcJFm1vTcuyaLZ0ootq5jaPw==
X-Google-Smtp-Source: APXvYqzeJ3mOvCPjhNXGfdJ8+2kDmOcIHQie6UTiAp7v1ZXKvZo52TNCV9Gbb7NtZ3w/eJRbJSvNHg==
X-Received: by 2002:a65:4c86:: with SMTP id m6mr75952115pgt.75.1558380947150;
        Mon, 20 May 2019 12:35:47 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 140sm29730954pfw.123.2019.05.20.12.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 12:35:46 -0700 (PDT)
Subject: Re: [PATCH 0/4] Fix improper uses of smp_mb__{before,after}_atomic()
To:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <1558373038-5611-1-git-send-email-andrea.parri@amarulasolutions.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22799784-3fbe-00fc-1899-29166668f5ea@kernel.dk>
Date:   Mon, 20 May 2019 13:35:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558373038-5611-1-git-send-email-andrea.parri@amarulasolutions.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/19 11:23 AM, Andrea Parri wrote:
> Hi all, this is a respin of:
> 
>   https://lkml.kernel.org/r/1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com
> 
> which includes the following main changes:
> 
>  - add Reviewed-by: tags (Ming Lei)
>  - add inline comment (Zheng Yan)
> 
> (Applies to 5.2-rc1.)  Remark/Disclaimer:
> 
>   https://lkml.kernel.org/r/20190430164404.GA2874@andrea

Applied 2-3 to the block tree, thanks.

-- 
Jens Axboe

