Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0F1C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16B72063F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbZ2WVJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfFQWH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:07:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36056 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFQWH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:07:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id u8so1019551wmm.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cq3xBrs71UY77jcBkTVh4FMBqjMhDVmcFlATy07xl4g=;
        b=PbZ2WVJR34XQFcPuUzs458hR+8YmZWdEqmgFSzPWSFIlsVDZL06pJ3uu6mRjk90ijM
         Ee8SeuFeQB+HJC7TOCcuol0gC8EHJ/NDkb1Yj3HJH7fQXsBcYEInOndleiRmubwEHElP
         7jUyZlHaPY1EVbCrsfXv+5ZixqFnRco3DWxyGfSNlyOcWHhFyI0YvfQVXQePgYDQC9St
         Tu4rlUr9z8I52MyfZ5eAvJ7SyiMgOOcjtPv7NktHvOimQwKHX2CjGQPUjJXhRXk2xuEp
         UiA/oBZokE4JtjUJcY9nFy0HxjBPtOAGcvYAZ9pbkKWKQXERHt/Lcq0XxVR2kDyOgMIc
         2NLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cq3xBrs71UY77jcBkTVh4FMBqjMhDVmcFlATy07xl4g=;
        b=sAUH5FilNFrVruBg56K6Eh4eMMXo6CZLoK5WACyTSO1sa0RXFQk2Os/EV7y9257khp
         dOfSui2Ss0l45C0u/8wnNBjfX9R6Srg0MrNZqlEK9qpr5NQAJh9DKocVK8Mj4hvOH2+c
         DZ3S1o7TWWv4tEwIsLLdlUXFiHeYcXaZ1UaIEQtlrKeoQtR+AOk5hLD8Nk4vOi8pnQ52
         BKoO8wRhAr8BZghDrBFBhBc0yKAwaFxfmalYRUmfJXgvbFK7O7/iU2vgu+SOoegR+TZ5
         fbeIBDnCuxHghPdlVza2QKhSHfe6s4LDj9UUasJ6KNvzgWZJE2kFXHWvGn1l3OAVDybI
         uduQ==
X-Gm-Message-State: APjAAAWFbwrCs7cM8dN16V8i3ZXNP3xyMbfpaJaXUryV3r9FO0lkm7Hm
        g6CrsL+n6JPPCVu98g3FvqSGYBbvg6jqwEQGKRbGlA==
X-Google-Smtp-Source: APXvYqwelkyoSXZXCs+ok0tAtv5XZgf/Y6CcbjhsQi64NXLvqgTSPnIY3I+Cf5Q+rm0J5C/KRhsnJkYs40tFDWHIiFA=
X-Received: by 2002:a7b:ce8a:: with SMTP id q10mr456126wmj.109.1560809276561;
 Mon, 17 Jun 2019 15:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190522231948.17559-1-chris.packham@alliedtelesis.co.nz> <355dad1321ed46baa98ca6f47b4d00b5@svr-chch-ex1.atlnz.lc>
In-Reply-To: <355dad1321ed46baa98ca6f47b4d00b5@svr-chch-ex1.atlnz.lc>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 18 Jun 2019 00:07:45 +0200
Message-ID: <CAFLxGvwNNWKzbfKvDjAK6rujbr5qtmVAWCDD5aULO4BVKutRKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mtd: concat: refactor concat_lock/concat_unlock
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 5:26 AM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
>
> Hi All,
>
> Ping?

Your patch is not lost. We start soon with collecting all material for
the merge window. :-)

-- 
Thanks,
//richard
