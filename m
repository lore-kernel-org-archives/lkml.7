Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3B6C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 21:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA7A222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 21:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EdYMGU10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfIZVgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 17:36:48 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36273 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfIZVgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 17:36:48 -0400
Received: by mail-wr1-f42.google.com with SMTP id y19so419496wrd.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbOjI3QEo1UkS5Gm752mqz5KqkL+oFqcUVJsgpwWPIs=;
        b=EdYMGU10Cfw2SuLaKt7IIod5noFPJTb9tXuH4/RPCTrjrVfRZ0MuYUMTY3SgBBqZFF
         uNAvxmQiq40XOWa2ajevHqFnBWo0jbDn/q26VzbvE21lzoeXCzKqGcRHZzplsrMZtBMg
         FICE4igHLeT8zpMOrYlaYVX51vd5jjO520vDz8kaOayPAOlY+q6MS6c1B/9UdCmeBaK1
         Lzk+u4GOgddrXF+KBjcZ0EHUp9FJV2DjsvDWlIPQYvR0lwkIcZ0zQdOy4GAOEbULPRsX
         R2cK+iUXDY777YvgwHkyPp1PrvrNZ9okQTt0Cs2cUjbWAUJXAoRY6BTFzcdTSK8GQBe4
         0LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbOjI3QEo1UkS5Gm752mqz5KqkL+oFqcUVJsgpwWPIs=;
        b=M/i5IZ7zxOP6kI0grVZnX6IA2wtbw1ZCJsHoDzfv0qUNRfaWVb9aoePefZX7bXxuGD
         w/WphDG9E9DeNVW9BK5ORz2B+U7jgDhRgI4G/VxfvKyI7iM/scBsg+ZTQ8iefARhkPi9
         B+2EDDhoZRBZjOmqkg72bkU7babSVUST20oNHmAi97B4IiqQeAru5T1leKlxGMlacXD6
         vDfir+Zr8eqD871UxpuNEm0uYXT3dSauII+9Rm4jb7I6bWRu9+i41I8k6rwO1mdwzb3W
         3Kik5P/9NcsjrEjbWh1G6dMW0qQHztwJtYViIqxcVWo5LjJZ1IypES8s+p2iqrhqAjVm
         ff9Q==
X-Gm-Message-State: APjAAAXWQVkpTBkodtCXQZOBrQtpH6Tg6DT6M4DKojhTEBwBdWq/KdqC
        KqzHP+IQtPtjW9GnbfobZCC/yOqG6TnrQiIzpmmhJA==
X-Google-Smtp-Source: APXvYqx+S0S8FK4WODmrazo7hHoctrPBtnbKLzmCRlB57lCTYzMeWByT+FaEYCdKafIkx9fZA+jFS9rqhCNyWHEriLk=
X-Received: by 2002:adf:d08b:: with SMTP id y11mr422072wrh.50.1569533805890;
 Thu, 26 Sep 2019 14:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <20190906184712.91980-6-john.stultz@linaro.org> <20190923221150.lolc72yvuyazqhr6@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190923221150.lolc72yvuyazqhr6@DESKTOP-E1NTVVP.localdomain>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 26 Sep 2019 14:36:33 -0700
Message-ID: <CALAqxLWyNiaf_Fxa76t9nA9Ea++O1Tcisq_XpH9e1yZJP1YujA@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 5/5] kselftests: Add dma-heap test
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 3:12 PM Brian Starkey <Brian.Starkey@arm.com> wrote:
>
> I didn't see any response about using the test harness. Did you decide
> against it?

Hey! Spent a little time looking at this bit and just wanted to reply
to this point.  So first, apologies, I think I missed the suggestion
earlier. That said, now that I've looked a little bit at the test
harness, and at least at this point it feels like it makes it harder
to reason with than standard c code.  Maybe I need to spend a bit more
time on it, but I'm a little hesitant to swap over just yet.

I'm not particularly passionate on this point, but are you?  Or was
this just a recommendation to check it out and consider it?

thanks
-john
