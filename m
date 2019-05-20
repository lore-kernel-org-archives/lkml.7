Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F64BC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A0C214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GcPGlfCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393005AbfETRhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:37:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44227 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392771AbfETRhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:37:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id e13so13232570ljl.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZ9wE683n0C5yjhKbdgsiksRQ/utvzytcQ5/oroGBgE=;
        b=GcPGlfCiiLFvcvLs7/DCm9x1vt1/0qPmXgvBx7BD9BV9b9oigsJ1qQB+Gbw1WZfUp0
         qKzGm2GiJju8+CTNepHC4vdaBxNIuf+jNEQBgONdxeHuZMqFAZ9cnVdeK7cpgsihc7bx
         EqPKrLU4zdN2ITMKq/h+DoJvKHiL0LudPLqvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZ9wE683n0C5yjhKbdgsiksRQ/utvzytcQ5/oroGBgE=;
        b=EqY/NBuerlad99msst5pd83V13IhGbm/3eA22nPyH9qqPmEXBoz9bMO6DJijYcN1sp
         Co4X9rwoMeJpz7UIv2DxYYQN9+ohm/klY0qjUhZKhDP+BI0ft5kwM++WZxnOs+K1spJn
         lJVWRhs1WiUJqVGjaoHfTvi9rNySBOTN5Js3Y3+MylydW3BGzwmc7wlrh+iepY5bFZMB
         dDq9WNz7uER0UYT03FgPGcsOm8EKjNNghfXcG65lk+Ez06xFJClYvij250uaOeODj7wt
         dmDkaIJymgXi92DMXD/tU2pXUrNvTHeEbskznN7/8UT+Pqw7Tkqoo1gduZRsujAI7L2C
         fH7w==
X-Gm-Message-State: APjAAAXvh2yUqPsPb+NkWchnMVJuo/s2zjcaUe2vtxb8qzhHssCp6seC
        0D6ihq7DVLmAALfXyKAaH/1FrqE6iZM=
X-Google-Smtp-Source: APXvYqyfyx/8L4WNZEw8vxpcyz+ai03XdOeBAv7qoVX+9dkiDlpgxydHSHjJDb2tOodr+IFwLyQ/gA==
X-Received: by 2002:a2e:b0da:: with SMTP id g26mr20510546ljl.161.1558373827805;
        Mon, 20 May 2019 10:37:07 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id q124sm3872240ljq.75.2019.05.20.10.37.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 10:37:06 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 188so13238824ljf.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:37:06 -0700 (PDT)
X-Received: by 2002:a2e:8956:: with SMTP id b22mr32405874ljk.134.1558373826185;
 Mon, 20 May 2019 10:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-10-elder@linaro.org>
 <CAK8P3a0eYWN6mMwft5OSu8wQQo=kWh5safGFFNkDCELZJyiMmQ@mail.gmail.com>
 <14a040b6-8187-3fbc-754d-2e267d587858@linaro.org> <CAK8P3a37bPRZTHZcrg8KrYRLAhCr9pk8v4yuo_wSyUONs2OysQ@mail.gmail.com>
 <4a34d381-d31d-ea49-d6d3-3c4f632958e3@linaro.org> <dcd648f2-5305-04dd-8997-be87a9961fd9@linaro.org>
 <CAK8P3a0FfSvTF8kkQ8pyKFNX9-fSXvtEyMBYTjtM+VOPxMPkWg@mail.gmail.com>
 <d3d4670f-eb8b-7dcf-f91a-1ec1d4d96f67@linaro.org> <CAK8P3a12+3a-p2pNuQrJu01dOJJuCoQ4ttt=Y0g97wTtBmQO5w@mail.gmail.com>
 <8040fa0e-8446-1ec0-cf75-ac1c17331da5@linaro.org> <CAE=gft4ZkO+cGMNEt05+Xw=pEoR7gzJ4jBRB9wA0gQ7V=Pag6g@mail.gmail.com>
 <fa83020a-248c-9686-5a90-81923fe843bb@linaro.org>
In-Reply-To: <fa83020a-248c-9686-5a90-81923fe843bb@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 20 May 2019 10:36:29 -0700
X-Gmail-Original-Message-ID: <CAE=gft6mdbNZxCAUweP7ppEyfqVGBPwzBNukWJcdte53EoDbRQ@mail.gmail.com>
Message-ID: <CAE=gft6mdbNZxCAUweP7ppEyfqVGBPwzBNukWJcdte53EoDbRQ@mail.gmail.com>
Subject: Re: [PATCH 09/18] soc: qcom: ipa: GSI transactions
To:     Alex Elder <elder@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 9:50 AM Alex Elder <elder@linaro.org> wrote:
>
> On 5/20/19 11:34 AM, Evan Green wrote:
> > On Mon, May 20, 2019 at 7:44 AM Alex Elder <elder@linaro.org> wrote:
> >>
> >> On 5/20/19 9:43 AM, Arnd Bergmann wrote:
> >>> I have no idea how two 8-bit assignments could do that,
> >>> it sounds like a serious gcc bug, unless you mean two
> >>> 8-byte assignments, which would be within the range
> >>> of expected behavior. If it's actually 8-bit stores, please
> >>> open a bug against gcc with a minimized test case.
> >>
> >> Sorry, it's 8 *byte* assignments, not 8 bit.    -Alex
> >
> > Is it important to the hardware that you're writing all 128 bits of
>
> No, it is not important in the ways you are describing.
>
> We're just geeking out over how to get optimal performance.
> A single 128-bit write is nicer than two 64-bit writes,
> or more smaller writes.
>
> The hardware won't touch the TRE until the doorbell gets
> rung telling it that it is permitted to do so.  The doorbell
> is an I/O write, which implies a memory barrier, so the entire
> TRE will be up-to-date in memory regardless of whether we
> write it 128 bits or 8 bits at a time.
>

Ah, understood. Carry on!
