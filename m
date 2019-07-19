Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BAAC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E9B21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAzd3DTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfGSDZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:25:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40120 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGSDZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:25:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so30709377wrl.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 20:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jIYPnkgBs5i86rbWUSwNdiw65NtG6kE0hp4IepPNimw=;
        b=uAzd3DTOad8sm8SbAbgLpLuIhEdXSKzEZq0uAVNPjjgfCGSTsFIK7uIaPbM+AILI1T
         JAvFnrZaC3ngiU7GDa/hEQeMeNf62aTdCJ+/2tou3cwabyOoq/c3eQ/8GQtN2xa9r/QT
         sO3MrrlkW6O4cJY1gi4NgKsLjlmNRdsQSf2bXYAtuZHNIYXLvrR+NuTJ6DebYT4mdRKZ
         AVujvuw0kIDZdVfrjhrlx0cnJs8IlapWBSMutWKM5GwfeHuzZ/hI//2duR/hsTNY7WcM
         zvbcqleNRVXUwGRmxYi6jv7nrMFYn3OF2YwOBRjzz6xER/YP8caUuLYdu5MwbHFCaXMg
         FwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jIYPnkgBs5i86rbWUSwNdiw65NtG6kE0hp4IepPNimw=;
        b=uhxuBl6ypxGPmUJbEcBwNcXqS7T1rEdCQnjCwRAwxIMf/JuqslZygmGEgvfhggIwM8
         RN7y1xWlkhwbJ7MSC/X26OwidSAf/zmlzV2C/ZJINzozmJLDNhRiiBWMVUWOT4UrMfBL
         XCV1GRbKaaonqdls2Uc+MfWjckUeBMbMjnt0ExeabNV4ikTXvCPnRLrakYo/reln+3Ad
         IphX95pKVxwKPG5TSiXTeOaz6enSKt5fARNJZlRyF8anj6UA8NUXr+dq5n1xkHe3p6+j
         6x9fa3+//NqsqodhsCiMD3exy4aoPXHnwIShgGxHfVBMErCy+lbNijdM+/qC9oZOqkmb
         yYAA==
X-Gm-Message-State: APjAAAW7yMVSWvs121++UTffTFjtN7xwnJ1M7yKWzF6eGtgZ/CtXRRkr
        Wle3P13mdZrCACn9z6jB1m8P5wd0+N8=
X-Google-Smtp-Source: APXvYqyT8jgZuM/70vXITnsp6orU2Gbote6On0qrgGrBbjMKFgK5AbQwBSEInRvsJG2tx8AWq8pyaQ==
X-Received: by 2002:adf:f883:: with SMTP id u3mr52455389wrp.0.1563506698857;
        Thu, 18 Jul 2019 20:24:58 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id r14sm27007800wrx.57.2019.07.18.20.24.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 20:24:58 -0700 (PDT)
Date:   Thu, 18 Jul 2019 20:24:56 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
Message-ID: <20190719032456.GA14108@archlinux-threadripper>
References: <c6ff2faba7fbb56a7f5b5f08cd3453f89fc0aaf4.1557480165.git.christophe.leroy@c-s.fr>
 <45hnfp6SlLz9sP0@ozlabs.org>
 <20190708191416.GA21442@archlinux-threadripper>
 <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr>
 <20190709064952.GA40851@archlinux-threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709064952.GA40851@archlinux-threadripper>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 11:49:52PM -0700, Nathan Chancellor wrote:
> On Tue, Jul 09, 2019 at 07:04:43AM +0200, Christophe Leroy wrote:
> > Is that a Clang bug ?
> 
> No idea, it happens with clang-8 and clang-9 though (pretty sure there
> were fixes for PowerPC in clang-8 so something before it probably won't
> work but I haven't tried).
> 
> > 
> > Do you have a disassembly of the code both with and without this patch in
> > order to compare ?
> 
> I can give you whatever disassembly you want (or I can upload the raw
> files if that is easier).
> 
> Cheers,
> Nathan

Hi Christophe and Segher,

What disassembly/files did you need to start taking a look at this? I
can upload/send whatever you need.

If it is easier, we have a self contained clang build script available
to make it easier to reproduce this on your side (does assume an x86_64
host):

https://github.com/ClangBuiltLinux/tc-build

Cheers,
Nathan
