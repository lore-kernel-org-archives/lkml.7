Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E84C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 12:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A982064A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 12:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXtBIWzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfIVM3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 08:29:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51500 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbfIVM3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 08:29:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so6872014wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 05:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=21j2zzfwkesIZ6myrBPcvCgKsUfGnEO2xG0NBiEWz2E=;
        b=DXtBIWzgumW2Pk37hldBMhWkSZjej64iArMZgU4peeF5eOLnoANUzbB8cwR+aF7Pcd
         XkeNoLBZm3mucDzhZu6p5aI77K8NtSZESM1Kbaru8LRAR31axI/q9deK61kqq4SDIkj5
         XrSrWOQUBbLYXdyZEadFPp6XRmVSkP45oobfiVRoEEkk+1GZN0CAo8L2fDcV5fzPsUvw
         CkmCowO0bC3zoBveusE40r4+my/8BiiozDdvSslEKrttUqEyEQvbttuf5T02UmjjQaNK
         d7pGkPMSgZhhine/WrW+4PSr417gQunCT1hojcqB35gOcwyrfmsCmza+3/LSfB3AgLsU
         BiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=21j2zzfwkesIZ6myrBPcvCgKsUfGnEO2xG0NBiEWz2E=;
        b=SMf9KiTwkVbwtCwPU7Ck6oFOQjADIu1nY4Qklqev0vPvpf1zMgzmyKcODCM2F9tPoI
         zVX9iep4bTrhXwclOZfO2SkQnHfJov2MDAgD+ebsJKVur1L+Pe+uCzK34NONXps0BKZn
         Z0zLExHUfg5u68PMKvOInA8Fy26AY7XxKsX+wWsYKdGI/yf+ji7cGNm+JWMPf3SBo2lo
         0J25hQ+VVEG7w8UCWvM8RShfzB7bQt6uBcB/wgQg3QBfRMoDwIengwAaGD3TxQL7OXh4
         uILfX9X2JaWJP3IJljH30attMot71cU/vMfwbu7e6lZmmvrEAkYvkYil6ALlDaZytM5B
         Id7Q==
X-Gm-Message-State: APjAAAV3NoknahZrv5jvFW6BfHphIVlhso9kWDFw52/hkSYuDZVun8CD
        SYqYI/FXukbLgn0BNs5JVA==
X-Google-Smtp-Source: APXvYqzEDXoCYBI1PPWGRbEw6o5L8FtY/Q3gIVjpRYXbeimytEHT6B33coIhn8lavK1FLwOm65/tBQ==
X-Received: by 2002:a7b:cbd0:: with SMTP id n16mr9822482wmi.82.1569155379524;
        Sun, 22 Sep 2019 05:29:39 -0700 (PDT)
Received: from avx2 ([46.53.253.157])
        by smtp.gmail.com with ESMTPSA id w125sm17426272wmg.32.2019.09.22.05.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Sep 2019 05:29:38 -0700 (PDT)
Date:   Sun, 22 Sep 2019 15:29:36 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     mingo@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, torvalds@linux-foundation.org,
        rdunlap@infradead.org
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
Message-ID: <20190922122936.GA31964@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Beyond the muscle memory aspect, nonsensical naming and inanely flat file
> hierarchies annoy kernel developers

Flat(ish) file hierarchies are good -- less typing.
If you're copy-pasting then it doesn't matter much (it still matters a
little because long filename occupy more space on the screen and in logs).

> makes it harder for newbies to understand the kernel source as well.

That's fine too.

>   drwxr-xr-x    crypto          # move to kernel/crypto/ or security/crypto/

No, crypto/ is fine.

If everything arch independent should live at kernel/ then why should kernel/
exist at all? It should be trimmed and everything moved to the top level
directory (OK, I'm not really suggesting that).

>   drwxr-xr-x    ipc             # move to kernel/ipc/

No, same reason. It was there since time immemorial.

>   drwxr-xr-x    samples         # move to Documentation/samples/

Just delete it. Best API usage samples are in modern parts of main tree,
actively maintained/updated.

>  drwxr-xr-x    scripts         # move to build/scripts/

eh

> drwxr-xr-x    sound           # move to drivers/sound/

NO! it has hw independent part and pretty big one.

>  drwxr-xr-x    tools

If tools/ people could somewhow stop duplicating large parts of include/linux
and arch/x86/include/asm it will be very much appreciated.

>  - 'block' could in principle move to drivers/block/core/ but it's fine
>    at the top level too I think.

It is fine indeed. Short name, top level dir, arch and hw independent
code -- it is perfect.

> I'm volunteering to do this (in a scripted, repeatable, reviewable,
> tweakable and "easy to execute in a quiet moment" fashion), although
> I also expect you to balk at the churn. :-)

Can I pay you $100 to not do this ever?

In Russia we say "what has grown has grown" and it is not like Linux is
perfect example of intelligent design.
