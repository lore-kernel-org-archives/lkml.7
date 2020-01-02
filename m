Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B2CC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2102F217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/BhNFU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgABJQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:16:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42348 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgABJQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:16:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so38509771wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 01:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6a8Lf8iEQGPGso4QNX6qUnH52YiLw9fw+hSHtKVe5Q8=;
        b=D/BhNFU6bkcHXvEEINUxmv5FYMGVJ1xnqDnkjQKk7Psk38x8ZeFVyul9+U+jpd1eSP
         DxvMkMuhFGPsr2bguS5sbWEVvTagxv2BVzUbBhBbrrdyWk9xlc8tg3D3q2X7UFR+mwKN
         GcAsYJtTgJU65WZgNmIIt1F79AXFFpX9hW814XSMl9le+PMU5d60T6mviFe/KlEv9DLc
         vGkMkDKBZGJPQGsq68gzWbOkhr1331JdL4w9uJLRmChkAHHnw41iy/k6wKJ4iKH6tAQ/
         OeoTPcgC7qslPI4dGafciOxDND6ibxP83RDR6OWnZvq/XfZfKyzIMb6TpoOakUdfYbIt
         Yg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6a8Lf8iEQGPGso4QNX6qUnH52YiLw9fw+hSHtKVe5Q8=;
        b=oEOIPo3SbcPcdbGWQ8eXJJMxFjiUtEQMNQFSYn647OmkT8UWPrr4vBknLfgyEnQMLm
         H+G05kK+NB9NAYx25ILOTDVSTFKJA8eLq/84aXCjb2Iskzs/SFj22fmcoHrqpJ5IAC2T
         yMlOPKbRZ4kR5opgOTMluRSSYHRtsogNY2HYLRvqapkcdyL2Ku++AVSW+W7DgL+YRWgn
         k1OYjP0ZTSHggQW27DM5cjaAK3da5OZSvAMAre5vHvLtTp4h+gzdwxOeMHB/FvMmsx9e
         zPYaj5FyZJuhk6/gax1YiCSBDgI2ZCtRtfhpRxoFc+9SBT++72wL6LyABJaDEER3WrTS
         aAhw==
X-Gm-Message-State: APjAAAXxWA+uFYzLfOVYXD1Q1B1tsNC1D6hbiWM9xp9ebQYbgUWPcrLa
        3CLPW1JNQH9iIK+IEqgubGE47w==
X-Google-Smtp-Source: APXvYqybG2Qh4sWG7qTZyUUPWfXvX/S5vD0yRLklxHqM3YdDWd5j3iodlFA6Zg/JlnxNGZ3VMUXiHQ==
X-Received: by 2002:adf:ea8a:: with SMTP id s10mr79641067wrm.278.1577956573505;
        Thu, 02 Jan 2020 01:16:13 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id 60sm58034828wrn.86.2020.01.02.01.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 01:16:12 -0800 (PST)
Date:   Thu, 2 Jan 2020 09:16:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/37] mfd: intel_soc_pmic_bxtwc: Convert to use new SCU
 IPC API
Message-ID: <20200102091625.GE22390@dell>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
 <20191223141716.13727-28-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191223141716.13727-28-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019, Mika Westerberg wrote:

> Convert the Intel Broxton Whiskey Cover PMIC driver to use the new SCU
> IPC API. This allows us to get rid of the PMC IPC implementation which
> is now covered in SCU IPC driver.
> 
> Also move PMIC specific IPC message constants to the PMIC driver from
> the intel_pmc_ipc.h header.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_pmc_ipc.h |  3 ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c   | 22 +++++++++++++++-------
>  2 files changed, 15 insertions(+), 10 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
