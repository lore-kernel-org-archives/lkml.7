Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D48C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A7F20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtQnQlCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfCFQSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:18:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39331 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfCFQSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:18:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id h8so8788510pgp.6;
        Wed, 06 Mar 2019 08:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0y6wNEQhnkyDxpUXBHImOgIzY9NqUw6RV4Q+u1AuA7Q=;
        b=HtQnQlCm/FdkzRSLg3KCqfWUCv/CfbRTk4UsKRNwrGA5WCaH1KIlLFwj38H0LGSgSr
         XQLy8pZNp/XdRWNzoSiXo0rz8h2kcnuYOTby+nlpDcxdBjPK7WhHAKhLyqvpguK+MmgN
         LSZF9BJLwVSLC8wKXvPdM2k3eG2nywyZyah7ZHrrOsaPDYYKjGijilseQ6AD1Pm1G8qx
         D51u3ynhRZM05keopt6SfeK9NZZ/hy9BUHi+sbvv31pLNey17p5NH2pjcQ2a1mZoAWps
         aG/v3CAADTN41GclPwTY9NVswrOBRRnqkiDQcs05ES4zleaNbzXFOaBVKsbwaBWSrT5n
         jtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0y6wNEQhnkyDxpUXBHImOgIzY9NqUw6RV4Q+u1AuA7Q=;
        b=tm5sZupPDq3+XNxGLpWbTZOY8bAnKfP1mS1OCvhkdqNbvhAa2gSWfPbwbk21EhhuD2
         BYWef738JcrALppPeKSi0D8QPslTTVJf+OsGd2EyaupLsHMopwGc4mtrSDMl85FvaQEl
         YpUu3IScsoi2ShAASY8wMXKd2eYM7bIQMk72fmBFo/qFiDXh5H8HC04eWo1xHV6b8prQ
         pTxdSD+7OWTwmPtH2H6pcO3kLwdOp51KDlbh/AA0XgHFjA+/R8yG/11KZXSSOCwCA7mU
         ZhcQQdyLxzamKizt0n2YFjmf+e494m+SsafCKy2t8+7FMyM3HzHJMk2SlLUi1o6zS1wp
         +2og==
X-Gm-Message-State: APjAAAXSdK/dEjyZaU+qAACsZG77015H1FPoxbZ+SPjWWBcaulDRZMfq
        2sE2G5RSiiCTMiG44QNieHU=
X-Google-Smtp-Source: APXvYqxyUF4i/ItcUVBn3VVOoNONSIjrNj29dTYkHt2+0iQcg3TRka8j1cxmz6dFbUTs1GmMhQD5ZA==
X-Received: by 2002:a63:2224:: with SMTP id i36mr6895284pgi.169.1551889096252;
        Wed, 06 Mar 2019 08:18:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x23sm3033927pgf.10.2019.03.06.08.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 08:18:14 -0800 (PST)
Subject: Re: [RESEND PATCH v2] of: fix kmemleak crash caused by imbalance in
 early memory reservation
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr>
 <CGME20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8@epcas3p1.samsung.com>
 <20190123055414.GA4747@rapoport-lnx>
 <78f4ea8a-996d-038e-9e33-5ff02fa2c43f@samsung.com>
 <20190123123143.GE4747@rapoport-lnx>
 <4b8f82c4-7f8f-b814-c1ec-9902e43963f6@free.fr>
 <617e0d57-342d-4162-bd21-ece18e481d87@free.fr>
 <CAL_JsqKbCg-rGmLoA3mPv54=LMuQBfevfzL8f2QPVyjN-sNk8w@mail.gmail.com>
 <20190213085028.6199594b@canb.auug.org.au>
 <CAL_JsqK-cC6oVZ9MkP+ExOGjCRhA0XxGSgqGKL3W9bFF3rKAgA@mail.gmail.com>
 <20190306021248.GA17298@roeck-us.net>
 <CAL_JsqKhhZuPi8vWXZLTip_=kLVvknvQxzVXMaKD3BB0YHOA7A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <48ccaa25-725d-e72c-391a-5a078e1c7f77@roeck-us.net>
Date:   Wed, 6 Mar 2019 08:18:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKhhZuPi8vWXZLTip_=kLVvknvQxzVXMaKD3BB0YHOA7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 5:39 AM, Rob Herring wrote:
> On Tue, Mar 5, 2019 at 8:12 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Tue, Feb 12, 2019 at 04:12:24PM -0600, Rob Herring wrote:
>>> On Tue, Feb 12, 2019 at 3:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>>
>>>> Hi all,
>>>>
>>>> On Tue, 12 Feb 2019 10:03:09 -0600 Rob Herring <robh+dt@kernel.org> wrote:
>>>>>
>>>>> On Mon, Feb 11, 2019 at 10:47 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>>>>>>
>>>>>> On 04/02/2019 15:37, Marc Gonzalez wrote:
>>>>>>
>>>>>>> Cc: stable@vger.kernel.org # 3.15+
>>>>>>> Fixes: 3f0c820664483 ("drivers: of: add initialization code for dynamic reserved memory")
>>>>>>> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>>>> Acked-by: Prateek Patel <prpatel@nvidia.com>
>>>>>>> Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>>>>>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>>>>>> ---
>>>>>>> Resend with DT CCed to reach robh's patch queue
>>>>>>> I added CC: stable, Fixes, and Prateek's ack
>>>>>>> Trim recipients list to minimize inconvenience
>>>>>>
>>>>>> I'm confused over commit 3532b3b554a216f30edb841d29eef48521bdc592 in linux-next
>>>>>> "memblock: drop __memblock_alloc_base()"
>>>>>>
>>>>>> It's definitely going to conflict with the proposed patch
>>>>>> over drivers/of/of_reserved_mem.c
>>>>>>
>>>>>> Rob, what's the next step then?
>>>>>
>>>>> Rebase it on top of what's in linux-next and apply it to the tree
>>>>> which has the above dependency. I'm guessing that is Andrew Morton's
>>>>> tree.
>>>>
>>>> Yeah, that is in Andrew's "post linux-next" patch series, so if you
>>>> rebase it on top of linux-next and then send it to Andrew with some
>>>> explanation.
>>>>
>>>> ...
>>>>
>>>> Actually, if it is intended for the stable trees, then presumably it is
>>>> intended to go to Linus for the current release?  In which case, the
>>>> patch in Andrew's tree will have to be changed to cope after your patch
>>>> appears in Linus' tree (and therefore, linux-next).
>>>
>>> At this point in the cycle, I wasn't planning to send this for 5.0.
>>> It's not fixing something introduced in 5.0 and it is a debug feature.
>>>
>> Hi Rob,
>>
>> this may be a debug feature, but we do test our kernels with it enabled,
>> and the problem does affect our 4.19 branch (chromeos-4.19). Are you
>> suggesting that we should backport the fix into our branch and not send
>> the backport to -stable ?
> 
> No, not at all. Just that I wasn't going to add it to the probable
> last 5.0-rc and would wait.
> 
> However, it's complicated by other memblock changes in 5.1 and not a
> trivial backport. One of the versions on the list should be easier to
> backport than what's in mainline (or going to be).
> 

We went ahead and applied a backport of an older version of the patch series
to chromeos-4.19. We'll see how well that works, but so far it looks like
it fixes our problem.

Guenter
