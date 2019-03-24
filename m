Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0555C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5732148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaT/xtjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfCXEHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 00:07:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42398 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfCXEHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 00:07:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id r15so4087810pfn.9;
        Sat, 23 Mar 2019 21:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MRm25Mq7sSdAKcYNmsiuGnOxKdMDFRpruZX/lX+nroM=;
        b=IaT/xtjOaloyW34bAa8prr1vSFL8z5zVoitFhgMrIhZAQ+cSu0HB1zZBVHCoYv+IXt
         X0fO1NcM18c42fVhe+E+ttWvOH0zaZNffgHFstgow3a2MNlP9OIaH9TReYoJwZS6xLG9
         EHrZwpHOIe/+Ts4NDO7qY72k8gCY3QgRJD/dXGty+TyFH/sqrL8WsNETLJi6/72wVIXx
         uzMS2jvAWa7nQR7RHPk0bXPvlbQEoSxaHk6nMn1znhJgADFMOP0TwX3cOfmbu6PswmLe
         4+/uXkAf1zhG2YfZq/cZS9oHQBV+EM8bf22Yv1nZfJDc2hhGbRq4PiASuGFGZkFRgJY4
         Bk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MRm25Mq7sSdAKcYNmsiuGnOxKdMDFRpruZX/lX+nroM=;
        b=VSxeRfKCtRwx7XLuhaP4Y3U3sdhVOkVd/7KQwcMEuVL8sKwM8LTd3iaiJjhYaHUkN9
         9hw6uF1I2j1L+X7EyF5BMr2HCg2PXzmvsYXrgnP3Ni4e5Jf1KRV4ayN9V9Ln/FNRU0zC
         M3uMyVEBBfPM3N2WkszLngDkducAWd1RTeQLMA/USL22e2slUFPi4Jpnk9ImYf8OH7dg
         znYPjPnOJRS7n1nNUqR4dGwzqKBgkUKLohMFaib0l8sS4YF1fTXmyeOlgjgerlJxycJZ
         Z+CePG8dKnP5/5RC17gmNad/NxAxJb2zc1PXpliT66kP89zA3L30WuDyPZoyRUPTs5s2
         wOYw==
X-Gm-Message-State: APjAAAXEu0XS9Q4qgLuCCGgmKDYakVFGHBlWLxRAOsq0S/k/w6pUp8wY
        L0od4f/zl9nY4fyaWrKbhoC6tYeA
X-Google-Smtp-Source: APXvYqxTxNZC5GaWdQcMiXWbBskGUl9FQ4DFTN4XoJouQzL+/mxQrNsBNmGoPM/tpwmerdkWRkxoug==
X-Received: by 2002:a17:902:42:: with SMTP id 60mr18053742pla.132.1553400443909;
        Sat, 23 Mar 2019 21:07:23 -0700 (PDT)
Received: from icarus ([2001:268:c0a4:5125:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id g13sm21638168pfm.159.2019.03.23.21.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Mar 2019 21:07:23 -0700 (PDT)
Date:   Sun, 24 Mar 2019 13:08:09 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Reid <preid@electromag.com.au>
Cc:     linus.walleij@linaro.org, akpm@linux-foundation.org,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 00/10] Introduce the for_each_set_clump8 macro
Message-ID: <20190324040704.GA8285@icarus>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
 <20190322191202.GC9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190322191202.GC9224@smile.fi.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 09:12:02PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 14, 2019 at 09:29:32PM +0900, William Breathitt Gray wrote:
> > Changes in v10:
> >   - Fix off-by-one error in bitmap initialization in the
> >     test_for_each_set_clump8 function
> >   - Fix typos in clump_exp array definition in test_bitmap.c ("0x28"
> >     should have been "0x38")
> >   - Utilize for_each_set_clump8 macro in intel_soc_dts_iosf.c
> 
> One more, can you look at gen_74x164_set_multiple() ? It seems a candidate as
> well, if I'm not mistaken.

We can utilize the for_each_set_clump8 macro in the
gen_74x164_set_multiple function, but I skipped over it earlier since I
noticed it used the BITS_PER_BYTE define rather than a hardcoded 8. If
it always loops 8 bits at a time, then we can use the
for_each_set_clump8 macro; otherwise we would need the more generic
for_each_set_clump macro to handle the non-8-bit looping cases.

Will BITS_PER_BYTE always be defined as 8 bits?

William Breathitt Gray

> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
