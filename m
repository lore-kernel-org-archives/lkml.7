Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E383EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFD1206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DqCtJziY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfKNJAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:00:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37120 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfKNJAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:00:11 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so4402001lfp.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 01:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PlNrN2GhAvRY7IW8hzvOGZWhxEVtG6SWuwKkUSlWRyI=;
        b=DqCtJziYkryUZAUqd2xAAGwJFBCGTywmDlEpqjTs1//7QvPdR0AwIUntDfUsmL7VXt
         inp5/f3kzSiCI/REeaZwhuroE7fO4RLz1hNiMXce1uHOOoWd/krMOrPvIsHk8VUu/Idx
         CVhp6Qxtadp2q8Bf0VYuQFMBrMOjcRmWU1E3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PlNrN2GhAvRY7IW8hzvOGZWhxEVtG6SWuwKkUSlWRyI=;
        b=ZzBhPUEaX2PJV/hXk02jmAgHr2jpMOs+eAaVrE7WUaTu5RzASgH2Uwfc1y4L9T/fW7
         ffJfAdfhBW7dn45c/VzVGUN0BhL/QPHyUBClylrkkMrpndZJRh0PucUN2EibpKEXcCOm
         6IfO7hRrTzsi7Fx1ZSyovHELCzMBcb+k8LQdiE8VlMzQyDFvqR4alwoFY+quyqZ42XNd
         SpipXeiBH1bjLQNPzytlmD17KU7hXk/UdY1mDeB+6UdisqABVL9fJ84GLQtvEEX/cPOF
         laJpCJZJzhEZ+4/n7WwNT/Z7wxFQyi44aIjgAIjohZ2dYBxCb7GbxmUpbkQjYv278it+
         gceA==
X-Gm-Message-State: APjAAAUlCIygieq7YCB4SFhHVgPTrwApS44ImqOz350tIgfUI6uigfnK
        H5K9KOTAluEdh0KrsOD/jNEC+A==
X-Google-Smtp-Source: APXvYqziuBwUwTFwvFITVp9Y42/Pf1aEQFfzH3vqpE2R1SKDE+E1rudpEqbbReFJja9okUlvGnJRkA==
X-Received: by 2002:a19:c386:: with SMTP id t128mr2627137lff.7.1573722009265;
        Thu, 14 Nov 2019 01:00:09 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2073916lfi.57.2019.11.14.01.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 01:00:08 -0800 (PST)
Subject: Re: [PATCH v4 30/47] serial: ucc_uart: factor out soft_uart
 initialization
To:     Timur Tabi <timur@kernel.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-31-linux@rasmusvillemoes.dk>
 <CAOZdJXVQ_wQLK-4uutb2e6zOt0b8FBVY3qoWdoo4UM8p7=bV0A@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <73337067-953c-55e2-986a-24116fb10544@rasmusvillemoes.dk>
Date:   Thu, 14 Nov 2019 10:00:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOZdJXVQ_wQLK-4uutb2e6zOt0b8FBVY3qoWdoo4UM8p7=bV0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2019 06.14, Timur Tabi wrote:
> On Fri, Nov 8, 2019 at 7:03 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> -       /*
>> -        * Determine if we need Soft-UART mode
>> -        */
>>         if (of_find_property(np, "soft-uart", NULL)) {
>>                 dev_dbg(&ofdev->dev, "using Soft-UART mode\n");
>>                 soft_uart = 1;
>> +       } else {
>> +               return 0;
>>         }
> 
> How about:
> 
> if (!of_find_property(np, "soft-uart", NULL))
>     return 0;

of_property_read_bool() if anything. But I didn't want to do that kind
of transformation - just a pure "move this code out and fix the
indentation" with the minor edits needed to hook it back up where it
came from.

> And I think you should be able to get rid of the "soft_uart" variable.

Eh, no, it's used in several other places in the driver. I kind of hope
gcc is smart enough to see that in the !PPC32 case it is a static,
never-assigned-to, never-escapes variable so all the "if (soft_uart)"
branches go away, but that's not really very important.

Rasmus



