Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0492BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C169F2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Ihu15yqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfC1Bge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:36:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42942 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfC1Bge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 21:36:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so21266615qtc.9;
        Wed, 27 Mar 2019 18:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yzeYRYKpxPIPd2OebYeG2ReDjht7mYv49boS4j2shTw=;
        b=Ihu15yqqXQxEqaKSSKYQaaPI0Y/yV3YWWxdsNmSqnNMvhQ8ZpTNgt8693PiWgf/fMF
         DEaXasNVvegIT87bVFMorYRlE0Soi17vowkKpTHa1zTdCcldhqP0H7F4NWBu7fX+yXJ5
         knxXCBfoVmyQ/EERYmQUPCehLHG1v6U06Uu0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yzeYRYKpxPIPd2OebYeG2ReDjht7mYv49boS4j2shTw=;
        b=EuuzPsXvx+R4wroaVXbU6qjv9j98ERQvOAKJnPSFeYzUr9mfzmtfi3cfHtJIHXdX1y
         Q/aoFNZctdmJmqrjFjbRjlxpuPv6sP9kK6YgTWTCHwnYCgYH6vUqfKUiUukauBbisHYg
         QdZqvf31u3S+75wslvGWOlLoZlSiTcoHxlGclxs0GxPqrRJIK/2FHN07v6mxFKxJY/UZ
         9l3c7ljB5yczVl0NZhjjuln0J3rI6hQPXscoQaAKgbTdv8USLvpuh8gJqpQK8HtUlu7p
         fX3HyY8A5BtOabKFBTtgZKkkYtLKByIBnN95Mz+FulUjsJYEMF4mY17+RMzQKwAGVxSb
         BDMA==
X-Gm-Message-State: APjAAAXj+jmCbyssE9Ps82qdSBrTxP37ZtDCMucnGxXVVzKP/mokwVs9
        mt8B9DG+OPWnh600SI9WErM/0zEd7xbMY4ctijCAtiLC
X-Google-Smtp-Source: APXvYqzzoefr9QsY7b3pcWM+WuuFdvWOA6JSLfHIi45wiQHwGGkMpdz76AkXrjcIJZYjDgxunaE4/YNZcoDdLt6obzM=
X-Received: by 2002:a0c:d07b:: with SMTP id d56mr33462714qvh.89.1553736993050;
 Wed, 27 Mar 2019 18:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190328122300.02fc46c4@canb.auug.org.au>
In-Reply-To: <20190328122300.02fc46c4@canb.auug.org.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Mar 2019 01:36:21 +0000
Message-ID: <CACPK8Xdx5TtG=7ZTgRg_V=obawreGrTG-aA2gESjpxcQY-wOBg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the rtc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 at 01:23, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the rtc tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
>
> drivers/rtc/rtc-aspeed.c: In function 'aspeed_rtc_read_time':
> drivers/rtc/rtc-aspeed.c:26:16: warning: unused variable 'flags' [-Wunused-variable]
>   unsigned long flags;
>                 ^~~~~
> drivers/rtc/rtc-aspeed.c: In function 'aspeed_rtc_set_time':
> drivers/rtc/rtc-aspeed.c:57:16: warning: unused variable 'flags' [-Wunused-variable]
>   unsigned long flags;
>                 ^~~~~
>
> Introduced by commit
>
>   7f4d485413fb ("rtc: Add ASPEED RTC driver")

Alexandre, it looks like v3 went in instead of v4. Do you need me to
send a follow up?

Cheers,

Joel
