Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66036C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4A72084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="PDel+T6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfDCMRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:17:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42996 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCMRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:17:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id v22so9972846lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 05:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8yo9PlIGRvKMYjgwhQ0bYkMPLDCvIBBMPm5yOH2/BOc=;
        b=PDel+T6cl4UTjTboDO+bwMZn63ZZ66I8QVoIPBQiPDe4z0P9fudt0t/qUbLl0XXFnM
         jwYTlO+LcYJz5XXq/fE20iGtR8xvb4wiEL5WJQvfbm5KZNyPdzefXaBEtpvoZk8StlEC
         +tNd0sUvHxn0OwVl8VtXQAnqIX9jNKN7n4jH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8yo9PlIGRvKMYjgwhQ0bYkMPLDCvIBBMPm5yOH2/BOc=;
        b=hBeLf+FiOnrrZy4MVqrqXqJ2mfG1Nd6rC/nqqCsStSwuV6vgyNchOM8vBn9KKrrBpn
         j3s/9m4CZYbFF4UGMRQhA7fV5bp4ZVTSTwpck39sNs/ARRLLZ2/cjoF9G1WrGSsobnv1
         v1unT+362vZT+rNiQ4sofLof/Xf/RPLOfqvsqZv4D8W5t3jnAjvrSplBn+eC5+jXLT7B
         G2OmB4N4YUM//0xLeZ2PNcDza0m8yDy/P2gbn6KKOFLdpHvwCjRh5ol0NMlvAX6SIWVH
         VuOD/xl/aZys8HNP1LjNx4jN3nCcVUsg7vw38GOaoAJTnifDo0n/tpwLzVA2Hw9tVZzO
         WQuQ==
X-Gm-Message-State: APjAAAWNRfBFr4bjM5lukGhe/baPAZVlxoEWgKg4lXq8lLEgjYe1L8HU
        PViSQ8xheiwD1iJ+KQZgZxrNRgdEBd2p7CHm
X-Google-Smtp-Source: APXvYqzxlah/cCjENnfGcq5nM/MQ6YpJjOKkKtKlKk+r6w7OepLqLZLPjvWHoWb0AM8w/tsSfqHJCw==
X-Received: by 2002:a2e:9213:: with SMTP id k19mr20279197ljg.118.1554293861753;
        Wed, 03 Apr 2019 05:17:41 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id j14sm3182937lfb.18.2019.04.03.05.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 05:17:40 -0700 (PDT)
Subject: Re: [PATCH 1/5] lib: make bitmap_parselist_user() a wrapper on
 bitmap_parselist()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>, Yury Norov <ynorov@marvell.com>,
        linux-kernel@vger.kernel.org
References: <20190403044540.16322-1-ynorov@marvell.com>
 <20190403044540.16322-2-ynorov@marvell.com>
 <20190403111522.GP9224@smile.fi.intel.com>
 <20190403111745.GQ9224@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8408fada-5fcc-9a45-9631-685505ed14f0@rasmusvillemoes.dk>
Date:   Wed, 3 Apr 2019 14:17:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403111745.GQ9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 13.17, Andy Shevchenko wrote:
> On Wed, Apr 03, 2019 at 02:15:22PM +0300, Andy Shevchenko wrote:
>> On Wed, Apr 03, 2019 at 07:45:36AM +0300, Yury Norov wrote:
>>> Currently we parse user data byte after byte which leads to
>>> overcomplification of parsing algorithm. The only user of
>>> bitmap_parselist_user() is not performance-critical, and so we
>>> can copy user data to kernel buffer and simply call
>>> bitmap_parselist(). This rework lets us unify and simplify
>>> bitmap_parselist() and bitmap_parselist_user(), which is done
>>> in the following patch.
>>
>>> +	buf = kmalloc(ulen + 1, GFP_KERNEL);
>>> +	if (!buf)
>>> +		return -ENOMEM;
>>> +
>>> +	buf[ulen] = 0;
>>> +
>>> +	ret = copy_from_user(buf, ubuf, ulen);
>>> +	if (ret)
>>> +		goto out;
>>
>> Why not memdup_user() ?
> 
> Even more precisely (for strings) strndup_user().
> 

But the user buffer is not nul-terminated, i.e. it's not a string. What
you want is memdup_user_nul() - take a length-delimited user buffer and
turn it into a nul-terminated string in kernel memory. And yes, please
use that.

Rasmus
