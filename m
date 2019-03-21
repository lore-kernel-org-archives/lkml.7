Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8BEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D199221900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjOy6GC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfCURUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:20:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40016 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfCURUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:20:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id u9so4635229pgo.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKdLEwDmDwggC4Pma1A8YJs0L4iqB8H/SQFNLYqGBRg=;
        b=hjOy6GC3EjWFP6FN+ECYxEfMQvdTvpbjQ9/If5pNvPyNeMQNICOMyxNtC6oUy4d191
         kZ8bJeLA2dniYI9awuuybeIyjZ/XOiAtHyTZis4+pPGle8CdwY82yehF+iMwHekMC/rz
         FfXExcYbIHKfadIulXwh1QepN2x2/j3wJWNa5kBdYvOq6SMXpYxukJjqAOXifgJU4s6q
         WvOBrt5/9u4rFfIcXUPpJyHgxwtsfX/rX/RRckZcRyq49ZSK8w5Hja3uNRXSTLEoFB/r
         QCcBJP2DWN6gBD3Y9synDezYin9OW9hkGTCqYxcQdf9Jp6XIvYlD2Icippws3mY8xCE3
         th+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKdLEwDmDwggC4Pma1A8YJs0L4iqB8H/SQFNLYqGBRg=;
        b=HgW731cxlaKys+jruVBo7fnbwxxuDi7MJReD05K7+cOuRVQ123I4y3aSROvF/knMHP
         vXMrZRHpUg+IyDk9EV5jJcQZcyUcN6b252WrJlkNy4bKn6GA6/dhLnLJsaHO8UuKnu80
         Y+vFfVh+dKqJ1wA+CbLIk6XvSrNjNZ2DtCIE8igQV/lbevDdoBfxFhOqBfXsg3a3tkrQ
         ZJZ/UlMrjgklFuz7CPP6yzEZmqUTU+GnaVlLfS275wDMaKQiIfP+4eIzVopdp0YpqgE9
         xthJGxZ1SfKTlsYZVDC2Q9Cpd9ibX3AkkhgZjYclgc+fGaP8q6uKyH0YjTZcrUelEStI
         M80g==
X-Gm-Message-State: APjAAAVHfAs9BqWcHZNNly9fcACClQk6glfyY3uJVOeS7ELzP8nAus8O
        F8vX2/4epB38L7hzNN47iFHNCEXblx/dVQ52YclG2Q==
X-Google-Smtp-Source: APXvYqyNl+QD7r11AZXYqW9wLSMJ1ExHhPzxXxAKk+l5slPpm6kirbsm8zLb8cv9Cw4fHxYUWGbbTgDGCq/DcZSLKM0=
X-Received: by 2002:a17:902:8e82:: with SMTP id bg2mr4697126plb.217.1553188831072;
 Thu, 21 Mar 2019 10:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <7549EE7E-4172-467D-815A-63664A33D410@goodmis.org>
 <20190313211335.165605-1-ndesaulniers@google.com> <20190320191135.e49e976a8258c8ac0bb428c9@linux-foundation.org>
 <CAKwvOdn84HNEB3u4XO-V_+c=txmDd1061G_7K0zZVS4MfF--Lg@mail.gmail.com>
In-Reply-To: <CAKwvOdn84HNEB3u4XO-V_+c=txmDd1061G_7K0zZVS4MfF--Lg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 21 Mar 2019 10:20:18 -0700
Message-ID: <CAKwvOd=pJQ=SNJPSJjKZN+MY1P1gBjzT1V84T0rxV8ue9gC3xw@mail.gmail.com>
Subject: Re: [PATCH v4] lib/string.c: implement a basic bcmp
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     clang-built-linux@googlegroups.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 10:02 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Mar 20, 2019 at 7:11 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > I guess we should backport this into -stable so that older kernels can
> > be built with newer Clang.
>
> Ah, you're right.  I always forget.  Is it too late to add
>
> Cc: stable@vger.kernel.org
>
> to the patch in your tree?

Just noticed now. Thank you for adding it!
-- 
Thanks,
~Nick Desaulniers
