Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD03ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D136620854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbfJOOhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:37:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17865 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732087AbfJOOhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:37:00 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC6DA5D66B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 14:36:59 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id w2so10304329wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 07:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7gWYtkII8mtOVls6zkJP3id5nOPibyKp3U8OMw+vtSs=;
        b=tDRTUkKTeLMAfsOtCKfptCcpAXAB0BaZvhmQ10wmklf0hAJf0zcVTE+VYAPqf16++0
         9N5x+XCbris2J/uLL8UasfLDyx2aPm/tUkSx0lnK8ubpx0NBUHIF5qbA0IiLPxRe1OgH
         8KhNLWgBJPHHCMTUSeU1Etc35gj+GygnsVaNFusNEfgZz8J5IYlb0GeaIJsiX8MfYeay
         5fbfUGHXmbDT2kSBLSJg1EI8wxX8IfquqRXyrGLjCQOmXcNZfOIK6JgBvGFqOO7/9kSR
         gtnMZshByqBzPBQW04ThPpJPk5IBvMUyiWjn8GkHOiZkADVGEF1G+hJjBg6YmSf/j1VS
         8IzA==
X-Gm-Message-State: APjAAAWHDH/UnuP0PguzInxu4oo3+em94XEVjzlz51SWUx12vZlnDKz4
        dNULX3I1c0GQir2v5RIfZIyxkWmN7nOU8a6vp8G/Q9DiSPCeGwk4iUFlVOFFH5KRFS3oKE/R2TJ
        +UjGLy+YDFhFBZ3UjbzJoqv6I
X-Received: by 2002:adf:a109:: with SMTP id o9mr6215045wro.96.1571150218499;
        Tue, 15 Oct 2019 07:36:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy42FIpOdPfkX/N+JnSoKHv+iGGPsS7ya7sjKODSLyv9Nu8uwV8cmZ4JAP7DceOJtB+Y0l45Q==
X-Received: by 2002:adf:a109:: with SMTP id o9mr6215021wro.96.1571150218266;
        Tue, 15 Oct 2019 07:36:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z1sm3637250wrn.57.2019.10.15.07.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 07:36:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] KVM: X86: Make fpu allocation a common function
In-Reply-To: <97255084-7b10-73a5-bfb4-fdc1d5cc0f6e@redhat.com>
References: <20191014162247.61461-1-xiaoyao.li@intel.com> <87y2xn462e.fsf@vitty.brq.redhat.com> <20191014183723.GE22962@linux.intel.com> <87v9sq46vz.fsf@vitty.brq.redhat.com> <97255084-7b10-73a5-bfb4-fdc1d5cc0f6e@redhat.com>
Date:   Tue, 15 Oct 2019 16:36:57 +0200
Message-ID: <87lftm3wja.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 15/10/19 12:53, Vitaly Kuznetsov wrote:
>> A very theoretical question: why do we have 'struct vcpu' embedded in
>> vcpu_vmx/vcpu_svm and not the other way around (e.g. in a union)? That
>> would've allowed us to allocate memory in common code and then fill in
>> vendor-specific details in .create_vcpu().
>
> Probably "because it's always been like that" is the most accurate answer.
>

OK, so let me make my question a bit less theoretical: would you be in
favor of changing the status quo? :-)

-- 
Vitaly
