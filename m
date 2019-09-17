Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F9EC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1634421881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NIs3zdhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfIQPVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:21:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50997 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfIQPVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:21:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id 5so3989434wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=OjulAGrUuGemM9gSZfSlGAauZMenX7YjWl3lxcSoow0=;
        b=NIs3zdhOCngBnuBHO1LbLej0XYA0fx3pJvBb5LAq9irsW8UeUktgNHXZMnDZxyaaOr
         2k+bvHUE/fHLZ7lf9Kul73T/QwVd+bmEflgxCK0SnHStHOhQnALmk8nuUmXyAzCWPul6
         tMU6PN1gvdxlyq/5hh21ijiyxq8ZglCxZeGrVjRnZhCGhY5VeaZ2hh7BtJOh1HISOtA8
         1CVnUwBkgaQ0rUpkQ3ZI8DTPHPTiJ4vJpGCsUBPhH185EKUvoa7BkmeUtt0yYJ9bTDs6
         u780dgRKf+UcHeceEUe9nq90hYS03wwSc0u8KF7NyWXCV7loB9k1CStMmQLhcJ1cU7zh
         34og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=OjulAGrUuGemM9gSZfSlGAauZMenX7YjWl3lxcSoow0=;
        b=KxGpXS3ezEzJMzvBStzwspptY2xHaKe5SahhSDQWIDVOdWAMMfUtXO9XS7lJVNPXNi
         rUB6S6N/6vyVQzjdqCFPAHOH14UYnWuUTgFmG8NgUtPCojQUV7dAqW4GHTVeXR4etkDv
         pxR/yFNCvujPZIk/u4cTkUbT+tcjD2DW0hJqYRZIWRmy8sPScwJFkhy6KrdsDJYFJjrC
         uY1FBtkJVu1Dz+D5C4CI/Kw8tgI3nacwC+m5v1ZMd5fglpsv4w+7muEYIrgwV/4sqnbI
         WSVWyW61O4fokiSHJQIBwBykrs2FhcfamnZntyl5vVnhzW2Jx29bgb0wY2NouHVYwHVp
         3+Sg==
X-Gm-Message-State: APjAAAVK0IjRA+mfH5lVElKZDpNblcRu/NA2ha7bsOB4WDX5IKhpxZk3
        J57UHwO/gCBX/joKUYW07kwNng==
X-Google-Smtp-Source: APXvYqwbUAYfuqjAyAa/Lkp2LToXiaq5d9pX178q4XtabOWrIVPxdsT1Xyr0gfOYq00MaiHPBKzAoA==
X-Received: by 2002:a1c:9988:: with SMTP id b130mr4310361wme.164.1568733668324;
        Tue, 17 Sep 2019 08:21:08 -0700 (PDT)
Received: from localhost ([195.200.173.126])
        by smtp.gmail.com with ESMTPSA id v8sm3712084wra.79.2019.09.17.08.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 08:21:07 -0700 (PDT)
Date:   Tue, 17 Sep 2019 08:21:06 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Aurabindo Jayamohanan <mail@aurabindo.in>
cc:     Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: sifive: check return value for
 platform_get_resource()
In-Reply-To: <alpine.DEB.2.21.9999.1909170709070.8198@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1909170820470.21451@viisi.sifive.com>
References: <20190917085627.4562-1-mail@aurabindo.in> <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com> <alpine.DEB.2.21.9999.1909170514130.11980@viisi.sifive.com> <ij_UksEXUomr_L7KQam02lHBryAppgwKDjG90VbVcRRUeXlKU8TAiBWc3aU8vt20Wvlwt_6NDgz5fuMSwwP1mm-1eP6GYWoR1Kbr0y0ElRk=@aurabindo.in>
 <alpine.DEB.2.21.9999.1909170709070.8198@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I just recalled that YueHaibing already posted a patch to do this:

https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1909041520130.13502@viisi.sifive.com/


- Paul
