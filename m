Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B0EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4B42075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574873431;
	bh=VOb0RS0hAHyS/PUhi54+xwu0nqWn0a82oOuNbu97k2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=of5eAIHT8N5fZ5IFim9WORr/gvpdigQVECRGxp6h6rHSPp7JgDKmZoODxgPBrIxr2
	 Clzkj8IQCtHEaQcdlDYg5ev1ZhiWSw01EE+F1knD0EFDXtj/Mg3S9UwBx1iA7Vy2xr
	 nofLRMGLzueX0N8zzay6j75y336VNxmAuF6VcF48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfK0Qua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:50:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50359 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfK0Qua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:50:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id l17so7856838wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 08:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v9XbK+DvvfKA1QR8bjGxkLx47MI/57nuygnHN6PvLgE=;
        b=RHuWO4TVRimsB9jc2zljXz3aT9aCUx5iVG2Y1yJ2Zu7mAqM5fIpU7gCxDIA6lewi1t
         4uuIC6L62A5zKZIUnE/+ioZyJTbJpyPrptr68z4N/dptfeqMSIAOhpL1NIfdWKyZ78Qm
         yz+69HCc12Q2WqkABOz9HM/UiJGf/XE0ojhVUE0s4Cj93CQ6oqPlD8pxe6TFDskg3E4k
         47o9BUtd7S6z8HUGn8Mz1RCDPcAMW3j3vg4oqHXk0GLpAQfOGN0tI8B8S9Ri2fCYulBZ
         Yk+qdGF/6Vna0WD1vquJMScQ6lNcFsX6iV8YqbC8duAZaJSpueeWqTMhp4JnQku6WpIe
         y3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=v9XbK+DvvfKA1QR8bjGxkLx47MI/57nuygnHN6PvLgE=;
        b=oeZDwOll6PWCX2EdT3dDJWbZo8gKAp68+ilJSeNjbEktJmnUR1tXIoo8bUYj0Lihz6
         v2m4X7zB/hguRXfMuaWwAyEE64DoK5/AVTaF3uhsHh0lfX4qgf6YG2v3ibl04nN3waoi
         4OFqLtoc2HgfHnzrDUDn6bje29DZRBt0XIVsV/iuBTpak5gHpF/dhbnnkQSTpfyXRudl
         Oaz1GNWWNYnCjol3mRi1ieHgZ3a5mkGUYiP/p5x6tgzGeGGN9wHjJVVaHZwi4lwhuaQY
         AHuhkt3LZ+uepjipqMS0VbVFfw+nX39/1FHKAlMzXsI+Ql+J5HCc6sBUggYcw51MT77X
         COpg==
X-Gm-Message-State: APjAAAXeyiHf9mB9DsQVSbxdwEbGJVqgdQZCDyOZAveiKp+eEr5LXaOu
        p29ZJ5b4i6AbBpKNZmJ7Z3A=
X-Google-Smtp-Source: APXvYqyrTMCaFJhYzxfLZCgk6qLH09/xX3Sb7F9urLw7I+AZ7EzbFKTe98LUcSF6OTCGWQJ/NNMUtg==
X-Received: by 2002:a7b:c94c:: with SMTP id i12mr5374964wml.95.1574873428168;
        Wed, 27 Nov 2019 08:50:28 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 2sm19702634wrq.31.2019.11.27.08.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 08:50:27 -0800 (PST)
Date:   Wed, 27 Nov 2019 17:50:25 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jules Irenge <jbi.octave@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        mingo@redhat.com
Subject: Re: [PATCH] cpu: microcode: Add comma to 0
Message-ID: <20191127165025.GA10957@gmail.com>
References: <20191126221519.167145-1-jbi.octave@gmail.com>
 <20191127065436.GC52731@gmail.com>
 <20191127112613.GA3812@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127112613.GA3812@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Nov 27, 2019 at 07:54:36AM +0100, Ingo Molnar wrote:
> > 
> > * Jules Irenge <jbi.octave@gmail.com> wrote:
> > 
> > > Add ","  after 0
> > > Because memory for the struct is being cleared
> > > and elements after "," are missing on purpose
> > >  as they are being cleared to
> > > 
> > > Recommended by Boris Petkov
> > > 
> > > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > > ---
> > >  arch/x86/kernel/cpu/microcode/amd.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> > > index a0e52bd00ecc..04ee649f4acb 100644
> > > --- a/arch/x86/kernel/cpu/microcode/amd.c
> > > +++ b/arch/x86/kernel/cpu/microcode/amd.c
> > > @@ -418,7 +418,7 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
> > >  static bool
> > >  apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_patch)
> > >  {
> > > -	struct cont_desc desc = { 0 };
> > > +	struct cont_desc desc = { 0, };
> > 
> > This is 100% unnecessary - " = { }" is enough of a structure initializer.
> 
> That was my initial thought but empty initializers are not ISO C
> compliant, I've been told.

Yeah, but the kernel isn't ISO C, and the hive mind has spoken in favor 
of the shortest variant:

  dagon:~/tip> git grep '= { }' | wc -l
  647

  dagon:~/tip> git grep '= { 0, }' | wc -l
  231

  dagon:~/tip> git grep '= { NULL, }' | wc -l
  38

:-)

Thanks,

	Ingo
