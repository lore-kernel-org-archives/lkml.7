Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D52C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B751B20645
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="czjywQBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEBS6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 14:58:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44094 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEBS6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:58:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id z16so1461079pgv.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=5FgSWzT6cp2rvJ1/txB98YcNdupdx1c0jgM9/LDh5nA=;
        b=czjywQBHbF0HA0icUfD5qcGpwPG3KMZkyi3FO1PvySKIAEdrS3LBSNyBEwB/WJZkDE
         z4GOfEWnt/T5/aTAsPev7b/4n6zxo3xHvW1hpiZDxFYiLhxaWd5v8Y7Ju5fcFrsszttJ
         oPTqz6uy/8U0CeTBuOyFcuDmfMjW6dmDfvM6B9cm43s5hRMX/r7JP8VFj4eaX6IR8Ydi
         RsYZnO0o8J/IgIpYifiWy1s3319OwkDHVDEYdl7nRAoCPxBKQrKepf1AOsDP82+bU0nG
         n2eSTYzXxYfx+u0fMIMix0W+jqcjR0vv15MwD1OKqAXGvyFmYJQR6iemBYbNm+EEBdLx
         XuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5FgSWzT6cp2rvJ1/txB98YcNdupdx1c0jgM9/LDh5nA=;
        b=NWQL1hPpzFFWbUQKZtue7Cq3XKVCV3lA2G2xh5vFlR7RCxrrSuGFQdr8DGgCJnWnYl
         VrFVvKQBDC2kkB81asTGJX+LNEaypZCOUeHj1HzkSV+Rw1WW4A7Eisft0PYfSDS5oA5z
         kCGQW6XaNGNx1phKnagzYZfuRd7KiAZs684hMcS3ZtM/gDDg6y3J58pNFkYASNyapMw3
         +0Yr3lG2oSv08gqbdBucVv07EPrmEwi85GQCR29oUuMQAiQzxBZTFsJxjfMgCMQZuxnO
         Oj9Q9xFPVuRtV7xWX8ZIQoYYnG1tq+OC/aAKQ4zDdcvZK9Sy/rVR7eTOowcQsDDhBPtA
         jxJw==
X-Gm-Message-State: APjAAAVc01M4I+MRdYU7EAJkozXbaj8OTTQ4d6qSlTW8QkcgogIevhwk
        k/UhWx67zaRA+2ZWbjhfphz9EA==
X-Google-Smtp-Source: APXvYqxRLqzZyute+oKqyMi3R2+Lo0Yovv9sNOI08RvIWIN78cB1mkCzZthekg8/lTPfNIgyB2pVTQ==
X-Received: by 2002:a62:7089:: with SMTP id l131mr6047867pfc.158.1556823493889;
        Thu, 02 May 2019 11:58:13 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:e50d:c7fa:92aa:c53d])
        by smtp.googlemail.com with ESMTPSA id j12sm19593256pff.148.2019.05.02.11.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 11:58:13 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, gregkh@linuxfoundation.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>, Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v5 2/2] tty: serial: add driver for the SiFive UART
In-Reply-To: <20190413020111.23400-3-paul.walmsley@sifive.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <20190413020111.23400-3-paul.walmsley@sifive.com>
Date:   Thu, 02 May 2019 11:58:12 -0700
Message-ID: <7hpnp0lm4b.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Walmsley <paul.walmsley@sifive.com> writes:

> Add a serial driver for the SiFive UART, found on SiFive FU540 devices
> (among others).
>
> The underlying serial IP block is relatively basic, and currently does
> not support serial break detection.  Further information on the IP
> block can be found in the documentation and Chisel sources:
>
>     https://static.dev.sifive.com/FU540-C000-v1.0.pdf
>
>     https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
>
> This driver was written in collaboration with Wesley Terpstra
> <wesley@sifive.com>.
>
> Tested on a SiFive HiFive Unleashed A00 board, using BBL and the open-
> source FSBL (using a DT file based on what's targeted for mainline).
>
> This revision incorporates changes based on comments by Julia Lawall
> <julia.lawall@lip6.fr>, Emil Renner Berthing <kernel@esmil.dk>, and
> Andreas Schwab <schwab@suse.de>.  Thanks also to Andreas for testing
> the driver with his userspace and reporting a bug with the
> set_termios implementation.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Wesley Terpstra <wesley@sifive.com>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Cc: Emil Renner Berthing <kernel@esmil.dk>
> Cc: Andreas Schwab <schwab@suse.de>

Tested-by: Kevin Hilman <khilman@baylibre.com>
