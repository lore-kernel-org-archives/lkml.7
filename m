Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD20C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72784206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569262728;
	bh=LO4GTKKSHWB9kcHekO7hnomAZooSVXs0I2xg7poD4DY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mhDWPixasQMMaD5rF6CmfIrnVUsdBJqW1LOy/eELg3a6Cli3CKCgNZWqKZTeEBwYX
	 gSo4ZntAwlVOl64pLwwJ92l3jOEjhJoWTfnPNTp4vtFxH6bx9j2Q52DMLpbZX3qo41
	 pNwkCS+6oTHOpYzkp/Hc47Zj/SaNDL00/0AsGfJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440438AbfIWSSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438191AbfIWSSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:18:47 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7116E2168B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 18:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569262726;
        bh=LO4GTKKSHWB9kcHekO7hnomAZooSVXs0I2xg7poD4DY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j0BZXQIpX2MOlhf9SNznn8IGzntp+2babJIqLVhkcA9epdql6lJxsc3WfrZx4AT2H
         sCnl/bTZ5yOO4OB4REdI7QlHWu57x01sWSen0jTwTw33GaDgw8KHXRFivZkFtwGjq1
         /saaLIbAjaaHg35vxirC2Q74D3G6RlwxqQiPpEJU=
Received: by mail-wm1-f47.google.com with SMTP id v17so10329360wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:18:46 -0700 (PDT)
X-Gm-Message-State: APjAAAU4RwyfCoMn+M18UsyBrrZn/JhVTbgbj8ObcW/8Q3CTntAQEpiM
        A6twtWcdj0obVJVyYGwZIOrcevUAhs3gfd8No3SLrA==
X-Google-Smtp-Source: APXvYqyuY3H2DKNpr0Bzr8dbUHAxIiCTpvK12u2LHOiAR0CZVPK82iYnYzgf0u3M5gP9FATk1J7gn1h2vcuI6Q6N73Y=
X-Received: by 2002:a1c:6143:: with SMTP id v64mr689647wmb.79.1569262724979;
 Mon, 23 Sep 2019 11:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190919150314.054351477@linutronix.de>
In-Reply-To: <20190919150314.054351477@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Sep 2019 11:18:33 -0700
X-Gmail-Original-Message-ID: <CALCETrVpG9iH821LMuL5OOrAeRekYjYE9fyK3KkCwohN6ZUcXg@mail.gmail.com>
Message-ID: <CALCETrVpG9iH821LMuL5OOrAeRekYjYE9fyK3KkCwohN6ZUcXg@mail.gmail.com>
Subject: Re: [RFC patch 00/15] entry: Provide generic implementation for host
 and guest entry/exit work
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> When working on a way to move out the posix cpu timer expiry out of the
> timer interrupt context, I noticed that KVM is not handling pending task
> work before entering a guest. A quick hack was to add that to the x86 KVM
> handling loop. The discussion ended with a request to make this a generic
> infrastructure possible with also moving the per arch implementations of
> the enter from and return to user space handling generic.
>
>   https://lore.kernel.org/r/89E42BCC-47A8-458B-B06A-D6A20D20512C@amacapital.net
>
> You asked for it, so don't complain that you have to review it :)
>
> The series implements the syscall enter/exit and the general exit to
> userspace work handling along with the pre guest enter functionality.
>
> The series converts x86 and ARM64. x86 is fully tested including selftests
> etc. ARM64 is only compile tested for now as my only ARM64 testbox is not
> available right now.

Other than the comments I sent so far, I like this series.
