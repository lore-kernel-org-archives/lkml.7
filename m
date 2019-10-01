Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7D7C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903FA20659
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UI4eNsI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbfJAQuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:50:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34775 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390015AbfJAQog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:44:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so22470504qta.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7GPDFQWuJXwzJuqgdtkv8cWj1/rryU2amRMgaS7klwk=;
        b=UI4eNsI01cw12FCH1szI/WpOWDa4aYdcfwkvjF0IataQqplLO5GIZr4lLpKiTNA1Ay
         30U8FhzxOnozK/bML5k8xB8Vk/Mvr4T7avhwBHv7jt3G0Id/wFihN8VFw3eyKc8pGSLF
         vhJd5VxytmfI8W3SVJ6Y70mWApfvtdP0qOYh7jZjeIuXbqyZ30E6+7D8kBMzAJGnJwMj
         JO2DFGWYAm8+CuNdxW50PvPeOpgJUYiXllV7SB789XKFpeK9CDGSwG6iG7kBSIKxpHeE
         2GhuyBg5Imcu8wBPi3w4si8hU8R9pLqCkPmY8iyZyieAMvzcmNRhTOiCeB3x7VYWf7L3
         MWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7GPDFQWuJXwzJuqgdtkv8cWj1/rryU2amRMgaS7klwk=;
        b=rGvFpwlI6d+jBK0sskeVG44YVMrl1r+TFjZToP/jMf0i+w1f7++WiV0VvTkoopELxc
         o/znvSxrGMha7zUYgxk5dKO2kr/6kqaNMwVCCVnesK9cCl0triRXlNf3JOfVh3V2Gdei
         YnntUA0G/x3mImeoQg7MamenDYQTy4uwgtP4i6G+zr0/+3wtAQFNohNXamFUsEntS+21
         JFr0t83I8hCR+GEEahj38ZBUD+7UGYgs/EqBW3P+7i0LSvRq60i4aeQFQhpmjXBiassn
         hDGP5FUO2oOJqH8ENX0uf5GE6wVkqGrATr7ZiZtbGM0mp1DLyofd0F0tR0RwwfelLlUm
         fvpQ==
X-Gm-Message-State: APjAAAW7UlhK6Ivw8jCG1i1GxP7S8Yk7DRODsw/pMLkFZhIQRJOYvm4u
        YVTzfhaEwXVsWeZzsJbOeDb4IA==
X-Google-Smtp-Source: APXvYqyObNCYAzFu3jyjhNDjKUVhXypcTsi/L5PiHM0qUrfbw71DITAFbh7MVl2LtTvReBCYDaJLHQ==
X-Received: by 2002:ac8:1207:: with SMTP id x7mr22977563qti.247.1569948275773;
        Tue, 01 Oct 2019 09:44:35 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a11sm7923492qkc.123.2019.10.01.09.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 09:44:35 -0700 (PDT)
Message-ID: <1569948272.5576.259.camel@lca.pw>
Subject: Re: [PATCH] mm/memcontrol.c: fix another unused function warning
From:   Qian Cai <cai@lca.pw>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Tue, 01 Oct 2019 12:44:32 -0400
In-Reply-To: <CAK8P3a04nMwy3VpdtD6x_tdPC14LPPbt3JKrGN48qRo_sDVk-Q@mail.gmail.com>
References: <20191001142227.1227176-1-arnd@arndb.de>
         <1569940805.5576.257.camel@lca.pw>
         <CAK8P3a04nMwy3VpdtD6x_tdPC14LPPbt3JKrGN48qRo_sDVk-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-01 at 18:00 +0200, Arnd Bergmann wrote:
> On Tue, Oct 1, 2019 at 4:40 PM Qian Cai <cai@lca.pw> wrote:
> > 
> > On Tue, 2019-10-01 at 16:22 +0200, Arnd Bergmann wrote:
> > > Removing the mem_cgroup_id_get() stub function introduced a new warning
> > > of the same kind when CONFIG_MMU is disabled:
> > 
> > Shouldn't CONFIG_MEMCG depends on CONFIG_MMU instead?
> 
> Maybe. Generally we allow building a lot of stuff without CONFIG_MMU that
> may not make sense, so I just followed the same idea here.

Those blindly mark __maybe_unused might just mask important warnings off in the
future, and they are ugly. Let's fix it properly.
