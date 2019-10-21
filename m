Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204C6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37752086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yM7hcATB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbfJUTFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:05:11 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:37943 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfJUTFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:05:11 -0400
Received: by mail-oi1-f178.google.com with SMTP id d140so7704128oib.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgHGWvN6Bj5hyNJniLQ4k5wccPyzgO8pGCipXRk1Y54=;
        b=yM7hcATBudH8QtZKtYwmZrQaiv0jewLVJrYFtSc/3axEtwv22+lqq6fwpzyQZRqiaB
         zbr8s6RsOGFnip2YhUQvv9vOpCkjD12ejLmww9OvYxAjikTkEEId6TVYp59pteKLabiH
         6F1g1uWTRrBZkPDp7p6RvYunKoLCdUU+oMKe8wgIF8BV4BiSVd/G5UIDsPsUCT8S5LTi
         eI6rdvPAIy9dGshQvE5VIZb9hgC4ywxkk4xgO6pUNt5EwEEx+nwqszE2IMF+BysJzbZ6
         9CupBenxGoN5ucqk3M/vBKPVxKl2Vcem8Ohp5GQweElKxalxKZnUGBTGrIP+wYCCLjbw
         +msA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgHGWvN6Bj5hyNJniLQ4k5wccPyzgO8pGCipXRk1Y54=;
        b=RcZb48R2AA0dOHUoIc20iJS6aFLz8N4z536PPG/fQ2HgqMPTG1hrXF0b37AqEh8ZfS
         +6gOrM4ab678t4NFWkW6+9ReYAxWCZlxx8AAsQ+TAF9f6Hu5rDN5wSGoDTx7RgAKWd4U
         4jPOdEk58p/kcXU4fVM1T6hJv8Yy3t0R9QB6fHvIEZid5iSSR8fFS1eVUGpZV8bMsqns
         JojpYYLBb2xwVHA968SSqMSEPopPVFSyUUYE68Lda15k9S9VIsy9lCrTJ0rufCvhN+/Z
         Q/sMO61/YUyUJvOkkwt0XWiBhKCpdQH39+x9dsmxqK+lyarBtx+6wVRU95bUvLPPkMG9
         JplQ==
X-Gm-Message-State: APjAAAVKwjuXQewqhGa82ZPdonyvUIGCtfsYl1gMp8pV5d4Ht797q/RP
        eUnwAXy4Wt853+Gd/PDGWtuIHDwSvfdVLoALtpll9R9U
X-Google-Smtp-Source: APXvYqwWzzGUzz1JAt2td+MFhU/b0S3R/rALubdx6OFVlDMUE3zqPszttr+7oqJt32tjWTqFThbEJ5YdFYeuFTnT50A=
X-Received: by 2002:aca:5405:: with SMTP id i5mr883384oib.161.1571684710216;
 Mon, 21 Oct 2019 12:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191021190310.85221-1-john.stultz@linaro.org>
In-Reply-To: <20191021190310.85221-1-john.stultz@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 21 Oct 2019 12:04:59 -0700
Message-ID: <CALAqxLW5eQhVBMyFamjMyU2Vsd6TgG=dC0zftwA2AtY-8S9Scg@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] DMA-BUF Heaps (destaging ION)
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 12:03 PM John Stultz <john.stultz@linaro.org> wrote:
>
> Lucky number 13! :)
>
> Last week in v12 I had re-added some symbol exports to support
> later patches I have pending to enable loading heaps from
> modules. He reminded me that back around v3 (its been awhile!) I

By "He" I mean Brian here.

thanks
-john
