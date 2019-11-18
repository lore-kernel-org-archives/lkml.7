Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C31C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C56320692
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zs8hejVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKRO0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:26:31 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44317 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKRO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:26:30 -0500
Received: by mail-io1-f68.google.com with SMTP id j20so7893332ioo.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 06:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=du0XHpmLviazuqr3BCaTDTx0qFpy8dgUcEPCv5dSJV8=;
        b=zs8hejVgqws+v5Gu+l9yMA4nopGmUwQZjUJnjQUVogqktbkEW14DoBX4fxmhG7BB/e
         rbN4UCFmLnNygIsV39ni0tlA4BEAF0c/APLGD/ZTa+LkBHNC46Fe71TDJYmAFLebNyxc
         bjaWoImPEfZG6H9WC5To7FeQBMDduWzgs+/SQjH9lBAkeDWDxYkTO3ubICGofpdVvKus
         0b1z9986UfZvNv5urlsR3h80NV7YEjLnLNftaCkm9rwMdgd1Ag+TcSv1BI3Ew39zHT4p
         vT2DE3u4vKl39KI8bmFDHR0/j76auj782kQxmZCHQSZQP9FsM4utTEaiaBiseC/CF4qq
         /wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=du0XHpmLviazuqr3BCaTDTx0qFpy8dgUcEPCv5dSJV8=;
        b=VaIAOUuu15rofHuik41zEcZ7Sw7avTWJy5JRDbGzp/b+1dK3A9SmEaHAiS8Z7zU+hB
         pCXXi3khvQf9j+EHAlacDuzfuYxv2saqwUkIGYWE1sIagocwStBDF54iDzjqcYL+6Rhk
         jIEC/PBzsV8cBCd6KU0Dssil3AwznJW3XGplM4mNFA7y2bUCpPiwlhJrkQg69xZn/Swl
         3f4lU3od1UJuE81JaK2B5VIPxoJJbtKT+/ooIlI0AlQXBOL3x8i/bmv4+vLGWgGj/4o3
         jD22CZYmS6khkqWFQ6Sejl5udWYckcSPg7e8a1074g5JIDBVLj6VXe8CwPiVA6Tl94t8
         eNOg==
X-Gm-Message-State: APjAAAVT1pmmctGGDkrqk0swMrfcvvT0AN5gIviofAvn/MNga/bh2U+R
        KnU02niI8nKH+9rFium4kOLLsW7N6pI=
X-Google-Smtp-Source: APXvYqxho+itgdP4ffBUh8zwnHiMwlXoVhy59Svd9UMWT0O5v/ZjRugfj87x35RO8m6Uyxka3HtgRw==
X-Received: by 2002:a5e:d716:: with SMTP id v22mr13226365iom.152.1574087187154;
        Mon, 18 Nov 2019 06:26:27 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e4sm4534244ilg.33.2019.11.18.06.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 06:26:26 -0800 (PST)
Subject: Re: [PATCH] kbuild: make single target builds even faster
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
References: <20191118045247.14082-1-yamada.masahiro@socionext.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2b1ab1b1-dd20-31f7-c787-921cbd66a828@kernel.dk>
Date:   Mon, 18 Nov 2019 07:26:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118045247.14082-1-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/19 9:52 PM, Masahiro Yamada wrote:
> Commit 2dffd23f81a3 ("kbuild: make single target builds much faster")
> made the situation much better.
> 
> To improve it even more, apply the similar idea to the top Makefile.
> Trim unrelated directories from build-dirs.
> 
> The single build code must be moved above the 'descend' target.

I tested linux-next, which does improve things a bit, and this one on
top further improves it. We're now not THAT far off the situation
before these changes, that's a huge win. Thanks for working on this!

You can add:

Tested-by: Jens Axboe <axboe@kernel.dk>

to the commit, if you wish.

-- 
Jens Axboe

