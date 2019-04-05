Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E85C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476652175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dEZS2s+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfDEIJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:09:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35947 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfDEIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:09:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so4452629ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dx79+XInnPowGjjwsIRkiCrROvWr75BiD12MWbrfRbY=;
        b=dEZS2s+FKVKFRCAvFGESrac2N9eEiwi18rLwBDBo1LnGFm/PwxRhQHXnddz3JJuhN5
         Q9o9bOnytiJfhz5tCLWj5eARQMncSSsrfcfPPsL0Hr4SOkAe3kHz8FwYhkvtOt8MBc+M
         4yunkZ85OiqYGvU03blJGuwpH3PPbOLfqU41c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dx79+XInnPowGjjwsIRkiCrROvWr75BiD12MWbrfRbY=;
        b=G6OFB8a2jkIg6ooYcyb7gcacDGRShNvaqnduXOw6PgB0v/Ng9Gd8p7Dk6gxbp0o8pt
         rXAuCP6aHnvYXBVdxdG90ZWNmnWusetCBNo3ohZuiJc31nSVaOCj4ZQG1BvSG94Byuf3
         1TeSt1cxzLQIDv4jA82aBmT2ALjpA/h+k3ds1v+rgeMDFodx82fCKOC7YYTzWOtSDuTS
         aQq18N6GozZfeGLQSpuirFV33CQhIAbqK8yraJpEphJ0kV3jiX7l9wvjTuLhM02XbPkD
         eIapTX7pHMsGyK74hYZ7ry0PG2VxDSNt53muH1EvBNXgoXiJtlebBe4Bkoc1E4wSgvxl
         mRbw==
X-Gm-Message-State: APjAAAUk0alMRG1kDPMU3fpmFxr1NE5FQCK8pgXYLM7gvulVCHsy+Smp
        ZUddYdX8E2LQU28yTGrtoznmtQ==
X-Google-Smtp-Source: APXvYqyuaupIiCkA9J7T67QXbsXu24CaII2u7F1TcSH3XvWp1xSCXhY3czQjpUHnPXILJlTM1pgAag==
X-Received: by 2002:a2e:390c:: with SMTP id g12mr6095352lja.174.1554451773005;
        Fri, 05 Apr 2019 01:09:33 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w19sm3712865lfe.23.2019.04.05.01.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 01:09:32 -0700 (PDT)
Subject: Re: [PATCH] overflow.h: Rename __ab_c_size() to __calc_size()
To:     Borislav Petkov <bp@alien8.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20190405045711.30339-1-bp@alien8.de>
 <d2e7ee85-50a7-7026-82f9-2169656bd4f9@rasmusvillemoes.dk>
 <20190405075251.GC23348@zn.tnic>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <3fefb03d-3ea0-5a08-f00c-09a47b17f2a8@rasmusvillemoes.dk>
Date:   Fri, 5 Apr 2019 10:09:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405075251.GC23348@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2019 09.52, Borislav Petkov wrote:
> On Fri, Apr 05, 2019 at 08:26:45AM +0200, Rasmus Villemoes wrote:

>> It computes a*b+c with overflow checking at each step. calc_size
>> is way too generic and doesn't say anything at all about how the
>> calc(ulation) is done.
> 
> Ok, whatever.
> 
> Then it would need at least a comment above it to state what it does. I
> don't want to go and parse the macros each time.

It's an internal helper, and struct_size is fully kernel-doc'ed. But
yeah, a comment wouldn't hurt, and let's rename the parameters so they
match the abc naming.

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 40b48e2133cb..6534a727cadb 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -278,11 +278,15 @@ static inline __must_check size_t
array3_size(size_t a, size_t b, size_t c)
        return bytes;
 }

-static inline __must_check size_t __ab_c_size(size_t n, size_t size,
size_t c)
+/*
+ * Compute a*b+c, returning SIZE_MAX on overflow. Internal helper for
+ * struct_size() below.
+ */
+static inline __must_check size_t __ab_c_size(size_t a, size_t b, size_t c)
 {
        size_t bytes;

-       if (check_mul_overflow(n, size, &bytes))
+       if (check_mul_overflow(a, b, &bytes))
                return SIZE_MAX;
        if (check_add_overflow(bytes, c, &bytes))
                return SIZE_MAX;


Rasmus

