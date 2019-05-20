Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA26C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6A821773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ThBjJUeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389918AbfETQez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:34:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44478 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388110AbfETQey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:34:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id e13so13051876ljl.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dm71IPzdf9bSAV3nM8R6Sk0Nq2dH179jF68Ta8My++8=;
        b=ThBjJUeVm1/N9bp3Lj3TE8ok6QxXVgE/AyFDhqJ/6JeQfw6MkgGJIhElLTD5z8Iq/q
         3pXCYtXra4Lo21mkbX3EpqgYaQImOKH6CIsHawfbEKHPRPxg11w/3UFe06SYnwdncDG9
         Z3QNsLFaHcp2JcNzx95qCs4LyfvIP8ye9xxyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dm71IPzdf9bSAV3nM8R6Sk0Nq2dH179jF68Ta8My++8=;
        b=lzreRk2WH6y2buOAldhGdckS6dkI+VVO5DfJLVcTfNB9PKndNtHz5UALmrWuwgj6KO
         k/FPHx+BH0C/f2jx3THm90/452Gccr/8x/ae1l8+OYQNASZw9QzVGzxFKH72PuruC2QX
         3a9LrhwfHexmDRhgKFAQQ/hflMY/pNcLZgBC7JAwkBGph02zrLXqzateaOZDAAhZ+4oU
         14G0NbrUl/k6CY7vCi1T71LC57YJTXdcw8i4xF3fqkvjnFStk4TVmQDvQOHp6C5pavxR
         07gvQsVvQMfERbd1ayFLjNihOBN1V6BvNp16lRNitvolknj5T5Cpi9BCZg7lSsD3oj4u
         Y9Qg==
X-Gm-Message-State: APjAAAVdfh6AODAsvKCCCxvvUVE8OUKNbh9mnAASKIoO2VqNR+pKJ5PH
        kcIleFn2JIIjey0R4EL1nMOqEhAkA6A=
X-Google-Smtp-Source: APXvYqyCUfkrTtmo0uUGn5jh6xZ6BMmTrE5jOztb1rLJlZtDCRx5/bxj+xyChPM9uOAgQtZWj0VkmQ==
X-Received: by 2002:a2e:96da:: with SMTP id d26mr28454451ljj.9.1558370092543;
        Mon, 20 May 2019 09:34:52 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id w3sm3396598lji.19.2019.05.20.09.34.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 09:34:51 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id q62so3595067ljq.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 09:34:51 -0700 (PDT)
X-Received: by 2002:a2e:860a:: with SMTP id a10mr27599016lji.158.1558370091351;
 Mon, 20 May 2019 09:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-10-elder@linaro.org>
 <CAK8P3a0eYWN6mMwft5OSu8wQQo=kWh5safGFFNkDCELZJyiMmQ@mail.gmail.com>
 <14a040b6-8187-3fbc-754d-2e267d587858@linaro.org> <CAK8P3a37bPRZTHZcrg8KrYRLAhCr9pk8v4yuo_wSyUONs2OysQ@mail.gmail.com>
 <4a34d381-d31d-ea49-d6d3-3c4f632958e3@linaro.org> <dcd648f2-5305-04dd-8997-be87a9961fd9@linaro.org>
 <CAK8P3a0FfSvTF8kkQ8pyKFNX9-fSXvtEyMBYTjtM+VOPxMPkWg@mail.gmail.com>
 <d3d4670f-eb8b-7dcf-f91a-1ec1d4d96f67@linaro.org> <CAK8P3a12+3a-p2pNuQrJu01dOJJuCoQ4ttt=Y0g97wTtBmQO5w@mail.gmail.com>
 <8040fa0e-8446-1ec0-cf75-ac1c17331da5@linaro.org>
In-Reply-To: <8040fa0e-8446-1ec0-cf75-ac1c17331da5@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 20 May 2019 09:34:14 -0700
X-Gmail-Original-Message-ID: <CAE=gft4ZkO+cGMNEt05+Xw=pEoR7gzJ4jBRB9wA0gQ7V=Pag6g@mail.gmail.com>
Message-ID: <CAE=gft4ZkO+cGMNEt05+Xw=pEoR7gzJ4jBRB9wA0gQ7V=Pag6g@mail.gmail.com>
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

On Mon, May 20, 2019 at 7:44 AM Alex Elder <elder@linaro.org> wrote:
>
> On 5/20/19 9:43 AM, Arnd Bergmann wrote:
> > I have no idea how two 8-bit assignments could do that,
> > it sounds like a serious gcc bug, unless you mean two
> > 8-byte assignments, which would be within the range
> > of expected behavior. If it's actually 8-bit stores, please
> > open a bug against gcc with a minimized test case.
>
> Sorry, it's 8 *byte* assignments, not 8 bit.    -Alex

Is it important to the hardware that you're writing all 128 bits of
this in an atomic manner? My understanding is that while you may get
different behaviors using various combinations of
volatile/aligned/packed, this is way deep in the compiler's "free to
do whatever I want" territory. If the hardware's going to misbehave if
you don't get an atomic 128-bit write, then I don't think this has
been nailed down enough, since I think Clang or even a different
version of GCC is within its right to split the writes up differently.

Is filling out the TRE touching memory that the hardware is also
watching at the same time? Usually when the hardware cares about the
contents of a struct, there's a particular (smaller) field that can be
written out atomically. I remember USB having these structs that
needed to be filled out, but the hardware wouldn't actually slurp them
up until the smaller "token" part was non-zero. If the hardware is
scanning this struct, it might be safer to do it in two steps: 1)
flush out the filled out struct except for the field with the "go" bit
(which you'd have zeroed), then 2) set the field containing the "go"
bit.
