Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D71FECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0C6207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utOwdNUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfJNJJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:09:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39503 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730686AbfJNJJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:09:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id s22so13172363otr.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mmj2BkgM8N7EfRm0KQme7Wm8/QTctqo/rgR46m8jYww=;
        b=utOwdNUatw0TJVcjEzTDXL9YxHok/lnaqAbJDnMdLHtT8FLMimNAu+So6hq07QgsJy
         QoK22R7R0Y6jECX8A4N/OfLSzmFnpi7Kg8I79ukNgdxQXECWbbpzgDtNdPtCc03jsQx6
         F2LXvxe/OSFzyR9PJPe7jqbHoMjPOc0kz7hXY/ArEkOqCQ23QJq9NObMy5liNTpmzjlD
         iIV1j2OGFfIvfIZpL6JgoWjESsv5FpyS1IdGTbsULmPm4o/iqsZnV/dAG+PHwKtbhqwm
         Rbp7U40W6gHE9xclO4MBn91IxElM6TJvmOo2a/stnMSQkGmqzCqZWUpxDDVweW3byF7q
         qhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mmj2BkgM8N7EfRm0KQme7Wm8/QTctqo/rgR46m8jYww=;
        b=sZ5QPjT8GAUzzxbXCj3nHBWcxKPIlHxjbb9Di2ofs/YfI4fsn7sql6hRgkCbN0YI3y
         gOw9bRmdywogekymbPLZ6BhUEiOU6EHGsvAUYqdbpHBkLbN6Sy294I3lz3IcwtLOcbqs
         55pGoVnLzpx9GeZ96CwHcgRDlNXZndeNecEBxxLVkrLzxnk3GFqHYQoSNtjgRexJw95J
         yn4VAY2gecZUqujO61Q2csQ2SNfheccsPKQjaEGQ28ocIhNgEQvqWkZbLcHL5lkkVSqW
         AJeITBjixyfy3Rbe20RzCjomkyukqwUIrGkJ+oeHSM9TFZuy4sjmpmbmV2Slmmu+21R+
         /xOw==
X-Gm-Message-State: APjAAAXvr/bKpGnAIlikCksiLeeYQbvN1t8QoV34tnTE3dR3e8IBCa76
        Mz9hH0hvUBmVADIBFtv+iD/XLsHjoEKktHMjJyiPCg==
X-Google-Smtp-Source: APXvYqzCKjg45tJKERrykwPUGSuvKz+hjzMmNcjl6CE6Dw1vz4H7648JzVQqbrqc0NIeC+JpXC/vi4Q6HAipqR6zkhQ=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr23066520otk.2.1571044192234;
 Mon, 14 Oct 2019 02:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <000001d5824d$c8b2a060$5a17e120$@codeaurora.org> <CACT4Y+aAicvQ1FYyOVbhJy62F4U6R_PXr+myNghFh8PZixfYLQ@mail.gmail.com>
In-Reply-To: <CACT4Y+aAicvQ1FYyOVbhJy62F4U6R_PXr+myNghFh8PZixfYLQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 14 Oct 2019 11:09:40 +0200
Message-ID: <CANpmjNOx7fuLLBasdEgnOCJepeufY4zo_FijsoSg0hfVgN7Ong@mail.gmail.com>
Subject: Re: KCSAN Support on ARM64 Kernel
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     sgrover@codeaurora.org, kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 at 10:40, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Oct 14, 2019 at 7:11 AM <sgrover@codeaurora.org> wrote:
> >
> > Hi Dmitry,
> >
> > I am from Qualcomm Linux Security Team, just going through KCSAN and fo=
und that there was a thread for arm64 support (https://lkml.org/lkml/2019/9=
/20/804).
> >
> > Can you please tell me if KCSAN is supported on ARM64 now? Can I just r=
ebase the KCSAN branch on top of our let=E2=80=99s say android mainline ker=
nel, enable the config and run syzkaller on that for finding race condition=
s?
> >
> > It would be very helpful if you reply, we want to setup this for findin=
g issues on our proprietary modules that are not part of kernel mainline.
> >
> > Regards,
> >
> > Sachin Grover
>
> +more people re KCSAN on ARM64

KCSAN does not yet have ARM64 support. Once it's upstream, I would
expect that Mark's patches (from repo linked in LKML thread) will just
cleanly apply to enable ARM64 support.

Thanks,
-- Marco
