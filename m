Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E58C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCCE20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="JxeqGjQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfDAUnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:43:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32895 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfDAUnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 16:43:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id q3so9642926edg.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 13:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IPp5UBhjmauumhzMvJEgg7H5y+lW26wX4Uq5ovId0EI=;
        b=JxeqGjQHlNjMVebBP21HH0HbGpAX8q8RRJIjq+SuSnodAVVKetBbnHSHnHqhTY2FwL
         jnIMyVyl81Bj4dQeTkjWUEkMDGEeRLPbJDDdkLyUQt+GIzDqlUVIrWhUcM9dvKTvV/Nl
         eYaar5LPJjaxisTiHuGely22xjaKnV+fjUgt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IPp5UBhjmauumhzMvJEgg7H5y+lW26wX4Uq5ovId0EI=;
        b=aYZj6cRMOIWgrYDza+ohi0xiKVR9uUFCmreB5suvmauZkIkpjuZgb5lLq9zVPHVFZH
         iMoWywRao03kAntzUgfGyw23DTqqtGAiXRpvRFIl9wDYYt5ShvFQ2E8m9QtU4SkZ3cpU
         8lN1ucbh9ITRHdx5q+qE5DgXcub7QYupcSoTmKxpcVrDqC0p6XQFTlBBnqCZBjIdba0t
         CU+t10q1nEOZbo4CK0TBYG75ne0DITTAcxuSZ39VS1ozAbzRLR5sxsQEivUNMG6EMGkH
         2FG6hbM4lmWiN1SFnUy9GjrTAcLTsVtlpAaqkj5pOizsl11O3AAlVPxDo3zowKXUlEIF
         T+/w==
X-Gm-Message-State: APjAAAXIakJTKiCNcWeSk7aHQrj9M6i0kg+5fxekAjVms/mF7PHZKASr
        KY/FExRp3zVVsMzgrbKlW+JpWw==
X-Google-Smtp-Source: APXvYqzqB5VAYdKmyPb9MiRjG9QHesI0/ex7GrCGelNow5oel10I4LBf69a5MzKwcPh2j+y6mDZ04w==
X-Received: by 2002:a50:8864:: with SMTP id c33mr44834654edc.110.1554151394947;
        Mon, 01 Apr 2019 13:43:14 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id 4sm3455392eds.74.2019.04.01.13.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 13:43:14 -0700 (PDT)
Subject: Re: [RFCv2] string: Use faster alternatives when constant arguments
 are used
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
References: <20190324014445.28688-1-sultan@kerneltoast.com>
 <20190324022406.GA18988@sultan-box.localdomain>
 <2293c54f-40b1-1e59-665a-bd8f2cb957d2@rasmusvillemoes.dk>
 <20190324223202.GA875@sultan-box.localdomain>
 <8672b98c-bf71-7b5b-625e-2f241807d46c@rasmusvillemoes.dk>
 <20190330225941.GA7456@sultan-box.localdomain>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ec88d9a2-272e-973e-55ce-f3d411aafcd1@rasmusvillemoes.dk>
Date:   Mon, 1 Apr 2019 22:43:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330225941.GA7456@sultan-box.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2019 23.59, Sultan Alsawaf wrote:
> How can the memcmps cross a page boundary when memcmp itself will
> only read in large buffers of data at word boundaries?

Consider your patch replacing !strcmp(buf, "123") by !memcmp(buf, "123",
4). buf is known to point to a nul-terminated string. But it may point
at, say, the second-last byte in a page, with the last byte in that page
being a nul byte, and the following page being MMIO or unmapped or all
kinds of bad things. On e.g. x86 where unaligned accesses are cheap, and
seeing that you're only comparing for equality, gcc is likely to compile
the memcmp version into

  *(u32*)buf == 0x00333231

because you've told the compiler that there's no problem accessing four
bytes starting at buf. Boom. Even without unaligned access being cheap
this can happen; suppose the length is 8 instead, and gcc somehow knows
that buf is four-byte aligned (and in this case it happens to point four
bytes before a page boundary), so it could compile the memcmp(,,8) into

  *(u32*)(buf+4) == secondword && *(u32*)buf == firstword

(or do the comparisons in the "natural" order, but it might still do
both loads first).

> And if there are concerns for some arches but not others, then couldn't this be
> a feasible optimization for those which would work well with it?

No. First, these are concerns for all arches. Second, if you can find
some particular place where string parsing/matching is in any way
performance relevant and not just done once during driver init or
whatnot, maybe the maintainers of that file would take a patch
hand-optimizing some strcmps to memcmps, or, depending on what the code
does, perhaps replacing the whole *cmp logic with a custom hash table.

But a patch implicitly and silently touching thousands of lines of code,
without an analysis of why none of the above is a problem for any of
those lines, for any .config, arch, compiler version? No.

Rasmus


