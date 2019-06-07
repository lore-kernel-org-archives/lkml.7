Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAD0C28EBD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 01:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35EC20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 01:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKvNpstA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfFGB5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 21:57:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41307 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfFGB5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 21:57:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so237928pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 18:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fMmuJCA3LCdg91iSc6/9qeFXRSKlknMhuRfQX7ASOjc=;
        b=JKvNpstAHFdgappvoFZTSBTYlIL3/rZ47hg8HWoFbIEqVkiV0EhBBZRLRpyoICFyrS
         ClCg438cs5YejBJpHXQckK0pyK/nX11Mbv0+5nKGWykE5lZ3jpOuxeVRFnlLKbW87lcG
         bewtkILSMTIQJO7EetY0lF6sRJUs+8uhC1RbETeTx8z2OBcWkDlJX8xMnfs/FngxD9je
         npdlOr57+ayjx56h+5W94hdtUiDJMVs9Pyj5fGRTYXGLjXwkFhCFeOws4+ZwA/7nmOcz
         UYma0uNuuj6tU25IwM5aMXHiCF1uwqjvpSLHw6IOmKy/ZVxAahFu17CHyfSoUMsaCxjk
         DrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fMmuJCA3LCdg91iSc6/9qeFXRSKlknMhuRfQX7ASOjc=;
        b=e12JK36cfEPTzOcA8A8UtJBl/ENmnENH/62Wiot8iIz7n+MnuZ+j7mNXqsrFzHo8KQ
         uAxABG4UPxL7agJIeo9Q8HqQJxGvXebvjFaRCNRROOpNwMv+Wai/GRawS1TDOW/j8WwP
         o1UjRPKJ2XZz+emXvXX5Nk5GWLIM340kmSmY90LJR/1y26XtH60fPUp6azFgKm5Yv6UZ
         bNPPn7zHbGYRPvzEbjK6wc2X2AScbdEgKlgvPElxcLNs/g24nZi5+cozFt3rvSSKHO/r
         NusmHD2X7OLz+GySDyMAPQGmJVyAZdD6m1VmK3DxCBWot9doj2L1R1ECmv3X7J4WGw78
         llPg==
X-Gm-Message-State: APjAAAWwzYAYoqp5awlESb1RWT010VjDZiaDyREsfO5Pw7KsR1pUDw7E
        2wBAyIsCbgV+aWNIGebrf6g=
X-Google-Smtp-Source: APXvYqzOGmPQ+4bSZiqeJZcCwiv/ZjmMksHt7GIGid5GMzyY0FfrS/4RyF2iuz/q9m86aoMdGrLu4w==
X-Received: by 2002:aa7:9256:: with SMTP id 22mr43149580pfp.69.1559872660804;
        Thu, 06 Jun 2019 18:57:40 -0700 (PDT)
Received: from localhost ([2601:648:8300:77e8:e0fc:fdfa:3d2e:ab5a])
        by smtp.gmail.com with ESMTPSA id 85sm408342pgb.52.2019.06.06.18.57.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 18:57:39 -0700 (PDT)
Date:   Thu, 6 Jun 2019 18:57:37 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Qian Cai <cai@lca.pw>, g@yury-thinkpad
Cc:     Yuri Norov <ynorov@marvell.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: "lib: rework bitmap_parse()" triggers invalid access errors
Message-ID: <20190607015737.GA11592@yury-thinkpad>
References: <1559242868.6132.35.camel@lca.pw>
 <1559672593.6132.44.camel@lca.pw>
 <BN6PR1801MB20655CFFEA0CEA242C088C25CB160@BN6PR1801MB2065.namprd18.prod.outlook.com>
 <1559837386.6132.47.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559837386.6132.47.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 12:09:46PM -0400, Qian Cai wrote:
> On Wed, 2019-06-05 at 08:01 +0000, Yuri Norov wrote:
> > (Sorry for top-posting)
> > 
> > I can reproduce this on next-20190604. Is it new trace, or like one you've
> > posted before?
> 
> Same thing, "nbits" causes an invalid access.
> 
> # ./scripts/faddr2line vmlinux bitmap_parse+0x20c/0x2d8
> bitmap_parse+0x20c/0x2d8:
> __bitmap_clear at lib/bitmap.c:280
> (inlined by) bitmap_clear at include/linux/bitmap.h:390
> (inlined by) bitmap_parse at lib/bitmap.c:662
> 
> This line,
> 
> while (len - bits_to_clear >= 0) {

[...]

The problem is in my code, and the fix is:

diff --git a/lib/bitmap.c b/lib/bitmap.c
index ebcf4700ebed..6b3e921f4e91 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -664,7 +664,7 @@ int bitmap_parse(const char *start, unsigned int buflen,
 
 	unset_bit = (BITS_TO_U32(nmaskbits) - chunks) * 32;
 	if (unset_bit < nmaskbits) {
-		bitmap_clear(maskp, unset_bit, nmaskbits);
+		bitmap_clear(maskp, unset_bit, nmaskbits - unset_bit);
 		return 0;
 	}
 
I'll add a test for this case and submit v3 soon.

Yury
