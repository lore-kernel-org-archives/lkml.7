Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5FAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A1620650
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570709307;
	bh=gG30qz7Sr0XSbBoYXSRW7wlLr51IxikKi2bTjRnYvxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LQ6ZZrhTiRkt8aZL0qUOZO7/SU7KX9AgmSHiZRGZAXPwIj0NJS5J/YE42TtQYKbVL
	 /4fjPnsfosjFQV0PTr5gHaGX0vW6g5zwpwZgccBsDrGgivOzJWebrxZcyQL3yla1uJ
	 FJHh2RJv0Y3UmX5Ac4COnfSYuVwrq1lLgRWq2qOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733227AbfJJMI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:08:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32795 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfJJMI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:08:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id d22so2704105pls.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 05:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XmMjypGytVZHffptIbRZhP/O0ewnjNlKS7p88IhR+ls=;
        b=tg4M40cASDHJxVNSwQo728skw0SB39/EfT0itx8fUhbPtLOJb2xNZdIS223RAVIrqB
         O+S8oAoEWIFxw95ntELPyWOT5+bB1i5Ylk154aFfRoPBYBYutJP2VOX7D7umntZafp4y
         fAKVkkZbU4D+vQvPghHk/8q76el55l5MzuEd3f2qf8Cn7GPmHOSuJlI1jssiHXLKnkw4
         r0oG8uuskKUMwIPzkUrrFRGH7uBqq/W20+PKP6uK+eFeYh4XaJuQpwC+1MYyjgY99Hzn
         25lmmW1AMOEabmbLv2S68XRWUFjncvpFF7+6htyBe5oVjqdDE7R0tOG7BYxchmEX/H4W
         CYOQ==
X-Gm-Message-State: APjAAAWC7MR7WLoLaRlqtyoOkfOuLehmVg8Is4ji84ODkYFcOXSeWWf5
        +5+R5tXSiIJVDtxMj3ndcS0=
X-Google-Smtp-Source: APXvYqzpzoL0AKFn1v0waSbzHsnFgvNj4C76NrVCaOZPfK9UB7JpTasH3E+Y+WuIqMkFrMg1G0VvOQ==
X-Received: by 2002:a17:902:7202:: with SMTP id ba2mr9226909plb.267.1570709305304;
        Thu, 10 Oct 2019 05:08:25 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id m9sm5067222pjf.11.2019.10.10.05.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 05:08:23 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1AED44024E; Thu, 10 Oct 2019 12:08:23 +0000 (UTC)
Date:   Thu, 10 Oct 2019 12:08:23 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, bhelgaas@google.com,
        kai.heng.feng@canonical.com
Subject: Re: [PATCH v3 2/2] mfd: intel-lpss: use devm_ioremap_uc for MMIO
Message-ID: <20191010120823.GD16384@42.do-not-panic.com>
References: <20191010030335.204974-1-ztuowen@gmail.com>
 <20191010030335.204974-2-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010030335.204974-2-ztuowen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 09:03:35PM -0600, Tuowen Zhao wrote:
> Some BIOS erroneously specifies write-combining BAR for intel-lpss-pci
> in MTRR. This will cause the system to hang during boot. If possible,
> this bug could be corrected with a firmware update.
> 
> This patch use devm_ioremap_uc to overwrite/ignore the MTRR settings
> by forcing the use of strongly uncachable pages for intel-lpss.
> 
> The BIOS bug is present on Dell XPS 13 7390 2-in-1:
> 
> [    0.001734]   5 base 4000000000 mask 6000000000 write-combining
> 
> 4000000000-7fffffffff : PCI Bus 0000:00
>   4000000000-400fffffff : 0000:00:02.0 (i915)
>   4010000000-4010000fff : 0000:00:15.0 (intel-lpss-pci)
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203485
> Tested-by: AceLan Kao <acelan.kao@canonical.com>
> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I think you'll want to Cc stable for this, as well as the last patch.
LTS kernels with the ioremap_uc will be able to leverage the fix.

  Luis
