Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97D1C5B57A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 15:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E87208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 15:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rwGI7emU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfF2Pnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 11:43:39 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41307 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfF2Pni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 11:43:38 -0400
Received: by mail-io1-f66.google.com with SMTP id w25so19019695ioc.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 08:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YhneT2OmUYYi9QQ0MWtStUhcK32OoDHrBHLq0QqvII0=;
        b=rwGI7emUVEde+z71xN+kUWMitMm9xwN3fnnBOK2l281KSK3O0kZXQksInCuNFCOODP
         cc1cXOte3/8k8yAIUoSeRK8SaEU2N4uRKnNE1LQL0XdNbrTHvTqfrwVzKpSesFsBS//a
         H3jMmsd+RrSyMjiNF7PO5CcQQ/R6W6iCpApsnK4W3jV4IgZsNsz1F4IbpplnEMeneE+G
         1HoAWRrwgyAusGxYJB36LE6qpklmDok0yYUyNNVRdcNU9yB7bbUQmKnrdZk4cjfR/47p
         O102SHO07b+K3XY82F6G8xbcA6jeGqpADp27xGZjNLJQe6B9Mex7cfackxCL8E+Sztc+
         zlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YhneT2OmUYYi9QQ0MWtStUhcK32OoDHrBHLq0QqvII0=;
        b=QiQVUYSVJDys/bWevOQY33uG2sEo25k33u9H9K/1LJYIT7IV2KbiOohKSpKXqXah4o
         8UHGgWzueYcH/dB6W9EQHMkrhjNCf9fctPZbmkWjkwn+bQUHKdCusAQpnF8df4u7P3U+
         moKSvnzTIKKmSUqe5jLGHwT6DzGAQjHTo+n7Mz3/WCr4oA6n7cQfn07R+PMU+04+zZpf
         i3QN4iQK1xjW/k2OJZwwQXuu/0CXgmBA1IVl0Ef+m9liVdRTj/5QoB5fv+r5xxkdgF2a
         tieG53fBDlj4331wFc99w5IpFsMfgbZjtQuU2e6KK8WCvH3mV9l/1uwGNgoaYifR07le
         Bj9A==
X-Gm-Message-State: APjAAAUYm5sXL/Lpu9RQ5kIjCpNYh0UfBGTq0UMbhK1pWOndKnJKjYy6
        qGTF0J5Kpiu16LOekjNfXRejoEhLhtudyw==
X-Google-Smtp-Source: APXvYqzLpQnnfI8fmJ78TQweFrWED4gIwJ3Llz5lZMmG5nQO2Bnf1k/M6qZ/gRvWG5Egvf7rVCvmGw==
X-Received: by 2002:a02:7c2:: with SMTP id f185mr18395500jaf.16.1561823017689;
        Sat, 29 Jun 2019 08:43:37 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f17sm5128371ioc.2.2019.06.29.08.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 08:43:36 -0700 (PDT)
Subject: Re: [PATCH 10/87] block: skd_main.c: Remove call to memset after
 dma_alloc_coherent
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190627173516.2351-1-huangfq.daxian@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d296f570-dfb9-4add-ff02-2dda3159a13a@kernel.dk>
Date:   Sat, 29 Jun 2019 09:43:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627173516.2351-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/19 11:35 AM, Fuqian Huang wrote:
> In commit af7ddd8a627c
> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
> dma_alloc_coherent has already zeroed the memory.
> So memset is not needed.

Applied, thanks.

-- 
Jens Axboe

