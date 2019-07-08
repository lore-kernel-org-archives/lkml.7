Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BF2C606C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481BE20693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJxVXCxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388220AbfGHRGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:06:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40252 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730562AbfGHRGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:06:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so8600684pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4XiK7cNOF46bWFR8m4DNHaIOk38+dsjAxLZcmKLCeZQ=;
        b=OJxVXCxfMK+mwCEENRbSUCDzOGN83p9YGujVxQsC48TwIJ6IuNUW7JkBszAJ8njCFM
         vdsQ0qQ8nOUAUnn7wQqqVEOCcE0nlYFqGh4mHkhKPJqK+NiKvxG8PQgmdDZVsa+WcOdM
         qIKfxugHejd4pBwzINR1yecpk6ve7vuc3rZvZe6RoTKmsn47IPsIY9H3QeK5dKunK23J
         /yVfO+W2saMiJGb2qTuAuE2vpr9Rc2nZiiUwsKeNvNfm4JjZpZ28R+eq1nA5SiGBL8Iv
         DXZjEcGH/kq4dPzpQSnvxLoTJUYR3THxtg9DqKEg82UU6Uj46pKlxsq0MGuc3cLECotz
         Erlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=4XiK7cNOF46bWFR8m4DNHaIOk38+dsjAxLZcmKLCeZQ=;
        b=ufkVPlc9hywWzi27eEEIVuymZ4EaCWbOVlfBBfkmVwblvDvniEqUyeJvytCv2zgfEB
         oY2RnppkWucK+9Y0710ZMpAbpdK6ovvzrkHRoupx98LihotgMtUKgdcJMwQ1HOLfqHfP
         fh0qApgG0nveoTX+UvTWoZN+0EAWqfZqe/PFClKuSAm69kkuMeI3BYJQTq1VfwrWAlc1
         B6/YK1a79IyiyvjmaAbsn+y6OEzmFcvkeSyfoNKZWEzkofnvnhdnyjLXwh3WrPMsBqwA
         a2TyeCs8QJqCRtGL9MRGI/XysH8HuIRmxL/rVJj9YoTOcIO42K0ocjY6ahekOj0V1haK
         JDhQ==
X-Gm-Message-State: APjAAAXyh1XvQmOUNl+q1W5yjZdfTL8hp7Xz+QMvVeWAG5EEBphDFjt/
        U0pQUt6q7JXS7pDJi7OlB5M=
X-Google-Smtp-Source: APXvYqz1ckv+LdozavwqdnPaMMRC1ba1JzLoqD2K3M8QzZeR28vMiS+/Pi6qU0wTvuO5I+IY7KfXJg==
X-Received: by 2002:a17:902:20ec:: with SMTP id v41mr24871190plg.142.1562605609923;
        Mon, 08 Jul 2019 10:06:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p187sm11889437pfg.89.2019.07.08.10.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 10:06:48 -0700 (PDT)
Date:   Mon, 8 Jul 2019 10:06:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-m68k@lists.linux-m68k.org
Subject: m68k build failures in -next: undefined reference to
 `arch_dma_prep_coherent'
Message-ID: <20190708170647.GA12313@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see the following build error in -next:

kernel/dma/direct.o: In function `dma_direct_alloc_pages':
direct.c:(.text+0x4d8): undefined reference to `arch_dma_prep_coherent'

Example: m68k:allnoconfig.

Bisect log is ambiguous and points to the merge of m68k/for-next into
-next. Yet, I think the problem is with commit 69878ef47562 ("m68k:
Implement arch_dma_prep_coherent()") which is supposed to introduce
the function. The problem is likely that arch_dma_prep_coherent()
is only declared if CONFIG_MMU is enabled, but it is called from code
outside CONFIG_MMU.

Guenter

---
# bad: [d58b5ab90ee7528126fd5833df7fc5bda8331ce8] Add linux-next specific files for 20190708
# good: [6fbc7275c7a9ba97877050335f290341a1fd8dbf] Linux 5.2-rc7
git bisect start 'HEAD' 'v5.2-rc7'
# bad: [ba30fb6d5d6464bd7d3759408ea7f178d8c9fe87] Merge remote-tracking branch 'crypto/master'
git bisect bad ba30fb6d5d6464bd7d3759408ea7f178d8c9fe87
# bad: [4226c2bec4757a3acbf86bb836375d3966ab72ce] Merge remote-tracking branch 'i2c/i2c/for-next'
git bisect bad 4226c2bec4757a3acbf86bb836375d3966ab72ce
# good: [e41aad4a290783ec7d3730542cbed0e99b2dcb4a] Merge remote-tracking branch 'tegra/for-next'
git bisect good e41aad4a290783ec7d3730542cbed0e99b2dcb4a
# bad: [e495984468b15cb8fa276b63fff3986111a513a5] Merge remote-tracking branch 'ceph/master'
git bisect bad e495984468b15cb8fa276b63fff3986111a513a5
# bad: [8e8fefda572360f00854547f3458a9c2cf932ff5] Merge remote-tracking branch 'powerpc/next'
git bisect bad 8e8fefda572360f00854547f3458a9c2cf932ff5
# bad: [01fd0e565283d69adf0ff1da95cab5bb4cb58acb] Merge remote-tracking branch 'm68k/for-next'
git bisect bad 01fd0e565283d69adf0ff1da95cab5bb4cb58acb
# good: [7dcbe273f9c61b83e398a19152f6529d1676751d] Merge branch 'clk-allwinner' into clk-next
git bisect good 7dcbe273f9c61b83e398a19152f6529d1676751d
# good: [59f375866fa68888fedc7bcd2dad381ceb6ba4dc] Merge branch 'clk-sprd' into clk-next
git bisect good 59f375866fa68888fedc7bcd2dad381ceb6ba4dc
# good: [49193327486022abc85b24d058aefa666367ffff] Merge branch 'clk-lochnagar' into clk-next
git bisect good 49193327486022abc85b24d058aefa666367ffff
# good: [7b4e6f9a4b8daa37a86cd7bca46bf70b522dbb62] csky: Add new asid lib code from arm
git bisect good 7b4e6f9a4b8daa37a86cd7bca46bf70b522dbb62
# good: [c6d41a2a548b8b684a006ab77d42c73815105011] Merge remote-tracking branch 'csky/linux-next'
git bisect good c6d41a2a548b8b684a006ab77d42c73815105011
# good: [69878ef47562f32e02d0b7975c990e1c0339320d] m68k: Implement arch_dma_prep_coherent()
git bisect good 69878ef47562f32e02d0b7975c990e1c0339320d
# good: [ccd1eda4ac7a73806ccc6afa899bb58e00c7772f] Merge remote-tracking branch 'h8300/h8300-next'
git bisect good ccd1eda4ac7a73806ccc6afa899bb58e00c7772f
# first bad commit: [01fd0e565283d69adf0ff1da95cab5bb4cb58acb] Merge remote-tracking branch 'm68k/for-next'
