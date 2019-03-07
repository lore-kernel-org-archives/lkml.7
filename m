Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723BCC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD7620840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GaWakx+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfCGRYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:24:42 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43576 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCGRYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:24:41 -0500
Received: by mail-io1-f66.google.com with SMTP id y6so14197483ioq.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJj9iPUsqYorzV5NCT/lexYuC8UswEhuTyAshA4URC8=;
        b=GaWakx+5mE9kb/COTV8mMyp6BHT+LY/KE3/qlMxtJgRqBhuTYY4c1K9q+MngWckD0h
         ptd/xKSJmNQVOqS0DD9SQa7GzloK1n95/h6OfXadB59+fZG/joRAi9usXgcrSjHKhN1o
         k6ULBUJ1TYfDsslqPUcydLJnF0fmTSiUHNQyks5qwwUw7xTylJB4oPsK/M45Ryzd5H/v
         kTwDEXXixuJRymEqd/+pH2ABLvRi+LhhEd7k60WXcPPaNblEWHAQJg7jT1ao47peFOks
         8o/4doHgfoIdAssX1gR01YBW+l1/5uP3qRCIf+J16FlFqnAT0m8c8v9QyCN1SBTIChXo
         d66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJj9iPUsqYorzV5NCT/lexYuC8UswEhuTyAshA4URC8=;
        b=OEmLVfj0EzjMyvQ2j6J4Cg5ul/oeQHw8QlISvzsx6mrUXesmEt9VMCgIrh0a0qqFKU
         oPBfyGvJCOD3vh2Q7kEWg7L6uW8FxyGV/4+qZ7L8Er/I2Dk2raJXItm5biQGQLDloDDi
         ZkuVHXDP+C6vbXsqe/s5UHm4iLURQslgt9Gh9GleyykoDR3EB6zBXwE8tEBSzvx3sBjV
         WfZud/JV48nOIAtk8zIIcL/Noj03B0dAIkb1rIXirvCD0Lp/5XNEomM0epRi+SeMPSxR
         E7s+GbzJTDP4t2tGnmD58LSgurtN4J/dHosLAb/nAx/6vfhS0Hg7RbHA0VMRv6tnodKN
         My1Q==
X-Gm-Message-State: APjAAAUbMpkb+nG7frD1hLNM8MznHe7Yz7gdKrBmPu3wDKxRpwGkhMO0
        1FV4GkyB2JY8RWc5rBAOz58qS3MT5HUSbh8aTjHOfg==
X-Google-Smtp-Source: APXvYqzLW5icEUCPPN0KnmLrzkY6hEUZOFIWH7bkQopLyqzz9wrsf5BM4eCnF4ckbFJSimFQoNYEbg1tIxkE0qtRxjE=
X-Received: by 2002:a6b:c8cc:: with SMTP id y195mr3812718iof.86.1551979480672;
 Thu, 07 Mar 2019 09:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20190307103309.1574563-1-arnd@arndb.de> <b32ab22a-2513-29b9-c000-d698f4efcb90@arm.com>
In-Reply-To: <b32ab22a-2513-29b9-c000-d698f4efcb90@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 7 Mar 2019 10:24:29 -0700
Message-ID: <CANLsYkxQJA8ttw3sMv9aC3fg9PSh+5qAxtZL+UpqmKxDsMdHCQ@mail.gmail.com>
Subject: Re: [PATCH] coresight: catu: fix clang build warning
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        ndesaulniers@google.com, Greg KH <gregkh@linuxfoundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2019 at 03:48, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Arnd,
>
> On 07/03/2019 10:32, Arnd Bergmann wrote:
> > Clang points out a syntax error, as the etr_catu_buf_ops structure is
> > declared 'static' before the type is known:
> >
> > In file included from drivers/hwtracing/coresight/coresight-tmc-etr.c:12:
> > drivers/hwtracing/coresight/coresight-catu.h:116:40: warning: tentative definition of variable with internal linkage has incomplete non-array type 'const struct etr_buf_operations' [-Wtentative-definition-incomplete-type]
> > static const struct etr_buf_operations etr_catu_buf_ops;
> >                                         ^
> > drivers/hwtracing/coresight/coresight-catu.h:116:21: note: forward declaration of 'struct etr_buf_operations'
> > static const struct etr_buf_operations etr_catu_buf_ops;
> >
> > This seems worth fixing in the code, so replace pointer to the empty
> > constant structure with a NULL pointer. We need an extra NULL pointer
> > check here, but the result should be better object code otherwise,
> > avoiding the silly empty structure.
> >
> > Fixes: 434d611cddef ("coresight: catu: Plug in CATU as a backend for ETR buffer")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for the fix.
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Applied after fixing line over 80 characters.

Thanks,
Mathieu
