Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAF4C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A282342E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kepstin.ca header.i=@kepstin.ca header.b="eejwfPGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfH3O3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:29:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35062 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfH3O3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:29:20 -0400
Received: by mail-io1-f67.google.com with SMTP id b10so14431134ioj.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nALWCT0w/4IgpkaPDMmW8i7xojZhX1BM8LFM2iLzr84=;
        b=eejwfPGzhvImQ5rQ6Qj0W1VGx7GEXZl6+k/BQeUXMgIcYSW8X/erRCeCoiphXyK6Ms
         3Wn3R2Zq8EkiIfdBcro5M3vcicP7/F4L07CDl6HrsdF9iKAOJ8Ozz3r1UD81mVcaYIwj
         B3k/MLM5xCtj582jfHxUPhV7Tch/rEE3VhCfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nALWCT0w/4IgpkaPDMmW8i7xojZhX1BM8LFM2iLzr84=;
        b=q6CAtEDcxYw1ftFd3ypi8OaDH+v3qFNWpMBD4y39F8bpHFM39Xohf3/Gvdr2mqJcfr
         A6xFY/i0+I4rQy+JvdyDfhpupYKnvoFNMspSVYIJTHfHDzUG6k0VY9VflxaPkkjBvZRU
         tCDIJpgZQ7cCbznTEwcaxPStnOfYys+xeGjlGSRJYIWhkGPUHKZg8TSw/2rAl2fnwAHv
         o7eFwOgGz+z3CPDDK/6X8hHr2EqFFFjbD1eRqu9sXT9lsjil3YlbNdJdZtloVEnYzKqb
         b9rWTlnb5ibtWnn+2n9OxHrcE0TWymck2DzeAmrtimunl9XUwR8SbiaJIXPu+MdqqmiV
         JfKA==
X-Gm-Message-State: APjAAAUTFwKoIghk/P5DOLgtjCwdLt487gQBU1zu87WoTl55XPq6pbbA
        PTLhL308YU8FDdl0gDNrGTR2oQ==
X-Google-Smtp-Source: APXvYqzMABslZm35OP2emany0n3ZDwgvDigPTjq3wXTQbTIjv/iS/DZ11voTizEK44QEZ7S59HLxCA==
X-Received: by 2002:a05:6602:c7:: with SMTP id z7mr19125822ioe.130.1567175359361;
        Fri, 30 Aug 2019 07:29:19 -0700 (PDT)
Received: from rocky (CPEac1f6b45e387-CM9050ca1e1520.cpe.net.cable.rogers.com. [174.114.230.157])
        by smtp.gmail.com with ESMTPSA id k9sm5491455ioa.10.2019.08.30.07.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 07:29:18 -0700 (PDT)
Message-ID: <fea87715422ac21ca5d439e91ff45074069ada20.camel@kepstin.ca>
Subject: Re: [RFC PATCH] tools/power turbostat: Add support for Hygon Fam
 18h (Dhyana) RAPL
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Pu Wen <puwen@hygon.cn>, lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 10:27:46 -0400
In-Reply-To: <1567157008-29679-1-git-send-email-puwen@hygon.cn>
References: <1567157008-29679-1-git-send-email-puwen@hygon.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-30 at 17:23 +0800, Pu Wen wrote:
> Commit 9392bd98bba760be96ee ("tools/power turbostat: Add support for
> AMD
> Fam 17h (Zen) RAPL") and the commit 3316f99a9f1b68c578c5
> ("tools/power
> turbostat: Also read package power on AMD F17h (Zen)") add AMD Fam
> 17h
> RAPL support.
> 
> Hygon Family 18h(Dhyana) support RAPL in bit 14 of CPUID 0x80000007
> EDX,
> and has MSRs RAPL_PWR_UNIT/CORE_ENERGY_STAT/PKG_ENERGY_STAT. So add
> Hygon
> Dhyana Family 18h support for RAPL.
> 
> Already tested on Hygon multi-node systems and it shows correct per-
> core
> energy usage and the total package power.

I was a bit worried about these two chunks, since as far as I know AMD
has not yet released any processor with family 0x18, so there might be
future conflicts:

> @@ -3803,6 +3804,7 @@ double get_tdp_amd(unsigned int family)
>  {
>  	switch (family) {
>  	case 0x17:
> +	case 0x18:
>  	default:
> 

> @@ -3982,6 +3984,7 @@ void rapl_probe_amd(unsigned int family,
> unsigned int model)
>  
>  	switch (family) {
>  	case 0x17: /* Zen, Zen+ */
> +	case 0x18:
>  		do_rapl = RAPL_AMD_F17H | RAPL_PER_CORE_ENERGY;
>  		if (rapl_joules) {
>  			BIC_PRESENT(BIC_Pkg_J);

But the second switch is already guarded by the CPUID check for the
rapl support, so it will either "just work" if AMD's family 0x18 chip
uses the same RAPL registers - or cleanly skip the CPU if they changed
it.

Please add a comment on the 0x18 case in the rapl_probe_amd function,
something like:
	case 0x18: /* Hygon Dhyana */

Feel free to add a
Reviewed-by: Calvin Walton <calvin.walton@kepstin.ca>

-- 
Calvin Walton <calvin.walton@kepstin.ca>

