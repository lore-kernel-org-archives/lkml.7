Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2EEC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A3121774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKrcbzET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfK1Tad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:30:33 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39390 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1Tac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 14:30:32 -0500
Received: by mail-pj1-f65.google.com with SMTP id v93so8984665pjb.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 11:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=osQYL3pDmdl2TaeiizJjLXstEKC6lN2gc0hqrN0LReo=;
        b=ZKrcbzETQZZWRqIYJledPltEAabffGiHBHmsWpqhA3DhqMOfYykL/UKFaj4TlaTFPQ
         cT2yGt+4cZUho070NFk5pGh9MqUmW+77WyX5g+iZTRvEsZxvPB8XRxvPuUa/7y9Y04Tr
         AhuI0MXadMjWOBObLW1CjunbGMNDbJRgegD44D4WZnl95K5nSLQkP7h2eWihj1Oxj6s5
         X5TOzjxVJOLVNbk+2QrCWGjkYUqVdwPWlD2c8iZqWfINAH4CH5h10aS/T8NurrbaL+Sf
         yra8IyywQPn8avMXOl2e5jtNw6HEbX1JaCfMIgWuWZMvO/RyzaXPDbHsDY6rHm38Ht9x
         UE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osQYL3pDmdl2TaeiizJjLXstEKC6lN2gc0hqrN0LReo=;
        b=g77s+RKcH/geh687HzH3W0yeuT8tr3ajuVn6xTkdgod5vvfpGjuhgH0PnouWz9O9cn
         NSFsFrU1/FisgS/GBImyrFwblvG+EKsBUQjX0M/DdUaAvBy+oNt8JP+5+zt/viwyvChZ
         udw2xENQEoIbXNDtEI74I/dS9mhE7al7YLnyxmdSB87w6zrwjMIY7whEChWx8bVsaD7F
         aziYrxuE0nyh2c8J9ESOZOecMkCZdo/fFK8jjcRHWBCl/3vBZVvEFzDClOiaw+QL05KB
         iQsXJQ54xyjqFxg4pL6EEtvPcwIBJd9qfzpvq/mzv4FHQE5SJNQ/rVQmFsR4vfyy8yit
         nCBQ==
X-Gm-Message-State: APjAAAW/Sfr7lq5jFnwD5SGhnm3RzbtnCS3WPOF7sy/3KKaZZkihlQwJ
        Hi8tTijDpkOyREV/dXQ9g/oAmPYHeXU2MvC5mG672dABKwM=
X-Google-Smtp-Source: APXvYqx2ILVRxzHZL7JR3+vRmSwtPzN2gRVKmlweVhtEix33SJgqggQn4Stkk4g/PaKIo8UPJmOpcirO1H0rnSK6+Ro=
X-Received: by 2002:a17:902:34d:: with SMTP id 71mr10523489pld.316.1574969432079;
 Thu, 28 Nov 2019 11:30:32 -0800 (PST)
MIME-Version: 1.0
References: <20191121001348.27230-1-xiyou.wangcong@gmail.com>
 <20191121001348.27230-2-xiyou.wangcong@gmail.com> <9ac29292-bc3d-ae57-daff-5b3264020fe2@huawei.com>
In-Reply-To: <9ac29292-bc3d-ae57-daff-5b3264020fe2@huawei.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 28 Nov 2019 11:30:20 -0800
Message-ID: <CAM_iQpVqs2zLxnwC3p81qv-n8tq8vQ6DJRGE9zwMJNm-vULZAA@mail.gmail.com>
Subject: Re: [PATCH 1/3] iommu: match the original algorithm
To:     John Garry <john.garry@huawei.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 10:01 AM John Garry <john.garry@huawei.com> wrote:
>
> On 21/11/2019 00:13, Cong Wang wrote:
> > The IOVA cache algorithm implemented in IOMMU code does not
> > exactly match the original algorithm described in the paper.
> >
> > Particularly, it doesn't need to free the loaded empty magazine
> > when trying to put it back to global depot.
> >
> > This patch makes it exactly match the original algorithm.
> >
>
> I haven't gone into the details, but this patch alone is giving this:
>
> root@(none)$ [  123.857024] kmemleak: 8 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)

Ah, thanks for catching it! I see what I missed, I should pre-allocate those
empty entries in order to make it work correctly.

I didn't catch this because this was tested on a production machine where
we can't afford CONFIG_DEBUG_KMEMLEAK=y for obvious performance
concerns.

Anyway, I will fix this and send v2.

Thanks!
