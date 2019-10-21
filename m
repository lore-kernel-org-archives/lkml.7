Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5539ACA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273DB214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571648530;
	bh=XqxK9zhnIdTcXMoeAE3KBhXGCX02MDIAgNsQz/zcdNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dRydE3DyhCHZlkOzYTu9qodKSXHspM6SwHOowM9mtn+WpsUk/VCh2Ctog46qQtHHV
	 vigm2Du+cENq/tugVDQJPPKTydslfdZTMwaxZiUxDJuaX/+jgc7FuxfEWZUV7Qkrlv
	 N2ErynkZEB2AO9YMzMpqQxA20UApDw15SMlUM1jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfJUJCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:02:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36443 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJUJCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:02:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so12391201wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 02:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BTE84q/lPpOTe8Tqy29uBivPUm8c4vgZpNRM2g98H9k=;
        b=cq/wiUdw8mPI/HuEnTzF7M5NC2nl+NDRyMyC3aWK5jLddYoob3hVGnFDHAdfC30RaD
         yPq0vLr0KyJEirKs+7gfGMd2Fhwq3PvC+MVDvVh/6SuveoD4izamItP/k4PNIi0QR6SZ
         A4Fb/o0rPsN1c/jlN6HR+az8QqLFw28EvBnalnq7/RLfjnS3wcbAH4PNmgKnQO8SXOBm
         moZOzDvGauxAQss/6PVT8iGvcZ8dwKxcb3h/UL+ISy/O/1Ysdo6bmmxXjWN9gGPte1yz
         zu51yUWTaqBg7DdxY/FC1lDnj6Y4uiIVDS2/LaTXbErwYRY2DQ6sYS0Vn86lG1iLNC+s
         OR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BTE84q/lPpOTe8Tqy29uBivPUm8c4vgZpNRM2g98H9k=;
        b=mF8Qs7avv7F5fzq1Brtd/+L4MVpWmiU1C+gOORgcfGNhUJQqbUXsVDWwaq6kesqvuj
         JXWK8ldJIH2as/Q4ZXXQMCrW7ysGh6WLOVDeVr0WSkZ5D0w5CKo3zHYyGHALrP1XEI76
         /6QrcKb1blz//5oK8ia30ecK5Sbhf5rJzocJks9w+FiXNdbr1Wn96ng4C6yd6mIJkwJw
         jOqPkz3kkdTtZvsYqonpCWhXIJcR3V/z2Iez7FmnoI8A7dG7tLu/B2dRnoaxpKjSFjwn
         /Gpi5YUUdzb5WgVPQknzqQi2cmMKByngMIKTqamEf5RqiooICHafA/YPU/GAbjmTCBfu
         Ws7g==
X-Gm-Message-State: APjAAAWdDXSvmmKy/Fw63CYK5+WZEVoBXSRQ5IMQmyYfkmG1t96A7pnr
        2PCMoXITmzwcdx9afzrwOMM=
X-Google-Smtp-Source: APXvYqyqWFX8g8NbR/i4sVitjLS35CLEEqLe4fohjzRs2U3ukC4WUPrI02jIqnp4cl+zFKSmH1bVWg==
X-Received: by 2002:a5d:4302:: with SMTP id h2mr19708932wrq.35.1571648526494;
        Mon, 21 Oct 2019 02:02:06 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x2sm13624867wrn.81.2019.10.21.02.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:02:05 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:02:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 09/16] x86/alternative: Remove text_poke_loc::len
Message-ID: <20191021090203.GA88859@gmail.com>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.457534206@infradead.org>
 <20191021085830.GA102207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021085830.GA102207@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> >  	 * Second step: update all but the first byte of the patched range.
> >  	 */
> >  	for (do_sync = 0, i = 0; i < nr_entries; i++) {
> > -		if (tp[i].len - sizeof(int3) > 0) {
> > +		int len = text_opcode_size(tp[i].opcode);
> > +
> > +		if (len - sizeof(int3) > 0) {
> >  			text_poke((char *)tp[i].addr + sizeof(int3),
> >  				  (const char *)tp[i].text + sizeof(int3),
> > -				  tp[i].len - sizeof(int3));
> > +				  len - sizeof(int3));
> >  			do_sync++;
> >  		}
> 
> Readability side note: 'sizeof(int3)' is a really weird way to write '1' 
> and I had to double check it's not measuring the size of some larger 
> entity.
> 
> I think it might make sense to just break out INT3_SIZE from 
> arch/x86/kernel/kprobes/opt.c into a header, rename it to INS_INT3_SIZE 
> and define it to 1, because the opt.c use is pretty obfuscated as well:
> 
>   #define INT3_SIZE sizeof(kprobe_opcode_t)
> 
> Where kprobe_opcode_t is u8 on x86 (and won't ever be anything else).
> 
> ?

Oh, the latter is done in your patch #11 already. Nice!

Thanks,

	Ingo
