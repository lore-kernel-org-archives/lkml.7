Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02801C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 02:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C881B20856
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 02:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557196491;
	bh=Io0xSI3lw5mzyWHx0UyKpI/9H1mnLEQDYX48uIGJcBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x9OSy1rsLlwcdnF/nzmaiRI1l/qcuUGIBHbLuf0sHEoe8soamf6Ay9f4xtR+5avTO
	 AKhDi7y/Lk9vI9WkqxLosLCcergl4sjP4N6UnAomru1E8q+YMR58koLPYWzGdQ6hn4
	 yhq4Wz4oJPNY3Tvj4hdmG5oXSNMH7H4Xp2dvE9GQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfEGCeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 22:34:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46919 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEGCet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 22:34:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so12802886ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 19:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtEkyVeK1FG141ZNbqUNDiDkDaGa5Egmv7z41Kin/Z4=;
        b=bMpsabR8hmahjs3RFGKw3QVCOwzsV9GbkOHIuC+Dib6ELB3W2v2LQnqamGXsCBN7zp
         k2yliPz5yx0OjC3SBTcyQKjEUZ+6CaNyC8hMRNBJWhX/dULq1WZ6c/SMO3NcID56id8n
         se1+GooMIUOS9ysKu0WWktm1ZEx0BepMEm5/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtEkyVeK1FG141ZNbqUNDiDkDaGa5Egmv7z41Kin/Z4=;
        b=o/8aRKWwKgD5sBmSLZrgfr0RJg907MBKmJbFLWQZpEWV6xHJ7x4FF0le5/gxdULXmQ
         1u6rFXUBC7De0mgXbV3jS8mjxbvDc7h35PHsZPnnWazHepc3U+OEVtSgXulTbomU3wP2
         UG0Sji0ORhti94rrjPpLIHeKYooQZfVqUnRskxDckcDA+bRlPzgP3gkqMYLDNtuUqf+C
         D9bOarkTG+PLOp2LwRF3iRejjJxVUd2OphYfqfzvedYahizn/kND6iR5VN32EZFtD2s3
         rSqGBww6eTA5OURjwBV8bNI6HGKzz57aV6rci5REme2oR5FhGDHgDqaKz0XejIruVCzK
         LQkA==
X-Gm-Message-State: APjAAAWkTzdadI9Rd2yZI/mutP852Yng22XwT4YMx5MT81g4Pfd/f2To
        jRF34EkZhtQ+MOcIWEGUUkh729xS+As=
X-Google-Smtp-Source: APXvYqwY8SD2YvqCWV28Du2lSWCRWMElTO76abFaQqsoR/FMmRvojk6AbjxpSPCnDN2sIrw0ABHuBA==
X-Received: by 2002:a2e:8098:: with SMTP id i24mr7582328ljg.88.1557196487383;
        Mon, 06 May 2019 19:34:47 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id b15sm2868958ljj.1.2019.05.06.19.34.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 19:34:46 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id v18so8403509lfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 19:34:46 -0700 (PDT)
X-Received: by 2002:ac2:5a41:: with SMTP id r1mr1358836lfn.148.1557196486137;
 Mon, 06 May 2019 19:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190506143301.GU14916@sirena.org.uk> <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk>
In-Reply-To: <20190507021853.GY14916@sirena.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 19:34:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLZMe5kNpNMnhh5oVHFKNv7Um4tBS+rH=kLvM+CWzzxw@mail.gmail.com>
Message-ID: <CAHk-=whLZMe5kNpNMnhh5oVHFKNv7Um4tBS+rH=kLvM+CWzzxw@mail.gmail.com>
Subject: Re: [GIT PULL] spi updates for v5.2
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 7:19 PM Mark Brown <broonie@kernel.org> wrote:
> >
> >     dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
>
> That looks like it's a fail on validation of the kernel.org bit of
> things which I have no control over and which purposely doesn't
> advertise DKIM stuff in the hope that people will actually be able to
> send mail from non-kernel.org mail servers.

Looking around, I think you're right, and it's probably not actually
the DKIM thing that causes problems.

Because yes, kernel.org dmarc will just say "ignore".

So I think it's just google that still doesn't like sirena.org.uk.
Iirc, that's happened before, no?

                   Linus
