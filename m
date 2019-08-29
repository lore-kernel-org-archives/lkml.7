Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAA7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A39C2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfH2PbE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:31:04 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:39754 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfH2PbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:31:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BFB7060632C8;
        Thu, 29 Aug 2019 17:31:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id l0ArbPxmnKEu; Thu, 29 Aug 2019 17:31:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0359A6083139;
        Thu, 29 Aug 2019 17:31:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZIcI1Ha_Olgo; Thu, 29 Aug 2019 17:30:59 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id CE25460632C8;
        Thu, 29 Aug 2019 17:30:59 +0200 (CEST)
Date:   Thu, 29 Aug 2019 17:30:59 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Dark <dark@volatile.bz>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <1851013915.76434.1567092659763.JavaMail.zimbra@nod.at>
In-Reply-To: <20190829103628.61953f50@thedarkness.local>
References: <20190828204609.02a7ff70@TheDarkness> <CAFLxGvyiviQxr_Bj57ibTU4DQ1H5wQC4DE5DNFBtAFoohcgbsg@mail.gmail.com> <20190829103628.61953f50@thedarkness.local>
Subject: Re: [PATCH] um: Rewrite host RNG driver.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: Rewrite host RNG driver.
Thread-Index: 5ROVPaoIle6zHgGJuGUZ0lu9vjcmrw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Dark" <dark@volatile.bz>
> An: "Richard Weinberger" <richard.weinberger@gmail.com>, "linux-kernel" <linux-kernel@vger.kernel.org>
> CC: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>, "linux-um"
> <linux-um@lists.infradead.org>
> Gesendet: Donnerstag, 29. August 2019 16:36:28
> Betreff: Re: [PATCH] um: Rewrite host RNG driver.

> On Thu, 29 Aug 2019 15:26:24 +0200, Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
>> So, you removed -EAGAIN handling, made everything synchronous,
>> and changed the interface.t
>> I'm not sure if this really a much better option.
> 
> I should have been more clear here that I'm using the interfaces
> provided by `drivers/char/hw_random/core.c` for consistency with the
> other hardware RNG drivers and to avoid reimplementing stuff that's
> already there.

I got this, and this is a good thing!
 
> It might be a bit hard to see in the diff, but I pass the file
> descriptor to `os_set_fd_async()` to prevent it from blocking.

Well, it does not block but passing -EAGAIN directly back is not nice.
Or does the hw_random framework handle this?

> For the -EAGAIN handling, I'm passing it onto the caller. Since you
> mentioned it, It would be better to handle it in the driver itself
> so I'll update the patch to address that.
> 
>> Rewriting the driver in a modern manner is a good thing, but throwing the
>> old one way with a little hand weaving just because of a unspecified issue
>> is a little harsh.
>> Can you at lest provide more infos what problem you're facing with the
>> old driver?
> 
> Most of it boiled down to it silently breaking if /dev/random on the
> host were to block for any reason, and there was the userspace tool
> requirement to properly make use of it. With that said, the interface
> was also inconsistent with the other hardware RNG drivers which would
> require a rewrite to address anyway.

Maybe our -EAGAIN handling is buggy.
That said I'm all for changing the driver to use the right framework
but please make sure that we don't drop useful stuff like -EAGAIN handling.

Thanks,
//richard
