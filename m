Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CCBCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0ED22085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agiWMe9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKAV3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:29:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38381 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKAV3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:29:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id q28so8211864lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 14:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gOa+Uip2nJTA7dHzW0JEHqi6pQE4lW9YppBlYQo9lY0=;
        b=agiWMe9H7ws/oZIbQJzuATqUbWsI/FrW0NoFCLlyZ7JhajRANceyiXk+yi6DMXRO9l
         svAacToMmz9ECWkhEnja60cV8RNBfQ7MuVpxkRc+Oc9rtltHmTFC+oLHmmcVIq9/VKYB
         v+v3Ca0ObP9JmKENgvZM6K7PMOtppa6DG3xPIeYpjS86roxoM+e7+QAbUxFpppK6BnFb
         RIQBLzy7N2I0MdMaz0+m30aVPepk7vQLX/xP+IDZELDOjbS40s67hYzRb6kGZHt6h2EN
         htptF8foUanmnghXJDydVnk0ykTwudtIbjp4jnS9peRUXc2kpnofoWf4r4zzdjATnXrr
         uRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gOa+Uip2nJTA7dHzW0JEHqi6pQE4lW9YppBlYQo9lY0=;
        b=tBK6JgNgLEoto2AME+9h9l9UxJT3/LYuHKksZ5sqUnzozbNwZ3rWhfwZnBP3B5BfyX
         ZoPacOpBtppnd8+9menrzgyueWBjQxSISRNRJ3MGTp7jYpD4omGi2bO77T7lOeUuxsTS
         ShK6BoGzYTXWRqC8lZjWCr7LCATyWSV+d1g6e8nENpEqTPBsik0UqZbQYF/+ghNvQYl1
         jEL5zNTuFCys+84ISOkfTx4/4zK1oZSeMh+sZiuUBIweDE16tS+xyzU4t33y+G05+5/M
         +yBUzvNrdOfakHKjuGxD0A7DPmhroLlel0+bd9acyCIhjJcszT8lxsno479gA4yMtCpB
         0pPg==
X-Gm-Message-State: APjAAAW7fkHsOmgPh6GQJAEnsCucBQHDL5y6gQd91xyt1JP3k/VH8VDC
        VpoAMBjC/kUDT4fGP/ReS2M=
X-Google-Smtp-Source: APXvYqyy37gQ0OD7tx+P0WNh0GLibR9sZlvl9O904ODh2Sz6a2+ybYI9vquCe4W9fd6nsIlSMfYoSw==
X-Received: by 2002:ac2:4d17:: with SMTP id r23mr8974141lfi.56.1572643742907;
        Fri, 01 Nov 2019 14:29:02 -0700 (PDT)
Received: from rikard (h-98-128-228-153.NA.cust.bahnhof.se. [98.128.228.153])
        by smtp.gmail.com with ESMTPSA id q24sm2741803ljj.6.2019.11.01.14.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 14:29:01 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Fri, 1 Nov 2019 22:28:57 +0100
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, bp@alien8.de,
        joe@perches.com, johannes@sipsolutions.net, keescook@chromium.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        yamada.masahiro@socionext.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Haren Myneni <haren@us.ibm.com>
Subject: Re: [Patch v4 2/2] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
Message-ID: <20191101212857.GA889092@rikard>
References: <20190811184938.1796-1-rikard.falkeborn@gmail.com>
 <20191009214502.637875-1-rikard.falkeborn@gmail.com>
 <20191009214502.637875-3-rikard.falkeborn@gmail.com>
 <20191011192737.c0e69db9ca49cd7622efdae5@linux-foundation.org>
 <20191022195306.GA479880@rikard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022195306.GA479880@rikard>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 09:53:06PM +0200, Rikard Falkeborn wrote:
> On Fri, Oct 11, 2019 at 07:27:37PM -0700, Andrew Morton wrote:
> > On Wed,  9 Oct 2019 23:45:02 +0200 Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:
> > 
> > > GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> > > as the first argument and the low bit as the second argument. Mixing
> > > them will return a mask with zero bits set.
> > > 
> > 
> > I'm seeing some breakage in code which is newly added in linux-next:
> > 
> 
> As of next-20191021, those breakages are fixed ([0], [1]). next-20191021
> now builds (at least for x86-64) with the GENMASK compile checks added.
> 
> I also stumbled upon [2], which is a fix for an unused macro in a header
> in mips/include/asm. next-201008 contained both v3 of this patch and the
> mips header with the bad GENMASK in without build regressions, so it
> *should* be ok to include v4 (but given the track record of this patch,
> I totally understand if you want to wait until [2] lands in mips-next and
> linux-next).
> 
> Rikard
> 
> [0]: https://lore.kernel.org/patchwork/patch/1139777/
> [1]: https://lore.kernel.org/patchwork/patch/1139778/
> [2]: https://lore.kernel.org/linux-mips/20191022192547.480095-1-rikard.falkeborn@gmail.com/T/#u

And as of next-20191031, the mentioned mips-header is fixed [0]. Also, a
recently introduced arm-bug has also been fixed. I just built x86-64 and
arm64 allmodconfigs without issue.

Trying to get this patch merged feels a bit like playing whack a-mole.
Perhaps it would have been better to make it a warning at first, and
then promote the warning to an error in a later release? Then everyone
would have the warning in their tree when they do development and the
number if issues in next would be (almost) zero.

Rikard

[0]: https://lore.kernel.org/linux-mips/20191009013721.qda2bo5teppr7nom@pburton-laptop/T/#m6e7cd9c89ef06240fe3cd36a60bd73eff1a1ea5d
[1]: https://www.spinics.net/lists/arm-kernel/msg764473.html
