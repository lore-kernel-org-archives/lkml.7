Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2A3C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3738220863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfFRRiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:38:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50740 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfFRRiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:38:02 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B2FAE15104429;
        Tue, 18 Jun 2019 10:38:01 -0700 (PDT)
Date:   Tue, 18 Jun 2019 10:37:59 -0700 (PDT)
Message-Id: <20190618.103759.1101173171614676988.davem@davemloft.net>
To:     gregkh@linuxfoundation.org
Cc:     willemdebruijn.kernel@gmail.com, naresh.kamboju@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, fklassen@appneta.com
Subject: Re: 4.19: udpgso_bench_tx: setsockopt zerocopy: Unknown error 524
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190618171516.GA17547@kroah.com>
References: <CAF=yD-JnTHdDE8K-EaJM2fH9awvjAmOJkoZbtU+Wi58pPnyAxw@mail.gmail.com>
        <20190618.094759.539007481404905339.davem@davemloft.net>
        <20190618171516.GA17547@kroah.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Jun 2019 10:38:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2019 19:15:16 +0200

> On Tue, Jun 18, 2019 at 09:47:59AM -0700, David Miller wrote:
>> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
>> Date: Tue, 18 Jun 2019 12:37:33 -0400
>> 
>> > Specific to the above test, I can add a check command testing
>> > setsockopt SO_ZEROCOPY  return value. AFAIK kselftest has no explicit
>> > way to denote "skipped", so this would just return "pass". Sounds a
>> > bit fragile, passing success when a feature is absent.
>> 
>> Especially since the feature might be absent because the 'config'
>> template forgot to include a necessary Kconfig option.
> 
> That is what the "skip" response is for, don't return "pass" if the
> feature just isn't present.  That lets people run tests on systems
> without the config option enabled as you say, or on systems without the
> needed userspace tools present.

Ok I see how skip works, thanks for explaining.

It would just be nice if it could work in a way such that we could
distinguish "too old kernel for feature" from "missing Kconfig symbol
in selftest config template". :-)

