Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5264FC3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CA421883
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="AGKzs8O5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbfHZO5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:57:54 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39955 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731593AbfHZO5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:57:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id s145so14242966qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 07:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NPJGDOo6L0S+CxpwgDKYq0p9QenFZx3WP7pTe8S4sMs=;
        b=AGKzs8O5qznJgGIwpcBHKPCKaBpDnNPQopX6O6DHaXhR0KlirNeInM2VbTizrvmum3
         0f4vpmov8OQjbLJk1Uu16D/TOk9HdYztfjR2UNe9dwmng70wrygV1IvJyjMDJATGZ7yk
         PobQ8qvG35MNY31lVY5cwgH3G7bORvaNch/ljPBUTdENjG6RkvRB2RS2398T2uRSGen5
         ViR0M5vcYyWEOfqp9LX7QdJWMYS6i91HVP7ljpA9/AH4jOB2UJTgVO/bz9QxDRTSh9fV
         2R9wHdvrj+d6EskJaU21USriV0jICM3S69Lq+YySOHBCEcG9R76zVDNftBSWlXet/W2R
         qVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NPJGDOo6L0S+CxpwgDKYq0p9QenFZx3WP7pTe8S4sMs=;
        b=rX7F1MjAdx1wW3ZHqgI2WoHbSgRfkK1arvX/zNG+OW/Zp9KnJmeiqwIMvNY6Xe7NCA
         186xGuPlFx5DVkEL8iaH7FQecPCmFW6Odbew5VqWadfQQ6W2KG6g/JRc6mXwR0ixROFh
         PuRlNZoLWdbekXTniO3Do8khSl/GdHILsAs/of2XWRnnJT6uudmfQdoE7vBJO/nOhfSf
         4mvDonkHxP+pPlYc/B22CVebcBfMpGZ4lLiWx6/vhkK38AJJgIvnMWGlGrvLpx3AYf6f
         aiecT+W5rgUb5X2dhxHSqhxhLpOcNZV/bV0UVNCSG6EY0LKpfd2YJSgO6UNMjPvUeiFX
         PGzQ==
X-Gm-Message-State: APjAAAXOWmXUToZXNuZv4lF3rv4Q7DpxG6gQkotIeGDBD84riwkzG5fu
        +oLUUUHn4GbF+L+5xQxJXhmDqw==
X-Google-Smtp-Source: APXvYqylzZdUtT3tWQZ6cbQ0jUMry5R+13+YQvBswaR16gpPILhv7dep1DWgwRIXcXehIisp40eyBA==
X-Received: by 2002:a37:6e03:: with SMTP id j3mr16061933qkc.362.1566831472597;
        Mon, 26 Aug 2019 07:57:52 -0700 (PDT)
Received: from cisco ([2601:282:901:dd7b:3979:c36f:a14f:ef87])
        by smtp.gmail.com with ESMTPSA id m20sm7309611qtk.11.2019.08.26.07.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 07:57:51 -0700 (PDT)
Date:   Mon, 26 Aug 2019 08:57:56 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincentc@andestech.com>,
        Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, me@carlosedp.com
Subject: Re: [PATCH v2] riscv: add support for SECCOMP and SECCOMP_FILTER
Message-ID: <20190826145756.GB4664@cisco>
References: <20190822205533.4877-1-david.abdurachmanov@sifive.com>
 <alpine.DEB.2.21.9999.1908231717550.25649@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908231717550.25649@viisi.sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 23, 2019 at 05:30:53PM -0700, Paul Walmsley wrote:
> On Thu, 22 Aug 2019, David Abdurachmanov wrote:
> 
> > There is one failing kernel selftest: global.user_notification_signal
> 
> Also - could you follow up with the author of this failing test to see if 
> we can get some more clarity about what might be going wrong here?  It 
> appears that the failing test was added in commit 6a21cc50f0c7f ("seccomp: 
> add a return code to trap to userspace") by Tycho Andersen 
> <tycho@tycho.ws>.

Can you post an strace and a cat of /proc/$pid/stack for both tasks
where it gets stuck? I don't have any riscv hardware, and it "works
for me" on x86 and arm64 with 100 tries.

Thanks,

Tycho
