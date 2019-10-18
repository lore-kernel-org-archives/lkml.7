Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49623CA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E872082C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncPaBbJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505684AbfJRS3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:29:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35168 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505612AbfJRS3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:29:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10so6847744wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jM3mqQowcnIqqAadMg1JP7jXhgCphy4yRtthUQq8/D4=;
        b=ncPaBbJZs3QwmaWC8n5a/tYGtGsYFjLWRdunAcoo3rSjcSu4BXW26U7bkskK8OO6TP
         3FD7LHPbHqupw4LRalLiBKjaIbQtF7l7QQpAYNOXezS6l5cwIuHZqRFfCNF2PM5/d5Gg
         JDiVQWIYpUd8YD3+ZjOvMzMw80MGmCjEj2WwT/Sk8TZwXwReqB8P/yqQir49rSVFj1O4
         T7cT2gpJsEYZcVXPV7R6V2ge1IxIVLQa4CTo55YCIM9PxFZW/4QOb3vPQKHujHyFG3Td
         mkW5GC6NJbJTjQBVCRIkJvb8/VxTcsr6+/dh7ax5gBifEzn2gwxJtliOQNSaqqmAdhVY
         niuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jM3mqQowcnIqqAadMg1JP7jXhgCphy4yRtthUQq8/D4=;
        b=kA8Urr3dfvQnRRj9u6QBehZ5bCZq2nsuVUQ6hW15yuR4bVRwqgazOWtfellEjluE9f
         YjA4sTzuaI8TbpI6IQfU/XBEUcRzc3c1H94p5ztNVgdV5ZZDBGV3SM9HE199gr6nffzJ
         9MqL1mu4wwNCfNY0tqnrDQhy11d1gEx6H3jqwB7iKu6o8ojI/jca92YVYG1fDf125UiO
         kPPkwcGO6gJHWhVncNNZgff75ExK/G2+Eb0JqGvt9rYYY3aBVplPkoqM0oBY9iRg1cvh
         r7wqhc6XuGGayXfF+dxY4rHuErJAjoFIrWYXjk5M7ktfmMZHHb9XPaTTZzD+EY2vFLv3
         Wl2w==
X-Gm-Message-State: APjAAAVMHt+q0Mnx2FdIB7C3HejsIObm1/AbBX1Td10+89km8+1hqaSd
        cHVB+r+P7PsdBI10BkLUoHkrjZ++OprkIKZsqbropQ==
X-Google-Smtp-Source: APXvYqw/ORDV9l2s2JvayF6Hp3+kzOGkiFz+Fg9YoEW0w523xapkapxxJarA+A63lfzlD4kH1X5LWJXwoVh3S7Lti20=
X-Received: by 2002:a5d:55ce:: with SMTP id i14mr8818316wrw.169.1571423380050;
 Fri, 18 Oct 2019 11:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191018052323.21659-1-john.stultz@linaro.org>
 <20191018052323.21659-5-john.stultz@linaro.org> <20191018112124.grjgqrn3ckuc7n4v@DESKTOP-E1NTVVP.localdomain>
 <CA+M3ks6KqqXCfqA6VDKnQOsvFLQfaGrUnA+eesnyzMRniFB00A@mail.gmail.com>
In-Reply-To: <CA+M3ks6KqqXCfqA6VDKnQOsvFLQfaGrUnA+eesnyzMRniFB00A@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 18 Oct 2019 11:29:29 -0700
Message-ID: <CALAqxLXwo=Pwi7BUXNzpk3-aqm1j+O9ZTi4NpYWdc2eYVK7t1w@mail.gmail.com>
Subject: Re: [PATCH v12 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Brian Starkey <Brian.Starkey@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
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
        Hillf Danton <hdanton@sina.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 5:04 AM Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> Le ven. 18 oct. 2019 =C3=A0 13:21, Brian Starkey <Brian.Starkey@arm.com> =
a =C3=A9crit :
> >
> > On Fri, Oct 18, 2019 at 05:23:22AM +0000, John Stultz wrote:
> > > This adds a CMA heap, which allows userspace to allocate
> > > a dma-buf of contiguous memory out of a CMA region.
> > >
> > > This code is an evolution of the Android ION implementation, so
> > > thanks to its original author and maintainters:
> > >   Benjamin Gaignard, Laura Abbott, and others!
> > >
> > > NOTE: This patch only adds the default CMA heap. We will enable
> > > selectively adding other CMA memory regions to the dmabuf heaps
> > > interface with a later patch (which requires a dt binding)
>
> Maybe we can use "no-map" DT property to trigger that. If set do not expo=
se the
> cma heap.

I don't think that's a good plan. See my WIP tree for the approach I'm plan=
ning:
  https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=3Ddev/dm=
a-buf-heap-WIP

thanks
-john
