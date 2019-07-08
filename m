Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFDEC606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3C221874
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn+ywXAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbfGHR6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:58:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38125 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbfGHR6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:58:11 -0400
Received: by mail-oi1-f196.google.com with SMTP id v186so13302841oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6BYXR7+fOdaYBcbsh3ughBec33Q5ZK6pIAnMm20zX4=;
        b=Kn+ywXAHUiDPK5+TJCW6kotSSgpd2BHUDV/2hUkPZNa+N4r5coXiFuu3l6K3D1Zbwj
         FI9bcHWA1ajVrR3Y0W6Xix4ewCKitv2pdqvT1+r1V7z72PVfPoRnL84Euav+NXe19qT4
         rODKJZieMLdDEq4CRj7FZ4/qJRAduZpTAFy697lgHDkcdIi0A2biKe3/IuvACWtpEJ3G
         Mg54FTPHln+5J8ONLpPXf6a0oVi1rYUU6poMXe1I2pCulaFXMsEWq2Cl5zVGjyCoCpiY
         i5TEN97zqBk2QVfWX0w/bn/A8w0ZSYvne/1WI777j8ypcyqwQ3zrUNeBVZsLeYWnTF46
         cEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6BYXR7+fOdaYBcbsh3ughBec33Q5ZK6pIAnMm20zX4=;
        b=ch35ECqDbZhf/XKYi1rbXh3KTjp8jAIoZqErtjVm0Rmv3X11o88vKeLWPCeo8nU7hn
         hI6ULobTQy1nnmy0La+d3hu3LgHaYNhUR7TBKjKEpMBRdebtBwX/feY2+BFIRXUL4t4H
         MJtJeYdUoK8I2vAa7ioDjlr1Erpin5hDTHHYuB1T0Q5Oum9QJYs5u2sNzOZ8KlbdKsAV
         cq+zlu+s7VbSZMo8mPrqtAVuEZ4lIvFioRYAxISg2d35I/h9TbBu0LwDfrWJkqhEQ/jH
         SUt5yJjvVxpeeBDdpRWaM/YS38DxDQXAg+cBSWByB7RzOqaR7zx1PN/m3qgvI4CUCFj4
         zf7Q==
X-Gm-Message-State: APjAAAXSdlpyIDF4mvdMzqzLa8Ppsg7sMA89Xl4GT/LuFTaLYt0B0FHe
        737Cm/tw6MdTkhGrs3noPyrI9vRzzmO64M4PTl8=
X-Google-Smtp-Source: APXvYqzFB5NdeTU13L7Fv1wsmPdbONbYZrMIHrL7iJKHItGJ2/5APvUtcBxAYOTpZCxb/9YdP2bFcEtzFfvwSBY3QTo=
X-Received: by 2002:aca:4d12:: with SMTP id a18mr10154747oib.33.1562608690964;
 Mon, 08 Jul 2019 10:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190708170631.2130-1-lpf.vector@gmail.com> <20190708173534.GF32320@bombadil.infradead.org>
In-Reply-To: <20190708173534.GF32320@bombadil.infradead.org>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Tue, 9 Jul 2019 01:57:59 +0800
Message-ID: <CAD7_sbEog0OQ+Bxg1nNt2CWgHHLqf602dzhAHTAThPjwK3yitQ@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc.c: Remove always-true conditional in vmap_init_free_space
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, Uladzislau Rezki <urezki@gmail.com>,
        rpenyaev@suse.de, peterz@infradead.org, guro@fb.com,
        rick.p.edgecombe@intel.com, rppt@linux.ibm.com,
        aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 1:35 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jul 09, 2019 at 01:06:31AM +0800, Pengfei Li wrote:
> > When unsigned long variables are subtracted from one another,
> > the result is always non-negative.
> >
> > The vmap_area_list is sorted by address.
> >
> > So the following two conditions are always true.
> >
> > 1) if (busy->va_start - vmap_start > 0)
> > 2) if (vmap_end - vmap_start > 0)
> >
> > Just remove them.
>
> That condition won't be true if busy->va_start == vmap_start.

Yes, you're right.
Sorry for my bad job.
