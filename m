Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A6AC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE6C2071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="0OgC9EH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfKVQcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:32:16 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36916 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:32:15 -0500
Received: by mail-pj1-f68.google.com with SMTP id f3so3257250pjg.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 08:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ewg/yv2nDe6mNePO1hVyJcZEM93PzoLaB/4JIOpiCl0=;
        b=0OgC9EH1ZwAFvHpXL/6pLXTDHSn+8VY2B3rru4xCMEKyLrwwCBjt+0ju713/hBnlLO
         6JFCR6kXueKU0tFgif0fYrcIetYAMcjOM6Tc6zm5HAHOn+g+CKW8vVEQlj2GYBzgfPVz
         73mpwToER8ZPuyOA7xbBh4VkDVxmB4Ok5Kjp9cFHCNe/eHo1FbwepyY9lVBXRDn8quFi
         2dOicxRS8FKkNBKSGYdY6RwUyUfDffnmdQUy2vQPMX4vJEer5UfFs3Z2O14CtNAWie2Y
         lFukwJ4ya64FBzfdStOa8H6QQAOiW74HpbBxbpiS/ykVVZQyTmyWXU2xff3D7BkTGbIs
         /O3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ewg/yv2nDe6mNePO1hVyJcZEM93PzoLaB/4JIOpiCl0=;
        b=qJsIekkjzkiPvv3+u39bIeTXjG5bEOLkEWeZugQhBCxI4ex7q8+0/FKsTLcKuI6Epw
         2BTsTiNqhpu/c1lRL2vK7/RZqKbYTKlomjJNA5dFpW9VNRCA8/PW29hCNOGE0QH5c8Qd
         XSyGM5fyJC5IOFSmRUvgI8kjFPxAQOeWgwb3pUvb/CnvUHSP3arfTPvdZGHH+3iO0kPy
         HzirEMiSBSm89WF4AzurHUOhZzCK+06b7lIkzdgVhku9kIljuwvm5odEk6RCaocMwiGQ
         /aC5o17UqFoCAUkx7OiS+foDw6PsdWBk0kNBwquQn+zF4Hz9qkD696uBo50ebwBT+cvO
         zyBA==
X-Gm-Message-State: APjAAAV+GcNNofO/jq1At/d27awWZf5UhvNDlsYy+CYE+CncCK83N7jU
        bVvXlr/PO7GUjjEapoSCA25Quw==
X-Google-Smtp-Source: APXvYqxEIfyniojvma30s6ns/04gYIZpwUSTsRkTCxCzssAF0WQY2T5q6QYAavd9a93yje2qog0eew==
X-Received: by 2002:a17:902:968f:: with SMTP id n15mr14084646plp.12.1574440333138;
        Fri, 22 Nov 2019 08:32:13 -0800 (PST)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id m7sm369937pgh.72.2019.11.22.08.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 08:32:12 -0800 (PST)
Date:   Fri, 22 Nov 2019 08:32:11 -0800
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org,
        sergei.shtylyov@cogentembedded.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH v5 bpf-next 11/15] libbpf: don't use cxx to test_libpf
 target
Message-ID: <20191122163211.GB3145429@mini-arch.hsd1.ca.comcast.net>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
 <20191011002808.28206-12-ivan.khoronzhuk@linaro.org>
 <20191121214225.GA3145429@mini-arch.hsd1.ca.comcast.net>
 <CAEf4BzZWPwzC8ZBWcBOfQQmxBkDRjogxw2xHZ+dMWOrrMmU0sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZWPwzC8ZBWcBOfQQmxBkDRjogxw2xHZ+dMWOrrMmU0sg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21, Andrii Nakryiko wrote:
> On Thu, Nov 21, 2019 at 1:42 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > On 10/11, Ivan Khoronzhuk wrote:
> > > No need to use C++ for test_libbpf target when libbpf is on C and it
> > > can be tested with C, after this change the CXXFLAGS in makefiles can
> > > be avoided, at least in bpf samples, when sysroot is used, passing
> > > same C/LDFLAGS as for lib.
> > > Add "return 0" in test_libbpf to avoid warn, but also remove spaces at
> > > start of the lines to keep same style and avoid warns while apply.
> > Hey, just spotted this patch, not sure how it slipped through.
> > The c++ test was there to make sure libbpf can be included and
> > linked against c++ code (i.e. libbpf headers don't have some c++
> > keywords/etc).
> >
> > Any particular reason you were not happy with it? Can we revert it
> > back to c++ and fix your use-case instead? Alternatively, we can just
> > remove this test if we don't really care about c++.
> >
> 
> No one seemed to know why we have C++ pieces in pure C library and its
> Makefile, so we decide to "fix" this. :)
It's surprising, the commit 8c4905b995c6 clearly states the reason
for adding it. Looks like it deserved a real comment in the Makefile :-)

> But I do understand your concern. Would it be possible to instead do
> this as a proper selftests test? Do you mind taking a look at that?
Ack, will move this test_libbpf.c into selftests and convert back to
c++.
