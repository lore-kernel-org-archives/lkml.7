Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47080C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146F62087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551789453;
	bh=SIQj+VHq4Z6NlEdDQ9yK00lYzXSMvalkc6XEov7GPXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wn8qcSonCBesoysFL5P3nIYoogO2N9NA0jjfekxgvGyJGQkfcBMzzjkr/kIh7BfTp
	 Hpn7iP2aS2wZ3JjFf/juEe0dj5+zLXANmiXfJQgYmFWseFpDI7mS+6p5QzGBzdxrPu
	 YawXlsw5dZcPDVxE+WmtE/8VCY0xnB03ToTkJ2Dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfCEMhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:37:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42168 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbfCEMha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:37:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id r5so9275965wrg.9;
        Tue, 05 Mar 2019 04:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7QokLhVRiXMfRg+ZFW4EZloog6wgQwAh3snVLb8Xlx0=;
        b=gxFd2FaW4iI8cuSGuC6Wq/5L3tTQZTBzveg/t5UAmJ7+7531WxXu46KgB2tX3sr7lz
         XlfhOemzABM1Hx67bAQytsea4bbs171AT5THcnNtVO5qVPsEovl/DPk0DK23JabPOIYx
         Xc1duSGsTYAP3DU3CD2lHSSB3jbLiTdRLVH2zrd1fmEG5lIKlK9GVx+Z7+hwbnfyke8W
         IOez+nLNWjp1awQSpussx96gSnJcqg/Bfsi45KFY1NaRG2J0rRPHAn8tvcDtufyHT0XA
         kAq2oP048Z3+TJ6VF9MQD7E0li4WfCfxdQktvKKLN9H6sOELW7vN5at4gWJbq8wjeTZG
         ftPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7QokLhVRiXMfRg+ZFW4EZloog6wgQwAh3snVLb8Xlx0=;
        b=NUj4kGPreJR1Y+M2CitBEsqVF68hTHnxNc8f3nyytC9mBftBEPDELNoS+LDGm1mEW8
         xm8qNlVxto0182MJKUmB9vs8lAdfAsq5oIBJs4hpqw/L/SrUE1Zxw7+23M25IRc4iH4s
         mkjkmJF27vDeueH7NERweNmeuT9MLuf7j/pwsbO3SRdlyIcxJr7Uu74t8QiEq7E3fFQX
         C74xJqhSdhZzZvyD5VHSrLiDMDDziytV11S8qU6gHxPfHBvqF2x85yemj6L0r1Cjo0SJ
         nxeJbQuJi6vIs8AMCM7k97X6W87XXrEROJ0Nc+w+UgCt/qP2L3EG5DASUhRXfmqEniDx
         7QJA==
X-Gm-Message-State: APjAAAWoCwX2xltiiF9MMijxBfMRnE+QO6RGTguCknenbyA2sXZXFkZ+
        Epo7LX0ct6ylcMcZ0yd0PPI=
X-Google-Smtp-Source: APXvYqx+4Fkd0SQKCQuFZLbtCf4PQy18HNTYg95JdDf4naBpwptaxrxSsi7Fo1KPZOTTijbB36pLVA==
X-Received: by 2002:a5d:574b:: with SMTP id q11mr15555406wrw.41.1551789448783;
        Tue, 05 Mar 2019 04:37:28 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d21sm27040962wrc.44.2019.03.05.04.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 04:37:27 -0800 (PST)
Date:   Tue, 5 Mar 2019 13:37:25 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] EFI changes for v5.1
Message-ID: <20190305123725.GA42141@gmail.com>
References: <20190305122038.GA2472@gmail.com>
 <CAKv+Gu_P-tmM-tFCDuxy+6mE-tGUUbcFoCUbJMAsitMk5Ahstw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_P-tmM-tFCDuxy+6mE-tGUUbcFoCUbJMAsitMk5Ahstw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> Hi ingo,
> 
> On Tue, 5 Mar 2019 at 13:20, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Linus,
> >
> > Please pull the latest efi-core-for-linus git tree from:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus
> >
> >    # HEAD: 5c418dc789a3898717ebf2caa5716ba91a7150b2 efi: Fix build error due to enum collision between efi.h and ima.h
> >
> > The main EFI changes in this cycle were:
> >
> >  - Move BGRT table handling to earlier in the boot so we don't overwrite it
> 
> This one actually got reverted because it broke x86. I haven't heard 
> back from the Intel engineers that reported the issue, so i will 
> revisit this at a later date.

Indeed, and I applied the revert and then promptly forgot about it...

So the real changelog is:

 - Use 32-bit alignment for efi_guid_t
 - Allow the SetVirtualAddressMap() call to be omitted
 - Implement earlycon=efifb based on existing earlyprintk code
 - Various minor fixes and code cleanups from Sai, Ard and me

Sorry and thanks,

	Ingo
