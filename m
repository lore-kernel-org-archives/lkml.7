Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F28C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7473C20652
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="n/+hgzau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfDZIms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:42:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35612 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDZImr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:42:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id f7so3309303wrs.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9MU1IdAQeQ47a3CDcXM8eoZTJOFdkZQ9xHCLPVf5Nw=;
        b=n/+hgzauxCACf37JbCqubpc6ejARtZebct9i9I1Mt2FY8Saok6AmUEEwzfMAD3wVjP
         m7OYKBxTAi7BbqonQnJVQrQ8jQRNo8PaELaUVe6FizWzGp61N9dyHyo9MzkBuiBFs16+
         sAW0KmcYlDBDIjsQv8CagduWQIbY13uFNSRDj6uYuvaj7XLhxWRfN8qcllhxYX1RwyVT
         3Vtp3r0DX2yg8jjI7sFAVVTM6i/elxwtZTWpTdpTZLE7FtwGqVKngGxX+gH17w0q+yWg
         znrOLU0IGOQtXxMh5caRX3xzPyQCUNX7I4EcybbV6csSurhkOkROPjcLE2ccGf4FlQqk
         71Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9MU1IdAQeQ47a3CDcXM8eoZTJOFdkZQ9xHCLPVf5Nw=;
        b=Y4BjDFpkSrOGa/x2tjlXtBDQt/n1qsSF8BISfMVhCkjPpZePvRRqhnjfh9yCQvFb/+
         Ltjc2fXryF9GYkkKohffjVMHNon9Tt0zNMmdKnCTSDg6aNa9aXIhte+Lwg0lFKt+EjCf
         8iKjy28wxUCcjHEn8/dlzv/csFqESNruYYT0jrblktWTmy4TdJZwGDYFD1bGVf3HXf+Y
         1chGfamsR9GpgJ/CuH+ZmR7A41jX03gZpiubpVHvNV3uOG9sK9wTBYAVV6sp8/A5nU10
         z8kjTt5iYlViZMTK8n7aL3skdXIgVUPLg1UQ3c0FG8iZxPMOeViRlNRvalwI5e0PuWMW
         4ktw==
X-Gm-Message-State: APjAAAUCrDkHXkdkKe9cFzjQlfwEJsXJUBy//Yj9eXTvI+ThixNnWk5v
        scLrlHVAtU9X/HRJ2tq3OJnU39HLQhkUMrJax/X61ete
X-Google-Smtp-Source: APXvYqzMNhhXRFesWECwTBM7WFb1r0WtOR9RtHwmmhiGhakLC1n7xqdll33oaj9riCM93DkXikdAgfKkPd8Gme9hb1w=
X-Received: by 2002:a5d:5346:: with SMTP id t6mr9152799wrv.59.1556268165924;
 Fri, 26 Apr 2019 01:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190425133435.56065-1-anup.patel@wdc.com> <9a8be7ef-e62e-2a93-9170-e3dc70dfb25f@wdc.com>
 <20190426062133.GA28529@infradead.org>
In-Reply-To: <20190426062133.GA28529@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 26 Apr 2019 14:12:34 +0530
Message-ID: <CAAhSdy1nVFCwiP6vyy9i2f+S2WxLodmdwpwUKZUHYz15YfR64g@mail.gmail.com>
Subject: Re: [PATCH] tty: Don't force RISCV SBI console as preferred console
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:51 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Apr 25, 2019 at 09:41:21PM -0700, Atish Patra wrote:
> > Do we even need HVC_SBI console to be enabled by default? Disabling
> > CONFIG_HVC_RISCV_SBI seems to be fine while running in QEMU.
> >
> > If we don't need it, I suggest we should remove the config option from
> > defconfig in addition to this patch.
>
> I think the whole concept of the SBI console is a little dangerous.
> It means that for one piece of physical hardware (usually the uart)
> we have two entiries (the M-mode firmware and the OS) in control,
> which tends to rarely end well.

I think the SBI console is only useful for early SOC bringup and early
SOC debugging when most drivers are not available in upstream
kernel. It cannot (and should not) be used in production deployments.

Regards,
Anup
