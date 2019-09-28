Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E50C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 12:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEA42081B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 12:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569674495;
	bh=fWEqOP5WLaXuDsvzMGUQKGCnDbdIhYYZvgnqJk6MnZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kZzHOkbty2Dlha4TQQUP214p9xir0axK+/POCy6+rla1E03woR+Epw/tMhFQdDl3x
	 skb4SvyoB9mEF3UDybEJWZH5qcYQDHsuyxgHopLUuRBeTchdGumqqQfjwkVVZx34mW
	 m2sLIadN2sUpzfV9tiOXasrsYQZq25yNTMkPSQuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfI1Mle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 08:41:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52211 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfI1Mld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 08:41:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so8605300wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8hTXgUu85gufNsCTT7x1AC0Il1AhP4KkOpsI4+mqbUQ=;
        b=fb8OA3gCcDSUzKmp9DapL1fMi0LXtzEqgDCMUG+IRHD+2arbDIh0vGevAwLaG00DP6
         2u0phnXmEcy9J5VcJ0RwMROMkQOCujLk04LEsEX/4yF5sGuIHhUVkVCxsUPQBA32+2DH
         qPd+rzEoJ0TeRVD//G8N25CRbnhhbBvATtiB5DoVW4pSl3PtCSSL3JZwsKCJTczc2OmM
         Xw1RApMKUhfamxY1++vzRfh+xtH9BtlnARsWbSnUjnynv1lhUcE01P6+CZtd8QtzRmi2
         TMj4KaHQoNNmGld3gynsEys8IzFVd7bfTCTcPVaJBgMQ4WJ4X4TYI8emf5P+KiEei2X5
         fQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8hTXgUu85gufNsCTT7x1AC0Il1AhP4KkOpsI4+mqbUQ=;
        b=pw+c+VdtceYmO6blupuOQ5o4148d0+pBW6i1LqZevPubN1Z4VhuDn9YTr6XN5q5UgW
         qZJ6kNFjwDtPNAhv8X9K11WOoZeLQ2Qovcw5/FYPnTORdsVDxF2IcLDLr8WLS2kgSK5/
         OJ1ed3mJ+IpOagzmIcdcflRJRox6XD2r0RTwcWAZwd5ybgW4jUVxebfs+AaZ3ZnRU1BA
         y6EPsCdWNLgT75BjXC0+1tdRyvaIvCfaUglKgKzR71YeWKTSsedaL6gcanXecWNJE5ZH
         iZv5hTdu9R3INxr8oqppYROZh/GyzUdOsqFxcRc19F9mpLrOLhJMv/tjm0bevUV8kF0h
         yyUQ==
X-Gm-Message-State: APjAAAUtu/voz7SED7fZnmWnpU8N/jVb1zUKa73Qd5pF5b5u1/Gxbenl
        BgHORt8Z4AXyXAvipn8iBSoqirDm
X-Google-Smtp-Source: APXvYqw4gS4RMHdpvCnKZ24YhZWIhJVufMKDFeaTa3+uDJvJPMf/6yTH+yX5y+YyZlQYxHsXTjsD5Q==
X-Received: by 2002:a1c:9dc1:: with SMTP id g184mr10376431wme.77.1569674492093;
        Sat, 28 Sep 2019 05:41:32 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p85sm17740577wme.23.2019.09.28.05.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 05:41:31 -0700 (PDT)
Date:   Sat, 28 Sep 2019 14:41:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andreas Smas <andreas@lonelycoder.com>,
        linux-kernel@vger.kernel.org, X86 ML <x86@kernel.org>
Subject: Re: x86/purgatory: undefined symbol __stack_chk_fail
Message-ID: <20190928124129.GA97534@gmail.com>
References: <CAObFT-SqdcM2Xo7P3FqgwTABao5uoWrb+A3bXy9vKt5rBffSwA@mail.gmail.com>
 <6c46ae4d-6837-d1a3-dbe0-03a9efcb862f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c46ae4d-6837-d1a3-dbe0-03a9efcb862f@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy Dunlap <rdunlap@infradead.org> wrote:

> On 9/3/19 8:50 AM, Andreas Smas wrote:
> > Hi,
> > 
> > For me, kernels built including this commit
> > b059f801a937 (x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS)
> > 
> > results in kexec() failing to load the kernel:
> > 
> > kexec: Undefined symbol: __stack_chk_fail
> > kexec-bzImage64: Loading purgatory failed
> > 
> > Can be seen:
> > 
> > $ readelf -a arch/x86/purgatory/purgatory.ro | grep UND
> >      0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
> >     51: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __stack_chk_fail
> > 
> > Using: gcc version 7.4.0 (Ubuntu 7.4.0-1ubuntu1~18.04.1)
> > 
> > Adding -ffreestanding or -fno-stack-protector to ccflags-y in
> > arch/x86/purgatory/Makefile
> > fixes the problem. Not sure which would be preferred.
> > 
> 
> Hi,
> Do you have a kernel .config file that causes this?
> I can't seem to reproduce it.

Does it go away with this fix in x86/urgent:

  ca14c996afe7: ("x86/purgatory: Disable the stackleak GCC plugin for the purgatory")

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent

?

Thanks,

	Ingo
