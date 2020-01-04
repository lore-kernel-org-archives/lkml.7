Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9C5C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F3224650
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Tbg87j3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgADA5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:57:24 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38110 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgADA5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:57:23 -0500
Received: by mail-io1-f68.google.com with SMTP id v3so43171390ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=b+wuHQ8PY87+3MWTpA3gpEZGOy/6vHnLCLuwEt2do7E=;
        b=Tbg87j3PPOxRwH8JxWZAOHbZ7f4QtLAtll1DFSLqMkgtkejmVljEyaZAvUYGhd+4g6
         zNJwD/wKPRtFOJIwq6Oy5+IdNFZE7zFUJ2QtI1zd28eXSHAMDryCVQz5J1bCTzZ9sGs0
         FqjJgTYnvuFhY9CfAadApuFM4em8tVji3+AdPj/2PygzSbhGkLtlv9IcAPacjhO/l4m4
         tmF1V94guhSb3MwEsU8ucXTsrzCWuKoXGykSExUKKf5XLKGJB3aDJL2H9Abfig6Mj003
         gvSBb3KisEINE5XZjcHD+2K2xqgIyX9buiTs7ljvpXPrsQxq4CR7GcX7C11bK7WK+40D
         FQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=b+wuHQ8PY87+3MWTpA3gpEZGOy/6vHnLCLuwEt2do7E=;
        b=ZlMs+r9wi03wuXuU7+qKf/buURiWZEZBM/7B9Zlk7REajCo8q7bqGsVZp8TyZQZ+VB
         xOqOFQ/S+0OA4FaDEKBGlWNkwbcXQE2NaRTxEJ8v1EggG4atg+NcqhwHNz7XBA6D5W5b
         gRNK2rfWwppcKgtuM6ec6DhCN/HMwYISiRbUYa0GPd4S541UZ1vT1tZ/Gycq+QhvFCTv
         Vr6P+tAM1w6tfl6fbQQASLWwyd5EE1W0vZaZDssJl4NdnX5oI6BZcHbRomkjbMomiAqE
         QCX5TpZOFtFS49MMy2x8OK2hj/ZhxVntFMGkAbk/9b1oOiOY/epWN9aNK+xUm9Q0siKG
         FNOg==
X-Gm-Message-State: APjAAAUSlvFzNfslx64ksk095XDBxumOSgMFlz6+qGQ1sQ8Q4VIMuMNi
        p+MEQB27HEB5qy6PbAJbaeMZSQ==
X-Google-Smtp-Source: APXvYqxoKvk5Vn7dmhmcyOPjvml/ezHr0AEAtcLVuPk5lZbITAeIHwlh1dJ9a+dwdwHhO3WBbhK4ig==
X-Received: by 2002:a02:778d:: with SMTP id g135mr73473365jac.115.1578099443247;
        Fri, 03 Jan 2020 16:57:23 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id f72sm21519402ilg.84.2020.01.03.16.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:57:22 -0800 (PST)
Date:   Fri, 3 Jan 2020 16:57:21 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     robh+dt@kernel.org, mark.rutland@arm.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, bmeng.cn@gmail.com, green.wan@sifive.com,
        allison@lohutok.net, alexios.zavras@intel.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de, bp@suse.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com
Subject: Re: [PATCH v2 1/2] riscv: dts: Add DT support for SiFive L2 cache
 controller
In-Reply-To: <1578024801-39039-2-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.2001031657090.283180@viisi.sifive.com>
References: <1578024801-39039-1-git-send-email-yash.shah@sifive.com> <1578024801-39039-2-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2020, Yash Shah wrote:

> Add the L2 cache controller DT node in SiFive FU540 soc-specific DT file
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks, queued for v5.5-rc.


- Paul
