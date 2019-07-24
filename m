Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23B8C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CBD21738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPVBip25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfGXMgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:36:37 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38959 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfGXMgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:36:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so45239328qtu.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=voVat0+SUGB52qvYfXcNdUtGtc1hBZGuRMC7BUlflBk=;
        b=OPVBip25a2WbO9ODN0MyghyJIILAB6LukDE8UAmEorbY0N4kgLUY2uNRwi3FZ94Tq2
         WVZJ27BVRqUFrwGrF7y3xRswPREKSy4ENkQABk4SMMM8MKReM5GAVLHzjRa+L0qk3ABJ
         oiMqnhzbp0/PJlMk5iRCEveK469FircUOR20RtoiHnlPymUhZmCBxeTDQcGdLBqY9U0C
         QCeLWleFpBFgm4lxQB3TLR9YLleAbu4NeFpgw94cGEwIqvbF0rK95tuKMkws8StrO+3/
         e0PZIk2OoGm6E6dK1TYc1vNFRx6SDnVY4fMxm1fKkEHEmR58mbCgEU3QOT0f4JgMAuQ0
         TzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=voVat0+SUGB52qvYfXcNdUtGtc1hBZGuRMC7BUlflBk=;
        b=kZeJk4emNbHczedjMA1o5HFbCyPQWBOpm173uZEOUOueRfkmXBq65/ZRgIEIFpa0h1
         j5wtAH0nytP61RA5ebmfveYGkM1PYCDuZKOyCenlR3Wsd3Bjim7e6UXsrsE2DXNIQvJg
         ZHXPGOaWlWTwi1dnCOc9PQaFFP2uGP8SF8pkygBRtTIMXhQRvv0dZz3YyYe9QG2HU6GP
         U4HgfHRdNET8JuzJxGvfJQR1lh47eI9WUL+t42+wqWnbpm3quA/9CrZefUVqCNA4oXBF
         dnyY3KK1KO5YQHoem4maookWJlzLaE4aAlYKsH1GccC/2Ex8h15ldc/InvsMU6gnDm/Y
         GGlA==
X-Gm-Message-State: APjAAAV/LzYIkceGaw4nG8LTpPHwUxj3coOa9HobD4LHzPm8fXhTyCgJ
        NKCmy3bjQUZ3zZmhJl8hJPC0OQ8l6onbrapyzpY=
X-Google-Smtp-Source: APXvYqweMQQSqCE1gaCRnyucL3mpNVOzYSXi/vtTRECBlg3dbrAT8Icq4DwJgDvi+7/kFYQu2Om5YYbah/bQgvHXyQI=
X-Received: by 2002:a0c:b159:: with SMTP id r25mr57272575qvc.219.1563971794304;
 Wed, 24 Jul 2019 05:36:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:4144:0:0:0:0:0 with HTTP; Wed, 24 Jul 2019 05:36:33
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.9999.1906281147260.3867@viisi.sifive.com>
References: <1556093512-5006-1-git-send-email-liush.damon@gmail.com> <alpine.DEB.2.21.9999.1906281147260.3867@viisi.sifive.com>
From:   sh liu <liush.damon@gmail.com>
Date:   Wed, 24 Jul 2019 20:36:33 +0800
Message-ID: <CADnCVLwL0DK0Xa8FHhxCyqpJNU3Az=Xvdr3_MqA85ju_nUBZDg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: redefine PTRS_PER_PGD/PTRS_PER_PMD/PTRS_PER_PTE
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     palmer@sifive.com, sorear2@gmail.com, aou@eecs.berkeley.edu,
        anup.patel@wdc.com, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the previous description is unclear, and it is difficult for
readers to understand the meaning of these macros, because I never
understand. So I submitted this patch with reference to the definition
of arm. I think this way can make the reader easier to understand, and
I also think that this definition is more reasonable.

2019-06-29 2:52 GMT+08:00, Paul Walmsley <paul.walmsley@sifive.com>:
> On Wed, 24 Apr 2019, damon wrote:
>
>> Use the number of addresses to define the relevant macros.
>>
>> Signed-off-by: damon <liush.damon@gmail.com>
>
> This patch looks reasonable to me.  But what's missing from the
> description is the motivation.  Is this a prerequisite for another patch
> that you're planning to post?  Or because you think this is clearer than
> the original?  Or something else?  etc.
>
>
> - Paul
>
