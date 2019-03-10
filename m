Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4E6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FED0206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YXksFClc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfCJVGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 17:06:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40333 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfCJVGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 17:06:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id c17so1536137eds.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SFyFxE0EvyDINPrnH4i7HvpY4i5ywd12Et6Irs3iXSs=;
        b=YXksFClcvj6ySnKqo4e07WzKKRnKBfxRzSHuRjW1s3D1cqF85ht+tjfh3lgENlAtJg
         iFO5ZBjwfbMj9eLNsM5BFgmWCvOVqDDH8ocwH7VxKQBCuNiGxi/hFg0oQkZFg2Hpdudu
         5j/u73seg8MFuPVmb/RUP0hMpi18TH6XcY8xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SFyFxE0EvyDINPrnH4i7HvpY4i5ywd12Et6Irs3iXSs=;
        b=uDRRkK5UB1ISjKUUFs4thz/YTkhDD0nLGiRp7ErcOBdoCNgniUjDhSwFunP3FiyMOb
         ldqxkgChOOlOvIQCETuDePc5rCj6yZWCIsuDqaFpcwmY9/zAFNqvaRO2V4TmIYYDZv9b
         0vVUJajEgURKyjasM+zXSRz1vh7krVvTOMRgx9ufSNGEZp8vyjSKP7lVAs6cpDTirtjU
         1C6BSZjdjya4XIkVE1jxuyPGvR0wQj1Z+kFGTV7sIBYfZAR40xN18ifjAiwVb81WQ6nT
         sjpyDyMrhZkTtOLelg0ueH0synxz4s3LkHQ3Z7YKqbwzobZdJ9KQI6fI2seBwiY5R4Ji
         Ttrg==
X-Gm-Message-State: APjAAAUZ9G+tcQpcxRZcKq/lbVg1biOid8UerBF0bm8M3E6lZlR9+iFM
        UMtCGwimQHBq05i6r89X1NPJVQ==
X-Google-Smtp-Source: APXvYqy+O63ndFAlMcMF60sMt+2f1oZcnZl5r29LNDcacccz3l8W6O7cR295RR0uAbtKRooiZvRXGA==
X-Received: by 2002:a50:d8c2:: with SMTP id y2mr42231593edj.65.1552251988608;
        Sun, 10 Mar 2019 14:06:28 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-117-145.cgn.fibianet.dk. [5.186.117.145])
        by smtp.gmail.com with ESMTPSA id g3sm1387274edh.83.2019.03.10.14.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 14:06:28 -0700 (PDT)
Subject: Re: [PATCH v1 2/6] lib: scanf: handle integer overflows in vsscanf
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <155223448227.4075.6846910559654700796.stgit@buzz>
 <155223699287.4075.13184771244455866778.stgit@buzz>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <9da44b6b-49c1-3383-e272-d61065f81de4@rasmusvillemoes.dk>
Date:   Sun, 10 Mar 2019 22:06:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <155223699287.4075.13184771244455866778.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2019 17.56, Konstantin Khlebnikov wrote:
> Traditional scanf implementations ignore integer overflows because
> C language standard allows here undefined behavior (§7.21.6.2 #10).
> 
> So, sane and safe behavior wouldn't harm anything.
> 
> This patch carefully checks integer overflows and stops matching if result
> does not fit into appropriate type before assigning it into argument.

IIRC, this has been attempted before, causing a userspace regression
because some sysfs/procfs file matched with %u or %x, and somebody wrote
-1 to get 0xffffffff .

I can't remember or find a reference right now, making the above a
rather weak argument. However, please start the series with your test
cases, before any refactoring. That makes it easier to see what
behaviour you're changing (i.e., what used to be allowed is now treated
as non-match, etc.).

Rasmus
