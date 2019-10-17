Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB81FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A58421835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CggdjClI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437257AbfJQQA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:00:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38229 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394068AbfJQQA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:00:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so3111725wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=K92xI+/RkXkPNl+cGfvbqFzqM/p/1yJ006GVWjx3IVs=;
        b=CggdjClIWcSoRXgef5gv0ShuIOG24Za8FzwWf9E4ClyF7n+mPqXeJ+FYEV/bIW1lnx
         nAc/I/Iq4ZR73NYNSACNxdqyFO39HgzTtoQT/r5XTknAPVFalD3lDMOvpaxTbAQJTp+w
         us20Uh8RDWgTOgAD0JxhShJoOFBAidBAO5YK6k3Y0ynId+jEVP9jeQgHk+FBqiuPezbE
         SQfo1I0Q2muik78pHRAXWiFsoKyGUMi9pg/ZCDOgNOiBeF2Awq/HcccVeXQKOtlbWCvO
         oxPi6LgaOFvLUEmQdOOuqwqw806kCTizmxPdN53ELPDSOdUt3b7sh5t2h33BzZoGGYj5
         t3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=K92xI+/RkXkPNl+cGfvbqFzqM/p/1yJ006GVWjx3IVs=;
        b=FVYEijYUrltrM+iz7gki6PuVgH4RBFOeHrKfYoKiQ+sun0ZDnH4tNRCQoOTtwLlbNP
         8ZlhKwBKHjP3wfSGjjDLYeRFx4gfZmB6L03XQbUP6bghnWEF8BWL2obJ8+/GS6YpCaex
         XUTlmbFycwhDn0ml/ARnsFZ+lPtSTQ911IMJ8jD9sn6G2TZZ37dc2rJ2odfe8tggFYFA
         OzF/ieQM663SsLxKVNVIqP8o+aHyZ1TfbhRbHjsGSWZSqLebTE7iAyx3+b9o+tKXI1ZD
         3Ol+7XBTfUCVD2nzhrNRvcSwjDl9umyXCHKn2ldmBlnzHWJQbzbH0Pg5AuF6tqp1p4br
         YABQ==
X-Gm-Message-State: APjAAAVW9pboaoWlFP6V+ZrFAST+3c/xace2aBSxJO+RYNsuj8lnSiD7
        vDl7pct0HMN0QVpSxsOmBj1JAw==
X-Google-Smtp-Source: APXvYqxU9x5KGD/Ua0mSg1w0b4PXk+F6jDtTrWq3r+9vIpk0bZLy8thz/z4qpoSUhgJ4QRtxB4X/Jw==
X-Received: by 2002:a1c:20d8:: with SMTP id g207mr3538145wmg.79.1571328023876;
        Thu, 17 Oct 2019 09:00:23 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z13sm2538882wrq.51.2019.10.17.09.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 09:00:22 -0700 (PDT)
References: <20191009082708.6337-1-jbrunet@baylibre.com> <7h7e54hdif.fsf@baylibre.com> <7ho8ygfxo7.fsf@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: meson: sm1: add audio support
In-reply-to: <7ho8ygfxo7.fsf@baylibre.com>
Date:   Thu, 17 Oct 2019 18:00:21 +0200
Message-ID: <1j1rvb2wh6.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 16 Oct 2019 at 18:43, Kevin Hilman <khilman@baylibre.com> wrote:

> Kevin Hilman <khilman@baylibre.com> writes:
>
>> Jerome Brunet <jbrunet@baylibre.com> writes:
>>
>>> This patchset adds audio support on the sm1 SoC family and the
>>> sei610 platform
>>
>> Queued for v5.5.
>>
>>> Kevin, The patchset depends on:
>>>  - The ARB binding merged by Philipp [0]
>>>  - The audio clock controller bindings I just applied. A tag is
>>>    available for you here [1]
>>
>> I've pulled both of those into v5.5/dt64 so that branch is buildable
>> standlone.
>>
>> Thanks for details on the dependencies.
>
> Just noticed that all of these had "meson" in the subject instead of
> "amlogic".  Fixed up when applying.

From what I can see in the git history I have always used
"arm64: dts: meson:" in the subject.

Did we decide to that change this recently ?

If so
 * Sorry I missed that discussion
 * Should MAINTAINERS be updated to grep on "amlogic" as well as "meson" ?

>
> Thanks,
>
> Kevin

