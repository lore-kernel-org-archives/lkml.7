Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680A0C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F599206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567768255;
	bh=8J7vhVPmmaH9VUTrqUcBmnghWw79eGkl8RkGxlSWzfo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uMddqUssrF9GUtdSsndhGxAQ8uGz0BzONtDSD3ruW1/IN4DUHqqAn7SzkvP86yG3C
	 npZsHMitiqd8HeGwDvtaJW2DdfewWfQcAFLZ/px3eI1tgEF66H/dk4gZEQ6kg1dQIy
	 9XnlQEixLmFlfC7fqNylhUju0IDBA5TIYLTe/o0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388541AbfIFLKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfIFLKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:10:54 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E3721670
        for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2019 11:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567768253;
        bh=8J7vhVPmmaH9VUTrqUcBmnghWw79eGkl8RkGxlSWzfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2tH17ab0r7UVbqybsCAzXSFz8s8fx7N0RDZLd3K3qEf2t1BWCGA/kbbgRnRvE2I0R
         CsWBkREnQKOV+3gBw5jsQUirVldIY5NrEkrZsOv2D9bJo7AMBBw5dl0x4aG7tHd5F4
         hUPkkn/5KWLiZrnEQsQNjA+iXd1wJTbzI67l+YmE=
Received: by mail-qt1-f169.google.com with SMTP id l22so6508177qtp.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 04:10:53 -0700 (PDT)
X-Gm-Message-State: APjAAAXuNe8D/Jjs6KK/rAN/WKM9c9uz7H+SuolVx1hhGtove05YIxyP
        pZVBZ/DRW7EXKbOM0pLl/cJjL2l4lme19GeIjg==
X-Google-Smtp-Source: APXvYqwxtJ2nxLsP9EuH4mMTLaDZPmidxeZD/Ez80LDFh4lXToL9ygmYpFYBKD1c0/Epcj8dt9cSUuE4W77RloAjVnY=
X-Received: by 2002:a0c:f70c:: with SMTP id w12mr4284929qvn.200.1567768252224;
 Fri, 06 Sep 2019 04:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190905121141.42820-1-steven.price@arm.com>
In-Reply-To: <20190905121141.42820-1-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 6 Sep 2019 12:10:41 +0100
X-Gmail-Original-Message-ID: <CAL_JsqKyKUBOK7+fSpr+ShjUz72oXC91ySOKCST9WyWjd0nqww@mail.gmail.com>
Message-ID: <CAL_JsqKyKUBOK7+fSpr+ShjUz72oXC91ySOKCST9WyWjd0nqww@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Prevent race when handling page fault
To:     Steven Price <steven.price@arm.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 1:11 PM Steven Price <steven.price@arm.com> wrote:
>
> When handling a GPU page fault addr_to_drm_mm_node() is used to
> translate the GPU address to a buffer object. However it is possible for
> the buffer object to be freed after the function has returned resulting
> in a use-after-free of the BO.
>
> Change addr_to_drm_mm_node to return the panfrost_gem_object with an
> extra reference on it, preventing the BO from being freed until after
> the page fault has been handled.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>
> I've managed to trigger this, generating the following stack trace.

Humm, the assumption was that a fault could only happen during a job
and so a reference would already be held. Otherwise, couldn't the GPU
also be accessing the BO after it is freed?

Also, looking at this again, I think we need to hold the mm_lock
around the drm_mm_for_each_node().

Rob
