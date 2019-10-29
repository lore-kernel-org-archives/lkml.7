Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D525FCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7450C208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="HO3FtE89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfJ2Uro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:47:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39598 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfJ2Urn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:47:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id g19so415509wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sdQEilUBsv4W84bOTkCZzeL8QzQSuMZXqv2RU9TZjao=;
        b=HO3FtE89X2nnUjWxLnkh9det58Apja3ZBC39B7Cii3JBMyAng0kg20NrrVjd02dzGt
         6FXp3spxqAHOpw66+tykZJjtOYoMeR9ZimYtj2HXrBDYbCP6IzFE822m0bJ53ci1ueYp
         IsxMg4gtjhfXTMFve9pVN7O3Dyhe6mjk5lKX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sdQEilUBsv4W84bOTkCZzeL8QzQSuMZXqv2RU9TZjao=;
        b=fXCJ5b+C3PgJghbcKm3VOelhZM5Ct9P8aOiDNfd8CgQfh/adLzgeEtOrnN9F9mUSi0
         Ynv6O4Wumtz1bTCk+u0VmpYCSX37yDurHZiZBS3Y8Pyt//ZmPdUMF8v45YiJgNOAKV0u
         rKR9fgMgEgTXBXJhpF8nGSTfvvnEmXQiS5g5tRPc/LgHxZP4DPGHY1T5VMlXiE6284K6
         ol5inQ4WgDQINgqTw1SjkVGgnOFaXbBfUdtcJL59ruoCijWbzYjeLnUp+aR65l5k+JQY
         EFMYPDSnicUybr+PfdgcwIFm0Znxs0sc4BYzGH8iZPqDCzVlFLCFmRopy4vnsUi6mRM3
         FpJw==
X-Gm-Message-State: APjAAAU6WbXyXei89Z47H0s12HTBMwyqsIILs/8Wt/o5gbwasNN4i+Lk
        WuRluaqVFsLzMVgM/bo8LvtNUoRTwSFcukCu
X-Google-Smtp-Source: APXvYqzB/nOtWNfB+GGK+i4n8/Q3QQOsLk4ejAe819ABbIW9j+MaOaRerNwm+70K9FM7SBnU5rJOcA==
X-Received: by 2002:a05:600c:303:: with SMTP id q3mr914166wmd.139.1572382061642;
        Tue, 29 Oct 2019 13:47:41 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id t16sm203045wrq.52.2019.10.29.13.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 13:47:41 -0700 (PDT)
Subject: Re: [PATCH 06/16] dyndbg: fix overcounting of ram used by dyndbg
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        linux-kernel@vger.kernel.org
Cc:     greg@kroah.com
References: <20191029200035.9889-1-jim.cromie@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ec6fba26-c384-a29d-eee9-4f0e56c3af06@rasmusvillemoes.dk>
Date:   Tue, 29 Oct 2019 21:47:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029200035.9889-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2019 21.00, Jim Cromie wrote:
> during dyndbg init, verbose logging prints its ram overhead.  But it
> counted strlens of all ddebug callsite entries, which are full of
> pointers into shared __dyndbg memory, and shouldnt be counted at all
> (since theyre already in the __dyndbg section)

Hm. I agree we're probably overcounting, but the strings themselves do
not live in __dyndbg, but in .rodata. It's true that __FILE__ (and maybe
in a few cases ->format) get's deduplicated and by the nature of
__func__, ->function points at a unique-per-function string.

So I think the commit log is a bit misleading. However, I think the
patch is a good idea anyway: avoiding 4N strlen() calls during boot is a
good thing. And if anybody wants to know how much memory is used by the
pointed-to-strings, well, "wc dynamic_debug/control" should give an idea.

Rasmus
