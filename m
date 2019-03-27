Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD61C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C882082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="NGkFsgZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfC0VbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:31:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46500 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC0VbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:31:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id d1so15393273edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 14:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=42BMOtzCvR79SSHddTfYvJZntWsVfLBjpBOf8g0s5ek=;
        b=NGkFsgZ2ILFu9CV78l/uPPbCMm6/VpQUnmGm6MBaML9zSNnLKGVb4YdwkdMgjiQUep
         V1M2Vl36G5WvMrHArMChxWuto8zsvFkOov6ai8VEtYtv5iyxqh4F0OGpBYnAettejDoD
         ahmp4fDgRcLp48OzdInLQv7igst2r1ORRDBqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=42BMOtzCvR79SSHddTfYvJZntWsVfLBjpBOf8g0s5ek=;
        b=U0hitO9SjiI10eLAlrRD4BHQvjkgj+XonPlIZLJ3xDLYxxsRcH4cktxCc2BQCBgbEl
         jP7wlylkAhJ9KABk2dCx3oTbb5eSPoO5Jvs+uTb+xKRslr2+1GVv9FQ7FwlRLn1avQnF
         aXwYYt9zAWR0oP+tIgsuRsx19pzJckDsaeojk5XhuLycKrtzeeAiBcSB6L2aMieye3uI
         bCid7hUnfd/sMU7MOcAmo/2OVdxAZ983DwH76Yw+dIkpq2XzrlcfJErMfxJ4BxHHwYeu
         at43lJPgkKCn/oIU4eAc+owqM6VEkDacVMWB1k2JyWc3ZilqKpS56MpPr0UJ/rOxEFMR
         3DYw==
X-Gm-Message-State: APjAAAV7nPbVPYn0c17XqyJpoACAw/Lr8QyeKrd5EFll/ec3KVjoi4u0
        Ob9aEEiTG3jJV5CGJgjnavbUTw==
X-Google-Smtp-Source: APXvYqxDr4ZCQQFV16WEiWGgg2h0dnNX2JBT7L3fR//kW+XT2+Lqz8qKcpHdlMCSUpX2OAzgOpb8vw==
X-Received: by 2002:a50:c251:: with SMTP id t17mr26052727edf.179.1553722282940;
        Wed, 27 Mar 2019 14:31:22 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id cg22sm2943039ejb.2.2019.03.27.14.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 14:31:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] leds: netdev trigger: use memcpy in
 device_name_store
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-2-linux@rasmusvillemoes.dk>
 <987c3e60-edb3-44f0-be28-434c70bb8659@gmail.com>
 <d1fccd75-c48b-d585-1170-1c1b76e1e098@rasmusvillemoes.dk>
 <21193aab-7880-d116-64e8-dd08afe5a47f@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <5871d2bd-1a9d-9cf0-e8bd-6d691ea94415@rasmusvillemoes.dk>
Date:   Wed, 27 Mar 2019 22:31:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <21193aab-7880-d116-64e8-dd08afe5a47f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2019 22.20, Jacek Anaszewski wrote:

> Thanks for the heads-up. I must admit I'm hitting into that for the
> first time. After "git am" it was all OK, but it got screwed up after
> "git rebase -i". And having "commit.cleanup = scissors" set globally all
> the time is annoying if one extensively uses interactive rebase for
> rewording commit messages. It entails the need for manual removal of
> the whole stuff that appears then after actual commit message prepended
> with "#" comment characters.

Eh, no? At least, whenever I do commit or rebase -i, git automatically
inserts a trailer starting with the magic scissor line

# ------------------------ >8 ------------------------
# Do not modify or remove the line above.
# Everything below it will be ignored.

Maybe there's some other config option to get that, or it depends on git
version. But I certainly don't do anything at all other than write or
modify the commit message.

Never had a problem myself since I set commit.cleanup = scissors, but I
have had lots of my commit messages mangled, which is why I'm reacting.

> This is probably the reason why people use often other characters
> for command prompt (see the other fix for ledtrig-netdev).

Command prompt char is not the only problem; C snippets with #include or
other preprocessor directives also regularly gets mangled, as does shell
snippets with a bit of commentary.

Rasmus
