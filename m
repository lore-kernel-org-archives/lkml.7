Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB71C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03F021D81
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pj82qvCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfJBQO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:14:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36760 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfJBQO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:14:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so7606046wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AF6ICp5pMJTO5IIGLISprcfM72Z5T4FMqcpypJNCaW8=;
        b=Pj82qvCr7yhwECurupIzOoiaPefmUaVaC77k5jM4n7NCxzRScPppT9N1NBsdU/0Bdc
         STDIX+l5ImCzPn+UzMQW61dxl2ckrirh0K/Fws6uPFz0F6d35CCynDjpwknaa3Wtvbgv
         PufiV13RcwmUCc97d76tTngXyMP0qoZyBT9Odk5R77qCB97i7IgJcm2Lk0BGbCumFZYJ
         0ThNeAlzrPoMASS7xtr4Q5ifJUprzKxzvFuXD2I6TB1p0c20DKAlYQnpKoa95pwlfuKW
         gEq7T75KwQ1dh/Nicx5ICfGYEykJvJlRQZZeV8agAbJpBZIpbA0sLa8GUWp9QdJ1URfn
         qxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AF6ICp5pMJTO5IIGLISprcfM72Z5T4FMqcpypJNCaW8=;
        b=mJrEUHo7EWy6hR1xcBhqki3rqjXrlqEffeiWKL+/cIbv9+em9wE5CE+Mv96Lhp08Hj
         86cZKESTUmRtWDaWtFTQKrIPVXCGPCgvAMtOL5JRRrqMivqtIFqESNr2h2HmxvOOmN+D
         GnsqSUKR4MthhQpdZJFHvrOYz33V/HP5R6OGCXYun5TuG7zc3nEZczpim07g+h4WnR0+
         pU/cKVAQctQ4eMcXavvanFkiwvneDmKGyaopRJ6nQsJSMveXq+T2KQYoLKyZ0kVu5Y3D
         0D9kEMGk7y3lkEdmyG5BN0yPs3mDopjkuAIuAcGZWU4ds1b5Ww+G/yX8dOk9UK9zSUPI
         hDNg==
X-Gm-Message-State: APjAAAUA4MV195OCwuZT761PC3/hSOCv0gP9tXmefP+txz/dqB4mN1Nw
        KX23zp09WPUtoYggoa+B0SxwH0uuTJcU5Df+69mlMQ==
X-Google-Smtp-Source: APXvYqxj14UP2YosV0Wb9Qqfsm6keLBgOUgzLZ1CEYsSBNjwnQ4/nWKR4BKVux6nywu0axAH/0eaNnBX6u+8JOsm8n4=
X-Received: by 2002:a1c:c189:: with SMTP id r131mr3614749wmf.153.1570032894414;
 Wed, 02 Oct 2019 09:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190906184712.91980-1-john.stultz@linaro.org> <20190930032651.8264-1-hdanton@sina.com>
In-Reply-To: <20190930032651.8264-1-hdanton@sina.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 2 Oct 2019 09:14:42 -0700
Message-ID: <CALAqxLUXKYibt6e4ji=kpP4ROFkU_4YQZoAE-ciq2bnFJxM_PA@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 1/5] dma-buf: Add dma-buf heaps framework
To:     Hillf Danton <hdanton@sina.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 8:27 PM Hillf Danton <hdanton@sina.com> wrote:
> On Fri,  6 Sep 2019 18:47:08 +0000 John Stultz wrote:
> > +/**
> > + * dma_heap_get_data() - get per-heap driver data
> > + * @heap: DMA-Heap to retrieve private data for
> > + *
> > + * Returns:
> > + * The per-heap data for the heap.
> > + */
> > +void *dma_heap_get_data(struct dma_heap *heap);
> > +
>
> It will help readers more than thought understand this framework
> if s/get_data/get_drvdata/

Sounds good!

Thanks for the review and suggestion!
-john
