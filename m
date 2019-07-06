Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0CDC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 16:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B5D20843
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 16:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qicd/fun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfGFQHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 12:07:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35233 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfGFQHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 12:07:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id s27so5579841pgl.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 09:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bnmQjEH1vYixqqvcA510E7VkS1LxWaG+p2Hix3E3JqU=;
        b=qicd/funjrpa2MxTNeuQoPhPDV7SU+qyw6BwWY6yh7r1IaDvoqyQ07St8p9OEgylYS
         GqFgK/mDeKxRdWK9fBISg1CxtaYg0ECsLe8zIijMLfzhffg7KiWwNAXftRDwUfCUGYrn
         O/idl9gZ9KvApAbkKOZ6eJsjiPWhqoy93KMjk8awTsCUr7DprObuPppW5lQJQMN125aL
         zURFvuFcGZ/rBDROj87VJSuqvVu+ubO6rtbMzAXybEdbD7WKL5craHDFUxMEvLZL4W5M
         7T5Epsk0F7jirsFnQ4sr6t/u7WS16NEWaF9EnF2IGLidGdRU1zxI8z+4ZP0HLQcIzZYB
         qzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bnmQjEH1vYixqqvcA510E7VkS1LxWaG+p2Hix3E3JqU=;
        b=gFtVYICb5VbUPonTErqurKd0OM8ayIc/9U504olOlFQyxNRXUNNdBLq6vUlv5gih0Q
         os64RB1vWDygpk2nSTKdXSRxmMRrFh5Hqorx8i0c7KcTylIvucwC8QuXHedxbiz/K4/Q
         5gFe9hNC7HA1j/86A8D/oG5nRAccIpcdGW7ne9/4NaYqyB1MTWhkNBrzOLJI4qpfGLKO
         QrBvyTYWbZeJfwjxQgtwsUc//m6ltS/q6VlcLdr8Kzz0Mh/4WoOQFs3b4y/0SpwEZpS1
         OOEKZvHH9Ures1vehA9vA8kL9TI/4x3Jt+rMdswan5E1RWiCTDogiTPyUt3vFFKDBkCQ
         /hEQ==
X-Gm-Message-State: APjAAAWLKeQ/biQe9m8pOcQV0RLZD/HdNhG5W1EgCs0g7k6iHJF6XAzG
        OzuZomD8mS/VHHk17QRhwx42Gg==
X-Google-Smtp-Source: APXvYqyO0Zbgcab0FOZETV4bJlTWSr88APdiToWut3pIn34c0C0iG+3cGDkmAcy9GC9UBH5M7iDOdQ==
X-Received: by 2002:a63:5610:: with SMTP id k16mr11733599pgb.335.1562429239012;
        Sat, 06 Jul 2019 09:07:19 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id b126sm14572448pfa.126.2019.07.06.09.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 09:07:18 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: fix up placement of debugfs directory of queue
 files
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>
References: <20190706155032.GA3106@kroah.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a4e28385-6f87-05f5-edb2-d68446771b7c@kernel.dk>
Date:   Sat, 6 Jul 2019 10:07:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190706155032.GA3106@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/19 9:50 AM, Greg Kroah-Hartman wrote:
> When the blk-mq debugfs file creation logic was "cleaned up" it was
> cleaned up too much, causing the queue file to not be created in the
> correct location.  Turns out the check for the directory being present
> is needed as if that has not happened yet, the files should not be
> created, and the function will be called later on in the initialization
> code so that the files can be created in the correct location.

How about we shove this in for 5.2 final? Trivial enough to do, and it
would suck to have 5.2 released with this. Though not sure what
devices this actually impacts, I haven't noticed anything awry on
my setups?

-- 
Jens Axboe

