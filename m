Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C41C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EB7218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c6935lM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCOUNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:13:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51291 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCOUNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:13:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id n19so7704113wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UFMdBRsGAu44JgGIkSUfbrU9EwKu+fv2CxmBbUPq/5k=;
        b=c6935lM6XELJ+DVpw2Q5TZoexKSNVTnmA58DWVT40XM55BgdkKxexjMuw6xgbGC5jY
         OsdFpuJAZMgojhoH8/teTFX7BDmL6z9WmQJAhIJmU63UzdBoLeou+NAnLsBYezeoOQhk
         A6M68yE+pUo3oE9uaZ66d/MSwyhfa7qV2/JJ+NZtr4rJnuzWEP3faGJeIVnhx6BWeKWH
         lAQMKqNAula9/t6TdRlW837AqbcusZ4apMc7HdyE3YeckhtConR5EBBvKlvLoN9h5GS3
         ss3j+xedrdwo+318q52MSPxjOGh+xvGe9mf8VsU5dq+WB3fxJ+kCJNqE0dbN3qdbnYKf
         1YFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UFMdBRsGAu44JgGIkSUfbrU9EwKu+fv2CxmBbUPq/5k=;
        b=XqYPJLixbbZB0JHFumq5QIrLxwJk1bszkotCbtxupWVXx/yV325juUaG5GX6m7uh8i
         f7qcVUQvcTY06V4d3rF03XRkF74Q+1BpdRT2inN71b8+m+Ic3+5RY3V3sn1oB9BmCvyE
         Ql6VOc3CZWIV3609YfXAvWTeH/P8iGFKT/4dS2cCp0OvyDqQui5f5GBOQhHvoFqBY/US
         HWBhr+xAQfknYrrDBtBO3S/aCm+rF1RJEm9xtEsklvWVJNRdkDkduVs26bPFSvQi3Qts
         rHxvsLbhQZMFEEJ1U9gbO9WGCsFHarQnIocGwnV98zS1dkM7/1Qjd0VQchsbnOaaiOW3
         iXwA==
X-Gm-Message-State: APjAAAWGvzfiGpOFnpwP05JbCC6EaOzkkjGQe6Q+SEyobcnoNwqvKwfM
        5alo1lW5hk5WBRBgETnFeInoKj33NuSOBbgk9ad3YA==
X-Google-Smtp-Source: APXvYqxPoLg8H/w9V6sXkdXrPdPwoiA0ZVu7A3rzwdDMrlqLSfStQQBq0u73fFKG8WEr5HL7os26xomhjJQW2RBatBs=
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr3112656wmb.23.1552680803684;
 Fri, 15 Mar 2019 13:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-6-git-send-email-john.stultz@linaro.org> <CA+M3ks6AUmmYbXscjTRo+Vr-6cV8okafsDn2Tg3tskvzrV_dbA@mail.gmail.com>
 <CALAqxLWxpExDpiKbNGQ6Oz5h=FUPNLvehm34JdrntLQjFed41w@mail.gmail.com> <232410de-f20c-cde8-fdbb-48ca8ec1223b@redhat.com>
In-Reply-To: <232410de-f20c-cde8-fdbb-48ca8ec1223b@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 15 Mar 2019 13:13:08 -0700
Message-ID: <CALAqxLUjSZHBXsT0c-KTra4zLFxCYDmYHTJswk5OckrUbd=ykg@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/5 v2] kselftests: Add dma-heap test
To:     Laura Abbott <labbott@redhat.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 1:07 PM Laura Abbott <labbott@redhat.com> wrote:
>
> On 3/6/19 9:01 AM, John Stultz wrote:
> > On Wed, Mar 6, 2019 at 8:14 AM Benjamin Gaignard
> > <benjamin.gaignard@linaro.org> wrote:
> >> Le mar. 5 mars 2019 =C3=A0 21:54, John Stultz <john.stultz@linaro.org>=
 a =C3=A9crit :
> >>> +
> >>> +       printf("Allocating 1 MEG\n");
> >>> +       ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> >>> +       if (ret)
> >>> +               goto out;
> >>> +
> >>> +       /* DO SOMETHING WITH THE DMABUF HERE? */
> >>
> >> You can do a call to mmap and write a pattern in the buffer.
> >
> > Yea. I can also do some invalid allocations to make sure things fail pr=
operly.
> >
> > But I was talking a bit w/ Sumit about the lack of any general dmabuf
> > tests, and am curious if we need to have a importer device driver that
> > can validate its a real dmabuf and exercise more of the dmabuf ops.
> >
> > thanks
> > -john
> >
>
> There's the vgem driver in drm. I did some work to clean that
> up so it could take an import af33a9190d02 ("drm/vgem: Enable dmabuf impo=
rt
> interfaces") . I mostly used it for private tests and never ended
> up upstreaming any of the tests.

Thanks for the poitner, I'll check that out as well!  Also, if you
still have them around, I'd be interested in checking out the tests to
try to get something integrated into kselftest.

Talking with Brian yesterday, there was some thought that we should
try to put together some sort of example dmabuf pipeline that isn't
hardware dependent and can be used to demonstrate the usage model as
well as validate the frameworks and maybe even benchmark some of the
ideas floating around right now.  So suggestions here would be
welcome!

thanks
-john
