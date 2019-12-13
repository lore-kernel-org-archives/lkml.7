Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DD0C341AB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0702B247D5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Bp//zj4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfLMQo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:44:58 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33955 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbfLMQo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:44:58 -0500
Received: by mail-pj1-f66.google.com with SMTP id j11so1438667pjs.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 08:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=fmI0q2QLwZdi1/ko0IPKbdfR0E57YPB/Rs3JgkuWmOE=;
        b=Bp//zj4JBODXzYJJt7veZ/peeeptebZ8fr4dGpjaOgGTbKBdU60fw5XQE6jAF8ljhD
         VkU64UqGutn0G5bSFoAJ59Rb+GV6l70KWPlLdZ/F9MVdyN4z7XKlN/laM9deWvBjbuCx
         1U5k61e8NBl9yGOQEL+C9RBShdt9tlxPbaeSr/gW3HtrGGLRwJ2jb2UcE+9xd+KNPKQz
         Jj5MaiJxpRC6BcyfsAGEgEiqu8je2bBaaJjpnWzpUI3dvMJtZKJR4WOvciBXMF+vLbsH
         Z9i6D5YgK/zoTQaD3aRhDfkIzWNPOkSigMn9f7jqZtvXga86iIBEQYOM0BM1eYVYi9Jj
         DcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fmI0q2QLwZdi1/ko0IPKbdfR0E57YPB/Rs3JgkuWmOE=;
        b=LSCe506/M36hMFYEwNpjAO/keE3wHEF52XuXGHro78S25vxrE3eTO8meAFr2eFZscO
         2EX+OI3FE/KPtR0hiBZVke0y8DQXSYOtMcn5Prhoz8BpJP1EGgYNjSlpEyW26GEMXS1S
         v+x1tUdwwwJb+pC8FEUVYYXdh69yDq2e7uxuzUcKA25h2o+PbhZYidpqyWA/1XLblkFe
         G2jCuWsScz/ec9LbcDYYyRoKDoTJM1uAJ5a5XMyU5RNJfOqylnaUPjKAktgj8kHtk44s
         QC6Ff+TCU52SAxGkbRSUYOxyAtfvy5PgMKHidJGTY1LoLQoyYdSuxV4HytxwFOyExvAi
         PICA==
X-Gm-Message-State: APjAAAXh6k81Oy383xnCzg2janbFoPsxRmDCMjIVksdsrzcSAyulJh5r
        CCrtqLCr/r5PSQohwlD2783Wdw==
X-Google-Smtp-Source: APXvYqym6EAp5lYCv8KMi1Fhh/VFm6LJynE5N3+KB+ys3E7f6IvzFL3EHBCYw3mNN3ueV7B57ro+vA==
X-Received: by 2002:a17:902:6a8a:: with SMTP id n10mr241277plk.9.1576255497466;
        Fri, 13 Dec 2019 08:44:57 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id q11sm12167725pff.111.2019.12.13.08.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Dec 2019 08:44:56 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>
Subject: Re: [PATCH] clk: meson: g12a: fix missing uart2 in regmap table
In-Reply-To: <20191213103304.12867-1-jbrunet@baylibre.com>
References: <20191213103304.12867-1-jbrunet@baylibre.com>
Date:   Fri, 13 Dec 2019 08:44:56 -0800
Message-ID: <7h1rt89nuf.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> UART2 peripheral is missing from the regmap fixup table of the g12a family
> clock controller. As it is, any access to this clock would Oops, which is
> not great.
>
> Add the clock to the table to fix the problem.
>
> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
> Reported-by: Dmitry Shmidt <dimitrysh@google.com>
> Tested-by: Dmitry Shmidt <dimitrysh@google.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>
