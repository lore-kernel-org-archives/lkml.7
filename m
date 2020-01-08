Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7094C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF7B20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GTNCpgnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgAHRja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:39:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36357 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgAHRja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:39:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id x184so1981561pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bKjvwLoHlC29TnvYqxLfJzXQCusKrCOIAaFwwH7cSJ0=;
        b=GTNCpgnTvYnInEtO3QFpRZVybeL6CBYzJJx27ePUFw0/SafUvNxEYcOYQfvASQ6xqX
         6j+5vDN0aFTy3n2vQk6NkoWpkjjM2jUwkxQaSbL/wj3TBgA2VXvX2hZcLRoUwLWwSopL
         JoZOKKbVLSYcz5PbBGPmd9fCF6ZxmqIR6YilM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bKjvwLoHlC29TnvYqxLfJzXQCusKrCOIAaFwwH7cSJ0=;
        b=AEfx0rnZMAh5yn2I4OQbuoLOBGbeb0OF43XlDv+ftuc9ta17ilI5VeuToGQTFRNeF7
         N1c0BQCWRcLoQup9VqIw4j2FXp1ClUts4q0a6U4sqS2+YZ+jo7aru6MjiffO32sc+xFf
         nOTco6fp+m/s7JXnCuQGF/zoV9AL5Wi992Cna+lA9fqXHsCOpO0wEEQGEUzZoX8LEWK3
         8FPg0l9z7YxkxxOJR2fnSVy0RX9C2JifVooN2EiOKPiiUG2VuynP74gh29BvNMflR7e2
         7azx7qFoLjPcliet4tQwMwWbPnJGvQqzUuN0hqz9I9GGJejJhT5bmuubdQ50l3yycd7Q
         RSIg==
X-Gm-Message-State: APjAAAWuHEHv9tx2wNPQrEdNoLkZpzLURmFxWbkl2P54nwHb9JaZpkt/
        0fezphkSWW7kJAFK2A8qclfbRQ==
X-Google-Smtp-Source: APXvYqxdgwKREsz1YZeH4VDxSzla/QubcfkdDOAeGwicuj/jBB+4Si/iUY0qR/AhKo7jBTllsOCHfg==
X-Received: by 2002:a65:63ce:: with SMTP id n14mr6602246pgv.282.1578505169677;
        Wed, 08 Jan 2020 09:39:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l8sm3901278pjy.24.2020.01.08.09.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 09:39:28 -0800 (PST)
Date:   Wed, 8 Jan 2020 09:39:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Tianlin Li <tli@digitalocean.com>,
        kernel-hardening@lists.openwall.com,
        Alex Deucher <alexander.deucher@amd.com>, David1.Zhou@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] drm/radeon: have the callers of set_memory_*() check
 the return value
Message-ID: <202001080936.A36005F1@keescook>
References: <20200107192555.20606-1-tli@digitalocean.com>
 <b5984995-7276-97d3-a604-ddacfb89bd89@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5984995-7276-97d3-a604-ddacfb89bd89@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 01:56:47PM +0100, Christian König wrote:
> Am 07.01.20 um 20:25 schrieb Tianlin Li:
> > Right now several architectures allow their set_memory_*() family of
> > functions to fail, but callers may not be checking the return values.
> > If set_memory_*() returns with an error, call-site assumptions may be
> > infact wrong to assume that it would either succeed or not succeed at
> > all. Ideally, the failure of set_memory_*() should be passed up the
> > call stack, and callers should examine the failure and deal with it.
> > 
> > Need to fix the callers and add the __must_check attribute. They also
> > may not provide any level of atomicity, in the sense that the memory
> > protections may be left incomplete on failure. This issue likely has a
> > few steps on effects architectures:
> > 1)Have all callers of set_memory_*() helpers check the return value.
> > 2)Add __must_check to all set_memory_*() helpers so that new uses do
> > not ignore the return value.
> > 3)Add atomicity to the calls so that the memory protections aren't left
> > in a partial state.
> > 
> > This series is part of step 1. Make drm/radeon check the return value of
> > set_memory_*().
> 
> I'm a little hesitate merge that. This hardware is >15 years old and nobody
> of the developers have any system left to test this change on.

If that's true it should be removed from the tree. We need to be able to
correctly make these kinds of changes in the kernel.

> Would it be to much of a problem to just add something like: r =
> set_memory_*(); (void)r; /* Intentionally ignored */.

This seems like a bad idea -- we shouldn't be papering over failures
like this when there is logic available to deal with it.

> Apart from that certainly a good idea to add __must_check to the functions.

Agreed!

-Kees

-- 
Kees Cook
