Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BADC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5C021726
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557345094;
	bh=RHXXd7lXMgFiZCdQS3stOTIConYe0AS69uhgFRQCJew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JFknlQOHJ7yV27pMTkVwWU4j1nIZs4gaxwr6yPCmsFzWftTo8zom/DPusZXL8io5n
	 Oo++9DMkWZ8W5KMmw+Wgexc46vkO1q94Y8akQhpBCHh/vGuvwkUWRispzFTKrpK+nj
	 Fqplu4qHdbzNd1mh4dyWSRN6cC7x+4TworYoWiB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfEHTvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:51:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42676 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfEHTvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:51:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so23180326eda.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 12:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xt6kSgujPUBekFrqEm4E/0l9ZP4sNoTUR2oIeyK8NJk=;
        b=sTQERpcMuUfEt6h9kooqh8PAlVuoDjLlCGqT7Uklvk+2EQBlVg89j5qvhho9BoM4JJ
         LniLqQheZ3gUuRUTTBtGrArqSpoVXHG+CE6WSZIhaQqfxWdJNpkKTXUvvA/v5Uclopoz
         8wY2ePk2oUrNv3OC8IxGPzxlF2hDzcxapEm7XuquyYGlvhwd0V7HTBW5oYNqR389nLsN
         HeElSiGJma2+pBpE+A5lUS9meTTM5K0axraxQ0gNvOyMY9CqBPycaKu6qjHcZuSevE8+
         03bkNRAFH5HMtKp2VbBmA5Ist3S5QQJXpZ1Bq59hM9le7nnj4gTowiQYXKeaQjCZjTzg
         ex0g==
X-Gm-Message-State: APjAAAVO3DBd/2CLYOrbSj64fOD5AY65SE4ui8TqLwg/x1UsKEulhOKZ
        DISRKsjDNTfK3KQEAM1tz+e6tz7aGg5fnPtDrwI=
X-Google-Smtp-Source: APXvYqznnKZ06hcmzGFukgkOAj3mFQpPbadte1ALKcH7Sr1t7EQrlgeB/oxaiF/3uZeNh3ZQ+lqYUASHV4vqYcXPFH8=
X-Received: by 2002:a50:b862:: with SMTP id k31mr39528025ede.27.1557345091391;
 Wed, 08 May 2019 12:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
 <1d7c4d47cfca91c11b0e078d86a8f7f7da6d862a.1557177585.git.len.brown@intel.com> <20190507122141.GM2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190507122141.GM2623@hirez.programming.kicks-ass.net>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 8 May 2019 15:51:20 -0400
Message-ID: <CAJvTdKk78OzgcsUjRpvOOgA1w9VyjADJ4m+=hSFk3WciNAdBkQ@mail.gmail.com>
Subject: Re: [PATCH 16/22] perf/x86/intel/uncore: Support multi-die/package
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 8:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 06, 2019 at 05:26:11PM -0400, Len Brown wrote:
> > @@ -1411,7 +1413,7 @@ static int __init intel_uncore_init(void)
> >       if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> >               return -ENODEV;
> >
> > -     max_packages = topology_max_packages();
> > +     max_packages = topology_max_packages() * topology_max_die_per_package();
>
> That's max_dies..

To keep the patch with this functional change minimal and obvious,
the rename of this variable was segregated into patch 22, which is
re-names only.

Len Brown, Intel Open Source Technology Center
