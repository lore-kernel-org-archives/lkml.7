Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14AAC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 04:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A4B206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 04:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="guB1CbXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKOEav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 23:30:51 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45096 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfKOEav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 23:30:51 -0500
Received: by mail-oi1-f194.google.com with SMTP id 14so7483571oir.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 20:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRWArS8EY6M5DOjOjqwZ6+pvf8YoFwoc/oPe6h/50XU=;
        b=guB1CbXX81G22dmWZBHxcVVxa54wwF5isiRP8DfyGl6WLw5qsD8/1yYkL94xe1bvja
         YWrfIftutXLXDL0eJK6ZS/da065bfHQYvNr79ght47XY6Zo0Ik8kf5tpJXSMFAAFQnCw
         ubcAHiqDy1ycfTVOPB41eht7V6f8fV65ZKDZ0inrspQuNJKy3jkEwKSowxth/UevHA+Z
         fTEAoFQL0v3zpTHMc57OpaWN8U0odan50b9dK7PBSP1E9f0eElQWxG9JTLJNXx33+/fU
         uN/a1NVNCswzKJSR8+RQj5yu/EViETOWFER8emzdphHbCRqRIAw57SwazMYWno23m3Pf
         w2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRWArS8EY6M5DOjOjqwZ6+pvf8YoFwoc/oPe6h/50XU=;
        b=ba3H46lnY9nBhEht6W7xnf/6IDxuDGzqL6hzyptgXDpksDEkVRiTyMZv14aTpHWmJi
         MwCjAua97QUYD3+yuwbHlmMku9LmvgARVhZXXou5Gwy07eH0eGb14B35bhuP0GusDcQB
         Jqt8BkTsz2YJcUo6SmIQXKYUuIfA8n1I62L5bjvGp0iv01V2fhQA95k9N0vCwfRWTqSj
         klxH/hpV1/yrRxNy3nviHHppGWoLfbZMVSYUHCvvbJ+H3vE1qHearLQnwQ25yMNHsx3U
         eqIQNikSglOIzOpyNR8ET51Rnwo3Hf54QIybw1JoXQj0QgPXznjkhWY2aZxRuDO3N0UL
         Qucg==
X-Gm-Message-State: APjAAAWAQKxkBrgm/HCP7r7lZc5IF721gGoLmLCgvVZCycd6hWiO4/74
        90Le+Xj8uwnbQ9zb5ycUd6aMCU3rxOu7qoA/REIrQw==
X-Google-Smtp-Source: APXvYqxglauMMGlyWf/TClpfIHTmgAmcgrRFm8og4eYzgO7jYK3rFnEyN8B0fbbAiBI0hQLPzfZ1wmS7ammk00zCWVA=
X-Received: by 2002:aca:ead7:: with SMTP id i206mr6863559oih.0.1573792250134;
 Thu, 14 Nov 2019 20:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20191025044721.16617-1-alastair@au1.ibm.com> <20191025044721.16617-3-alastair@au1.ibm.com>
In-Reply-To: <20191025044721.16617-3-alastair@au1.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Nov 2019 20:30:38 -0800
Message-ID: <CAPcyv4gb7xZpY+F9qupJbLznqHbyCOuOee8R6aLby72UkyjtZg@mail.gmail.com>
Subject: Re: [PATCH 02/10] nvdimm: remove prototypes for nonexistent functions
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anton Blanchard <anton@ozlabs.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Greg Kurz <groug@kaod.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 9:49 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> From: Alastair D'Silva <alastair@d-silva.org>
>
> These functions don't exist, so remove the prototypes for them.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Looks good, applied.
