Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DB2C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8716B2189E
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q0Zjd+TM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfHFViE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:38:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45167 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbfHFViA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:38:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id x21so2980867otq.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=lorWiddpxg2WMsy0/smy1K1C0pOfS2GdN2jnCeFogUs=;
        b=Q0Zjd+TM00oZ630nvIWNZ+HRm51Wsx5YHS2eeY8dHTTrbbgj7LjxyTLFOfgusW38kG
         wUssvWh5QtUnttZvlObrMx4ERY8wi8VJZsi/QRCWmLJ1w5S95mvpP8qXP1UYr1dH/ZmW
         5KGIqlPD1hOdbJX4af/sLexZHpyTvOce84cZQ7GSnGYvxPmiIdZg6KNhOqdRIpLtn5io
         rpUIoH4kb87hxR8tv8gevBuwFMYmJLwJC2E39hMHz//t+3AR412RMkSTzP3e8T/0wocs
         a6iP2KtaSIRWpj0P/BDXMz2wcO4uxVeHP2eSBk45hWyLOcK3kjynpMKguic5NKjTjKxf
         +ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=lorWiddpxg2WMsy0/smy1K1C0pOfS2GdN2jnCeFogUs=;
        b=MbTA0kcCLYvop+U3fRisp7WntDHe4/teC0LepxfoMG6/HEFicoaQlSkBnwgDWJMqJs
         vaY1kd80NHDZf+bdW4Mo4yadiQdlf0EvhPtyaVi1Lz89xyghbBUwl8vEIsnmB5j+jcza
         9+QGmJAtNzmOObcCN5+P3zBbMPqNAGCy9u50rm93qaRFE0iXCAyqURnKT60+k+4cuwGt
         Cms3ZhyvFc43XpQhq/vuaphf2TDFKx6iq94QGZ6Eh41LK+G7mNDdyMnSW7GUYYCpRkVi
         vK+XZ/XaUqQbRGQSXYYHFF5a44JPWHG7W5IjHcrq2YPkjgwyTvWULJn3bLLZqkomuCcQ
         +kIw==
X-Gm-Message-State: APjAAAU//B6tn9U/OrADnACmBOAb8K6qXhwLo87EIYuxnWxWQnz1m0Xe
        gRL1C5Px/O+56+e1UupnrtuxIw==
X-Google-Smtp-Source: APXvYqwDSlDrT26BRCk2A5kNmd5K8poKBkr8uW3JWosK9nm0mwlDSBLckAmTzrf3lJWlTfKIVDn2LQ==
X-Received: by 2002:a5d:8497:: with SMTP id t23mr5657932iom.298.1565127480073;
        Tue, 06 Aug 2019 14:38:00 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id t19sm78314934iog.41.2019.08.06.14.37.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 14:37:59 -0700 (PDT)
Date:   Tue, 6 Aug 2019 14:37:58 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 1/4] RISC-V: Remove per cpu clocksource
In-Reply-To: <20190803042723.7163-2-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1908061437000.13971@viisi.sifive.com>
References: <20190803042723.7163-1-atish.patra@wdc.com> <20190803042723.7163-2-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019, Atish Patra wrote:

> There is only one clocksource in RISC-V. The boot cpu initializes
> that clocksource. No need to keep a percpu data structure.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Thanks, queued for v5.3-rc4.


- Paul
