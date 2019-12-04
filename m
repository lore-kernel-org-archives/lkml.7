Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB344C432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA70F20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="n+endFyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfLDAKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 19:10:36 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40572 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfLDAKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 19:10:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id i15so4713747oto.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 16:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bP/Z58Vpywuyv/5D0jzMkQmzI1y6rfhslg4IeZkkfuo=;
        b=n+endFykFTnqubh50VPrXWkbnh1C17bRb+kJ9KNBP/OIi7x5Gt2jj1jE4QZA7KJurY
         AmrrjwyLa9EL2YmIn51znrTe82kgYxVYb4tLoDdwL2i+vPlgbkpVcj6m7pMlSdjd9sS2
         r9MtD6OKyJPruXqeyonngHAeBsm12j1uI3P8b3sknK6mPanlO+r4UIVQ1V03cycZtXhz
         6S2haS740B2yykeUeD2AmsBNf9OQYJjoQ0R/vwHSG3uAXmE6/A06XwFO6stEeNKU2v3l
         cu9GPX1+3bpbLQBsXGff+J5r4P4AFK8ST082lrYg48CPCG2n/qjxNBaFyeCcsyLSWGFE
         S4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bP/Z58Vpywuyv/5D0jzMkQmzI1y6rfhslg4IeZkkfuo=;
        b=VahQU3RId5LU4etRYb6QjAAjgiIrJe3xlq8Nn5MDDyzMfqnrw8zZ+vSr4Z1G45cJ42
         zLF5F7VY8FCpPBVh0zQ1cflcE5usVbGpn2CsW+lvozWGlr0yAz9EARtOHh6y5Oo8E+ac
         LO1fW4GFmwVsRfvh4ohPuAXY5v535SGbaJC6CtCsc3WakKX+kmk7w+wxkB6MZIDHsfBi
         esHjgR/XMXgCisqJuR4dkoSDS2Cijd8dBoA3q/lnYrExl6H0vgi/JCAjYBQ/5jzfvHK3
         kY9aIqugaTFyfl5b9Lc2j6ee5YpZVYwBGA+5YPWIhxMqU/uo8RrkIP8zBvbVBUUSiIr6
         7+xA==
X-Gm-Message-State: APjAAAVDDtOIkZ4fojz5dh83D2mItFBzAf3GZtuihYRMrevyyYAmMYzT
        gId0/HA1DiZ/5SZHr7MGFxvnBKh/d2nUKKIAZt/viw==
X-Google-Smtp-Source: APXvYqxo0TCLXhSv/bqImk1LBzsS+WuhFsZnPo87Ddb1FLy6KXZX2IyaJ7m+s1dMLiBho5Jej4+R6eEkMFQ/ORNprE4=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr511782otq.126.1575418234712;
 Tue, 03 Dec 2019 16:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20191203034655.51561-1-alastair@au1.ibm.com> <20191203034655.51561-3-alastair@au1.ibm.com>
In-Reply-To: <20191203034655.51561-3-alastair@au1.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 3 Dec 2019 16:10:23 -0800
Message-ID: <CAPcyv4hhK1dyqqe=CwnGfd=hRdUJn0pL6scCUgCz2R+bijZvYg@mail.gmail.com>
Subject: Re: [PATCH v2 02/27] nvdimm: remove prototypes for nonexistent functions
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 7:48 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> From: Alastair D'Silva <alastair@d-silva.org>
>
> These functions don't exist, so remove the prototypes for them.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---

This was already merged as commit:

    cda93d6965a1 libnvdimm: Remove prototypes for nonexistent functions

You should have received a notification from the patchwork bot that it
was already accepted.

What baseline did you use for this submission?
