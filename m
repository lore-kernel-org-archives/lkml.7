Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4846C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BE020644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZsCjlbCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbfFYRbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:31:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40440 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbfFYRbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:31:31 -0400
Received: by mail-qk1-f195.google.com with SMTP id c70so13269703qkg.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NxRs95n2elVksXNBSvDteGChb0IvO9Nqmt1xB7mtgi8=;
        b=ZsCjlbCH4wcKE34WzEQ1DugUDvRHuHiSQUHUHOfGUUjYiijjSpNplF30oa3GkcYdul
         vpntYyNF0B3SvaaomMv24Kpg5f0FAecAtGvksjGG72eEDLtOdDTyEgj1yslBDWYPc3w2
         ReIz2WcTILQeIDkTRNPyVNMIPnWSyNHlKQ/uzZivUpbqEV/DtAw88BOcd4dtxd8MBUc5
         1VQp0Ih/eZezYb8bxy3ObyWeWRCnPMH1grzKbSbbtnapYLIzsMXUYK7NPcOqFDPj36M+
         hh6n1ItcZZ7epTsiFg1oyAJb54d+LErCiea6curCZRNTiQBmuZId0IFuGiMhrLivrWgA
         Yv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxRs95n2elVksXNBSvDteGChb0IvO9Nqmt1xB7mtgi8=;
        b=s3owzgSJyIxSv9joRCscffpbPp6AfmfZh8zIGpyB75Ie+jef/Uhn9tpadZdudV7MkT
         bQNYoA44IRnaQriAIrQ9BYNG7YGsp970PAdmMxpG2WTNZuC2XSWVn1b0rDjJGRv42H3p
         CrNHFG11I4c2mznwwJF1IagRmjh9bP7zL+UTlx5OYPCvUrk0BFPs33tMlaSwgn685AFA
         7nxHIA0E7QHJyxoO+pf9EUYmff6iB3OhctbJVLrRbWnE8G7fBuIyASMuEBIpm1K7FEYy
         HK++G47xkH4ICu5YerVNYeDI2uszznZYQTBtWZQ3Y7joQwIRPHTBmTWEmWBkqSBQvPih
         pEag==
X-Gm-Message-State: APjAAAU+nwlQt7lun3Rns8HTFFlLPv8a5JJHqltvcyiI/rpARtViBPkr
        0Ul1UH/qml8HG1boLnis8ACI3w==
X-Google-Smtp-Source: APXvYqyLUf4D78VLGO1GHxXVfj/F5X5RbZoPnSYBuLjX/UxfVBm73dMjHnVMCfC/wqGdjVwlgEf2bw==
X-Received: by 2002:ae9:ee17:: with SMTP id i23mr22739595qkg.399.1561483890355;
        Tue, 25 Jun 2019 10:31:30 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f68sm7744695qtb.83.2019.06.25.10.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 10:31:29 -0700 (PDT)
Message-ID: <1561483888.5154.78.camel@lca.pw>
Subject: Re: "arm64: vdso: Substitute gettimeofday() with C implementation"
 breaks clang build
From:   Qian Cai <cai@lca.pw>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Date:   Tue, 25 Jun 2019 13:31:28 -0400
In-Reply-To: <193c179e-16ca-4b4e-2584-75e8f6c1819f@arm.com>
References: <1561464964.5154.63.camel@lca.pw>
         <e86774e4-7470-5cb2-fc3e-b7c1f529d253@arm.com>
         <1561467369.5154.67.camel@lca.pw>
         <00a78980-6b9c-5d5b-ed01-b28bb34be022@arm.com>
         <1561470705.5154.68.camel@lca.pw>
         <5113362e-1256-6712-6ce8-9599b1806cf1@arm.com>
         <1561472887.5154.72.camel@lca.pw>
         <668bbe72-b32b-8cee-ccad-d1f6110c6728@arm.com>
         <CAKwvOdmCFjunXRbninTdqoDGPNJ6b7npgXLAPYGqFZas5ofNjw@mail.gmail.com>
         <193c179e-16ca-4b4e-2584-75e8f6c1819f@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 18:00 +0100, Vincenzo Frascino wrote:
> Hi Nick,
> 
> On 25/06/2019 17:26, Nick Desaulniers wrote:
> > On Tue, Jun 25, 2019 at 7:54 AM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> > > 
> > > Hi Qian,
> > > 
> > > ...
> > > 
> > > > 
> > > > but clang 7.0 is still use in many distros by default, so maybe this
> > > > commit can
> > > > be fixed by adding a conditional check to use "small" if clang version <
> > > > 8.0.
> > > > 
> > > 
> > > Could you please verify that the patch below works for you?
> > 
> > Should it be checking against CONFIG_CLANG_VERSION, or better yet be
> > using cc-option macro?
> > 
> 
> This is what I did in my proposed patch, but I was surprised that clang-7
> generates relocations that clang-8 does not.
> 
>   LD      arch/arm64/kernel/vdso/vdso.so.dbg
>   VDSOCHK arch/arm64/kernel/vdso/vdso.so.dbg
> 00000000000009d0 R_AARCH64_JUMP_SLOT  _mcount
> 
> arch/arm64/kernel/vdso/vdso.so.dbg: dynamic relocations are not supported
> make[1]: *** [arch/arm64/kernel/vdso/Makefile:59:
> arch/arm64/kernel/vdso/vdso.so.dbg] Error 1
> make: *** [arch/arm64/Makefile:180: vdso_prepare] Error 2
> 
> This is the the result of the macro I introduced in lib/vdso/Makefile.
> 
> And I just found out why. I forgot to add a "+" in the patch provided :)
> 
> @Qian: Could you please retry with the one provided below?
> 

It works fine.
