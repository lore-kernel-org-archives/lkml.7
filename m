Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A33C48BD7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F7B20883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EH3y4zD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbfFYSbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 14:31:16 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39237 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFYSbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:31:16 -0400
Received: by mail-yb1-f196.google.com with SMTP id k4so999563ybo.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tJadmfIaP+3cUt4e6djg3uYwSGFYlA4L4PJ/03vX94=;
        b=EH3y4zD22YVqGG+RHMfFEthpglof2dKKJrLZODUIcgdQyL6wvrwdMmPysZQFNoc2BK
         03B4jdpd9RdUOnaQHMk/k7zYWHUxDFiMN85zh3eBas/KoFrA9RJ4Oh4Pay55XRPXrnUI
         kRlCCKZ1Q4xVqcRZg8cDczj/dp10i2E+bDt59cYKTPiX6rijpqiPa6Ng7hdxL8GVQzUO
         zK9o82cg7pIIab6+dGP9KB9qKEPh3aSRQEHXkMhIV0F1KB7EmBXM4kjp3LTaDvVnAmAq
         kYmt9k9R+v75ZAK5NW6TNMmnsYyEtKQ58mOIhfE0GXIPY85W1HBMHmw6ubXTAGPWdpdB
         i4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tJadmfIaP+3cUt4e6djg3uYwSGFYlA4L4PJ/03vX94=;
        b=b9lQzp2CWtglPvypY6T8tUMIV2QMQIhpHR9ZAp9Fq+pXG/65zqbyr0+VuRwi4gdxV5
         i3EFVQou/ZF/f2f8+us09X1a05r2PunNQ1ADGgO3L4CLP4b6a1kOibNH0K98uh81gRQB
         stwpCiUuFzC9uJWP6dZRtWKlu/esQG7nf3+bzx7xJe/+eeEOzwgnCF2TU1/ZvvnR9IE0
         l0loN7yFc9q6q/gaAiSmzLdPLkJfwcNhQZMD51GXA0YgEis/4bS9PrRw7D8Pc2Nw4AYw
         hzNduvERLfidJx7herbpvDtIz/2GYbNBm5nZuhA0TnkiUbrMf8a8M3XrqbneNLIa7GKu
         I4Fg==
X-Gm-Message-State: APjAAAUtFQTpk0QJM9XLCU1ICBjZ21NXwVOF3rBUK5y7qT8oX6iEPB0f
        6V7OohH8jlf/o8bDZijx0aq7p0m50xKwlLRnyeIEgQ==
X-Google-Smtp-Source: APXvYqwNG1kh+k/L+YnZbCVrDwBuWFG+WXRj+Yr7jmS6YTLtMJlpnmTuApTpCOI2UGQ8fp1IdBSvPwZbls9jENi5vd4=
X-Received: by 2002:a25:943:: with SMTP id u3mr82067600ybm.293.1561487475490;
 Tue, 25 Jun 2019 11:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190611231813.3148843-1-guro@fb.com> <20190611231813.3148843-7-guro@fb.com>
In-Reply-To: <20190611231813.3148843-7-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 25 Jun 2019 11:31:04 -0700
Message-ID: <CALvZod6wR7th1JF407-_i9PfbCzAiakU7mD2HBshH+jW9db1bw@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] mm: don't check the dying flag on kmem_cache creation
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 4:18 PM Roman Gushchin <guro@fb.com> wrote:
>
> There is no point in checking the root_cache->memcg_params.dying
> flag on kmem_cache creation path. New allocations shouldn't be
> performed using a dead root kmem_cache,

Yes, it's the user's responsibility to synchronize the kmem cache
destruction and allocations.

> so no new memcg kmem_cache
> creation can be scheduled after the flag is set. And if it was
> scheduled before, flush_memcg_workqueue() will wait for it anyway.
>
> So let's drop this check to simplify the code.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
