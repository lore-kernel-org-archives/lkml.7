Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C25C04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAD12081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UL/vJ9zw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfEBUh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 16:37:59 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52393 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfEBUh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:37:59 -0400
Received: by mail-it1-f196.google.com with SMTP id q65so4306575itg.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wUZCuohdRKoDtwCw7rpSCNfQpmZ2G6kYAjwgGTNQOmk=;
        b=UL/vJ9zw2ioEKKKIQPsBxyn+pcvK4SshzyL4jwE2DLBZ40sI2VmgnFtY95pCp6xBjl
         Nnm7LD0T5RrgyWR/xy6hiQcO55VV/duS1znRkktfTcQJ+xK25xhDxr28oXsJs68rzx9h
         XgYTK155M2n1HtMp3DGOreTHVM3F76w3f5GiWKA9UA9FzRflL8ErFclqPNJezVVk7tdr
         6c4RaaXHRJkOpLvU2Iz64zIrSXtkiTXdkUtHXj4+eVN3WEB0ee2VNSH9PicGf81/PZcb
         zSGzrl3EXAlMmmcN+3++/C/DJfFZNREMBxgYqR8SRziOTv6A10rI8PSdhDhpBswFNwDv
         Fw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wUZCuohdRKoDtwCw7rpSCNfQpmZ2G6kYAjwgGTNQOmk=;
        b=Foqmi1voHcBcVIIowW20shsVbCk9WafaoOPjTwF17s3ILM7JdLPWOlsEc+CDnJpNVS
         hkI176IApCKJncBZUJGVgMzhSK9jR4afKfzfLwcgcGni+ygQyhJVuh8NkHrmfM9vtj0a
         i4BxIR6DT+rc8/cc9xnNBHMCDHk1Cg/LFCC0lMX9hpnLW1Mcyt6PgjHo2nl7uafHmTw5
         /PMzM35Q3MYuuVFSdRyDG4FeQboV1+kwkurCmAfm86+GPwXuXQQRQoRYldnUdIsEwMP1
         ST7IvoSLHwZBlnMeoWztnTJ4Tz3kJO2Mjo8kYl5X22crSzVclsZyuFB67HV+piukYyp7
         P/Fg==
X-Gm-Message-State: APjAAAVsRpe+bIt+SOlNLlxXJI3DQV2LBll0Rnf3jfffC5LnQqkOk7th
        pqmP/AV9KKF2L4NToCzbNM+8Aw==
X-Google-Smtp-Source: APXvYqzlCq6WXjdnf/oddvNK1Cz+UTqXHQ0hODYhPUI0fDgjsYcop03sYkFqMdagDhmrKU3QVjxRSw==
X-Received: by 2002:a24:ee83:: with SMTP id b125mr4585381iti.43.1556829478105;
        Thu, 02 May 2019 13:37:58 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d4sm65586ioh.35.2019.05.02.13.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 13:37:57 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] blk-mq.c: Add documention of function
 blk_mq_init_queue
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
References: <20190416032801.200694-1-marcos.souza.org@gmail.com>
 <20190502020455.GA71748@laptop>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <698e2ef1-e45a-e66b-f604-5c6bf76c40b5@kernel.dk>
Date:   Thu, 2 May 2019 14:37:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502020455.GA71748@laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/19 8:04 PM, Marcos Paulo de Souza wrote:
> gentle ping v2.

It's not that I hate the series, I just don't see it adding any real
value. It should already be quite clear what the functions do, by name,
and the comments don't really add to that.

-- 
Jens Axboe

