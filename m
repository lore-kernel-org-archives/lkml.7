Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40ABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887EE20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WRaMQVWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbfCZImR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:42:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42934 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfCZImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:42:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id v22so10308319lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SD/PKwauTHsQj5wRHRWaalJgkbU5bKy2l+RZqvzJcgM=;
        b=WRaMQVWyrAOZ894ZOrSopfVDnZ5S/1PgKT6RybW6Lg7jo74Zvw/FZdaHAZOIGgTLt/
         Uk7I4XdsK5tt44qWQwYeeK9SERBVsNXCYc940IZ/cPJCbvfQFzTWg5FCYehW0/yaI2RB
         GBT40qTR659SbhHc9uaZ29+fulBI1BWwmYOHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SD/PKwauTHsQj5wRHRWaalJgkbU5bKy2l+RZqvzJcgM=;
        b=QJ3EKhfHyU4TiI6XYyi5KkHxuvJb+NtqXsXYfuyXWQ66zi0Wf3RcLPH/5Nym+uHJVn
         v2X0jsI/hoIYcJjN7NLQAGK8FPxbRrn3/krzupAkkCBuW4yxrhaJyZLbVSh2QLmLPsp/
         vCsuMAohzfoqWWa9MCkACalbz+t0FLRz/kHVwz82sznqFwqBLPCKsqPKQD5xPdkQUnOX
         eZStpHpHh6NP4V8Ktf4UdiuVs1FyH1HU5sk7VpSC4cjiPQNsI6p6/AD9d+Pz9nBH9UKx
         n2DZK1SxrAuP/8M93ITx4e/RAOpnjy6FRcdzgXXfiQgKZ/PLfaD0AcZtcfR1JOGW6V1B
         DYlg==
X-Gm-Message-State: APjAAAX7r7n/Evf+npwkmFXSDqO/fLnJW/8c36bVKijlC+ACjSEgXRuM
        e2C+GxJheEb+i4vhTdS5PxnuMw==
X-Google-Smtp-Source: APXvYqz2xzQcDrYIymBs/pa1Ds5aznhnCvVhpWEwFEWzLMMN35m0foDIQXa8Y8Yb40AMqkV7pChKTQ==
X-Received: by 2002:a2e:884a:: with SMTP id z10mr8687593ljj.21.1553589734738;
        Tue, 26 Mar 2019 01:42:14 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id v203sm3860763lfa.82.2019.03.26.01.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 01:42:14 -0700 (PDT)
Subject: Re: [PATCH 14/17] crypto: Don't mark AES tables const and
 cacheline_aligned
To:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, herbert@gondor.apana.org.au
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-15-andi@firstfloor.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <58128cae-5871-64d8-0b4a-c1e3bb354e95@rasmusvillemoes.dk>
Date:   Tue, 26 Mar 2019 09:42:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321220009.29334-15-andi@firstfloor.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2019 23.00, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> cacheline_aligned is a special section. It cannot be const at the same
> time because it's not read-only. It doesn't give any MMU protection.

Urgh. Perhaps this instead just wanted to use the quadruple underscore
version, ____cacheline_aligned ? That would make these objects correctly
aligned and still live in .rodata, no?

Rasmus
