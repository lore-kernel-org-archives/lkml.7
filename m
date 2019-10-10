Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5161AECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2564B2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CQBl48C9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbfJJAk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 20:40:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40847 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731155AbfJJAkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 20:40:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so2727500pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 17:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UcPd5Jny5aY5aMsPzhLMHUk3eBTerZnA6THOQx3YHYM=;
        b=CQBl48C9FQrJE5k703Kev1+BQ/3whfu6HOkubrefsdeM3B2i5ly4Dw9keO2geTEGUV
         s+Ui79CGMEi8TyPD6oEqp7cslGqZKhXLLTCoggJ/CPYtMcY9bWkjwact3xZFKaXvWZYO
         u5JLNe8rCmmBk2yB39UHSrBbn2Uo+Ciiic/jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UcPd5Jny5aY5aMsPzhLMHUk3eBTerZnA6THOQx3YHYM=;
        b=l0GVEM/Eb6BeDe0ZpKd2APkVsZjCij73X0Lrl1rOhTTHCSs3RKoQDHMejcf+xoFqsy
         mzaTLm/nJ/Bi4NOWSXHaGtuIv3OeX7UnodPiiYnr7chIlIanLvErkUJYaOdFbaYCWNBu
         YeD2BOjJOCeWShltNiQ8hXYqNl8pHxBAFn7TwX4eituKYzLKQHaWaU2Cf56g9Oq64j5C
         0pDSEGEjAFhPbKpAHWZ9/pBBjq7az9RttdAFAtd9J2Zly8O3ZCGBNGwIwYKqFDhkyQbS
         mAeRrznOQfjoxBSAoIknK1KI8PpGe1SQLUK5/Yb4xovyXBDBhA78QxdUp88CoWsl559z
         jbUA==
X-Gm-Message-State: APjAAAWD/p8/SH5lKQFBsyAPnuyaU0L/3jKPzlifXeoydD6f+sQtCyPB
        E8yN69/iStdMd/CuxMv5a1qHGw==
X-Google-Smtp-Source: APXvYqwiMuTGGeU2xAhSzgcNonr+8WNtJueMfhMlVoTbDTnimhgmwYn+zScwE00Wpmxe8o7Phci6AA==
X-Received: by 2002:aa7:93a9:: with SMTP id x9mr6675538pff.81.1570668025033;
        Wed, 09 Oct 2019 17:40:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 22sm3415597pfo.131.2019.10.09.17.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 17:40:24 -0700 (PDT)
Date:   Wed, 9 Oct 2019 20:40:23 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC] perf_event: Add support for LSM and SELinux checks
Message-ID: <20191010004023.GC96813@google.com>
References: <20191009203657.6070-1-joel@joelfernandes.org>
 <710c5bc0-deca-2649-8351-678e177214e9@schaufler-ca.com>
 <alpine.LRH.2.21.1910100912210.29840@namei.org>
 <2b94802d-12ea-4f2d-bb65-eda3b3542bb2@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b94802d-12ea-4f2d-bb65-eda3b3542bb2@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 03:41:56PM -0700, Casey Schaufler wrote:
> On 10/9/2019 3:14 PM, James Morris wrote:
> > On Wed, 9 Oct 2019, Casey Schaufler wrote:
> >
> >> Please consider making the perf_alloc security blob maintained
> >> by the infrastructure rather than the individual modules. This
> >> will save it having to be changed later.
> > Is anyone planning on using this with full stacking?
> >
> > If not, we don't need the extra code & complexity. Stacking should only 
> > cover what's concretely required by in-tree users.
> 
> I don't believe it's any simpler for SELinux to do the allocation
> than for the infrastructure to do it. I don't see anyone's head
> exploding over the existing infrastructure allocation of blobs.
> We're likely to want it at some point, so why not avoid the hassle
> and delay by doing it the "new" way up front?
> 

I don't see how it can be maintained by the users (assuming you meant
infrastructure as perf_event subsystem). The blob contains a SID which as far
as I know, is specific to SELinux. Do you have an in-tree example of this?

Further, this is also exactly it is done for BPF objects which I used as a
reference.

thanks,

 - Joel

