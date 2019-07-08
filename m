Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23054C606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06FB21537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="muDIQhw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbfGHPAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:00:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38574 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfGHPAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:00:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so16244170ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 08:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iAKzsaR3iuxO4zA014yfkJZC/e1MvRqZX+rJd4aMTnw=;
        b=muDIQhw7g4Nb/xbCo0YGsfqXpi/XpbmNV3ec56+y12BJXT4IQbIk3S8BZwXzHoeHd3
         6UVuH8YSRVkVVc7MZtL5Ij9VsRssTsWmsMRkJ+5xb3RjUDPqkR7QCVFCr9bpCujHPR+K
         kyjqIajqPiyd5WKLq3ObtJCJFRG+Kvt9F3yjCYvAcefyvmN19A0u+H0ynf03DUqwJj7V
         mM7GKA44kx36BqTGV9GvsUq22RgD/1CeA2brjmr61Q5IGsNFSHqMPcXi5xK8lbXKm5uq
         mbMb/MSg6HD0PViRiAIInq1fEyOTWu7Qr9R7fjZ2jZwCa7uP9hnJ+Qucq6RQ6mKg5x7/
         yY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iAKzsaR3iuxO4zA014yfkJZC/e1MvRqZX+rJd4aMTnw=;
        b=gF9J+upOuHaNcwKIevd4OmqPGz2Y8VTIExMl6iEHeA1leb29XNywALOpe87ztiRy38
         pSc0nSQa0R/d+0G9bc2Q9P+upAWAtoqpwPlmNEChPNWb0fGZDMl0LVgWTX81PnBRTSmQ
         dXuBZBEq7IbsSD7FSPqRKo0aqva+A+H9Li7d5t0ucY8hHrYuYsxyl5Y5yVN+ZH8GVoFM
         bdlI2ZzXNw67TN//XueY2jgci3uuSgYtiBlkkmmtYvOtkEHP0u+qKR6QqwavFt1It6Mx
         srGit8BCWW32gnHQAYA3IbfNLOscH1+JS8niN31nEELWHoWXLtDvZOCnqHga+5IDZal4
         yyeA==
X-Gm-Message-State: APjAAAXsvWCxiop46d+bjJDRL8dHYOI4+kBi7q5d6sa6aeQn10Nrl+9u
        KBqMbTGanIzICm+Fug4HKspRWpBo1Fc=
X-Google-Smtp-Source: APXvYqzSLwvoFEdtCYexhEG3MKpeeQ6VThuwY5UzRN/WS0u19Q3eef7DzDKCicSdcVwAJ/nw/cmghA==
X-Received: by 2002:a2e:9758:: with SMTP id f24mr10879714ljj.58.1562598052994;
        Mon, 08 Jul 2019 08:00:52 -0700 (PDT)
Received: from localhost.localdomain (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id t63sm3693363lje.65.2019.07.08.08.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 08:00:52 -0700 (PDT)
Date:   Mon, 8 Jul 2019 16:11:36 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: kprobes sanity test fails on next-20190708
Message-ID: <20190708141136.GA3239@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

argh... resending, with plaintext... Sorry =/

I tried to build a next-201908 defconfig + CONFIG_KPROBES=y and
CONFIG_KPROBES_SANITY_TEST=y

I get the following Call trace, any ideas?
I've tried tags back to next-20190525 and they also failes... I haven't
found a commit that works yet.

[    0.098694] Kprobe smoke test: started
[    0.102001] audit: type=2000 audit(0.088:1): state=initialized
audit_enabled=0 res=1
[    0.104753] Internal error: aarch64 BRK: f2000004 [#1] PREEMPT SMP
[    0.106845] Modules linked in:
[    0.107897] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.2.0-next-20190708 #1
[    0.110403] Hardware name: linux,dummy-virt (DT)
[    0.112104] pstate: 60000005 (nZCv daif -PAN -UAO)
[    0.113852] pc : kprobe_target+0x0/0x18
[    0.115268] lr : init_test_probes+0x1ac/0x3a0
[    0.116890] sp : ffff00001000bd40
[    0.118122] x29: ffff00001000bd40 x28: 0000000000000000 
[    0.120049] x27: 0000000000000000 x26: ffff000011190518 
[    0.122029] x25: ffff00001117e7d8 x24: ffff000011261078 
[    0.123977] x23: 0000000000000000 x22: ffff00001169bb70 
[    0.125930] x21: ffff00001186c000 x20: ffff0000116796c8 
[    0.127886] x19: ffff00001186cf10 x18: 0000000000000010 
[    0.129836] x17: 0000000000000000 x16: ffff80007b078000 
[    0.131829] x15: ffffffffffffffff x14: ffff0000116796c8 
[    0.133759] x13: 0000000000000000 x12: 0000000000000000 
[    0.135736] x11: 0000000000000000 x10: 0000000000000990 
[    0.137693] x9 : ffff00001000ba10 x8 : ffff80007b0789f0 
[    0.139659] x7 : ffff80007dbe1dc0 x6 : ffff80007dbe1d40 
[    0.141615] x5 : 0000000000000237 x4 : 00000000000021f2 
[    0.143599] x3 : ffff00001169bfb8 x2 : 0000000000000000 
[    0.145582] x1 : ffff000010184e40 x0 : 0000000040a0d76d 
[    0.147556] Call trace:
[    0.148459]  kprobe_target+0x0/0x18
[    0.149754]  init_kprobes+0x120/0x134
[    0.151103]  do_one_initcall+0x74/0x1b0
[    0.152511]  kernel_init_freeable+0x194/0x22c
[    0.154133]  kernel_init+0x10/0x100
[    0.155411]  ret_from_fork+0x10/0x1c
[    0.156717] Code: a8c97bfd d65f03c0 d4210000 97fd5cdd (d4200080) 
[    0.158949] ---[ end trace 823556350f0e2d55 ]---
[    0.160681] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    0.163247] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---


Cheers,
Anders
