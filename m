Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6741C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95473217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpj1e8S6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfJOA2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 20:28:22 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42085 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfJOA2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 20:28:22 -0400
Received: by mail-vk1-f196.google.com with SMTP id f1so3928144vkh.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 17:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=quuBF4iPY/Wt9WEvG0fNAxmwp7tynvi1WojC5cjb9xU=;
        b=lpj1e8S6Zo+6lpWokhWTMZ0qtY/2F9b3w1zpDJJLh5zcIT7iWstPaaKb9qdL73rMgR
         2F1spK0bQpV+t7U/Aqn5vmuNrfpshwwIGsXyC3BQ3zP/84vdATleZRvm7ApudJoIzTrK
         nZG+TWgouR4uaQEYlQrhKPKr4zPAsbB7p+CVm/wiWAooGCb+zAMb7z0vSuadL4tjCg5w
         2PUEsKk/hLYxIPoMhdXT/L7KJULlpVPAaPCMrerdCSrLr4H+GjOB0B7kLGc5uRAQV3XT
         0nHAdk6hvIlWaMwp02bCP9/lgiKTwU3L2Nczjh2Z02BMUXqt890G3t7XEqavr0q2H+PO
         TJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=quuBF4iPY/Wt9WEvG0fNAxmwp7tynvi1WojC5cjb9xU=;
        b=qVM1kOAjbtiwh5jc43fwSjXL62tfw3XOrgSo/A9/hRc/uVJxLJdOG3uryitOYkgpFt
         0bltQvc0GZxfCLHSOZuMgLsc3T5qE8pTC/H0HBaWdmF8V9JYHIXtvANwm9dX+aUucbvr
         gvJgGbQkdY2o1fEQ/FPq90ZbX087bU3w4FDC0DadncFbDrvF5+0QkbpYoDoYl0Mw1jGY
         yXLxfWY2NzD8HWTDqiAcqbWvV2Zcfk7BJWEaxA2YiddJumampsPKYgWDXfrWNF+w4IOx
         +Pw3Qc7h3KqjYchE6MuFxyZ7iHQmcEDPIK3Y204T1DaKBBHrC4TIrfQfsECqA0yNN43i
         goeA==
X-Gm-Message-State: APjAAAWxEdZMOPX95hw74YLxO1obtAUX1ZcFMD0IjVLsLizYmlEKm7xz
        PzbLIskXnVRd9ORzzxJC+Xz7plH4mlRYIefzaRz+LA==
X-Google-Smtp-Source: APXvYqyk/oPHXB2GPTLRU0uqExS4SkvlQyK0IdEb/p6sJ+8DrKdEkZblYAOKqR5cougkDieFGPLVX7jjDtHgP6dgaew=
X-Received: by 2002:a1f:1ad4:: with SMTP id a203mr17612116vka.81.1571099300495;
 Mon, 14 Oct 2019 17:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191007211418.30321-1-samitolvanen@google.com>
 <CAKwvOdnX6O0Grth11R8JLoD9bp-BECheucZKHbiHt4=XpQferA@mail.gmail.com>
 <CABCJKudGtvVazLpZFdbhe9z-4mx_t16zxzkcwYbdAJriakrWqw@mail.gmail.com> <20191015000017.66jkcya6zzbi7qqc@willie-the-truck>
In-Reply-To: <20191015000017.66jkcya6zzbi7qqc@willie-the-truck>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 14 Oct 2019 17:28:09 -0700
Message-ID: <CABCJKueDZBd1TZyNTH-jo=DsVeze=mout1ooK5sSbPb52RyjPA@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix alternatives with LLVM's integrated assembler
To:     Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 5:00 PM Will Deacon <will@kernel.org> wrote:
> Is there any benefit from supporting '-no-integrated-as' but not 'AS=clang'?
> afaict, you have to hack the top-level Makefile for that.

The goal is to eventually support AS=clang and this patch gets us one
step closer to that. However, with this patch (and the LSE one), we
can already use Clang's integrated assembler for inline assembly,
which is a requirement for compiling the kernel with LTO. Google has
shipped LTO kernels on Pixel devices for a couple of generations now.

Sami
