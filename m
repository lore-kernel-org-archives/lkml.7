Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE4CC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1C62080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IPuTYW4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfGOLbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:31:19 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41084 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfGOLbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:31:19 -0400
Received: by mail-ua1-f66.google.com with SMTP id 34so6590168uar.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 04:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XU8jKhBVJIGwCUR6YALgDf3CzV2y2cp7RAEeInAmf8=;
        b=IPuTYW4kgjiPJCyH1ulOxymE3bGfWfAPxbnGMMdbmXgssWbpw0MKDtY2U7jTXveIbD
         h3cxipr1WYPFB3gqwLBvVEUrIqUtwX4RHgnKJandIPsbDfadTa4jeydkybajjZ9r1i48
         F6jgvAAQGwrK5PsDDfGllISYJ+b1ElTIDkZKLYiTzA9iXle/autkWZ6fY/kbLzk89XgR
         rVrB7OmeRRk/T8akIfk+3Qu8D62jjB/4JOLLpsg5TfHVwoIRAJZxxtb5o7iF6n7EgWcf
         MXVqSD0AklbE3z/ZWXs+IAnGxZVTVLiazXoYHlCkK5qdTfSCPMqmtsxwXcY6RrIyEb0Z
         CiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XU8jKhBVJIGwCUR6YALgDf3CzV2y2cp7RAEeInAmf8=;
        b=Z4HaRJ12WgE7avQA1gpKpptpWotpHlUwRzltWtJO2sTWCxtBdUh9PQ+hXVExuhAhe7
         G5qVgW16jgpHJziXw3hW58bIJExNlJ9lpagaj9tIbBZOgfJNoOFuNWf5ye3tZz0fY2+f
         WsBAzqNpuMWqgYq9GGRjchN643dP2NcbvAQWn6AddZylSWJBpHxjv9px9KwL7HvLBAHm
         HEUHMyLsGwNJE4ZHIw1uvDEGLm94B45J3fRD6MF7VJOYIotraLOJve5f0uxtCqGEep4k
         dl9JrXkxGuKx43e3n8W6hUAkxy/7Gpw9gSNvjktwh3fEBwM9R2owjIhe1BJmDoIVm7Xh
         kP1A==
X-Gm-Message-State: APjAAAXckfUZFAP8ssK1+Mm7KFgwCsGNd9kwfXUURFurf/TjCHHBPtWU
        euRp4D0yo8nXYlO37T+/8JL/sgGqj1c6PcExgLbJcw==
X-Google-Smtp-Source: APXvYqz8kX/FHtA/R6g5rZlZruok/jN5jkOYLlQ0oreU3tYwXOubKKFkfzEoS8mZB9/JdupuUl3LMxao7rM9cewVF2I=
X-Received: by 2002:ab0:30c7:: with SMTP id c7mr15963841uam.143.1563190278200;
 Mon, 15 Jul 2019 04:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
 <CAARK3HkMz3AdcVyrteGmqczCaMDTYS1h9uALspm75RFE9c6jFQ@mail.gmail.com> <14025233-db7d-2307-5367-d41ed24f371d@microchip.com>
In-Reply-To: <14025233-db7d-2307-5367-d41ed24f371d@microchip.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Mon, 15 Jul 2019 17:01:06 +0530
Message-ID: <CAARK3H=TJNABphR_WZEQ-6ZTkr4ugEJhyutdXE_JZiLS-EU67g@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] mtd: spi-nor: add support for is25wp256 spi-nor flash
To:     Tudor.Ambarus@microchip.com
Cc:     marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, miquel.raynal@bootlin.com,
        richard@nod.at, Vignesh Raghavendra <vigneshr@ti.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On Mon, Jul 15, 2019 at 4:35 PM <Tudor.Ambarus@microchip.com> wrote:
>
>
>
> On 07/15/2019 01:45 PM, Sagar Kadam wrote:
> > Hi All,
> >
> > Any comments on this series?
> >
>
> Hi, Sagar,
>
> I was OOO the last 2 weeks and previously I was busy with other spi-nor patches.
> The series is in my queue, I'll review it. You can check the status of a mtd
> patch by looking in https://patchwork.ozlabs.org/project/linux-mtd/list/
>
> Cheers,
> ta

Thank you for queuing it for review and sharing the link.
I will follow-up on patchwork.

BR,
Sagar Kadam
