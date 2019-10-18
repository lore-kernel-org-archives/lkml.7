Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91311CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B49222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akYzP0Yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391490AbfJRF2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:28:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53972 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbfJRF2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:28:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so4738789wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rgI0YB4AiPdp5L4RaTennbKUpcmOoav7alTjyjJ79iU=;
        b=akYzP0YnEV3LrHKI0x27ywf2tmPVjk5x+F9QSkw4eiudLUi0e5ydkNp+wz57+hk7c/
         YhLmWqBjsUx4THeIYoeSis2gBMXbrC4+sfWFUa5epCvTglU2oSR/grY3CGsHHrmLFtxG
         rwXnSf4SBth6z6DcwFfBDU5jMoiArJ4oo0BSlTFSR98OedCI00w/ZPfqZakpcMuulg4s
         YiYYda+GqmSJ+eZ1c1u/fZq1OUDVSR8roXl71NpIc8YFVna7+hzir80BlG6zWFsLF53h
         XXRmAiQzlLjrauOR1nqwwgELHsk1xCnUspABX12unK3nwhYsiKYw/0kBlOHyh0keYwkv
         BmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rgI0YB4AiPdp5L4RaTennbKUpcmOoav7alTjyjJ79iU=;
        b=q87xPUrTZ1FsEY6Y5Pip/zZlra5WVrm9Yhgc8Uatd2R89AOXiVvpKI4rIgJ5VFoQbO
         JNr3fbHfn8aR1F3CYPq1zMP/t0GyX14iMMgkMiFzZAISS9jRtrwfRGm2vbnn/mjAGNID
         Ud/7IPqqQjq4zSab4vr6JgAobrTv4wqwIOmlSNEyEqbC0PnyiNlGbqT4Cf3Z1QSNcQin
         JryFmRRYNRDTKCTnTG0LISen1cqpnThYcCFpOle8QzpmmHjpIAEpO07F4R08FyOvZG3r
         DQAXXW49vclnWKO6LjiOmDN03DNvCZ+re5JxC6hSrhKXeIHIuZg8UNMgvCHQQbkzcCFX
         eV+w==
X-Gm-Message-State: APjAAAWvdbM4RRAi7sicKddnbWCDaES8tNFVEE9wrECpUKVSPB6+EbD6
        cDAd6K45ouXp4Hb3JpRqOzCZIg1y
X-Google-Smtp-Source: APXvYqy7fLnUS08Adl8FRD5tfNheTTY/1vBy5OQA8QcpVIycS6+5kjlmgUNlyCR+iSG4nj4zc2sY3w==
X-Received: by 2002:a7b:cf0d:: with SMTP id l13mr5601891wmg.47.1571376521764;
        Thu, 17 Oct 2019 22:28:41 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40ac:ce00:f882:d2a3:f943:89a4])
        by smtp.gmail.com with ESMTPSA id o9sm4346618wrh.46.2019.10.17.22.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:28:41 -0700 (PDT)
Date:   Fri, 18 Oct 2019 07:28:40 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] riscv: init: merge split string literals in
 preprocessor directive
Message-ID: <20191018052839.efpqhxkqsjoqtdks@ltop.local>
References: <20191018004929.3445-1-paul.walmsley@sifive.com>
 <20191018004929.3445-4-paul.walmsley@sifive.com>
 <20191018040237.3eyrfrty72r63pkz@ltop.local>
 <alpine.DEB.2.21.9999.1910172127220.3026@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1910172127220.3026@viisi.sifive.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 09:38:18PM -0700, Paul Walmsley wrote:
> On Fri, 18 Oct 2019, Luc Van Oostenryck wrote:
> 
> > On Thu, Oct 17, 2019 at 05:49:24PM -0700, Paul Walmsley wrote:
> > > sparse complains loudly when string literals associated with
> > > preprocessor directives are split into multiple, separately quoted
> > > strings across different lines:
> > 
> > ...
> >  
> > >  #ifndef __riscv_cmodel_medany
> > > -#error "setup_vm() is called from head.S before relocate so it should "
> > > -	"not use absolute addressing."
> > > +#error "setup_vm() is called from head.S before relocate so it should not use absolute addressing."
> > >  #endif
> > 
> > Using a blacslash should do the trick :
> > 	#error "blablablablablablablablablablablabla" \
> > 			"and blablabla again"
> > Or if need I cn fix Sparse if needed and desiable.
> 
> Thanks for the kind offer!
> 
> The backslashless syntax is pretty horrible to my eyes.  As far as I can 
> tell from a brief glance, the instance fixed by this patch was the only 
> instance of its kind in the kernel.  The existing kernel precedents appear 
> to be to simply use a single long line.  Example:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/compiler-gcc.h#n3
> 
> So, from a kernel point of view, we should just fix this specific 
> instance.  It doesn't seem worth changing sparse for such a rare case.
> 
> On the other hand, gcc seems to support the non-backslashed syntax.  So if 
> the intention is for sparse to follow the gcc practice, and to be used 
> beyond the kernel, maybe it's worth aligning sparse to gcc?  Only if 
> you're bored, I suppose...

I'll first see what is acceptable for the point of view of the standard
(and maybe some justifications from GCC).

-- Luc 
