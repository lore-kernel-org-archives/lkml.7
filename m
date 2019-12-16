Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED848C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2866207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="z9FknNNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLPJRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:17:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36649 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfLPJRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:17:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so5849738wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 01:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ympWuvVHTsyQisGFsJE6wNDGlF/BBCJa5n1XjqeTn0M=;
        b=z9FknNNfh6oxBP9msMi4VEbjlqa3qy68J30GAW/tCYFxV0uy+7uMZCI0ZHCwEHt6YK
         c/ahqRY/6HR5sEG+IJJTGcnUaYKMALkFB5dCK29eKZ0Ikn98GTodFNyjGLt+HrBxmDjI
         Sji6eAmYkZ2bbpv6YY+V43m2n5vLUxb7JrWmuALxEJBKxBuRQwChomjkSofJhs/Rvihf
         Cv2KA2orkiR8gADcIBF7nIYrJLpHR/l1bjkp3eBCoojaycERuYNaAAzaJasrQylpp/Lf
         1YfUdVv6KT3wMuK8k7KLM+hx8sFJ72qZQxYOMBeq+HNmi982jr8wro9euBnzO7fTq1rw
         5mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ympWuvVHTsyQisGFsJE6wNDGlF/BBCJa5n1XjqeTn0M=;
        b=G/Z7Q8f36rCW2x0FdEan9dmDhKieihO6ge68hXW8nAPD4o/6VnKLIAHzeJ6JR1FnAr
         JqIZXmXrK8QsMB3ZPRUAWc8CU7UVAxnIVCtggun0J/lCknEbECy2ySudI5mighGWlcxf
         iIQccZfid4RbweBv6C3uVz96Ferp3KWQtzMLUKULaLyOdkHXV2NJK5icddlF/2lRlW4O
         cIQvgnq2cdoaDk9ntZ9jfmeEFmYUcKfkHEubxg64iOUNBipNUbBKPnGqryYmx0MaomGt
         sPl6/AtVV9um1Tf6RA2RsYnE4/KeEbKBSrjp3I8ehaNoPhxCm7zVWHwi3HAdu7gGd+T+
         u9uw==
X-Gm-Message-State: APjAAAWEX29dohs8IpTHoMvGioB53h2tfJEXOpKo9A4LEdNaSlsvWEX3
        H5s1SkWtk3DWkjsFIU+NdRT7Eg==
X-Google-Smtp-Source: APXvYqzU8Tsr5oYK5LGn7OcfoU1jW/4JBvMiYIGT9Wfohalc0a4Io77U2njn9tjcLYyBn3aCc5QqIg==
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr28670265wmg.170.1576487848048;
        Mon, 16 Dec 2019 01:17:28 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id n67sm20894797wmb.8.2019.12.16.01.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 01:17:26 -0800 (PST)
References: <20190924123954.31561-1-jbrunet@baylibre.com> <1jv9r27kzn.fsf@starbuckisacylon.baylibre.com> <20191203090516.1A03B20661@mail.kernel.org>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] clk: let clock perform allocation in init
In-reply-to: <20191203090516.1A03B20661@mail.kernel.org>
Date:   Mon, 16 Dec 2019 10:17:25 +0100
Message-ID: <1jpngobpei.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 03 Dec 2019 at 10:05, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Jerome Brunet (2019-11-29 07:36:28)
>> 
>> On Tue 24 Sep 2019 at 14:39, Jerome Brunet <jbrunet@baylibre.com> wrote:
>> 
>> > This patchset is a follow up on this pinky swear [0].
>> > Its purpose is:
>> >  * Clarify the acceptable use of clk_ops init() callback
>> >  * Let the init() callback return an error code in case anything
>> >    fail.
>> >  * Add the terminate() counter part of of init() to release the
>> >    resources which may have been claimed in init()
>> >
>> > After discussing with Stephen at LPC, I decided to drop the 2 last patches
>> > of the RFC [1]. I can live without it for now and nobody expressed a
>> > critical need to get the proposed placeholder.
>> >
>> > [0]: https://lkml.kernel.org/r/CAEG3pNB-143Pr_xCTPj=tURhpiTiJqi61xfDGDVdU7zG5H-2tA@mail.gmail.com
>> > [1]: https://lkml.kernel.org/r/20190828102012.4493-1-jbrunet@baylibre.com
>> >
>> 
>> Hi Stephen,
>> 
>> Do you think we can fit this into the incoming cycle ?
>> 
>
> Sorry I missed this one. I'll apply it soon but won't be for this merge
> window.

No worries, I was referring to the v5.6 cycle, not the v5.5 merge
window. 
