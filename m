Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D532EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC381208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="IegVour0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKUIzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:55:38 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:43035 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfKUIzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:55:36 -0500
Received: by mail-lj1-f182.google.com with SMTP id y23so2266013ljh.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 00:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=nm9MbxbOhLJVk4VBorEHBe3daFrDVX/QgQpwK6J6Mg0=;
        b=IegVour0g97ytTjltHsxC7xw2eebqHL9gqSUJuXgdLDmBo+puXw4ReLGc/IiOy/SB8
         t9U9u3dXNavaFgDzfooZ6APWd/aWrwoW2z+s6yUyqody54/rTggSnS/wgDsSoz69gVYo
         sjyVeMUxNlq9rpjIf3b/Gr9+9JEEWvYCm5Bf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nm9MbxbOhLJVk4VBorEHBe3daFrDVX/QgQpwK6J6Mg0=;
        b=UMWUedIyZIUc4I0pC/bCfIvjGxJpkLGL/VtpcSZSk6+GH9g7Nh2hisq0HNlmrYmH5I
         E9vU6jBWfZPARb51stHP+4MJP1QOv46H4aaI2VS4IGN1e/EUJHTgRlK7aQDjarjVNwTz
         gGscdirZn9WFId6sDAKXpDcd4izuEDfy9cEbdzT2AlOMuyvPoXGjSEI1+XoZWMI4aT3U
         66OG2Pqm/s83UWYPcW8q7mVVH7QdzyjSfed7PCuzE7fwvzKh29uddLzRHbbtmAJqZrOR
         s7e0aBBTUAH29mQNv8NiAQQPcGzJw8f/tAGayKtPQebbDBIWv9lOXR7EIxknJYJ4EGaq
         gAbw==
X-Gm-Message-State: APjAAAW/3qb8/gzAR011NEaWff3u76r5PBZA9R6w9ejCrYzyZWCgfROd
        LQ+/TuOpj6PktfXCHOFYwNGkO/+6HAEghzbI
X-Google-Smtp-Source: APXvYqzclwlL5ssR6U9q3KRL0QWW1xjKH78BaWR9CxvWH8FCIHGsCrLoMq2kDQUm6wIsUAZRc3IlOQ==
X-Received: by 2002:a05:651c:1196:: with SMTP id w22mr6484508ljo.217.1574326533379;
        Thu, 21 Nov 2019 00:55:33 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a18sm977459lfg.2.2019.11.21.00.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 00:55:32 -0800 (PST)
To:     LKML <linux-kernel@vger.kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: can we get rid of the cpumask_t typedef?
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <d6a7ca69-2f65-5bf4-edbd-2644a1f3f124@rasmusvillemoes.dk>
Date:   Thu, 21 Nov 2019 09:55:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpumask_t alias for "struct cpumask" doesn't seem to qualify for the
kernel's requirement for when a typedef is warranted. It's also somewhat
easily confused with cpumask_var_t which has very good reasons for being
a typedef. "struct cpumask" outnumbers "cpumask_t" about 5:2.

The motivation for this is that kbuild informed me about some driver
that I just enabled for ARM happens to include asm/irq.h, and for magic
reasons no other previous header happens to pull in cpumask.h. So the
build fails

>> arch/arm/include/asm/irq.h:34:50: error: unknown type name 'cpumask_t'
    extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,

So I could just add a include linux/cpumask.h (and the reason I hadn't
noticed is that the -rt tree which I build upon carries just that) and
be done with it. But I'd rather not contribute to the "every header
pulls in every other header" madness. So I'd rather just change the
function to take a "struct cpumask *" and precede it with a forward
declaration of that.

As it happens, arch_trigger_cpumask_backtrace is a good example of the
sillyness the cpumask_t typedef leads to. ARM and Powerpc are
consistent, using cpumask_t in both declaration and definition. MIPS,
Sparc and x86 use "struct cpumask" in the declaration and cpumask_t in
the definition.

Rasmus
