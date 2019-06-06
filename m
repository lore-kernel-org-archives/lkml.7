Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F54C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277DA2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SIE+1nvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfFFWpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:45:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33119 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfFFWpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:45:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so57919pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 15:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HACnMQtPYnOPzs/mDwm4zputQD0bQTBQV8IWL1Bp2bk=;
        b=SIE+1nvWpCuuB8LQr4c2J5pdl9aN9TrZOuogqp0LuJdSCuJ7s3L/mwrQsN757QZwkL
         31MRdfiC4VlGxER8Nbk3eoehRYG45TPv0X47fAaLSi8NckGV2eY2Jwrt8KamFonbvefW
         JQuAMfCV3DzEvIW2EBETktFuUGqPf+Hg1Rip0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HACnMQtPYnOPzs/mDwm4zputQD0bQTBQV8IWL1Bp2bk=;
        b=SzHQdX+3xOS5FMd9Z5XPQnZBcCfMyMzf9wgjPFSaWh+LnX5iW8W1lcTa1cRKPnj+E0
         ndBTIRqwz72dr4ijjZrBI/BXvFbLQ5zxl2RMtwOFVdE3JiQGaSLMRoMRYUlgJ6YiQAXa
         Y5wYMqCpjyFfxWb8eJm6wQJoLCKkv/8DiEGtpWdluUMtqSWLYt5p1xezw0Ca4QRp0Ci6
         M1NntIY8EPHV9n9cHgSVtQpLRqqmliLrWxtPJ/sIoaRQ2oQky9tYXr95bfC5+tyGbiCM
         A4eiGJzPcc98z0lNt9/HXpzvzKnuj15xm7T3Mu1XyYMS+P1iNY74mSmGJU3g/1pS3wYK
         KGYw==
X-Gm-Message-State: APjAAAXwaeoblxkOgokNAoo8LCEQa2N+JfMLU1WzGEy177p1fM5+B0b2
        BT5HXK3moRgAGAYTePAwa10G6w==
X-Google-Smtp-Source: APXvYqzogBbs8NWhvAy6+K9bKGJowUgCD2OgwqNEA9Uv5xkcveaCMWVLXrYham6bjQifkgDDCXFp3w==
X-Received: by 2002:a62:6143:: with SMTP id v64mr18839097pfb.42.1559861110305;
        Thu, 06 Jun 2019 15:45:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v9sm184849pfm.34.2019.06.06.15.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 15:45:09 -0700 (PDT)
Date:   Thu, 6 Jun 2019 15:45:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <mjg59@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4] mm: Allow userland to request that the kernel clear
 memory on release
Message-ID: <201906061543.10940C6@keescook>
References: <CACdnJuup-y1xAO93wr+nr6ARacxJ9YXgaceQK9TLktE7shab1w@mail.gmail.com>
 <20190429193631.119828-1-matthewgarrett@google.com>
 <CACdnJuvJcJ4Rkp7gBTwZ_r_9wKtu34Yko+E3yo07cwc53QrGGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJuvJcJ4Rkp7gBTwZ_r_9wKtu34Yko+E3yo07cwc53QrGGA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 11:26:03AM -0700, Matthew Garrett wrote:
> Any further feedback on this? Does it seem conceptually useful?

Hi!

I love this patch, and I think it can nicely combine with Alexander's
init_on_alloc/free series[1].

One thing I'd like to see changed is that the DONTWIPE call should
wipe the memory. That way, there is no need to "trust" child behavior.
The only way out of the WIPE flag is that the memory gets wiped.

[1] https://patchwork.kernel.org/patch/10967023/

-- 
Kees Cook
