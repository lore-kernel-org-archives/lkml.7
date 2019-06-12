Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CAFC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F66A208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bgeq2ssJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbfFLU7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:59:00 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:37823 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfFLU7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 16:59:00 -0400
Received: by mail-qt1-f175.google.com with SMTP id y57so20118648qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 13:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpxGxrwLui1lSDTmJKUbxcTbMlSKvKe6lFF2VkrV7wc=;
        b=Bgeq2ssJOl4KRUJZ/YYuZYifZz4SPfb61vn7mgrpgLEtJrbw7UL2HllH9RuIAhvBc/
         4wa8l2XuDtsAX4C+DBwmjonICF37ytoz+sFx9uTuzUTINM2A28pgNslM6/r84QppokS9
         0RneN+EgwvoLzudMg1QHndgQE/ySrBRendHBXCJdAN0oCYagYFFyrkcjYkwAH5ArHCsK
         uKOxkcPvnYeZws0BajXNU1s5XpP9DNPRgJkrIJcAzQiEepSCo2iymqIsXWZ03ib2gYrV
         HjAVAjdWQnQ4KfKyMTjgP5iAJOuUzhAzA+uIExOC9bwFEVQtk7gcUubBjjCxAGhSp///
         Rsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpxGxrwLui1lSDTmJKUbxcTbMlSKvKe6lFF2VkrV7wc=;
        b=hP6c+poTdXvVmDrOV7WVCNIwaNFmxUYnYlIBZVMb8dx+GVOPZfZIpQJ9dt+K6ittsg
         nFDTfQyaT/hu3Jxo7pjyaXwzjJISCSimI5PQKeZFocABmWgF6tRd+AHdnpxrT/dTtp0h
         AlaVn48VJejFlw9cET7EFfgJj9DvY7NU99Mrg3NQnfhMl/E7wiZiRyPZGAsHU7XhFS7K
         +gjTBu9yKBni+unkLE22NkGCm57vSE0ySdzqRI8JgGOWDa5fhmEeXtgURtIPUrUd+3+n
         034c4QbD6p48JAq2f4duGwu8IjsXhdoDW2hYjatT0vNgekGv0IKiVS220RYJ6atsvc+E
         RSBw==
X-Gm-Message-State: APjAAAWp/brA+6V8O9qdeIkGyb/1mJOfS+2hUn4yr2qMGRMicKlCwMKa
        WcdvAYG+APFbzz92vt4jPjwgb3XNOYcfWLqT3myF2Evm
X-Google-Smtp-Source: APXvYqy0D37AjG7HTqHSdJtRmzXnniFyYc7Uxzc33HOtx5bjlINXNBzJgXNK/qoAiHqOW//ymXmd8JPsKP28mtSHN/w=
X-Received: by 2002:ac8:5407:: with SMTP id b7mr65664688qtq.48.1560373139166;
 Wed, 12 Jun 2019 13:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
 <1556637058-22331-1-git-send-email-dnlplm@gmail.com> <000c01d52147$e33147f0$a993d7d0$@codeaurora.org>
In-Reply-To: <000c01d52147$e33147f0$a993d7d0$@codeaurora.org>
From:   Daniele Palmas <dnlplm@gmail.com>
Date:   Wed, 12 Jun 2019 22:58:48 +0200
Message-ID: <CAGRyCJGFKf4q5yCV2ntZabU0ct8pfUKvN6x6L2A5C2U+g25nkw@mail.gmail.com>
Subject: Re: MHI code review
To:     Sujeev Dias <sdias@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, truong@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sujeev,

Il giorno mer 12 giu 2019 alle ore 19:54 Sujeev Dias
<sdias@codeaurora.org> ha scritto:
>
> Hi Daniels
>
> Sorry for delay response.  Yes, we will be pushing new set of series very
> soon that will have support for 55 as well.  The series that's pushed should
> already work for SDX20, 24 and 55.   There are some new features related to
> 55 that's not yet in series.
>

great, thanks for the update! I'll wait for you new patch-set.

Thanks,
Daniele

> Thanks
> Sujeev
>
> -----Original Message-----
> From: Daniele Palmas <dnlplm@gmail.com>
> Sent: Tuesday, April 30, 2019 8:11 AM
> To: sdias@codeaurora.org
> Cc: linux-kernel@vger.kernel.org; truong@codeaurora.org; dnlplm@gmail.com
> Subject: Re: MHI code review
>
> Hi Sujeev,
>
> > Hi Greg Kroah-Hartman\Arnd Bergmann and community
> >
> > Thank you for all the feedback, I believe I have addressed all the
> > comments from previous patches. Also, I am excluding mhi network
> > driver in this series. I still have some modifications to do.
> >
> > Please review the new patch series and share your feedback.
> >
> > Thanks again
> >
> > Sincerely,
> > Sujeev
>
> are you going to continue working on this series?
>
> Can this series be used with PCIe SDX20/24/55 based modems?
>
> If yes, it would really be important to have this integrated into an
> official kernel.
>
> Thanks,
> Daniele
>
