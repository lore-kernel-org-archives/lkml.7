Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AB8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6BD20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="dCNqxHY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbfHFKpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:45:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34729 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730844AbfHFKpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:45:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id s49so47061469edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 03:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mLxh1xnnQMfeNrHf0aYqKYeviGu5yN55vYMo0/wqLZk=;
        b=dCNqxHY8plIDmYXpsy08QCX+iLvxPKZniVm+ncSZ3Buz54doFAW+0MiXkxSfa6aZ8N
         jTXJVTUqheLEyn7aW+R/fuDvBVdUs6Xh1fwu7j26vjbyzEwKEDlhCUidQu4KmRqzZOVa
         oDhQ+hqdK6ua5BH0xjQgzzSY2YytIfxpQZbUbhHRfBt+5myVtlvcOTS0tg2Us6YrayDX
         spYFcJQpsTWAHLAWlWQ4c+a7j4DzTav2yKnrSBmM6urDLun3EPrbW9LTSp94TCS/Nqy6
         yUFovGgvKMukOtEtX/dZWO89MRVjVrn4dfNeI+KJg31PeTSFYAKqz3WMNOK0C1qeIyJD
         lgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mLxh1xnnQMfeNrHf0aYqKYeviGu5yN55vYMo0/wqLZk=;
        b=S1YBeDMpmTFroQBHkfxBJ1GAN0Q6EWA2ogmL8PcgqY9uSsZoSxy9ft82a/00FFFQ1l
         E1XDgWY/clv0+c4OKrSobpmZsyNt0EA/yhPzf2yKzHSWjoP8Tn+Ii0xwm4zB7Zz57raM
         KfWcKSmvc9u6A0MIRylHogtK+tmzNw6crEuJHz3KCe7vNUSPeYeK34b4Xntyco3gqYYd
         iSmP1BqWJO9wK310P0q1S7LtiX1ANDQkRYLvmSOkcMMw8rPEZiR4gUm+rOVL0psoIepQ
         CjdRuXB0BGuo42GqtUzRALNfrefqXJjXN3M4T5muF+8rnoOqW5Xy1LUKXVEUm8W8sFyf
         LQbQ==
X-Gm-Message-State: APjAAAUk30jjPlF5Jz3jWG80Ht8Qr6cK+QcEYk5pkpgRvGpkbuFuW/4X
        2hKd/GSOMF5xk5/+C4IEuXdvKw==
X-Google-Smtp-Source: APXvYqz/KhBA+ZSNGOJbjZoeKD/ak+4bM/swWsBeb0rTxPioOaajmtlsxRIAU93xegZHr6XtYLs1kQ==
X-Received: by 2002:a17:906:340e:: with SMTP id c14mr2544571ejb.170.1565088317410;
        Tue, 06 Aug 2019 03:45:17 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e43sm20620511ede.62.2019.08.06.03.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 03:45:16 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3AED71003C7; Tue,  6 Aug 2019 13:45:16 +0300 (+03)
Date:   Tue, 6 Aug 2019 13:45:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: fix variable 'p4d' set but not used
Message-ID: <20190806104516.yvioe2t4w2vwvs64@box>
References: <1564774882-22926-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564774882-22926-1-git-send-email-cai@lca.pw>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 03:41:22PM -0400, Qian Cai wrote:
> GCC throws a warning on an arm64 system since the commit 9849a5697d3d
> ("arch, mm: convert all architectures to use 5level-fixup.h"),
> 
> mm/kasan/init.c: In function 'kasan_free_p4d':
> mm/kasan/init.c:344:9: warning: variable 'p4d' set but not used
> [-Wunused-but-set-variable]
>   p4d_t *p4d;
>          ^~~
> 
> because p4d_none() in "5level-fixup.h" is compiled away while it is a
> static inline function in "pgtable-nopud.h". However, if converted
> p4d_none() to a static inline there, powerpc would be unhappy as it
> reads those in assembler language in
> "arch/powerpc/include/asm/book3s/64/pgtable.h",
> 
> ./include/asm-generic/5level-fixup.h: Assembler messages:
> ./include/asm-generic/5level-fixup.h:20: Error: unrecognized opcode:
> `static'
> ./include/asm-generic/5level-fixup.h:21: Error: junk at end of line,
> first unrecognized character is `{'
> ./include/asm-generic/5level-fixup.h:22: Error: unrecognized opcode:
> `return'
> ./include/asm-generic/5level-fixup.h:23: Error: junk at end of line,
> first unrecognized character is `}'
> ./include/asm-generic/5level-fixup.h:25: Error: unrecognized opcode:
> `static'
> ./include/asm-generic/5level-fixup.h:26: Error: junk at end of line,
> first unrecognized character is `{'
> ./include/asm-generic/5level-fixup.h:27: Error: unrecognized opcode:
> `return'
> ./include/asm-generic/5level-fixup.h:28: Error: junk at end of line,
> first unrecognized character is `}'
> ./include/asm-generic/5level-fixup.h:30: Error: unrecognized opcode:
> `static'
> ./include/asm-generic/5level-fixup.h:31: Error: junk at end of line,
> first unrecognized character is `{'
> ./include/asm-generic/5level-fixup.h:32: Error: unrecognized opcode:
> `return'
> ./include/asm-generic/5level-fixup.h:33: Error: junk at end of line,
> first unrecognized character is `}'
> make[2]: *** [scripts/Makefile.build:375:
> arch/powerpc/kvm/book3s_hv_rmhandlers.o] Error 1
> 
> Fix it by reference the variable in the macro instead.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
