Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE4FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A172067C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IYatTteW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfLQPEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:04:39 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44408 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfLQPEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:04:39 -0500
Received: by mail-qk1-f194.google.com with SMTP id w127so8469273qkb.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 07:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=KWvMnp6WnFUpycSP8rv3DWkxz/r0qpxVC39yfCQNPZc=;
        b=IYatTteW5y6ti8LEqO+/zdTUGmCv1KDv68bKa61tkxNA/krQNPJ1DcjdPIRpuOQLC3
         CQOpF0MVR3hP3jJVnCgTINdUmiwkvge6ogGB8p+KpBWDIf6ejcEzpsE2U1eNGaPv9sIQ
         GF2AUiR4gIIR/kxu9qTp2EaJ2HYUJgsv9IZXk/PxhrE7pOPhIrGf/0JpEBXcEl3tBWk3
         BErm+rW/yMR4fReQaGo/GSsnxoxkPELI5fdYm2psftBMpuKG1M8MjB1sbfNP/s4N4Wkl
         J8uf4/kz+JjLvRoPmXI0VkUKEv9SwZscKFi+6nhMH/+7bEsK52Pwc6VQW+kOmZVgKMG0
         pEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=KWvMnp6WnFUpycSP8rv3DWkxz/r0qpxVC39yfCQNPZc=;
        b=PPXv869/yysSNZHsySsTzLafUPiyWk4qlmfjsVt2XoOpAR3NaCMN31MrGdBf0CPkYB
         S9nZyAT4YeRHMRnHbWbRBWiG5i4e9dMZnVdIqwylf3zIzJclsulylahL4x3NkPv6AHvi
         MRt3zIHM9s2EwNMsjVxS5xcXhYBzWimunypZNbimwq7BC+KYocebtFRluq9ppWE/DXxc
         CKG8s9CBtBopipYPH/l5oouQfTePQemCJ8Ix2KdjDL6TTl88hPfxeSbeaWHtN9WKKOEk
         QHEmpQHKAaRBpuxwus1K/hZx6Igi1ivCstZ0iwx3ak9mWN4hMy7dQz/FHPAnbt/7XQd2
         yw5w==
X-Gm-Message-State: APjAAAVBmrdlZk4IC9LovrUkMsJXdYkfJceCFngaMY2atkUSM7aKyk5O
        fmQzeVPeXdiE1mdO39kwXUuc/g==
X-Google-Smtp-Source: APXvYqwB3tefmBijBbhtpmgp6Z8XZFIqVXA5SBPXcJUiqBJ+dz6d2gWsnzuhtCFCOn9Z/7d4kKYFSg==
X-Received: by 2002:a37:96c2:: with SMTP id y185mr5834810qkd.202.1576595077972;
        Tue, 17 Dec 2019 07:04:37 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 13sm7050492qke.85.2019.12.17.07.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:04:37 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under CONFIG_MMU
Date:   Tue, 17 Dec 2019 10:04:36 -0500
Message-Id: <43881F9C-90D0-4DE0-BA1E-B74ACF8567BD@lca.pw>
References: <20191217144652.GA7272@dhcp22.suse.cz>
Cc:     Chris Down <chris@chrisdown.name>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191217144652.GA7272@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 17, 2019, at 9:46 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> yes, I would just ignore this warning. Btw. it seems that this is
> enabled by default for -Wall. Is this useful for kernel builds at
> all? Does it realistically help discovering real issues? If not then
> can we simply blacklist it?

-Wunused-function is useful in-general as it caught many dead code that some=
 commits left unintentionally with real-world configs.=
