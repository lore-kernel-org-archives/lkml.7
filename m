Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265EDC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 21:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73BC21019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 21:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oK61HNpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDFVlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 17:41:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36783 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfDFVls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 17:41:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so11965888wrd.3;
        Sat, 06 Apr 2019 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5VAm0idPYqZs50bnW+v5cMp+ag/ntGJhAKZNEBfxbMc=;
        b=oK61HNpF+gAaWbkrUyfNiZWnBz6bxzh+AMOPIm58PuW074nLVA5FfyZMRT0249bf6N
         7YXLDJXOfdVC6wgSWsNHf3qBWh8k+MfasBHMSmT+026yjEn5K68jeILWMk7gvQGovyga
         2sSxiwF7tsoBd6lR96KzY9ijWP1lqZ25leiS9k1AZ1pBIemxAReNyBOkWUOf78ePhVJK
         wkcPJjH0MBo5fGN0FH1aiX8ZW/FGvi/9CbPUDs6cyZJuSW/TibVb+41Q4k8GI7ri8SG+
         +n6qKSLZ3yKa7OmXEvsIXFnWHlF6LJrScQ36Fl2PhJTdTyUorsJ6kbl1MQxV+TeGIe11
         5SLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5VAm0idPYqZs50bnW+v5cMp+ag/ntGJhAKZNEBfxbMc=;
        b=Dlf/vzWetwb2Znv/rlp/j0/giqMEwjdjlGMtK0maPWEwCwlK/FNuXa7dYhagbhR056
         ulS4j6CoH2nTumoNVoUieORjWEWPBeOusBTeYeKjtBVsZyiznuN/JnMrRYQNW2eiQsZt
         WonxJWDO3qA5PXGtqbp+1ZRXlaoiv22ASJqiHTm1bF4biEe2KFFnzeEGb4ufBiPXoX7v
         3mzLFnnv33QPNRxxwoFZHKq6JDP33qIB5XklDqY+94b0ppB4IC4GWGmdvCsMXCB9asfS
         /78tRRYwLofBmdn3fniXb9LOo5bnQxEwjrkov5kTMOgOJ/IOpP75/u9mUHchwZbGvNIK
         O84w==
X-Gm-Message-State: APjAAAVXiN5YOBlR7E8T/6bcPI3EEPjVIgplOxxkOvUrfhu+M6oWEIzf
        hsvPCz3SLsNl+v4LNdv7fg==
X-Google-Smtp-Source: APXvYqyY+t0sfGzkDJ7jdL/yGl1Ee2alpjBf9BTUU9pflSluMmv3I+X47alCwwyCMnJ1+vOoU1qnaw==
X-Received: by 2002:a5d:69c7:: with SMTP id s7mr12917856wrw.71.1554586906612;
        Sat, 06 Apr 2019 14:41:46 -0700 (PDT)
Received: from avx2 ([46.53.242.217])
        by smtp.gmail.com with ESMTPSA id v16sm37807860wru.76.2019.04.06.14.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 14:41:45 -0700 (PDT)
Date:   Sun, 7 Apr 2019 00:41:43 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>, mingo@redhat.com,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, aubrey.li@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v13 1/3] /proc/pid/status: Add support for architecture
 specific output
Message-ID: <20190406214143.GA21551@avx2>
References: <20190224044400.34975-1-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1904052129371.1802@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904052129371.1802@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 09:32:35PM +0200, Thomas Gleixner wrote:
> > +/* Add support for architecture specific output in /proc/pid/status */
> > +extern void arch_proc_pid_status(struct seq_file *m, struct task_struct *task);
     ^^^^^^

Unnecessary extern.
