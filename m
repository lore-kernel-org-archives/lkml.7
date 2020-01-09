Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4173C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 00:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05732070E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 00:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlXw4X09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgAIArq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 19:47:46 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35851 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgAIArq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 19:47:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so1815800plm.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 16:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rSfEEcmQyCUqfvgCiTT6mkGa4l0lidjR/v02Uy320aQ=;
        b=vlXw4X09XtxJmnvAJpjDx+iHGbAhzR8xoLQkJQBDx0HyHh04Cy/pvVg8AWPKiH1i14
         JHUj3TzmajSF4cRTHkQYxyNL/bJU+Wmt+CkIcjZiAotEGEGxmT/03D46hSWJEcxHvnSw
         auKTtM5a4oXh6YD+9rqg8h8jMFhhRuaDVBNNfaTnLxiG3XxV81N/+YbeJ6E68PnVlbmV
         EeMn4TWWovHmHBASdO480YbZIuMh/BaswVryM/GELCxzf5O/2ieWsLn0ZemGdaWy7dHg
         Ac1rxyw1VvR/+AV3gGkGBx+4XWGXQm3B7rHRCAtaiLGKIu9xyAMHJeMh72SlPrB5WnVM
         zfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=rSfEEcmQyCUqfvgCiTT6mkGa4l0lidjR/v02Uy320aQ=;
        b=Cign3MneRqAjdgaQT9ZTTEybma/Krc445yXWvDb09mgc6NWBcZt3Lh3hsPcASh2/EX
         AHbTHFR/dTLJm19YA1w+nzgh7rkRRvxWzZyVSXfsjnoA5Zvs3BFZgoDBO7XrrbNLHbFx
         5bLl5cd17Q+CCeUEAgKcB4KGGEKRVCPiLvr2KExs7cUFdAY7xCC0MQyjaJLX+9ZjUjcx
         MmXf5nJmh6q+5XGUwgqJvPdyIkhMrJcZcFOAq3h28ivZmwcSxjXJvpPcMCfgGU9kqcgd
         1oTaKCvrHbhs2pvydtA1kPBf3WC4J7zQWGf/EHkOqv2RJkIF5uuneLFqu3v+Vl4ssaPk
         jK7w==
X-Gm-Message-State: APjAAAVhO8HFFJ92aqiSwL37NVCHu9fnXu7KQ8lSTRLFeQCgf6hKnKbz
        0ghunpi2PycX/DDlY/PANxqjmw==
X-Google-Smtp-Source: APXvYqw7WGHnX/QpyTD8r1wwlNVnsgyvHRNaXQv42JH5+fdbom1in8GXTZi8DnCxNlaJBf7Bd6EUMQ==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8mr8665290plp.134.1578530865394;
        Wed, 08 Jan 2020 16:47:45 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id b8sm5099312pfr.64.2020.01.08.16.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 16:47:44 -0800 (PST)
Date:   Thu, 9 Jan 2020 09:46:55 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     pasha.tatashin@soleen.com, catalin.marinas@arm.com,
        will.deacon@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] arm64: kexec_file: add crash dump support
Message-ID: <20200109004654.GA28530@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Will Deacon <will@kernel.org>, pasha.tatashin@soleen.com,
        catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org
References: <20191216021247.24950-1-takahiro.akashi@linaro.org>
 <20191216021247.24950-3-takahiro.akashi@linaro.org>
 <20200108174839.GB21242@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108174839.GB21242@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 05:48:39PM +0000, Will Deacon wrote:
> On Mon, Dec 16, 2019 at 11:12:47AM +0900, AKASHI Takahiro wrote:
> > Enabling crash dump (kdump) includes
> > * prepare contents of ELF header of a core dump file, /proc/vmcore,
> >   using crash_prepare_elf64_headers(), and
> > * add two device tree properties, "linux,usable-memory-range" and
> >   "linux,elfcorehdr", which represent respectively a memory range
> >   to be used by crash dump kernel and the header's location
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Reviewed-by: James Morse <james.morse@arm.com>
> > Tested-and-reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
> > ---
> >  arch/arm64/include/asm/kexec.h         |   4 +
> >  arch/arm64/kernel/kexec_image.c        |   4 -
> >  arch/arm64/kernel/machine_kexec_file.c | 106 ++++++++++++++++++++++++-
> >  3 files changed, 106 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > index 12a561a54128..d24b527e8c00 100644
> > --- a/arch/arm64/include/asm/kexec.h
> > +++ b/arch/arm64/include/asm/kexec.h
> > @@ -96,6 +96,10 @@ static inline void crash_post_resume(void) {}
> >  struct kimage_arch {
> >  	void *dtb;
> >  	unsigned long dtb_mem;
> > +	/* Core ELF header buffer */
> > +	void *elf_headers;
> > +	unsigned long elf_headers_mem;
> > +	unsigned long elf_headers_sz;
> >  };
> 
> This conflicts with the cleanup work from Pavel. Please can you check my
> resolution? [1]

I don't know why we need to change a type of dtb_mem,
otherwise it looks good.

(I also assume that you notice that kimage_arch is of no use for kexec.)

Thank you for the merge,
-Takahiro Akashi


> Will
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/diff/?h=for-kernelci&id=aef73191765a88cadc0a627cdc070e5a0086b015
>
