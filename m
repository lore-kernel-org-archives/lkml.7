Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1F9C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C6720656
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9lcEG+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKKInY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:43:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35969 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKKInY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:43:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so13639201wrx.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 00:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yijfmtJwvjVfjSh/iMpqao7i4KpAQCiVixkHXW9ffmA=;
        b=D9lcEG+UQ9cUtO25g1fWxz9Bnr/97aA3IPoeKSdb5rWz0xLMphURrMP1po553ga+Se
         1WiFnvBHaw7P0Rt8SA7c7bUWZLSDrJgzNL5aVQo8mqpqVt1pQ93K0v/aG224hf+qztMK
         h6bcnH9YKWm4ZYOjppwJTomcx5CwofQz+GqofrVdWPf6pk5a46OhasH8F4FORRWNvYm1
         wqYciednr9xdAy8TiLHBObC3Kky9O8ZJkjxGSU44XFrqgn8h/+guLWdJDXuuBolNb0Jt
         al9XIuSHpPnaMjgrAo615viz4q6uthbF6cpjMjN+eKZueUWdtgk9AnUIyTHJaru5BujZ
         DFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yijfmtJwvjVfjSh/iMpqao7i4KpAQCiVixkHXW9ffmA=;
        b=PuISRH3Nxm3d71daVqn4yV90HYI0aNXOVFxv/h/GBDmHfWskAL/c+4MPf8mqJIk/Gh
         MHk/1fJZwdH1zOOhvnx+3guX+ge42XPQ1mUX8ezBAKUw0v3R7NDXv6Mt3rnIvbqrDbtv
         G9UcSnnWiRXHJaqkGGjW2xGKC2uOrCdxUBzWWrXKSppBSMpZagXqYF2TGPyAqS0g1w6K
         o7T02hk+n0FQmuU9fYPo4ixdd5xuXqxLI7pYAp5yQIMXfdFk4EtwVNH8+LNMOxcayZh/
         siRj6u5b7jEDjsQM/hi4pgtHQtpK88Y/zFy9YayWaqHkwvtECfgVi/o6qP7LdRuY3bJy
         qsWQ==
X-Gm-Message-State: APjAAAV69LsfKJDjgCZ/OCuz2lMylE3tPGOTPWCvu9cHNSzM1tkF15XJ
        4ldBp5qz7awn7JERMY/SpDZlsg==
X-Google-Smtp-Source: APXvYqz/5sYO8j8IKMy2CtTBzfn9BeDThVlHrP/qTuKPoWIvo5MWoZnsC1e0J8BaOwggVY1/Kc8lHg==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr19073835wrn.393.1573461801604;
        Mon, 11 Nov 2019 00:43:21 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id 4sm16631352wmd.33.2019.11.11.00.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 00:43:21 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:43:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, acelan.kao@canonical.com,
        mcgrof@kernel.org, davem@davemloft.net
Subject: [GIT PULL] Immutable branch between MFD, Docs, Sparc and Lib Devres
 due for the v5.5 merge window
Message-ID: <20191111084313.GL18902@dell>
References: <20191016210629.1005086-1-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016210629.1005086-1-ztuowen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-doc-sparc-libdevres-v5.5

for you to fetch changes up to 7b8c4d73d7fe68f371d11b38a353134e1ffe199f:

  docs: driver-model: add devm_ioremap_uc (2019-11-11 08:40:27 +0000)

----------------------------------------------------------------
Immutable branch between MFD, Docs, Sparc and Lib Devres due for the v5.5 merge window

----------------------------------------------------------------
Tuowen Zhao (4):
      sparc64: implement ioremap_uc
      lib: devres: add a helper function for ioremap_uc
      mfd: intel-lpss: Use devm_ioremap_uc for MMIO
      docs: driver-model: add devm_ioremap_uc

 Documentation/driver-api/driver-model/devres.rst |  1 +
 arch/sparc/include/asm/io_64.h                   |  1 +
 drivers/mfd/intel-lpss.c                         |  2 +-
 include/linux/io.h                               |  2 ++
 lib/devres.c                                     | 19 +++++++++++++++++++
 5 files changed, 24 insertions(+), 1 deletion(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
