Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EF8C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A349D204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nC+AT8Fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDKIyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:54:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33841 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfDKIyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:54:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so3151414pfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=lM+7ijBmcENwcoBLSsPq4JRUUBqamx38sGKH2ENl6NY=;
        b=nC+AT8FxR6Go47Pfpqe5BS4kmTeYhlkkc8zqEnU13SweRx2Xm3AifctiNnzm/GNKIY
         pfUChsm8/Od6QQRgcteTuojPMARCgxf8zvTwwIpY/tpXfoc9AtZWXrPUxLvFhZ94YdoL
         /gpmkREvdUAOYMiPo43QO6GF+nhuhlgJEZbH2eM3sM1FfgVoT2DkfK/iD5vopYKDf3bR
         tDbYjGI8LvC3/P5zIf9x2lf+5Phd0XvL5559GbXr4TW8H6wadhkMpQhhMI2AV/hhab9F
         DjEbp4ayQAee+Gd/9qyRywpmTOseMlIaWk3OL9695DwzBLAtqB5fGwbpDvTS/01bl7SJ
         J2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=lM+7ijBmcENwcoBLSsPq4JRUUBqamx38sGKH2ENl6NY=;
        b=AqZk0bebs2ehxT9S+PphhPXO0ud4sq4jRolf+QZhLdiA/O1JULhz5jPYY4qDuw12QD
         KnekINLAuHbzpfBS9KS+Fo2lke+ZvOC1wgti0O46nf0YDh/pEhLQydIfQLAzDHCxw7Ib
         9oXNomIpEGYFeKYKf7D7CJthkz86oEHBeu6MIt3jHiOYKoga7E9HcZoo8opY0N0UW3Wf
         QJqJpGoB1fsvfCq+8et05WptNGuj+/xXs0j+gvIv+qwC8cktUzDHWGmI9QqtEEOfUBOc
         TSTo1BtTGhRb8fpB0+OiS6OzzrHwlhs/jE4bXDLH5PEYcQ6myHXr35Ss4K3Z4ZSYx7UA
         FA9A==
X-Gm-Message-State: APjAAAXVeaXCR9ZAKzhKx3Akdn8YaeZbiGxxCZ97jxOICM7212m2y8Tx
        /6FX4zbZulSz30x9sHZQVde+2A==
X-Google-Smtp-Source: APXvYqw3TS0JoMsPi14KZqAaAAf6wEEZ7R25khR/kqFc2ttzp8CNzulQGjJ55DvlUciFoLtHER7iqQ==
X-Received: by 2002:a62:6402:: with SMTP id y2mr47617836pfb.194.1554972846514;
        Thu, 11 Apr 2019 01:54:06 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id e193sm8358501pgc.53.2019.04.11.01.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 01:54:05 -0700 (PDT)
Date:   Thu, 11 Apr 2019 01:54:05 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Andreas Schwab <schwab@suse.de>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tty: serial: add DT bindings and serial driver
 for the SiFive FU540 UART
In-Reply-To: <mvmr2bkxntv.fsf@suse.de>
Message-ID: <alpine.DEB.2.21.9999.1904110151030.5868@viisi.sifive.com>
References: <20181020101045.15991-1-paul.walmsley@sifive.com> <mvmr2bkxntv.fsf@suse.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019, Andreas Schwab wrote:

> Trying to log in on the serial console causes the system to freeze.  The
> last message is:
> 
> [  115.597858] sifive-serial 10010000.serial: BRKINT/PARMRK flag not supported

Have not seen that problem.

If you're still seeing this, could you follow up with me off-list so we 
can synchronize configurations, both with the kernel and with non-kernel 
boot & M-mode components?


- Paul
