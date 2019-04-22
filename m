Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953F7C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E27920693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NCQxT6yL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfDVOUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:20:42 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:54505 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfDVOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:20:41 -0400
Received: by mail-it1-f173.google.com with SMTP id a190so17995420ite.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cwhcEj4eB0a9TMWvDIOsvP1F5w2eXks3djvHmn1f/WU=;
        b=NCQxT6yLJQFOBan9xlWVVsz9p0zqeB4kko4oHUtqFxMFu0qnxeUnIBPLhBKOmdwW+D
         iw+pdqI9u0Z/qu2wKOzRD0Z/XKLxaFtdkAptUoyZVWpgPt+nVkL/Lj2O3ht4kAn2otHF
         mx7vtfKUWNsvbtuRiPOM3/McAkjz/jD2HeWqj7EHE0fdMxTOsbxm9T1YUXlh21dz/bOA
         350Lz6iYTA3EXujBnH+XujuY/Ha9BXH4gngvE0CM48r0d3MdJkHpcldQnDX/K1Z51jRy
         bO8m1SWE/VZ5FEGO9SbdAb810gWAZESPjhEDJo0VMG4xqJRtkl8kFN8XUn0yLzQXWyrh
         tUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cwhcEj4eB0a9TMWvDIOsvP1F5w2eXks3djvHmn1f/WU=;
        b=ThczYdPLOxCpYsSQ17iLWI6h0ahIuScYhzwgYa8eVz4IQ7saWUdC3lR2WZc3Tw/lj+
         XdZCHDTQ9Y246a3tgLmbIZ5rvu8AorUhVt6m61IGKZYU5H97wxvmIqTAP+VVwEinY98B
         0z5rjvvSN2J1QpRxVLsTcRBxcuVhKNc9nYcfRbTnLzRPehXKJ+kn6672YW63ypkrrYIp
         yUOtESaqS1xdCg3EWEQUuzQSdWtLyXtAMPQkJbopdZftQ+Wx9wOZNGOZ2DLF+3qFstfx
         GU+fEiRUPd0q+cMW5v4QhwFi3LiIzrYcVaaJ2d2OcX0yPAaR9Go+avHzvC0WsEITfx63
         rRug==
X-Gm-Message-State: APjAAAXwXFd5gNJBAkQ3nyC4fCWhKVxoF3JNJubQjoeqhEmXwQKbueAl
        pfHJCrklEkH3YUB6d3gX8n+FZQUk5VmiNw==
X-Google-Smtp-Source: APXvYqyhtIWpe9obiLogZf+xlOzAdLYl5XyjlwiebiYxSIl1ezcQxpjf2j1SiCjPmXFJUEATPeYRcQ==
X-Received: by 2002:a24:65c8:: with SMTP id u191mr14424514itb.137.1555942840197;
        Mon, 22 Apr 2019 07:20:40 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id z11sm4576074iom.73.2019.04.22.07.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 07:20:39 -0700 (PDT)
Subject: Re: [PATCH] brd: re-enable __GFP_HIGHMEM in brd_insert_page()
To:     Hou Tao <houtao1@huawei.com>, linux-block@vger.kernel.org,
        dan.j.williams@intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20190422132321.100156-1-houtao1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <19d700d6-f293-0c21-d75b-44cdae0513de@kernel.dk>
Date:   Mon, 22 Apr 2019 08:20:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422132321.100156-1-houtao1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/19 7:23 AM, Hou Tao wrote:
> __GFP_HIGHMEM is disabled if dax is enabled on brd, however
> dax support for brd has been removed since commit (7a862fbbdec6
> "brd: remove dax support"), so restore __GFP_HIGHMEM in
> brd_insert_page().

Applied, thanks.

-- 
Jens Axboe

