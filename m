Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B801C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC8821019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="AHxH269d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfIJI4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 04:56:11 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:34622 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfIJI4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:56:11 -0400
Received: by mail-lf1-f53.google.com with SMTP id r22so1498221lfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 01:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNfZ6D6BkW5VBAgD6NV0GNz1BCxCA3u2wXgw+w9oDDM=;
        b=AHxH269dTSeO5uFrk+ZsTv2xttxAWwY3vGT2RqKL9s0VLWiIaUREEiiQ2NyF1pfTOl
         8tDMzqHAvfuQDvW7vVaKCh7EJX6qYDY0Wa9oCheLgS/9hVZHp3Tx6IfGmTxdieRkl032
         /p07TJ47w4YX+L1Ivl1LQykhDn72UeNSqngrdEaF1KXMWRGigsy57ZykyS+027i/QwLq
         S+TddAHz1w3sJevGi9elfNke689QN8rN9S/cSXFOYB4Ssn8CT9mJxODj+RBHVrwPfBBb
         KLWT10dHr2IGLTW68zuk5XEL26YvdUoOPwYRDTim4Y6LW1aa3pNtzPtMKhrm4gP8UA9f
         rLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNfZ6D6BkW5VBAgD6NV0GNz1BCxCA3u2wXgw+w9oDDM=;
        b=ugEC3lJdmXAXuSZizT/yqTcBVVZ7GMHcFVWyHpNjiODqsEE2RPhD41et9AJLMX+mzV
         NLgRAN/lefllqGXQTIPXFCPIl+XGDo/NMrd2VXt5Wib1exXlTNS9yTa2A5FU8UhtrZNt
         KcC5+fZ5qPhwhfvamKs1KBEwHzljFU/nLaYNbCO69/znmNCzL+ua7b+b7sOR+SVRPygD
         H4wc4gircswmhMNVDjzG87TJH9DrHP+U7MeUdScMBasQPyPgy/QcVrCuLg/oOyr6+qtv
         oRH8OuwYKUiLz3ekQmBiW40dAHoRQ0jAKoPL0QH0aZie2Csg3ng4luItp6y8RrEV0GmK
         cVDA==
X-Gm-Message-State: APjAAAUoBXfN9nIS3rwmFX6Fv0wT2svnNOo2HZC2TIVX0+1ycPu1mCHx
        Sgk/ZWjwBFiAp1+VwPzJF74BSF02Xff8QvnCg+5TrA==
X-Google-Smtp-Source: APXvYqx8WFbmdHzdtKi9N5oQGSAaZLgzlIwkKwBIHnTKsUuZ4/h/Dy+UpUVGQdty83dzdc2Fa+IL1f33HIyuzNDtxoY=
X-Received: by 2002:a19:3805:: with SMTP id f5mr19258381lfa.173.1568105769318;
 Tue, 10 Sep 2019 01:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190906074526.169194-1-maco@android.com> <20190909145703.GA16249@redhat.com>
In-Reply-To: <20190909145703.GA16249@redhat.com>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 10 Sep 2019 10:55:58 +0200
Message-ID: <CAB0TPYEb-WdggSj=i+tpABfkO9KFqcgMc0twMx0L=ZcAN4HDfw@mail.gmail.com>
Subject: Re: dm-bufio: Allow clients to specify an upper bound on cache size.
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, Dario Freni <dariofreni@google.com>,
        Jiyong Park <jiyong@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Nikita Ioffe <ioffe@google.com>,
        Narayan Kamath <narayan@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Mon, Sep 9, 2019 at 4:57 PM Mike Snitzer <snitzer@redhat.com> wrote:
> Definitely not very intuitive.. but yes I think it is a reasonable
> tradeoff between your goals and further code complexity to be able to
> achieve the "ideal".

Thanks for the feedback. I do have a patch for the "optimal"
allocation lying around as well, if you'd like to take a look. It's
not as bad as I thought, but it does require another list_head in
dm_bufio_client; other than that it's just O(N), so not so bad.

> Think the documented example can be made clearer by documenting that
> dm_bufio_cache_size_per_client = 49.  And that _that_ is the reason why
> the client that didn't set a maximum is bounded to 49.

Ack, will send a v2 to clarify.

>
> Overall I think this patch looks reasonable, but I'd like Mikulas to
> review this closer before I pick it up.

Thanks; let me know if you want to see the alternative as an RFC, and
I'll clean it up and send it out.

Thanks,
Martijn

>
> Thanks,
> Mike
