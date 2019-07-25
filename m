Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4772C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB8321850
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElkF0jZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfGYGRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:17:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37989 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfGYGRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:17:33 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so19677607ioa.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 23:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRoqbDJHGfr38RXpT7qcza55DevlOlHgy5CoUePAUmA=;
        b=ElkF0jZ2oXdbwt+dCFUKNeLkDixlYYHEpD+pFLmuOYWj6wWyJcscplUObqPiiwAmyW
         OKcMh09HoG8tb6nJaEneRZMa7p/p5Aa/Xw2wOGBvu5ro3WetRLqQ5RNfjfwGwGGgfbMH
         AtZf04obC8OEXzLfTJ1vFUeSdSJpVszRAbPF/6rDDPB0O44x5zPiNIm7uJUsewru5p0o
         VU31YGLkjCU0mUhgaDfqke3vxe43OfWiFY81rhYW99fQKA1gkl+6P1rHoZGwGG2mUS9I
         On/OQMC0fFPzzFgBI79nNP9Y9yiH8Fjs6jxIK10ffXre40U7yqMytaLqS/z5gaxBx5Eh
         zMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRoqbDJHGfr38RXpT7qcza55DevlOlHgy5CoUePAUmA=;
        b=asNjrohdpZfqlOFBn9WSzvmixXaDhczYLfENIA6lWZk4uJDP0nQ2KF+pUn0e7XyhAM
         ccMXFg+0WHIaTgwBQpTU67UNWHB1Fr5B045Yj26LhW7KxbJxlSaf5pqmLKvbSd0dDoVw
         hkmRdxvWTLkvp3QymKF6PVkrt2eroPeX3ttFYbZY30FAlSlmR0UQawrZ7nmlwydB12zF
         mRdZ5Si3R4mBNyC8JOJTz1GbQvNBniS8TvKvC0u7aGifhzW4qTiCccJNJPVpWOLK8Poj
         +/CS/pfS8tTw3zV3YSGCak5DeAoKgouPPrXq/iLl1VNqWqaPDWZbKi5JWae16W7b3crL
         EBJg==
X-Gm-Message-State: APjAAAXCujfjgVPkFBuZ9seFVc15urbvFtoLx01pxNmQinOangF2ZhRj
        abenkN0T2WplpoCX+lU5T8wOQ9bBx07ZAidiL2P1kXy/PLMS4A==
X-Google-Smtp-Source: APXvYqw3GQTATk7TCpJIxhOvn2PyGKQTOn1eklEiI+U7h4SZXAwdtGqiBf2d5eqHcZ865TD85nByVoKsejn8s5nuf38=
X-Received: by 2002:a02:bb05:: with SMTP id y5mr86296517jan.93.1564035452598;
 Wed, 24 Jul 2019 23:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
 <CAC=cRTMz5S636Wfqdn3UGbzwzJ+v_M46_juSfoouRLS1H62orQ@mail.gmail.com>
 <CABXGCsOo-4CJicvTQm4jF4iDSqM8ic+0+HEEqP+632KfCntU+w@mail.gmail.com>
 <878ssqbj56.fsf@yhuang-dev.intel.com> <CABXGCsOhimxC17j=jApoty-o1roRhKYoe+oiqDZ3c1s2r3QxFw@mail.gmail.com>
 <87zhl59w2t.fsf@yhuang-dev.intel.com>
In-Reply-To: <87zhl59w2t.fsf@yhuang-dev.intel.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 25 Jul 2019 11:17:21 +0500
Message-ID: <CABXGCsNRpq=AF1aRgyquszy2MZzVfKZwrKXiSW-PnGiAR652cg@mail.gmail.com>
Subject: Re: kernel BUG at mm/swap_state.c:170!
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     huang ying <huang.ying.caritas@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019 at 10:08, Huang, Ying <ying.huang@intel.com> wrote:
>
> Thanks!  I have found another (easier way) to reproduce the panic.
> Could you try the below patch on top of v5.2-rc2?  It can fix the panic
> for me.
>

Thanks! Amazing work! The patch fixes the issue completely. The system
worked at a high load of 16 hours without failures.

But still seems to me that page cache is being too actively crowded
out with a lack of memory. Since, in addition to the top speed SSD on
which the swap is located, there is also the slow HDD in the system
that just starts to rustle continuously when swap being used. It would
seem better to push some of the RAM onto a fast SSD into the swap
partition than to leave the slow HDD without a cache.

https://imgur.com/a/e8TIkBa

But I am afraid it will be difficult to implement such an algorithm
that analyzes the waiting time for the file I/O and waiting for paging
(memory) and decides to leave parts in memory where the waiting time
is more higher it would be more efficient for systems with several
drives with access speeds can vary greatly. By waiting time I mean
waiting time reading/writing to storage multiplied on the count of
hits. Thus, we will not just keep in memory the most popular parts of
the memory/disk, but also those parts of which read/write where was
most costly.

--
Best Regards,
Mike Gavrilov.
