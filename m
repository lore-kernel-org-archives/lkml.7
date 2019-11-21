Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6B2C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7427206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b3uknYJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKURMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:12:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46710 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKURMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:12:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id l4so1829532plt.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 09:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bX2nh1escW0Cbgv/6Y0YEC/yQp+f/lNHh0V9/EZp33A=;
        b=b3uknYJi/sZSHAOgjARc2Be8VJ4UVFf+sbLnHFRsDK0ZKut7O8lFgoKs2GSCT+HPhs
         PcK9ZuDTgF0drXiXDE4kxXfmqwZdkn5ph2Z86hECWpaLxxVQPK2YzbnvRQbsoRazbM3B
         BXDU4ERDNyBVhzrdM/WQXd6VOMyUP8efrkPzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bX2nh1escW0Cbgv/6Y0YEC/yQp+f/lNHh0V9/EZp33A=;
        b=p3hexhPHxMu6s7gXIUojVMcAaUAnF6i4sWVOSiBwmcnaP+yhoJwpB9HfaqgvNO82G2
         G4TvA4kA+RIQlDYLjkByxGUoqurzVtwcHghFWYQTjY3MWNNL4Z2xzVPkaGlYfiFPHWd2
         qLoNNFE0HEawnlv+swws9inT7XIl436L9rvv5tL+pG8wBHwb40k3njdCG7Jg/jphT/Nu
         4LG4w34xD6SAkOSchWf/ocVXRoK+ZQ9rHIKWutSDymyEOIq6nq+0kEmHlcyjOsnayxjY
         z2ogLEBXGK48Cq7CYChDtBHMTXsdyhR4OZ4ulwIL6F+0HkIzgXXGFcllOMkVIdtI3pYN
         CNqg==
X-Gm-Message-State: APjAAAUWjNqDcUKGfkGpjND5nuMoOGi5PtM96eHXmf8yzuTcLCXH9oK7
        Gp8tk/9NYjRVWAnV4U40+leleQ==
X-Google-Smtp-Source: APXvYqzEnnwnBVPAPw6JDOlkLtmG4af2U/ESX1Ug1uur0kAk3ljoRiWfcSY3KdJwJT2qpZ50WXDZOQ==
X-Received: by 2002:a17:90a:8083:: with SMTP id c3mr12957286pjn.92.1574356320880;
        Thu, 21 Nov 2019 09:12:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u24sm4140890pfh.48.2019.11.21.09.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 09:12:00 -0800 (PST)
Date:   Thu, 21 Nov 2019 09:11:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     dsterba@suse.cz, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [RESEND PATCH v4 03/10] lib/refcount: Remove unused
 refcount_*_checked() variants
Message-ID: <201911210910.81231377F@keescook>
References: <20191121115902.2551-1-will@kernel.org>
 <20191121115902.2551-4-will@kernel.org>
 <20191121145533.GZ3001@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121145533.GZ3001@twin.jikos.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 03:55:33PM +0100, David Sterba wrote:
> On Thu, Nov 21, 2019 at 11:58:55AM +0000, Will Deacon wrote:
> > The full-fat refcount implementation is exposed via a set of functions
> > suffixed with "_checked()", the idea being that code can choose to use
> > the more expensive, yet more secure implementation on a case-by-case
> > basis.
> > 
> > In reality, this hasn't happened, so with a grand total of zero users,
> > let's remove the checked variants for now by simply dropping the suffix
> > and predicating the out-of-line functions on CONFIG_REFCOUNT_FULL=y.
> 
> I am still interested in the _checked versions and have a WIP patch that
> adds that to btrfs (that was my original plan) but haven't had enough
> time to finalize it. The patch itself is simple, the missing part is to
> understand and document what the saturated counters would do with the
> structures.

The good news is that this series removes the case of refcount_t _not_
being checked, so there's no need for _checked helpers.
CONFIG_REFCOUNT_FULL gets removed because all refcount_t ends up being
checked on all architectures. No extra work needed! :) (See patch 8)

-- 
Kees Cook
