Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDB3C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038C521911
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCyHnpB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfGXWd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:33:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40020 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfGXWd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:33:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so48440476eds.7;
        Wed, 24 Jul 2019 15:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUFDCZihyOAMtDKIntxfmltlyorITur9aOSpLJwBVKE=;
        b=ZCyHnpB+wQnxW/kXXzJ5cRZfjRumGcIpmII4Dj48Z+kdowGWJBF9j/26HL6AtqSJcm
         T1zuq4Q+6vcpQDYCT79O3YVFR1dRP9h+S2T21Qn+rQ/WPPDJsxF9gB6GYZp1hAQ/CiF9
         Qdgj8LZ75C1g6nc7bdzJmUUwq/YOlmVUG3ZZGUwQiJSYwqB2+GzHq3buC/ya8EUPB6zd
         /Gk3BqGlW53CY1S17keIxaHOmy2ysh8o2ARWmC2cXoHNUVqHSyZh/MKY0atrMTDGPYcu
         80kzi+mcJksxOLverKynUSYJFCpvNsNXFixAlCorFjXS5adceFraL0heXqXq1L+z/gXZ
         Vz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUFDCZihyOAMtDKIntxfmltlyorITur9aOSpLJwBVKE=;
        b=We7/LwGC1M0NXlU1IvejizoVcAkAcYRnqvTLJ+U8PhmZZGO1kSHS7bR7Vw6XiL05Yl
         9mIZTy3atqeqZH5LlV8Y2Pm4uskqQ5t35aCC4TjH46syWh2ezuDa7KiJ2tz/paepj2vc
         FGvBmARP/OhiGGs13YSy6YlN2g5iu5nP8kZ4TCdM3YGCtN5cnlz/6tAUFadvubT7jgeI
         Ps6vePHf1s+o4AhmRiEMBuqI9XA6gnX174No3ITostgm4gRpETwjatpj/hzk96eQmp/Z
         8iP9iqA6mb1nYndsxmZ3fuGHZNoZCRF8uPda2eATgecPriMJO/BrUT/RGflUVhFLLbD6
         AuCw==
X-Gm-Message-State: APjAAAU/+O4WulnZUo8VqSk0uCRDjoLJKgy7juk3+HY0gw+F8enHe8fq
        5YnJyVDMv7hYyyYObT7/OK1svco525g6oZHLczE=
X-Google-Smtp-Source: APXvYqzLdObF7V5Na8mrkqM+zbDlECvPoE0A3EfMK3AN+hkYRlMqFXuccmvphAEx5TbsYWR3qyM84NH/spp5rmkJx3s=
X-Received: by 2002:a50:b1db:: with SMTP id n27mr74572676edd.62.1564007636192;
 Wed, 24 Jul 2019 15:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190724165803.87470-1-brianvv@google.com> <20190724165803.87470-3-brianvv@google.com>
 <CAF=yD-+a=t_YizdJpb_Q+zxR7iP-V-EarNsp9tjnFTRBjOtFvA@mail.gmail.com> <CABCgpaWCLJtDx8kHNiQZneqYZkZ3fzRGnipT5__kmwMhu01g=w@mail.gmail.com>
In-Reply-To: <CABCgpaWCLJtDx8kHNiQZneqYZkZ3fzRGnipT5__kmwMhu01g=w@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 24 Jul 2019 18:33:20 -0400
Message-ID: <CAF=yD-L6RpnxptBtcpVGzP4UoPLRxr2JiQGyRCoTca4jHioPXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: add BPF_MAP_DUMP command to dump more
 than one entry per call
To:     Brian Vazquez <brianvv.kernel@gmail.com>
Cc:     Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Because maps can be called from userspace and kernel code, this function
> > > can have a scenario where the next_key was found but by the time we
> > > try to retrieve the value the element is not there, in this case the
> > > function continues and tries to get a new next_key value, skipping the
> > > deleted key. If at some point the function find itself trap in a loop,
> > > it will return -EINTR.
> >
> > Good to point this out! I don't think that unbounded continue;
> > statements until an interrupt happens is sufficient. Please bound the
> > number of retries to a low number.
>
> And what would it be a good number? Maybe 3 attempts?

3 sounds good to me.

> And in that case what error should be reported?

One that's unambiguous and somewhat intuitive for the given issue.
Perhaps EBUSY?

> > > The function will try to fit as much as possible in the buf provided and
> > > will return -EINVAL if buf_len is smaller than elem_size.
> > >
> > > QUEUE and STACK maps are not supported.
> > >
> > > Note that map_dump doesn't guarantee that reading the entire table is
> > > consistent since this function is always racing with kernel and user code
> > > but the same behaviour is found when the entire table is walked using
> > > the current interfaces: map_get_next_key + map_lookup_elem.
> >
> > > It is also important to note that with  a locked map, the lock is grabbed
> > > for 1 entry at the time, meaning that the returned buf might or might not
> > > be consistent.
> >
> > Would it be informative to signal to the caller if the read was
> > complete and consistent (because the entire table was read while the
> > lock was held)?
>
> Mmm.. not sure how we could signal that to the caller.  But I don't
> think there's a way to know it was consistent

Okay, that makes for a simple answer :) No need to try to add a signal, then.
