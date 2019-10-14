Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1499C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B04D206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571079974;
	bh=cugcVS6BwVMErWDImtXeHcuGvGtmF4IDDsE8pSs+D38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j/lvgsKoMNp3pxRZ2rCxuWPkwNsn6KEh5tBjOi7Xz2p5sp9vQ0zxRtqaRkP7XqSx+
	 dOh+yMbbrC5gv6665gH6QmJXSVRu6P1/w5p8Vw20tHHMOApfGWZlVuWCb50SWlexKI
	 amt4+Emo5CjNmzXKxtUhglf1qryZ6MCa948fkKls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbfJNTGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732753AbfJNTGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 15:06:09 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3ED9217D9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 19:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571079968;
        bh=cugcVS6BwVMErWDImtXeHcuGvGtmF4IDDsE8pSs+D38=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yfAwrlnOJlhGWfDrZYYsQxOSSvxIsO2fMDjg5l9ecX3X1157aY/5VXpe7atrM9R7f
         hpE79GqClgjgRmq0UZFqgQN7nJ/o8fICyeAaz/I6I1EExlRXQOkx/JZSAykCokkpbs
         R83vEFxegTrSpw7v0N8r+72zYh7Z7Z0bPUqk3OHE=
Received: by mail-qk1-f175.google.com with SMTP id u22so16830466qkk.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 12:06:08 -0700 (PDT)
X-Gm-Message-State: APjAAAU+/m1T4J/xjqkCYnlqIKyvqSBrCTnYCRT1ykGgu3vMtnkMobSP
        Bp7ZvwMcTEESbvO8MSZiVJg7mbGqsAM2AYyiDQ==
X-Google-Smtp-Source: APXvYqxtt56ct5CSujEjO+VWcC3CyHrQK6hvv1inNbBfhWj56N00Mfeotm8P/o2BF7zwHgnpKhBrYpD4dvfThQMyIgE=
X-Received: by 2002:a37:2f81:: with SMTP id v123mr32072393qkh.254.1571079967909;
 Mon, 14 Oct 2019 12:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191014151515.13839-1-steven.price@arm.com>
In-Reply-To: <20191014151515.13839-1-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 14 Oct 2019 14:05:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLG0csuGqg50xmAGdiEqHBkbU5+im2mhTWtxXKpPBGpkg@mail.gmail.com>
Message-ID: <CAL_JsqLG0csuGqg50xmAGdiEqHBkbU5+im2mhTWtxXKpPBGpkg@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Add missing GPU feature registers
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 10:15 AM Steven Price <steven.price@arm.com> wrote:
>
> Three feature registers were declared but never actually read from the
> GPU. Add THREAD_MAX_THREADS, THREAD_MAX_WORKGROUP_SIZE and
> THREAD_MAX_BARRIER_SIZE so that the complete set are available.
>
> Fixes: 4bced8bea094 ("drm/panfrost: Export all GPU feature registers")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_gpu.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to drm-misc-fixes.

Rob
