Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB44BC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6E82176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Cw3/cX10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfLRQ4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:56:53 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40567 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfLRQ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:56:53 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so2694052iop.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 08:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rTEAWvowPGiFm5bG98LTp8ro86bKvhqp1ci3ULDNOxE=;
        b=Cw3/cX10PPDAUYUM5rAGyGOME6Qu+RzUqAQmtd25Lg/C2gnl1JKPerg/GIHijZIZt9
         XhVJDbh2y/2QKLauB6fy2cvWemLqWd9Gq+64D27LSHQYbz/b7QMsQIeYkfYl8IubuZk9
         a2MaJhq1ioT8tZ7vxwy9ulLODP/ASjy0CZSXVW2jZSFR1Tov9j8Rcez5kHAi3VnQJZwQ
         wOR1hvatDhTd4Wdoj6B241fKvUaoghBKN8S3fK8cO+sVjk6sgl503k/8I0AZqPCPLTRg
         r3l9SeeB3eybTXsugdhUtMF11A9i59bZFyDvqpK/VIthYXb3OtSb5unN9+g2zlbDKBEs
         1TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rTEAWvowPGiFm5bG98LTp8ro86bKvhqp1ci3ULDNOxE=;
        b=BQjPaa1vzAA95O7EsQfaLHaremkvI6GjUh0BMombvjRCWPbZDqxwGtaWTGhWPKJhpm
         v0TjLOPJ3CLuiA0GxYicAzHZjl0myoMRYhHK1/HLaFTv8jqrQE7W/lxPn20eETd+7/80
         LWRx3yuWU/0gdS9tH114eFFqCWqjpNXx6zOhRTAM//Jj9DL3VTmJmcQGje34Kqy8aHgN
         jrdjxOekMHCHDN+vnIc8sRPcKdujQFdlKaZsyTYMI8tqi57acA9WWIQqYz2XJJnmhxGp
         Dib92hcmCfipTK/EOQ8NIsYXPqzDVJFjEGIvcGnOwCRkvpjxBMzPkSZ0XnFmdKDn8pKa
         RiOQ==
X-Gm-Message-State: APjAAAXFY31Yx6PZWk40scX0T9wXgX8Ege8u7WxEv11IReMKMAZN/a70
        WhUDInQTivCcmKoMzFrWMHkmCP1StBQOcw==
X-Google-Smtp-Source: APXvYqw6HgfbjWrkvdzzoP8foDMwN38PPf5JRmq4JvAUC33lN7IwtCTqA7XbBuU8q9KC3+R9uWtO9Q==
X-Received: by 2002:a05:6638:97c:: with SMTP id o28mr3342377jaj.8.1576688212169;
        Wed, 18 Dec 2019 08:56:52 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t15sm836936ili.50.2019.12.18.08.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 08:56:51 -0800 (PST)
Subject: Re: [PATCH v5] io_uring: don't wait when under-submitting
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1576687827.git.asml.silence@gmail.com>
 <28aad565ed6c3a3a03975377aa62035b1b0a4d97.1576687827.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7b684479-d0f9-4e74-b947-5ceba577734a@kernel.dk>
Date:   Wed, 18 Dec 2019 09:56:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <28aad565ed6c3a3a03975377aa62035b1b0a4d97.1576687827.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/19 9:53 AM, Pavel Begunkov wrote:
> There is no reliable way to submit and wait in a single syscall, as
> io_submit_sqes() may under-consume sqes (in case of an early error).
> Then it will wait for not-yet-submitted requests, deadlocking the user
> in most cases.
> 
> Don't wait/poll if can't submit all sqes

This looks great, thanks, applied.

-- 
Jens Axboe

