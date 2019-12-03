Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E353C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2576F20803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsrIQQ4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfLCT01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:26:27 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:45767 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfLCT00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:26:26 -0500
Received: by mail-pf1-f174.google.com with SMTP id 2so2311565pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 11:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sqtioymHBr0uuCq5mwVAHI29Uwj8my7Exon8dNBMKKs=;
        b=SsrIQQ4tDtJEG1eE6i6xdWD0thA30XH+Iwb/cUfSpfMWvtserG/Z8P1Tu2BSn1L+vD
         47Ri1mKfNphnsCdlxFzcxgtcuc55HOMXnr4BCgCq4LZXPuGHdbA3lqtVcCQEGFWqeHvi
         95aeGnDhy6lv6qycnhK6woh9OfgoJcRpZTVF9wAByEiZc4Gq9YHkLEGWtzw+ebumyjPe
         CJyP8wo8JxCp0hncgXVY9JAZwWLDGgHlC0BuJvf3iQmLLLDT3mxzvm/fLLIjsDJvUeOV
         rrbId5rvL1Ls+4C1y40bEpk2rmGF3ISIHyxZLe+hBdEauBsyyXUDKbiZmTGtv+9sR4QB
         bBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqtioymHBr0uuCq5mwVAHI29Uwj8my7Exon8dNBMKKs=;
        b=D35tWGtVuqGCQ39mFQmbbY1LnBkRau19hhp/dgZ9DqVVZ/6CZGF2dCpfTjojTvyMJa
         DVnTkUNCkeJewvFVNRpRoAdkJCW2cYEgs9SqxWgXvBCpUYOLnIvO06h0IvIO3UadrKOZ
         mReVrwMcuuArOtr7MfZd3AsWMBr9DdnOJ83k/82aFGQ9isIU5kvRsL4ugkF+NSCB9Q8F
         A7wp0fBcV+UnodfIRdYHeje8Z5255Td52nVxRdxjo02j3GCUePOW2fZ79eZ+F418/v9G
         ecNcaPyuv8lPjYW63XcjYGB5QEz2k3bKXa/0HiJNph7efdSg9g0p7+iUevDVW9pecs6v
         4brQ==
X-Gm-Message-State: APjAAAVllOVdy6/VhpKETYOb0cAXeGMfV3OfSuCoS7nLlUTToCQ3K8eA
        6FbtkMn+d9yw4iEcVoT3k6to14OwTfTVpRlVWDooTBmM
X-Google-Smtp-Source: APXvYqys3iet5YGW1UKJyuKaxQYtYMh5kqZuPWHHzRf2oS9FTmDwnVsLMfAS5j5iGOhcUKZDs899N5Tqi5hgxGU355A=
X-Received: by 2002:a63:1953:: with SMTP id 19mr6938676pgz.157.1575401185710;
 Tue, 03 Dec 2019 11:26:25 -0800 (PST)
MIME-Version: 1.0
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-2-xiyou.wangcong@gmail.com> <d0f58734-0c1e-af9d-3437-31cf6c8a86f9@huawei.com>
 <CAM_iQpXAf8obF1-CRCGc3Fb_YmNBozcyoKQC5yuP6r9Akg6HBg@mail.gmail.com> <b27d0ba1-4f30-3e25-6898-26305a3d42db@huawei.com>
In-Reply-To: <b27d0ba1-4f30-3e25-6898-26305a3d42db@huawei.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 3 Dec 2019 11:26:13 -0800
Message-ID: <CAM_iQpWj2bW+WS37UabhejWwQw7GCYEsCw1hP6eRcuOTCBHiAw@mail.gmail.com>
Subject: Re: [Patch v2 1/3] iommu: match the original algorithm
To:     John Garry <john.garry@huawei.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 2:55 AM John Garry <john.garry@huawei.com> wrote:
> Apart from this change, did anyone ever consider kmem cache for the
> magazines?

You can always make any changes you want after this patch,
I can't do all optimizations in one single patch. :)

So, I will leave this to you.

Thanks.
