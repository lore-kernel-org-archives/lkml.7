Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69100C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8A32086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFxJYmQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbfITRRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 13:17:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41395 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbfITRRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 13:17:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so7505999wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MAXIjagVVmgonNnmQANm0Oi+OX97y6W0ucvlA2vaghE=;
        b=tFxJYmQ32y4DTEt97iHGR9++ICIqv3KW/CKI7LmiTwcQ6/qjTSP24c00bj46Fcy2Vl
         o7taoK7cUXj3SYkmslBbg9k5qQbHg+oxXiSHDam/RIPjl9WRDnnoDU+G66dzMoiUdF+E
         lwlRJUZSgzW0LkcuYLql46Q14kA+y1Xn9VvmVQWGB8PKnNhXbdlzb1u9SWaIukOn4b4F
         oZsj1XodjzZDUNXdvzYmEz27pYij6m3V+nAOBTRcAiWv1JpmkALfu9jHlG9QqHMdqfJ8
         axi5puafr2RmYwi2+mJdnvuScnB+i+eBuTXNCd/JvLFGQA200MmQBS8k0pra4+6vObEr
         EHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MAXIjagVVmgonNnmQANm0Oi+OX97y6W0ucvlA2vaghE=;
        b=OESbAttiMwwZjD42B2v7zNxI6Pa3s7IvT7GZ6O02ww+M9OR8k1tiq/4qsmqqYWDvMr
         NSyCiLW/avtopgvE4f6VW6JYiFf0dJk5hTsTS/mhcAsFobORyomURZMtd/9enDRASGNo
         kcW7LcnBSX0kqANWaEvxXHmOwDd9BKx80Ume41WbYoFdM9k0Jw2mA0p3J6RkIRAgaa+J
         SqAjXpG3NERF4dCmn72duqRn0r9w++YDiYHaaXUAV2YITobgSoddv3qnENkqNGs4SLWB
         TJawPkdKECZx/IWHLRaONTRPI/OhewrDRuZVhWrRrECZcuPqNhjB+q0QHP+LR8+6MIhU
         +isQ==
X-Gm-Message-State: APjAAAV8SCiIBvM72KHiiHMfgq5Ak9R3YBAd1+Nf+RlADshkdHECqMvf
        RSH7NjTpQb2sCa0ykjk5/Vo=
X-Google-Smtp-Source: APXvYqyTMc/SqdwOtLFlyZA4cvZxN7JuoJRP7q3xT8oWw3ACmPyLactbBCRMFaw57FTZc93VJHJiwA==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr7901983wrq.201.1568999831956;
        Fri, 20 Sep 2019 10:17:11 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id i73sm2621906wmg.33.2019.09.20.10.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 10:17:11 -0700 (PDT)
Date:   Fri, 20 Sep 2019 10:17:09 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        clang-built-linux@googlegroups.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pmac/smp: avoid unused-variable warnings
Message-ID: <20190920171709.GA58520@archlinux-threadripper>
References: <20190920153951.25762-1-ilie.halip@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920153951.25762-1-ilie.halip@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 06:39:51PM +0300, Ilie Halip wrote:
> When building with ppc64_defconfig, the compiler reports
> that these 2 variables are not used:
>     warning: unused variable 'core99_l2_cache' [-Wunused-variable]
>     warning: unused variable 'core99_l3_cache' [-Wunused-variable]
> 
> They are only used when CONFIG_PPC64 is not defined. Move
> them into a section which does the same macro check.
> 
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
