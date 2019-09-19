Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C947BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8E32196F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvugnqvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbfISB0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 21:26:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39001 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbfISB0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:26:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so1266228wrj.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 18:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fq+RpFCn2McWuMg3C5OlmcYZSlU9P8enqlr/h4VhVAg=;
        b=AvugnqvMBEU2/e4eEo1SBrNXBDNXJgxlc+8OulchbPWmdEAonz0hLIBLOVLlL9G+q6
         F0DT9/X4lY65BMyqV6XI7DiNNDQF9bm1hFV4roW8v/5Q4SFZEtwjpk+X0dSaeb5g6rAF
         NBDKiBJ8in6K9vJGs3YiBBKvICzIsloJLgxrz0dmtAuExPQyOEZ7wkXAaN37jOvsH3Ct
         MfqejGKk9X4FVBLosvLumd0vUakjx3eG2Wco6D2tThQL6rsG02giNV2o62u3WzZqDQeq
         Js3I5VuDMmddVuCG+N2ye4LcOj/X1bocqfx84VXMYFO5KItYOd06OB8sI9DVZdp8Dfvf
         1Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fq+RpFCn2McWuMg3C5OlmcYZSlU9P8enqlr/h4VhVAg=;
        b=ECPvc5M96HiSHTudQijuJB3fZMPMugDuE9lZToG/CIX8c+jU5piXWeu1N2aSdk30A9
         y7U8uUfkso19gquX2ZTf6WhfMc1OkKoJlZ4XjUZNYzBC2PeZ00UFYDX9at0GHH8T39tR
         fPQuojA8eYUDLbjtgQjC/9u/QqqXbmsbR3TfZjLZ2KcFlI+bPKJnv7jXG0keF7JOzStI
         j081wHnQckk2JIxKmvIq9PjpQOUzOUMj04hjphw6G1PNCtYCy/GOSEx39IhfboFOL6sV
         CnDwMa1HogmwzdqZA1v+LeB1jNGxZjhWtAiXpcw87ZSo+DeVSu7OoJ7XL6u0Yp80Aas6
         c8tw==
X-Gm-Message-State: APjAAAVfj7PY4x2z1k0VzQCI1j5gcZ6ftfkrsZZ6iFYjQtxfEH4gSj7j
        Bk4K2TlPLBbJN1xCkwm451c=
X-Google-Smtp-Source: APXvYqycZBvXFbe7Rt4Loa6FLejQrVV/zV6+SXTUHjTMG5YBdUo3RXSkmobHDRFcivZ/nknGK8MI3w==
X-Received: by 2002:adf:9083:: with SMTP id i3mr5434855wri.310.1568856382862;
        Wed, 18 Sep 2019 18:26:22 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id f13sm4400000wmj.17.2019.09.18.18.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 18:26:22 -0700 (PDT)
Date:   Wed, 18 Sep 2019 18:26:20 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        David Bolvansky <david.bolvansky@gmail.com>
Subject: Re: [PATCH] hugetlbfs: hugetlb_fault_mutex_hash cleanup
Message-ID: <20190919012620.GA72561@archlinux-threadripper>
References: <20190919011847.18400-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919011847.18400-1-mike.kravetz@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 06:18:47PM -0700, Mike Kravetz wrote:
> A new clang diagnostic (-Wsizeof-array-div) warns about the calculation
> to determine the number of u32's in an array of unsigned longs. Suppress
> warning by adding parentheses.
> 
> While looking at the above issue, noticed that the 'address' parameter
> to hugetlb_fault_mutex_hash is no longer used. So, remove it from the
> definition and all callers.
> 
> No functional change.
> 
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks for the patch!

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
