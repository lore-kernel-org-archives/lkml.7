Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB609CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7FC20679
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FnEEyIv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfJ1D2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 23:28:42 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:34222 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfJ1D2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 23:28:42 -0400
Received: by mail-pf1-f178.google.com with SMTP id b128so5914951pfa.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 20:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JQoEGWmnXt1HXOcxozyvsTmaem0U3qNdOOn884rNMUs=;
        b=FnEEyIv893T2XirJza0c4gD3QRzsh+EzVypzATohez9L/qpvesSPyENktB+jwm9mHG
         MEj4bJb36cejJx+XuG2x3OsUfPFei1oiFfA027PeBQ3Mo+mF8Xl+2M3a46rfXbT+A7q6
         KVA7YlkEjQQpzRoXA9I6azk/JSqlxs0e+NsdrzqII6ISGq7J+ifHlOo3HiwdksWbkGwj
         3gqjAWFdf3PVVu0R6O82hIwzZ9xlRdUMrymA0KqQwVih2JMVRX5w/kQn/KhX4E8Vuwzc
         hwVSNuDvkZ3yhg2dWOqnugHaBN9i8ZejBy50qXC67vNQL9ga3ECeojsHSaF6ewEz9SwQ
         pIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JQoEGWmnXt1HXOcxozyvsTmaem0U3qNdOOn884rNMUs=;
        b=owCDNH1p/1Ha8WrbYkjnt1cY3zIqVpOgbN//aeVaAUEJZYB9vG2aHifUE3HPbvoRBn
         5J5yzEG5O15lu7VEAgHtDrWuMtDEy4tmV5ZUKr5z7NNUI5GExT0Hy/Qe7WKUlUjdRp+/
         MuMDNgsrqIr3DR/HspnwP52XBn3bCCA6Cimt13Xq8jLVjACc5J1DH/776hsBNx9ejd2V
         nmymJdi9N07hrr41HOxV2M7XRixH7YtobqQUCcDul8SSyIqqNNH8wMJGA4X89PIvStmI
         agEwFdwFnOpNRTULJi0CvQXHat78lYMFxvrnayCBOOWeJzxW/LWI0BtTpzKfkrZpunAz
         /5Kw==
X-Gm-Message-State: APjAAAXV49jGEaNIJME0USm4giLarDJi4G7rQ9Qs2dA8039FCql4YvTp
        LNcgOhxo3umKLWRMeULO1ARt2oIRIItXsA==
X-Google-Smtp-Source: APXvYqyEbnX1QMqfyPICKqhy4KjAimRgDkym/XFy/uORMMHVhUIEtP0uRApD6p70Ovqh2spF2H+DGg==
X-Received: by 2002:a17:90a:8048:: with SMTP id e8mr20403457pjw.0.1572233319549;
        Sun, 27 Oct 2019 20:28:39 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id s18sm2923371pfc.120.2019.10.27.20.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 20:28:38 -0700 (PDT)
Subject: Re: [PATCH][for-linus] io_uring: Fix mm_fault with READ/WRITE_FIXED
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a30b1e934506227b4740b6030dd77e7e233a58c2.1572207237.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e70202d3-53c1-db48-f95b-0334f11178d1@kernel.dk>
Date:   Sun, 27 Oct 2019 21:28:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a30b1e934506227b4740b6030dd77e7e233a58c2.1572207237.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/19 2:15 PM, Pavel Begunkov wrote:
> Commit fb5ccc98782f ("io_uring: Fix broken links with offloading")
> itroduced a regression with unconditionally taking mm even for
> READ/WRITE_FIXED operations.
> 
> Return the logic handling it back. mm-faulted requests will go through
> the generic submission path, so honoring links and drains, but will
> fail further on req->has_user check.

I thought about this a bit, and I think we should just defer this to
the next release and mark it stable for 5.4. I'll do that, thanks.

-- 
Jens Axboe

