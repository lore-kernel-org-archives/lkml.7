Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC412218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwB0sJL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfCUULP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:11:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33547 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfCUULO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:11:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so8101379wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9P5W3/unLbHiwQeefxsCF7KUs13ROq2ZhWkA041EwJE=;
        b=jwB0sJL7xU271oin4iKuHvx+pUnTN27Tx2/TiWyOnC0sdez0Wb4+426dnFtOd3gQ8B
         O90cFHLJrgLpLfI84K+bBjyMLJcYPu7a1TklbxiMfV13ezkTMXdbiKnHFyTHofix4wO6
         +MNz5SAoGBlynr/h0U1F7wXIIuT0VKYo8xn/8VmmAMvS9UeOsL0KqRow9Pb6+vYQu+AO
         ay/neaYZ10/m+G8YSlSQrDMOVAhvQ3PF5/GaQ7xeHLEUlytYYXMMllkknxmq8osuju6C
         Bq8wNqSWY07+1iRFbIks8e52eOnyb5LTAjLj1i1Gzj4wPg0spF4yJo5xGnMFG3n4+mRm
         7Z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9P5W3/unLbHiwQeefxsCF7KUs13ROq2ZhWkA041EwJE=;
        b=aJj884kTCPiXy4BuC2sn7ZQgnBCtSxLPX1FNfrvLt1go0Ev6KA1jqQXS8a2Ls9VwME
         CSPcaEX9yAnQsk6IemJQjia9eEuRyk8RtZqh3TlFD4hiw+TXaeiX4HBLPT4XDpTpsj3M
         enYGiao2MA9aeLJXhBEcXn48CcW0vtKt7IrOR1KyvIwcaPkJ/66bwAoH8utW3zMpTIdT
         WTraLtkvgQIpJWNWWbWlm6EDpJ9uYz2l1X1G1FzaSPDQiz+3z9E9e7sEkTzFMacNbOT3
         e5MHX5BrwFvkAU841wBMvX9r14ByDYtsTv/zIIQBBAV/6W3gHD3QRDdKsLgFTTQjJqKD
         +2AQ==
X-Gm-Message-State: APjAAAXh+b2rfHt4i99N+B7pG/+YJugwoHra9pQ5o8dMRP6F3OXPCBYS
        ll7x/STO8DrmResu0vEgkG8OgEhDhIo92wruEnf9mg==
X-Google-Smtp-Source: APXvYqyjtKoXpLSwnHSk3DwU9/rg3ROx381WtdtGw8E9GX5aQ4rKtnfGeqRJLbjjLF5JU26nMA9dgZsEKfnoOKU/mxs=
X-Received: by 2002:a5d:6682:: with SMTP id l2mr3696549wru.33.1553199072988;
 Thu, 21 Mar 2019 13:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-3-git-send-email-john.stultz@linaro.org> <20190319142604.f6puq3ugxrcxsrjs@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190319142604.f6puq3ugxrcxsrjs@DESKTOP-E1NTVVP.localdomain>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 21 Mar 2019 13:11:02 -0700
Message-ID: <CALAqxLU-qi6qQ=diMjN=XHfVcofhgQMj-kONRKkySODtnMqsWw@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/5 v2] dma-buf: heaps: Add heap helpers
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 7:26 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
>
> Hi John,
>
> On Tue, Mar 05, 2019 at 12:54:30PM -0800, John Stultz wrote:
>
> ...
>
> > +
> > +void dma_heap_buffer_destroy(struct dma_heap_buffer *heap_buffer)
> > +{
> > +     struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> > +
> > +     if (buffer->kmap_cnt > 0) {
> > +             pr_warn_once("%s: buffer still mapped in the kernel\n",
> > +                          __func__);
>
> Could be worth something louder like a full WARN.
>
> > +             vunmap(buffer->vaddr);
> > +     }
> > +
> > +     buffer->free(buffer);
> > +}
> > +
>
> ...
>
> > +
> > +static void *dma_heap_dma_buf_kmap(struct dma_buf *dmabuf,
> > +                                     unsigned long offset)
> > +{
> > +     struct dma_heap_buffer *heap_buffer = dmabuf->priv;
> > +     struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> > +
> > +     return buffer->vaddr + offset * PAGE_SIZE;
>
> I think it'd be good to check for NULL vaddr and return NULL in that
> case. Less chance of an invalid pointer being accidentally used then.

Thanks so much for the feedback! I've added these two suggestions in!
-john
