Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E562C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E495D206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RYzE+pIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfDZLdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:33:43 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44826 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDZLdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:33:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so2574606ljg.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 04:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DuE5gPdhmGsyOHPLUgmwWb3Ctbt7SCFstuuSNlmiVUk=;
        b=RYzE+pIypgcY1izxOzXxRNgsbsPOBu+KyV0ygkl/jTRTkmQM51TG7JIuuDudqWz2hQ
         ykMkQd0KPwi8mpn0lVmJmfJz3pkuC08hEdwjLDWmivdjEeC7/C2Mmz1onSrprHgZ5oZJ
         hbrl6Nyf3RLTaGJyjoSlkqtO9ZS9YzHQ1d9g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DuE5gPdhmGsyOHPLUgmwWb3Ctbt7SCFstuuSNlmiVUk=;
        b=BJQw2UNAOhh1O7QP5/u9kuq3QolN8dXwVpLCWfTS7EdsMgF0DUIxiWsPhWeJn+Gz5p
         /RgSDpT8eoCcddA7b6nilXNS7byO122rEEqesxEdJlSotX4C9rvcU/srVO0zPlOBT3q8
         tqCnUEma9BPM6X+YhrjkjTJEq0xOTPLyyYsXYUMT5qpqPv3P5/Ldlicj5VMu/3Et4YHT
         iihcAe1+S4gD7GVarFVOO8URDll5KbxLBxS0Q0hxDNjxUIDqoM37gjtlxP6YvHUOsRZ/
         gmQPQFTTMZeXUElfnM0PNw6MpTlbRdfFfMTVNfQYUBLnk/euYjiQtA1dPW54sh8Ja735
         mJ4w==
X-Gm-Message-State: APjAAAVUSUy3N8oiXKcqV+Lf19DwXIPwZu/dBlNyNVhW4re/TzKzFy80
        LtKYvEsR4bKwXAgQu5wktLwuLA7glaIMfBdD
X-Google-Smtp-Source: APXvYqxjMiLqM+Zxh5FFs5lY3DMKMNzG2mYbxgj/75Jvi2ejngi/7Y2TwVu0RS07m5pipI4P1mSkfQ==
X-Received: by 2002:a2e:9c85:: with SMTP id x5mr2905865lji.45.1556278421117;
        Fri, 26 Apr 2019 04:33:41 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id v23sm245289ljk.14.2019.04.26.04.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 04:33:40 -0700 (PDT)
Subject: Re: [PATCH] mod_devicetable.h: reduce sizeof(struct of_device_id) by
 80 bytes
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Mattias Jacobsson <2pi@mok.nu>
Cc:     Jeff Mahoney <jeffm@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20190425203101.9403-1-linux@rasmusvillemoes.dk>
 <62959593-6029-e66e-ebee-314db7aa6f10@metux.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <59adbc18-b2c6-267d-7fed-43886d95c9de@rasmusvillemoes.dk>
Date:   Fri, 26 Apr 2019 13:33:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <62959593-6029-e66e-ebee-314db7aa6f10@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2019 13.05, Enrico Weigelt, metux IT consult wrote:
> On 25.04.19 22:31, Rasmus Villemoes wrote:
> 
> Hi,
> 
>> A typical kernel image has hundreds of static struct of_device_id
>> instances (a lot of which are sentinel all-zeroes), each occupying
>> ~200 bytes. Nobody initializes the .compatible member with strings
>> anywhere near 128 bytes, so a lot of that memory is simply wasted.
> 
> I just wonder whether it has to be a fixed size array at all, instead
> of an const char* pointer. Using a pointer should, IMHO, offer even
> more savings while not having the size limit at all.

I did consider that, but file2alias reads the struct directly from the
object files, so it would have to be taught to apply relocations and
find the string literal somewhere else. Also, I think there's in-tree
code that does "foo->compatible[0]" to test if the .compatible member
was initialized with something; that would obviously crash if it's a
pointer rather than an embedded array.

One thing that might be doable, though requiring quite a bit of work, is
getting rid of the silly use of sentinels (quite a lot of the
of_device_id arrays have just two elements, so the sentinels are
responsible for perhaps 40% of the total memory use) - file2alias
already reads the st_size of the symbol and does a "is that a multiple
of sizeof(foo)", and "are the last sizeof(foo) bytes all-zeroes" - it's
obviously trivial to drop the last test, and process all elements
(though ignoring an all-zero element, so we can delete sentinels slowly
throughout the tree). That leaves in-tree uses of the of_device_id
arrays, where one would need a way to forward the ARRAY_SIZE(), yet
continue to stop at an all-zeroes element.

Rasmus
