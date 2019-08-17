Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ABFC3A59D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 03:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0212133F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 03:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FUAskgYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfHQDKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 23:10:22 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41021 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHQDKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 23:10:21 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so10185040ioj.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 20:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=jfgOUdM4DedenoDs7mkNiP9MH22kvTM4l0nUgH2b6uE=;
        b=FUAskgYNph7NlMVKSpFjZv0uSx+nRz0FxF0/ARpCUnmzGymlpn+1s5IepB10Np1YvP
         v1JwwgKCEeWDn7G6fiXzH5QdUN8ix4ONScugUwQNwZfL2+1yMsSNmDXjxtNO/RAlla4F
         BQHVJ3cgAlYW12MA0j7gJ+/YJWYdjwnMaohaNGAbzcsNkt05YwjBzHrG2Ya9w/gKgAGE
         QToxk3ss8dTD6ACTGsq9BtBsQZvLrPMIDkuwPGBVp1o59vJ/1W8gzy085pSuN7Mtq743
         YQdbSLB/kr8aBcLFhJ0hoJm6ma+IGqZmvc7W3oj5efz34603zdWk++RSkw1xxj9WqonV
         /agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=jfgOUdM4DedenoDs7mkNiP9MH22kvTM4l0nUgH2b6uE=;
        b=otaEQgs6boMSN/cqBJatPKtaJbKQbj7VgZhXVMJGSlOjeggU+4TwTdfcR4WAhnGMdu
         MdJ5D7TxuJ0P0oQnyVBtKC0pC76TrihcHoZc4MTqst3M9nHg0z4wnHaE47v8MZiwwy+q
         KFLVBW1/ce7zpE5IW+/zJDqBoikizDqeBKiEz+Yqivh5u/f3pHcMB0kdtRaq7pIm7xjl
         hL8T9zV0r3yKyNM3/AyeKRRqBCRnSrbnpgyYN5qPyCTGj4+OCdMco04tUJDRYrWLAwHS
         mEQduAqWNkLlFfPtDCLT6oQmHqzLEwmrperJoQSbZmHoRnnD43oYhoyvZCh+hEidHSsa
         +TCQ==
X-Gm-Message-State: APjAAAVbeoynHb9jdT+pHQqj9hJD4gEQQcOe/wAKMauACfykoEP/3Pkl
        mvAhjwTPmFa7UuP+AxSnYnbxCg==
X-Google-Smtp-Source: APXvYqy0KvQpXvX3njzYxm7Z+Wa5tKbp+RV6UdAs8L/2cysMnnbuUcopIVRMyIOY/MPtLuJHgW3FFg==
X-Received: by 2002:a02:caa8:: with SMTP id e8mr14264856jap.67.1566011420500;
        Fri, 16 Aug 2019 20:10:20 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id n22sm6379414iob.37.2019.08.16.20.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 20:10:19 -0700 (PDT)
Date:   Fri, 16 Aug 2019 20:10:19 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Joel Fernandes <joel@joelfernandes.org>
cc:     kbuild test robot <lkp@intel.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, atishp04@gmail.com,
        rcu@vger.kernel.org, paulmck@linux.ibm.com, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rcu:from-joel.2019.08.16a 143/172] kernel/rcu/tree.c:2808:6:
 note: in expansion of macro 'xchg'
In-Reply-To: <20190817010902.GB89926@google.com>
Message-ID: <alpine.DEB.2.21.9999.1908161931110.32497@viisi.sifive.com>
References: <20190817010902.GB89926@google.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019, Joel Fernandes wrote:

> On Sat, Aug 17, 2019 at 05:10:59AM +0800, kbuild test robot wrote:
> > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git from-joel.2019.08.16a
> > head:   01b0e4d3e0ac279b295bc06a3591f0b810b9908f
> > commit: bda80ba9decc7a32413e88d2f070de180c4b76ab [143/172] rcu/tree: Add basic support for kfree_rcu() batching
> > config: riscv-defconfig (attached as .config)
> > compiler: riscv64-linux-gcc (GCC) 7.4.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout bda80ba9decc7a32413e88d2f070de180c4b76ab
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.4.0 make.cross ARCH=riscv 
> 
> This seems to be a riscv issue:
> 
> A call to '__compiletime_assert_2792' declared with attribute error:
> BUILD_BUG failed
> 
> Could riscv folks take a look at it? Why is using xchg() causing issues? The
> xchg() is being done on a bool.

sizeof(bool) = 1, and the only xchg() implementation that's currently 
present on all RISC-V in Linux is usable only on 32-bit types.  SPARC, 
Microblaze, C-SKY, and Hexagon all look like they have the same 
limitation.  You'll probably see similar build breakage for those 
platforms too.

MIPS, OpenRISC, Xtensa, and SuperH have compatibility functions for the 
8-bit and 16-bit cases.  We could add those for RISC-V.  However, they'll 
be slower than the 4- and 8-byte cases.  This is both because there's more 
code involved, and because there's an increased risk of false-sharing.

Can you use a u32 instead for xchg/cmpxchg operations like struct 
kfree_rcu_cpu.monitor_todo that are intended to be cross-platform?  Based 
on a cursory glance through the tree, it looks like there's only one 
cross-platform driver that uses 'true' or 'false' with the kernel 
xchg/cmpxchg, and it uses an int as the underlying data type.

I suppose one could typedef "xchg_bool" on a per-architecture basis, to be 
smallest type that makes sense to use in an xchg() or cmpxchg().  That 
might save some memory on architectures that have a fast 1-byte 
xchg()/cmpxchg().  But given the lack of users in the tree, I'm not sure 
it's worth the effort.


- Paul
