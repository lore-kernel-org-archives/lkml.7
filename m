Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDF3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 00:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208EB213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 00:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UkdFbezT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfCNAPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 20:15:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36071 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfCNAPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 20:15:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id v10so3222330lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 17:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SGSAotKzOlS72l9zI4wpd01SsxLWhFkq81+JX8sRhjQ=;
        b=UkdFbezTjt5d+q15var8a/HVAM07h8UCBBtSQWVMcgTaLBZqXMOZgUa0R+vkkpYpO+
         LNJ9fGX/574mWB9XDRUucLiMnUo+XvWVa8oSaYdBw7GFaSy4yR5gg1OIxSPCld8EO2Fi
         nxMVQtzQNvuU5YlaYPC2UkIq1tifUKDej3OBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SGSAotKzOlS72l9zI4wpd01SsxLWhFkq81+JX8sRhjQ=;
        b=KWW0H8AsmLncXK1s+Qrh+NkB+ApxQKe4MXLWT0uhrBozb4VkLxhF3u6ijbDnsFsiJC
         qYEPXBJZZV1XhYtNTSCDSNXqFXTjJiLrhCHzjNcs6FqWZFbNSrgQkTU29Z0jzC33Wf6H
         /CkMRJBscri2h2d+oJbD0NOP5PtnLnJfMRQLl81vzTBSR2Q5K6Y0QdH7SO9PxI+A6jdV
         X34hHxwsccFMhZsBYRyl7d4B3A8Te4pjL/BjXGuiX4bhqAx2lAFvYOc1nBR2iQ4E8wAL
         y6l58NF9kC9ufSIzA+iUpfqoqvYjzaQsM5DcrdLw/Mh/LNjMOigwM4aSF/MZrN4sg7Vm
         qzpQ==
X-Gm-Message-State: APjAAAVe1oxT1yvOEDz7MvfvUNl03JiLYfD+o4/U2DQ2P8mlAoM2GIKD
        q/V8hCW0ZUsIx7g/QM8nZiVduA==
X-Google-Smtp-Source: APXvYqzDuej4x+Q48/FZm0xXJ/j4BZgmji3hZgYEact9J+RhWeSRjw/tDGwlgmUsQ5OCj2PSxFqSyw==
X-Received: by 2002:a2e:82c5:: with SMTP id n5mr7055601ljh.91.1552522514935;
        Wed, 13 Mar 2019 17:15:14 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-119-202.cgn.fibianet.dk. [5.186.119.202])
        by smtp.gmail.com with ESMTPSA id g18sm2097045ljk.26.2019.03.13.17.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 17:15:14 -0700 (PDT)
Subject: Re: [PATCH 2/5] lib/sort: Use more efficient bottom-up heapsort
 variant
To:     George Spelvin <lkml@sdf.org>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        daniel.wagner@siemens.com, dchinner@redhat.com,
        don.mullis@gmail.com, geert@linux-m68k.org, st5pub@yandex.ru
References: <cover.1552097842.git.lkml@sdf.org>
 <dbac34c6052fc973fb55df4966981bae24c7cce9.1552097842.git.lkml@sdf.org>
 <472510ad-77f9-49e8-4122-52f447cb1c15@rasmusvillemoes.dk>
 <201903140003.x2E03VZO028625@sdf.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0ef7f72a-8552-654f-db2c-5b4dfcff982e@rasmusvillemoes.dk>
Date:   Thu, 14 Mar 2019 01:15:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <201903140003.x2E03VZO028625@sdf.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2019 01.03, George Spelvin wrote:
> On Wed, 13 Mar 2019 at 23:29:40 +0100, Rasmus Villemoes wrote:
> 
>> Nice!
> 
> Thank you.  May I translate that into Acked-by?
> 

Sort-of. I prefer first seeing the full rerolled series for context
etc., even if (the important parts of) this patch would be unchanged.
