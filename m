Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740ACC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A762068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="gkyvth1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfK0MqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:46:12 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:43834 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfK0MqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:46:11 -0500
Received: by mail-qv1-f53.google.com with SMTP id cg2so8788171qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 04:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zh/vBERm/TbGM+yKl5SoCFkCcaIxa+50MOn7rbgBP8Q=;
        b=gkyvth1/Mbl64/TJUNIuUxJnbtlh5omWv1qlqK95S5J7cYBXdi05gUzZBljO3jOOcb
         HqEHMrZG/RmkV85nz7Yx4rZl1Jt53AtzzPaneyjPwSRKTJU2syvy170bWmvbWkzdQVWa
         DYiB77Gxhziqu90y/UTPGDggPTj7u5l6r1SZCSDOJSLMWldtA1LMX2yCGoFzxPvFGpGL
         Iu6kTOYu347m34fMmuuKuQ6KFlXEgX1LSHGIa72Ko70Ewh0IcOplDsh2WzzpLwL392gd
         oO7rEwZ6sun1jv2g5Qh1UzzGd+OFJydJmNRGMk+8O3HFB1dzUg2MRi34BWcKZiM1dNId
         YYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zh/vBERm/TbGM+yKl5SoCFkCcaIxa+50MOn7rbgBP8Q=;
        b=iqQr+ovSKAmNDb7/abFT8snLInoun1vjqCD4gsvQZQ4HoPCZA8YgnCry6WSvy7EsSu
         mYqCi3s1hkckMJGkPUVERat0xr6LFREfu8bm4kJtEaN1H///H68TIs/E73rhX61PAsze
         YApTDntWWL6tWuD3aVfem9/2Ouk1th8E5UrKNvij8e2y/Q4JQgl2YbqdekELvMsCEaol
         acAJ27XwYJtX0YND3VzitlYLCWmZNfHxrsgR9Q0l1E5VpnXIZHLzgYuoY/vGgWNJbxF0
         T6u4ZbUz8s5AHiWch5vy7zRDVcn/SFkD5mHrFqnjWTGclTp6LYp0lmuJ4KopOU5AjNpJ
         ZRPw==
X-Gm-Message-State: APjAAAXDtjbtpePTEV1qsgk3StJdkyNJWRGu77fSLXP2KV0Mw6eURKcO
        QikR0FJgUGxmmuIlCNEId8zCwKVzDxctXG6NlQv+1w==
X-Google-Smtp-Source: APXvYqzYfa89PkENwWgrr+lbnyQptNxwjQ2eMJwZTVJ9xXPkWzFPnmQzwgOahRvkhhc1AO6G3I1PdkrXLAcRysHEqrU=
X-Received: by 2002:a0c:9bd1:: with SMTP id g17mr4504471qvf.59.1574858770657;
 Wed, 27 Nov 2019 04:46:10 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtgEfa=bq5C8yZeF6P563Gw3Fbs+-h_oy1e4G_1G0jrgw@mail.gmail.com>
 <20191126155632.GF795@breakpoint.cc> <20191127001931.GA3717@debian>
In-Reply-To: <20191127001931.GA3717@debian>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Wed, 27 Nov 2019 18:15:34 +0530
Message-ID: <CAG=yYwnm4vRLRpjT2VOj5fynPhBfhvpVjfbSOvPrs-bwv09mTA@mail.gmail.com>
Subject: Re: selftests:netfilter: nft_nat.sh: internal00-0 Error Could not
 open file \"-\" No such file or directory
To:     Florian Westphal <fw@strlen.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>, horms@verge.net.au,
        yanhaishuang@cmss.chinamobile.com, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 5:49 AM Jeffrin Jose
<jeffrin@rajagiritech.edu.in> wrote:
> Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
i do


-- 
software engineer
rajagiri school of engineering and technology
