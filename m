Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB47C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE752084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554896586;
	bh=6kJO4cNcx+emlPPuCJZ51VLFO/bLcA7lWBdrlY2iBhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YF0KcJbBHMzKCJ4FS3oS54kIb4VW02Q8wE1XEdu23oQUrb8WOWeOtlUelI0CpVAuO
	 z8xoneG3m7HuX9N684Bn2Pbyb8x3nbKXYhyH2zmSbaSLBu8vBRFj8D5Pn5xD3Uu84s
	 XgpOjqjHSF6iB4LDgjaa9qX/yvB/9JgWK5cDsWtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbfDJLnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:43:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56168 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbfDJLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:43:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so2238841wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 04:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OFWBpIhkLdgnUSFIvPL6Xxu9vfy08O2kcjOvs5KEvFI=;
        b=gCPSII2ka6w5GNubEC6YjGTIDvEjhR6jOYi7SiXdOjUPci8Cyrr807cD3wTciw7M42
         UwEXXNHKnn2cvhGo9ybc9+ZPmfTsQYj/vFwRXKX1Ir4V0VS2WWdHiAvHWb/XR8guKS8E
         PsAvErnL2V2dm05jDpA9k/LzyfImDbI83yJ6UGVSvC+sL9bEipc146v/UhXYgtmm8FgA
         a1W/cx2kvJPDDKHkWlHjqADy38Y5lfCir4zpJRQqQUvYm9zx5DbRaisKlIbm5Ut/0PS4
         MCOZ54cv4l1cZ0KsI0sC09pCO9Q91+O/CdHRUCUMv+33j6lj+wm7gNkl2Su5Ckkugrjw
         fmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OFWBpIhkLdgnUSFIvPL6Xxu9vfy08O2kcjOvs5KEvFI=;
        b=YkSiA43eY4zCWd/1f8r0LZJb0AvjdpzBCB8aHkKism0JYbja+VgfxgcLvY4Ag1ce+/
         eHaMoc9rPGDKbmp3qcHgpMKFDJXifFteQN2Q0FKKh1JdJ+7/9E5z7eKL3QjfJDEjI3ik
         BWl3cO+xsMof8vSm/PJhddb+oOqM26lhEMz4WrSfeVSJEhvrDNrefcrbSkGeIrERyWz3
         k344xMbiNz/5t1mKOmcq8K7til5tDeazI98HmBFgJULI+YFa/iyaDc/Avk3A9qcNvcv8
         x4bMNfWePF4qpn68WDjS68dxc3DfcICeUebUmL8EvbD4G84DDX3FtjIVhgumsYyUsVCd
         mMsA==
X-Gm-Message-State: APjAAAVTqxyEuljwinyelVyUESC0gPqcYA3DQS3Jp7dzv/ZC8eeNdE3v
        3fwM55XUe0sdtm5KcPypR64=
X-Google-Smtp-Source: APXvYqwWxl7rC3fNrHsx97HbHCvTPZT+jq/DblKcsGWm10fpH8QNfBf56BmMI3uiCMyHxtTdT1Jf6w==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr2615512wml.110.1554896582741;
        Wed, 10 Apr 2019 04:43:02 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z13sm54820935wrw.36.2019.04.10.04.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 04:43:02 -0700 (PDT)
Date:   Wed, 10 Apr 2019 13:42:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Elena Reshetova <elena.reshetova@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     luto@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net,
        jpoimboe@redhat.com, keescook@chromium.org, jannh@google.com,
        enrico.perla@intel.com, mingo@redhat.com, bp@alien8.de,
        tglx@linutronix.de, peterz@infradead.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/1] x86/entry/64: randomize kernel stack offset upon
 syscall
Message-ID: <20190410114259.GB9293@gmail.com>
References: <20190410112103.15170-1-elena.reshetova@intel.com>
 <20190410112103.15170-2-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410112103.15170-2-elena.reshetova@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Elena Reshetova <elena.reshetova@intel.com> wrote:

> 2)  Andy's tests, misc-tests: ./timing_test_64 10M sys_enosys
>     base:                                        10000000 loops in 1.62224s = 162.22 nsec / loop
>     random_offset (prandom_u32() every syscall): 10000000 loops in 1.64660s = 166.26 nsec / loop

Stupid question, how did you manage to buil timing_test_64? Here it fails 
with a bog standard gcc 7.3.0 x86-64 distro toolchain:

 dagon:~/luto-misc-tests.git> make timing_test_64
 g++ -m64 -o timing_test_64 -O2 -g -std=gnu++11 -pthread -Wall  timing_test.cc -lrt -ldl
 /usr/bin/ld: /tmp/cc8VRkuV.o: relocation R_X86_64_32S against `.text.startup' can not be used when making a PIE object; recompile with -fPIC
 /usr/bin/ld: final link failed: Nonrepresentable section on outputcollect2: error: ld returned 1 exit status
 Makefile:39: recipe for target 'timing_test_64' failed


I'm using cb7f9f0592f8, which is like 1.5 years old - is this still the 
latest and greatest:

  git://git.kernel.org/pub/scm/linux/kernel/git/luto/misc-tests.git

?

Thanks,

	Ingo
