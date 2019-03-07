Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292DBC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27AF20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dizeQpbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfCGU2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:28:50 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34593 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfCGU2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:28:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id a16so14620610edn.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 12:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1LPdf3y43zhQ0TvL2EL2y29iS9cjigfcplA9kzrqzsA=;
        b=dizeQpbxh2WrRAo5c9fi8kqq/UV8oTVr0EOF3EMjzfaTadRRqzC8j/FuUdYidLbLRd
         rDA7lvHNPt/XmJHi1wVx1EF4eR9pe+Vt1jvcxYmdAQtBeXgGRYVByoc/vAsOm/g+4jwD
         QCuLLF+SDhz9YujP3N1tTeQuANUmKKi6qTiR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1LPdf3y43zhQ0TvL2EL2y29iS9cjigfcplA9kzrqzsA=;
        b=YdxRfD6rC5s26oOJQ0en0BuJJc6lBpN2YyDit+eAAsapZhqyR5Pykl8AgmU1do850j
         ChySxOi1HUbAt3Z+DC0gN8REDnYTmZ5h2h1wkUbyE9zqXQGxR0lGxVSXtBBPjeZHMFIt
         jXKSTuFKX+6tCioNs4Y/UOExcbrjBJyuIUdPQsys7PsvZCIlORN8u/djhPqPkDDOEntr
         Iz5uKFMI2n5OAVp5upE4G079Ow3CO/afFCcSEJzXCGRIMv4KituCnO0x8/jCkNuyT2Sg
         OroIRIgnxvib4P8HcBqzvUVFQT0kZ1tpgGoCG2JpLyrq9La6zfyAsKpErfZVP/kh/Lvo
         PGfw==
X-Gm-Message-State: APjAAAWnaXzACTM5AEVLf/nbkKT8CLDFD2yMwR90dgfVzi8mtutkf6Vj
        PLLOO1Grqh2jpa0qXEn2BwZZuQ==
X-Google-Smtp-Source: APXvYqwSsZM384DjGyOiGddgXelpP+I1myG7fYhZl80TW0twsdKiPFXxteocKFLcjBtDqxFEiGh38A==
X-Received: by 2002:a50:c984:: with SMTP id w4mr29625804edh.272.1551990527576;
        Thu, 07 Mar 2019 12:28:47 -0800 (PST)
Received: from [192.168.1.149] (ip-5-186-117-145.cgn.fibianet.dk. [5.186.117.145])
        by smtp.gmail.com with ESMTPSA id d47sm1634718eda.77.2019.03.07.12.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 12:28:46 -0800 (PST)
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
To:     Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@mellanox.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20190307010153.81157-1-bvanassche@acm.org>
 <20190307012417.GU1758@mellanox.com>
 <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
 <20190307072428.GJ1789@mtr-leonro.mtl.com>
 <4d90c392-5b6a-fea0-e6cf-c49ac19fdf30@acm.org>
 <20190307154020.GN1789@mtr-leonro.mtl.com>
 <CAGXu5jLBPpKOT-NV1P0nuFeSQYfoNY_8B0V4gcQg18xHPUVbhQ@mail.gmail.com>
 <20190307170230.GR1789@mtr-leonro.mtl.com>
 <CAGXu5jJDmEFA7=WuDnr0U6t9BTDFtd_WsB5HeryNKoZSaBW8oA@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <926da814-b21d-d01d-d0bb-6304bf545218@rasmusvillemoes.dk>
Date:   Thu, 7 Mar 2019 21:28:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJDmEFA7=WuDnr0U6t9BTDFtd_WsB5HeryNKoZSaBW8oA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2019 18.12, Kees Cook wrote:
> On Thu, Mar 7, 2019 at 9:02 AM Leon Romanovsky <leonro@mellanox.com> wrote:
>>
>> On Thu, Mar 07, 2019 at 08:52:51AM -0800, Kees Cook wrote:
>>> On Thu, Mar 7, 2019 at 7:40 AM Leon Romanovsky <leonro@mellanox.com> wrote:
>>>>
>>>> On Thu, Mar 07, 2019 at 06:53:54AM -0800, Bart Van Assche wrote:
>>>>> On 3/6/19 11:24 PM, Leon Romanovsky wrote:
>>>>>> My simple patch passes too :).
>>>>>
>>>>> Can you repost your patch?
>>>>
>>>> https://patchwork.kernel.org/patch/10841079/
>>>>
>>>> As Rasmus wrote, the thing is to avoid a < 0 check. In my patch,
>>>> I converted a <= 0 to !(a > 0 || a == 0) expression.
>>>
>>> I'd be happy either way. Is there a larger benefit to having a safe
>>> "is_non_negative()" helper, or should we go with the minimal change to
>>> the shl macro?
>>
>> I personally prefer simplest possible solution.

So, I played around with a few variants on godbolt.org, and it seems
that gcc is smart enough to combine (a > 0 || a == 0) into (a >= 0) - in
all the cases I tried Leon's patch resulted in the exact same generated
code as the current version. Conversely, and rather surprising to me,
Bart's patch seemed to cause worse code generation. So now I've changed
my mind and also support Leon's version - however, I would _strongly_
prefer if it introduced

#define is_non_negative(a) (a > 0 || a == 0)
#define is_negative(a) (!(is_non_negative(a))

with appropriate comments and used that. check_shl_overflow is hard
enough to read already.

Rasmus
