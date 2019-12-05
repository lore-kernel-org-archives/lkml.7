Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78622C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9152464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IOhWBLdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfLERBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:01:06 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43267 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLERBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:01:05 -0500
Received: by mail-io1-f67.google.com with SMTP id s2so4320614iog.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=YZZKoeme5xqeP330LDusDo42nmGku+QMxsQ4s+f0hSs=;
        b=IOhWBLdAxgPlmd0qEiroKhiD0mE4Z+Yjpl8sgB1Eatqqvm7NYrd825cwcPb0Bb41uf
         erz+nBeYO+uwWCfiwrjbzRSOTuXPD69HXV+4W2RvBZdp3v31q6Yi+LN+WHNm/udVcFms
         ullbp65eYtHDn37/VK6qc+sSh/KI9nRt6ZG+UYvvx5EtdVcRPZc/N1gospp+KhVz566P
         SuK0PKafbiPW9ExPB+XIeq6Yb+VvL6g9XHB2xfEwVu9QfvWtUHhnSzGFu9KMD15qMGb5
         FMXvRJPaDp5cUCJrUcybHWbOVVHa8JcAgQ3+fgmJSJ57gZv2TndldQrbRr/GkDDjrElm
         oQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=YZZKoeme5xqeP330LDusDo42nmGku+QMxsQ4s+f0hSs=;
        b=GvoXn9rrF16xCK/qd3vd/CAAIFvxbYw6jHDnlXK8nmR8xUeHc591VZa3D6SCr03dnU
         3D0zdVkwwSFXKqS4st2eNje7cxPMfuh2bKiWcuBsQKlGlT12ttLU3ZtBWAZxjrBSdBFv
         gDry++lVcm+QpOX0EZXhbqyTxxmxRdMssyneSDccd6Wtx7bKe/nGVfsRaPogHf2h3OCC
         J80Up10o7tbKh+B4rwQMORur+VNVFNCKCc2L//8lyq5yD9kIVrv87nglhhkfbK+NvkvQ
         Lct+iS2ezpRiF+gr0Mqy1MS7P+EptZVQzchIk3TnbNOMJEstI01HMCZy4nJk1vVapY6u
         lQqQ==
X-Gm-Message-State: APjAAAVbo5/ao6x0EJVJ/OOpWgJhuDwwA2I02dbKCGUrq/Qloq5TrI93
        K5y2eJK1FvKttOJfG8ljE1zyu/NdyE8=
X-Google-Smtp-Source: APXvYqw/zZ+sNL+hS35Q+rSxXrpQS4vtMuwXq+OuY5kqldv6dcTOsmCgm+R7PYBh8CgLOoWtrPH67A==
X-Received: by 2002:a02:9f09:: with SMTP id z9mr8952499jal.119.1575565264904;
        Thu, 05 Dec 2019 09:01:04 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id k19sm2400909ion.81.2019.12.05.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 09:01:04 -0800 (PST)
Date:   Thu, 5 Dec 2019 09:01:02 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <anup@brainfault.org>
cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Add debug defconfigs
In-Reply-To: <CAAhSdy1RQw3MVcVT5y1EHr72LDNADKRL5nO2E8OrzBi+tpuvtA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1912050900030.218941@viisi.sifive.com>
References: <20191205005601.1559-1-anup.patel@wdc.com> <alpine.DEB.2.21.9999.1912041859070.215427@viisi.sifive.com> <CAAhSdy1RQw3MVcVT5y1EHr72LDNADKRL5nO2E8OrzBi+tpuvtA@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2019, Anup Patel wrote:

> I understand that you need DEBUG options for SiFive internal
> use 

[ ... ]

> This is the right time to introduce debug defconfigs so that you can
> use it for your SiFive internal use

[ ... ]

> and you can find an alternative way to enable DEBUG options for SiFive 
> internal use.

What leads you to conclude that this was done for SiFive internal use?


- Paul
