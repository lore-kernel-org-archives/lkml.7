Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202ACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2608217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mfwaJzkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCNCxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 22:53:24 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40061 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfCNCxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 22:53:24 -0400
Received: by mail-vk1-f195.google.com with SMTP id l17so1020500vke.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 19:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NU+/QzXH/p7mQCPsMWv39Ij6HJV4jm8oyx/Pl7R4Tg4=;
        b=mfwaJzklZoV05HjVg5ywP1uITZCsuj6KEie/yRWLa6N0aXwaPH01sIMUL59KrThGG9
         QqV2NdTqoVhOSIcdXzAtjA8+JUz+r7YmMtdzCgmPXmNvyVVbYHNcSkIjHc41ToLzyAPt
         ruVgIQtRrkdf9BI6V6O02gfQPgON+nLGeNqR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NU+/QzXH/p7mQCPsMWv39Ij6HJV4jm8oyx/Pl7R4Tg4=;
        b=A6yTmJ6yPoSNeXybRnaPQOwhbZYtxwLOYfMkQZwtsG86wvqfZlB+s5tWmNua8AR4M0
         I0h6rCGrx9txAXg7S7wpp9oakGw8W7cAQbu13iF//G9nGVoW16DL/wMsoTwEd5IgOaf9
         kAwsjhk5MW0busOm1pWBr1naNJvV4Gp//bJQ4sBtxwLcDx1059KxoQIHPNzj9QMbR37L
         U3Y5UqBncanwdC8mfr2IX6s6vxpMGXyfOGwq7WKLI1thV+jbpHr7d8UbhHfRl78rW5rV
         u0eN7xo43zjl+JMFddpCU6LHdB7my/DgVJcaNagj7Jo3vMwVRkXz9HHk9C4MhKA/DHzd
         8mZQ==
X-Gm-Message-State: APjAAAWRp/FwcFCCb3uH/Kgb4OYl/t1yeksGuR3OqzisXZ4bpQBLH3Wh
        lMi+By14xMaSOandd9WZp7y9Zt4PINU=
X-Google-Smtp-Source: APXvYqy9CsXQzfKBzrrZ4q7uOlDIY95WPszcAcwd0cEkXI/bt0bvZLynD67aiLM4O/ee0wrgdV5MBw==
X-Received: by 2002:a1f:c7c3:: with SMTP id x186mr5265297vkf.6.1552532002763;
        Wed, 13 Mar 2019 19:53:22 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id t4sm2487383uaq.0.2019.03.13.19.53.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 19:53:21 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id z18so2352592vso.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 19:53:21 -0700 (PDT)
X-Received: by 2002:a67:ed0c:: with SMTP id l12mr6665405vsp.66.1552532001342;
 Wed, 13 Mar 2019 19:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <9fa84db9-084b-cf7f-6c13-06131efb0cfa@infradead.org>
In-Reply-To: <9fa84db9-084b-cf7f-6c13-06131efb0cfa@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 13 Mar 2019 19:53:09 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+yRt_yf2CwvaZDUiEUMwTRRiWab6aeStxqodx9i+BR4g@mail.gmail.com>
Message-ID: <CAGXu5j+yRt_yf2CwvaZDUiEUMwTRRiWab6aeStxqodx9i+BR4g@mail.gmail.com>
Subject: Re: lib/test_overflow.c causes WARNING and tainted kernel
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Mar 13, 2019 at 2:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> This is v5.0-11053-gebc551f2b8f9, MAR-12 around 4:00pm PT.
>
> In the first test_kmalloc() in test_overflow_allocation():
>
> [54375.073895] test_overflow: ok: (s64)(0 << 63) == 0
> [54375.074228] WARNING: CPU: 2 PID: 5462 at ../mm/page_alloc.c:4584 __alloc_pages_nodemask+0x33f/0x540
> [...]
> [54375.079236] ---[ end trace 754acb68d8d1a1cb ]---
> [54375.079313] test_overflow: kmalloc detected saturation

Yup! This is expected and operating as intended: it is exercising the
allocator's detection of insane allocation sizes. :)

If we want to make it less noisy, perhaps we could add a global flag
the allocators could check before doing their WARNs?

-Kees

-- 
Kees Cook
