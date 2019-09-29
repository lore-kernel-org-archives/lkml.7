Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8C7C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8B920815
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UlGoRVxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfI2UVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 16:21:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39142 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfI2UVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 16:21:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id a15so6775792edt.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 13:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/CVt/vLJtBjg+T9O+xWd34W6CPNXiOTrjXGXhqyE4Y4=;
        b=UlGoRVxLOvOnW6xzDkMA5QeopjV40q5Qkvbds6GzjMXoxAsOrxfjJhTEzThD1SQkHl
         ix+CHa4EHdQU9v6X8b9rtw+0V2FlyDAlvVbXloRaN5wK4Y8/nSGxjC35A4yY6ZlYKnOi
         YfnDQEcEp1AY86CgHh5QxCvOGwor+A7/6MjeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/CVt/vLJtBjg+T9O+xWd34W6CPNXiOTrjXGXhqyE4Y4=;
        b=ZFJpVUTaSE9aRmA7EWMfMj8KR+ZrkfMYENpzrFmPDZuQnctfM19/YY0Jgnhz/wUJER
         L/BF0YwwEdamcP9LE1YVuaNHbYgV4fp+PjGNGXzBFGKo/n69aM71ZgAd2EntCFuRMV7O
         e+TD3MXXvDCsjX/0JJiNqLy1fqm51fdXqCxsq1rZJ+JpHq9lzYO1MRrII4L0tpqqlk7a
         VM+Wtn+/r0XJbaRrytcrMGGCsUNehvU9kEyKlYhyKlFCkysFeSqyQ9UrOJNsGFe2jyhy
         ZdTckux6SSdOLgtBB2XgEIWhk2sxO8tGjPz92P1ym2L2KR+KpA6qtttLeGghMhqbWLAc
         /nug==
X-Gm-Message-State: APjAAAVaopeZeq5HTLKzngRl3HUnxli6IJpGlPPN4tfFORwJ9RGKAej6
        qkxL8qvcYN4tgnEH5XVDxkS/jw==
X-Google-Smtp-Source: APXvYqw0Xe1a2UNI2ulgsLY3l1OlAI7XERAIvvAsujPSwcPQkpK0D+mRjLYp+QM71d8lRu9f9PF4TQ==
X-Received: by 2002:a50:fa83:: with SMTP id w3mr15958065edr.262.1569788509849;
        Sun, 29 Sep 2019 13:21:49 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id f36sm2019864ede.28.2019.09.29.13.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 13:21:49 -0700 (PDT)
Subject: Re: [PATCH] Make is_signed_type() simpler
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org, rostedt@goodmis.org,
        mingo@redhat.com
References: <20190929200619.GA12851@avx2>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f99ca43d-1ba2-95fb-b90f-6706a06f8ce6@rasmusvillemoes.dk>
Date:   Sun, 29 Sep 2019 22:21:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190929200619.GA12851@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2019 22.06, Alexey Dobriyan wrote:
> * Simply compare -1 with 0,
> * Drop unnecessary parenthesis sets
> 
> -#define is_signed_type(type)       (((type)(-1)) < (type)1)
> +#define is_signed_type(type)       ((type)-1 < 0)

NAK. I wrote it that way to avoid -Wtautological-compare when type is
unsigned.

Rasmus
