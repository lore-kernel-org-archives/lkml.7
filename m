Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D52C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B6F214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZkGKz5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389996AbfDRTlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:41:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41536 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDRTlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:41:01 -0400
Received: by mail-io1-f65.google.com with SMTP id v10so2818114iom.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 12:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLjsWgvI5TqLgNxUpOBtI5kfMxdJfoEBx74fHPM2uWM=;
        b=OZkGKz5Iy+uHLzN/jIr93WTa3oJzC/oz/Mji9teQfTKfufsvuU8+Mux6jcTqnoCoxz
         uobc8s2OfXvvGA5SVJxbSJm6KrXG9iNojbTVduflfizp5hqa8d0VDZwXW1wccywfLMyh
         HO4EDbrbD9T1gCnw4/AejLM+7LIrCb26gY2vKBhkS2KwSlExNwDHe3695yWBXqdREpYU
         fPP+RGNSfhSAt0x2UIzS8Z8jcxl0xUBGnI/Tbfu/tcdzLRLP1Ts6nbOVJIU+dGWjdzXf
         I5lYfvq0gxPI1zC1d9tFfIlSRRA5jfrYnQYkKx8uafxlgFo592KJRDViLlXtCvRo+wdJ
         VHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLjsWgvI5TqLgNxUpOBtI5kfMxdJfoEBx74fHPM2uWM=;
        b=mAl4iWCf+L6+vaiM+SHgEKPz5kR1ntdXr07p6/YJBmAFyaWKh9dONxFI5VV0/czrdI
         FKhhisIraDy6qbbwSia4VHtn6Qzvwi1Gm+JnYqMflYIbYgST7k26lKnUtI3tdHjcdfD/
         /1s3jYv+0dnPaPF2NJief1618Xu4bQYWhOMSY2+QoEstZRKR+1yrfYNt9aYsjaHPlojM
         blCZ/kVM4p6Aw54UUo2Ck7/sviCxCOWN3enAEr6BfHXE4MwP/fQvIVl/VyyiwfxicZJg
         6w5W0i+vLvDmx3sKV2Dr4SrP1YRyl4w7HN60s0GAG1p0wklzWn8Ck1Bc6HO7xAr6BK9d
         4Tuw==
X-Gm-Message-State: APjAAAUz5zoQGBoPlFMCBoUMAXk0Xm/CxJpj5o9iO9PXE9OflspAWJqt
        LafWG+SnDtlClzdjtVRQGCPZKc7nDTPxwyj94yKjZw==
X-Google-Smtp-Source: APXvYqwYARGTR4wyCe6N5nee6lQKYvA4Ge0/7QaFeyvWQA3LIinvXuwn/tLLDBLlT70+mlv4scS+W9rpzBSWyK2DYDE=
X-Received: by 2002:a6b:c842:: with SMTP id y63mr3343253iof.304.1555616459918;
 Thu, 18 Apr 2019 12:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190416130740.7ff9e561@canb.auug.org.au> <20190416153608.GA11353@linux.intel.com>
In-Reply-To: <20190416153608.GA11353@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 18 Apr 2019 12:40:48 -0700
Message-ID: <CACdnJuvat4=kXD6NMnMw5E8M4KB_1nBP6Simi8gBUChdBs7eRw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the tpmdd tree
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 8:36 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> Matthew, looking at the code I guess the includes are in wrong order
> i.e. early_ioremap.h should be included before tpm_eventlog.h. Do you
> agree that this is the correct conclusion? I can do the update.

Yes, I believe that that's the correct fix.
