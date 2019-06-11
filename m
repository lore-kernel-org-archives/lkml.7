Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC1FC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC0620673
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390371AbfFKNMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:12:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36056 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390242AbfFKNMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:12:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so7589101qkl.3;
        Tue, 11 Jun 2019 06:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyYvnirAncfvqftH8b0du6PTVoUwek5hDeS0HicdvJ8=;
        b=a0gDpktX2fWf6Gi+wK6lT/F9VVIzl1ms/u98eTt4Gz7fp+vl73j+u+ZPuqBggcBE69
         fCjIAEwJIvrODWmDMQwlpZMvqHQKaEydPGlHJ0saMvsjo2YnVA/HcvmyEaIikVA5+McR
         DMth3ZVgxSFtDZ6o1/4GQC01AVPdsz753Z7UiAkgHjCP+YT4V4FocO2ZlpHsd2eMHxft
         2Ruy9qo4cuWMXQ3sbZ1P9IEFaCEm3zfjpLmZRgXiyiepypbMKX5qMiUAP3p873aqhi0g
         U7d+kS8ARmSvQCMqHAuMVLbx1uPg9F7+V+xIwZmUha5MQsXsXwUD+Pes6H7DKQNFH8g/
         3dvw==
X-Gm-Message-State: APjAAAVggiqXGCaYc9kPIiL7aXP5FvhijUfzONkm9OKEJsgkIwN7eYgU
        0DubTmDONT5Y2XChPD3FD2QBHYV3zo7dRvox0OA=
X-Google-Smtp-Source: APXvYqylIdCcVDzvlOPTn/Jad8SMMmSjCbrCYwIscvJcBt34a5gTosawEIrvHbQw778UawvftHqdj+8EU+S0lkdHer0=
X-Received: by 2002:a05:620a:16c1:: with SMTP id a1mr17486493qkn.269.1560258724850;
 Tue, 11 Jun 2019 06:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190610133245.306812-1-tmaimon77@gmail.com> <20190610133245.306812-3-tmaimon77@gmail.com>
In-Reply-To: <20190610133245.306812-3-tmaimon77@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Jun 2019 15:11:48 +0200
Message-ID: <CAK8P3a0s1fdt2yHVjOXffeKPKkwUyJ7DKCZHHMKjx+3j300ZAQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] soc: nuvoton: add NPCM LPC BPC driver
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Olof Johansson <olof@lixom.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>, benjaminfair@google.com,
        Joel Stanley <joel@jms.id.au>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 4:19 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Add Nuvoton BMC NPCM BIOS post code (BPC) driver.
>
> The NPCM BPC monitoring two I/O address written by
> the host on the Low Pin Count (LPC) bus, the capure
> data stored in 128-word FIFO.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

We've run into this situation before, but don't have a good solution yet:

The driver seems useful and well implemented, but I keep having a bad
feeling about adding a chardev driver into drivers/soc for something that
is clearly specific to a particular implementation on the hardware side
but generic on the user interface. The same user interface might be
used on an Aspeed BMC or any other one, so please coordinate at
least between Novoton and Aspeed developers on creating a common
user interface, and review each other's patches.

Maybe we can introduce a drivers/bmc/ (or even drivers/openbmc)
that collects all those user interfaces with a thin abstraction layer
and one or two hardware specific back-ends?

        Arnd
