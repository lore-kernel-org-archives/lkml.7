Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09006C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 23:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D376020706
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 23:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H6UXLQng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKWX1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 18:27:24 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43135 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfKWX1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 18:27:23 -0500
Received: by mail-io1-f65.google.com with SMTP id p12so4750161iog.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 15:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WS9mYTny3XR2p4bnvgnXxQTpacFjOo5Hsf/RJbveqqQ=;
        b=H6UXLQngKv9vBjOIOMqEtBhx81EPzmshinGBD4M/8N9CMpBibk7MmOPV2HyCavMDMC
         TGzLxdvRO+a5a4LVH/GhyCadWVvtkfvhziav/0vaVx50sdtLesVlfvb9ZhZHEJCCfO71
         7Rpa04BHMPURMllGZj/IvP+yP6kKwt/kA8fTi2HOYvDzEUvJN+efuy+NrxDHDYHjobzZ
         F94+0f40fDHM5MRVXx//Lr6XotniPckmjCBoz/Q74iGjgfB0QEN7s9RJLuC5OdtrRa96
         VDSljAxfpuOSk9IQ8jnEPO2187SIKkL8SDtpkaEnnUrbvpvcBg2Nus+Wv4kktQjRxbv2
         veew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WS9mYTny3XR2p4bnvgnXxQTpacFjOo5Hsf/RJbveqqQ=;
        b=RDSn93BGs3/zRGipKxmif1+7iHXBnTiunmIByo1+QHH1nplPKA7PLpBnLDYoRER0RO
         BNvaVd525467J0AxGcWngPFHzsKmj1dH9XR82WhH30dNWx0w8M0uGOyW1iXHweyEDCcR
         g1NBsPl6QSaDbeRrQ3CqRxmP9Xm8lmmS7JQAsRope+bUcQGf1xR65effkXUj3uuDkpHQ
         McW8Q9Vn7Rf6G72qH9MAgGX5lx/o2DTD8LLIrJUKcwJoN2YmhgF6VMOAjbKfQURwkdgx
         /TlEfvS3Dv2SelL4wpKtqpymgZtcO5CtbA41ST05ZekyxvLs5yEyFUfDRZ9MrhdG7m3W
         IgSw==
X-Gm-Message-State: APjAAAUsOq5KhBYeM2qW2IUIkto5GcbH3Xi0xsgGmrg4FzQF3r/fpoRZ
        BIc1EvU2D1eo4ZiYSto7jOtzNw==
X-Google-Smtp-Source: APXvYqxsTcmC3b6H1e2CjD6Fb9bOaOP72eMrbl0d/oKosQ/7J2E1uiFt1sNA/gCGQneqkSXeSCUHhw==
X-Received: by 2002:a6b:700a:: with SMTP id l10mr19972718ioc.164.1574551642851;
        Sat, 23 Nov 2019 15:27:22 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id t14sm589551ioi.29.2019.11.23.15.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 15:27:22 -0800 (PST)
Date:   Sat, 23 Nov 2019 15:27:19 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Jonathan Corbet <corbet@lwn.net>
cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krste@berkeley.edu,
        waterman@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] Documentation: riscv: add patch acceptance guidelines
In-Reply-To: <20191123092552.1438bc95@lwn.net>
Message-ID: <alpine.DEB.2.21.9999.1911231523390.14532@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1911221842200.14532@viisi.sifive.com> <20191123092552.1438bc95@lwn.net>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Sat, 23 Nov 2019, Jonathan Corbet wrote:

> On Fri, 22 Nov 2019 18:44:39 -0800 (PST) Paul Walmsley 
> <paul.walmsley@sifive.com> wrote:
> 
> > Formalize, in kernel documentation, the patch acceptance policy for 
> > arch/riscv.  In summary, it states that as maintainers, we plan to only 
> > accept patches for new modules or extensions that have been frozen or 
> > ratified by the RISC-V Foundation.
> > 
> > We've been following these guidelines for the past few months.  In the
> > meantime, we've received quite a bit of feedback that it would be
> > helpful to have these guidelines formally documented.
> 
> If at all possible, I would really love to have this be part of the
> maintainer profile documentation:
> 
> 	https://lwn.net/ml/linux-kernel/156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com/
> 
> ...if we could only (hint...CC'd...) get Dan to resubmit it with the
> needed tweaks so it could be merged...

It looks like the main thing that would be needed would be to add the P: 
entry with the path to our patch-acceptance.rst file into the MAINTAINERS 
file, after Dan's patches are merged. 

Of course, we could also add more information about sparse cleanliness, 
checkpatch warnings, etc., but we mostly try to follow the common kernel 
guidelines there.

Is that summary accurate, or did I miss some additional steps?


- Paul
