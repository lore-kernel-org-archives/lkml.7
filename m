Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6621C2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E1C2464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ZyBCIqvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbfLERFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:05:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44763 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfLERF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:05:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so4498908wrm.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmiicMy/6M+nsAYismUP6xCcu8kfa7/13Wnrua1z9JQ=;
        b=ZyBCIqvHD5Fw3/s1GossAdaOw/98K3zrqYDElXCxBpi4/Iv68AoRrJRRnG7HyBO2lW
         MTWiDEDoFmNklk1lP/I5zIT6bEjood7Bk+G0PlzfzSVPTNkDyuKZxFXBXoxqiYqXtbBr
         2njrE6Br/bHNIpleZjeD41c48Wm/O7MQnua5TsIuspIVxVOJEACbpVFEepSRH8YvuISi
         8/My4nIfSwAGy0BA7RKcgkkpY7cX6cjhLrLT/7QaEa1MstVIUgtC/c+kB1rVjMElb3iI
         D5D+CWD+R+Qe3qia42mRY8QSLu3uqYi/9SjS7DioUpOb0d/eyoulcNdrtTv22qmVb+oh
         o3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmiicMy/6M+nsAYismUP6xCcu8kfa7/13Wnrua1z9JQ=;
        b=h0c5PnF4HlyFTpSrAvamUSy5NlJVa67MlMd9Ko28sWPfcXwxvr29WvuzJ2ulWyzCPK
         +VGzQnypHAO6ja42r0qNWymmbfztjACV2QZa8ZAtAahH56WzK9zFXGEK45kafZNA4l7V
         xuaMY3EaQM2K+l/++F+iYgRCPBty+gyXqVzE3evng4mZ+nmajCXsugHy1g/+HJXy5baI
         XUNJl0Y86AJo7SA5aMA0Hpyo3CWZKApMsQA0hOPvE+0wRJvzIHDbtBhfyrJ9+pX8EE1t
         x9bKcqfyjscgZ6fC3hrm/B51wUOOEyQRxW+TjIZxrPUF2+2wABFNWXSZ20pmhxap3qx2
         3jcA==
X-Gm-Message-State: APjAAAXfPp05btGU8XfiAVOex26rhLQHtZ0dypBPJsBOgkXIRrKvrhRu
        3HU07o47trrx/CKJ/ja4cAGoTrOTrae3ZepT7fCEnMS39qQ=
X-Google-Smtp-Source: APXvYqw4k4hAJNrFCSqp5tAxbLz6JAprMFbTtuiQEa4hm28f/i05PdxA4aj5EH1iDs22iFZgxPNrT87oVQSx5niAtW8=
X-Received: by 2002:a5d:4752:: with SMTP id o18mr10964514wrs.330.1575565524767;
 Thu, 05 Dec 2019 09:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20191205005601.1559-1-anup.patel@wdc.com> <alpine.DEB.2.21.9999.1912041859070.215427@viisi.sifive.com>
 <CAAhSdy1RQw3MVcVT5y1EHr72LDNADKRL5nO2E8OrzBi+tpuvtA@mail.gmail.com> <alpine.DEB.2.21.9999.1912050900030.218941@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1912050900030.218941@viisi.sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 5 Dec 2019 22:35:13 +0530
Message-ID: <CAAhSdy2ySO_TGL9EYsHnk2p=tceRGaVfogyhthqJEJf-AoOCYw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add debug defconfigs
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 10:31 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Thu, 5 Dec 2019, Anup Patel wrote:
>
> > I understand that you need DEBUG options for SiFive internal
> > use
>
> [ ... ]
>
> > This is the right time to introduce debug defconfigs so that you can
> > use it for your SiFive internal use
>
> [ ... ]
>
> > and you can find an alternative way to enable DEBUG options for SiFive
> > internal use.
>
> What leads you to conclude that this was done for SiFive internal use?

Why else you need it ?

It is not at all a standard practice to put DEBUG options in defconfigs
across architectures.

Regards,
Anup
