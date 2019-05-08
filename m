Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DD3C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F49E20850
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bi42Ip2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfEHSIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:08:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36691 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfEHSIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:08:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id v80so10897960pfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SpJ2lO7Hf4iICB+8shwVOVK2JdSr+6WkoIZrngdYYfc=;
        b=bi42Ip2KB/9QJqCJ/YywdUnb+eotERAzeKeK3YLtu1ohUfov8nW+o0etGa5bqPh6hh
         Q1fQ+/yJFTaqIfh5FEOorb5R5m04I9qQ5cIUxLsjUUQmuOAop/HwItWzB1fS012irdy7
         6/ir2T2oTgy2IiwVOmYA90AlS3T3qHlIt5yYxTooqaSxFgPA4UAJKkQ3VSyxeRzNgFyF
         bYGAlJM2qpHImqCkCXgcEhj1E4M7kzi+tpyo3Dksp9C22I/m/qmZYu3cC/zVaZ729eZh
         1J9RWW/V6yruYJQPhnIOjnTHrglHdNoBHFL+qqrnUY2Yz9U6R4Ylpn9UzcL9qaALW0pK
         CNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SpJ2lO7Hf4iICB+8shwVOVK2JdSr+6WkoIZrngdYYfc=;
        b=qaFHPrJIhch1iVtyfnqMuu+nchV5WF7m/YSnhNMX1ax7fSCcj7C3fO5ZwlYtaVLlrT
         +vSrlp0qzsgykGVauhtKjF5Pza1ktYtIyE8wdB7BUJtioIendgz4bVDPxniLbQunTT4u
         EhYQgjX1CJUXMmKovb1qiVBpnDWa/x0afcwkgL8ZPx0tnO0YYI96nw1KgnaMHEjjGax4
         MV049ZSq710VjPm2+rnhskZJl1AGwI54HmcQJv7URHuygeGOmXmB7XITqB1NhCDLjp1m
         3z+DpRnV7JRPfKksFPpv23oTrgMzh0myduhu42F4xelFOu837Luh13bdhWl7aNLD9Amd
         jivw==
X-Gm-Message-State: APjAAAW4UNZC5GZtwDan1QPtd6wUAr4GbvQMnzL1G/mTXycgcm634Ow0
        b48SoQDUrhtF2KSJMB/0gRM2RM+SQ5nWdA==
X-Google-Smtp-Source: APXvYqyiWsv0c9g/811cwhhQ6P+9MZqtJz91kVqI15fyVl6DavQbYFkTph9ScT+pVpl9sjhjQLTzpA==
X-Received: by 2002:aa7:8ec6:: with SMTP id b6mr22796874pfr.234.1557338932043;
        Wed, 08 May 2019 11:08:52 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 15sm21831988pfy.88.2019.05.08.11.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 11:08:50 -0700 (PDT)
Subject: Re: [PATCH] ide: officially deprecated the legacy IDE driver
To:     Christoph Hellwig <hch@lst.de>, davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190508180140.12364-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c0332901-27ac-7d8c-7bee-a1d7616627f8@kernel.dk>
Date:   Wed, 8 May 2019 12:08:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508180140.12364-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/19 12:01 PM, Christoph Hellwig wrote:
> After a recent chat with Dave we agreed to try to finally kill off the
> legacy IDE code base.  Set a two year grace period in which we try
> to move everyone over.  There are a few pieces of hardware not
> supported by libata yet, but for many of them we aren't even sure
> if there are any users.  For those that have users we have usually
> found a volunteer to add libata support.

I fully support this.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

