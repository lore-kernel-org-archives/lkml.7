Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0080BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5907206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YhYa/eN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfKRCas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 21:30:48 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:39026 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfKRCas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 21:30:48 -0500
Received: by mail-pf1-f177.google.com with SMTP id x28so9600528pfo.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 18:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v8BAWdRTBsXRM8xdSToodwMOCDg93ZmO7iNpdniRA1s=;
        b=YhYa/eN1/0CYmCrBfLipG4tNs7hUM2OspQjH0ajp8lzwCz5POfa0zWoBz9cXGUxZdl
         knYZhCtZe1LuBDcxRPXlQKD86u2nVIL4Pez8iFZ9e0DkoqxhruLlJUMG57SpxO5lcXnb
         Eddw1zTtJnbFlY01xHJOZrZcdYMdNp0XEoXbvg/t8BWvt1QUQN/0yhUFS49/Kk+xSMEO
         goQA3DcV6IZM/ts4iL94rVvIz7JirIOOohGEhvm8KNaOzJUtC+XQ9R2vdfiyW0HMtwAT
         ulbFuhgN+QOLLUO5USyDogwsqZzM3+mGjMLJop6YV6at95DO5rsy9gMJngj4QZBvYHk3
         97jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v8BAWdRTBsXRM8xdSToodwMOCDg93ZmO7iNpdniRA1s=;
        b=rNH6GT69sBtSEcz0Gu6ZPw+ak+qvnJXuSHVviPHK9jla1H8hDCFLm7lsJ9e+u/WtWG
         1Q7+r5wkHcFWotGVs6ie2NQqmnU6/ZsHQb4EXFIvY3YaJrZda3NohMq9RCQrabBO5cac
         tE4TbfZ+FNcn3+XowTtwdx3iuiVNzHVgrpRsUkhMoe15ZErPJbPw3nCz3sHiKLoMPuG0
         iEQ/1aZniIEB6T+ufObovtyw4/DEBqF0BBzQSFSbViC4f79Ark3YZ5E6sPiLnBFLxSTh
         XMkfcbhaMWtlGACqGLIGjaZk8CYUtZ4mvdzH9HTboajGUP8BYQHjbadQElig4bBn8CHl
         CBRQ==
X-Gm-Message-State: APjAAAXujwcsPgceCFoW99O+GTX/HUFgyLD1L0oq11fz9lzfykhLIq0v
        hn9Nv6JqAEvt+4USVv6K+TQVxVspOKk=
X-Google-Smtp-Source: APXvYqx3pA+d8Gd38MjrEOEeopWnEcuRlRvpg9kJlJbbc+eA1td1lda41Q7Mfwbhi8fdHqf+0Ta2EA==
X-Received: by 2002:a63:ed43:: with SMTP id m3mr12428483pgk.261.1574044245656;
        Sun, 17 Nov 2019 18:30:45 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id s66sm21543885pfb.38.2019.11.17.18.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 18:30:44 -0800 (PST)
Subject: Re: building individual files in subdirectories
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190528121148.GA18162@lst.de>
 <CAK7LNAQRW+phJrdR-5NfUE9L09O-nRiimfW5rB8Y8S9POtkxCA@mail.gmail.com>
 <CAK7LNAQFy=AfJtk4GT+FL=Kzcf6Ev=keKoUz_7Le7iZOQEc90g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a08ab4f0-d500-331b-da70-388e6244bc67@kernel.dk>
Date:   Sun, 17 Nov 2019 19:30:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQFy=AfJtk4GT+FL=Kzcf6Ev=keKoUz_7Le7iZOQEc90g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/19 5:15 PM, Masahiro Yamada wrote:
> Hi Jens,
> 
> 
> (related to  https://lkml.org/lkml/2019/11/15/1152)
> 
> 
> I received questions about single builds not working properly
> some times in the past.
> 
> For example, the following is a post from Christoph to kbuild ML,
> and my reply to it.

I'm not saying it isn't useful, what I'm saying is that slowing
things down by almost 100% seems excessive!

-- 
Jens Axboe

