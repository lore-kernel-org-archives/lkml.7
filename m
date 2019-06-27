Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBB0C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F54208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fek+7sFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfF0TyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 15:54:11 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42456 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0TyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:54:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id b18so2831178qkc.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=553rdQLJIBk30wNrf7KA331BGV1DmLK681B/LC9Sp6Y=;
        b=fek+7sFaz2NmgnMkjBf4hCVq2Os9rpMZyltUfaBER/PufqJ+vhmMRXpkbh5onlck3D
         OnSKQWKXouC6SGBgqGEcTQ90YxO4kSKK/itxFIaHBngafq5QLJ27kklLi6qN0KjN5wAj
         Xg8h4CM/PAL4s14HpEO7NXEP6NgrDRWYkADRT5Oqi+0kRwuidP/yhUzt9BqxCt7/fjTN
         NWOe/kKZXZx/CXO1fC1GUuL5vkAwuRHvZ4sDMnfWi6PAzRumsXoLx/nDmS4HD+nXk1aY
         CTiiL5IkQubsP26Nxn7vpnQU5Ztj43JlwNTQKuoklbaTF0TaS0l7hpZU7wPF1FUzlVas
         dwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=553rdQLJIBk30wNrf7KA331BGV1DmLK681B/LC9Sp6Y=;
        b=qefXKKOFXh308xZKJJRc1SXxac/ooZPU51hU25c7p3vfj0sTm7wEG8fZ2R47fsEH2m
         IpkMuYI96AI1KoFIodM6pXxhMOr638dGniloTaoyEVcPIFu2n7My0fjOu4G5kf1wEpT+
         HA66p605V1zbSSMNkyGMB+tGV3dllpKcxNEo4qYJLBTvrh65YUlyh+eS9mjTk69q6D9n
         qK68v1oPAtj1m7uk6xxCvavArY5HAJRnIsehVuVpmNgzlGNh27Bi123xj2ZRTkPfx0fu
         IQvaguZ8vfNEbyVpGNAA7mFivLUgMdiLtugTPVpAKYrPnVTCPZ5nFJoYwEhZyy5K1v27
         pu7A==
X-Gm-Message-State: APjAAAW68LCgqcqyWeeShRbsViphE71H8Ouu/y7IxfUXHKvuIXwujlFZ
        i5Dh6IxPdC6iudqVpDZBD5G4Gg==
X-Google-Smtp-Source: APXvYqwDJWwHslnijHUtTNbSVL2Ww4PFg66QvqhhwOJeHsLKrqPq5pAF3F9PqOAv4dV5OJeXtHs13A==
X-Received: by 2002:a05:620a:1443:: with SMTP id i3mr5242536qkl.11.1561665250370;
        Thu, 27 Jun 2019 12:54:10 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s11sm53481qte.49.2019.06.27.12.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 12:54:09 -0700 (PDT)
Message-ID: <1561665248.5154.91.camel@lca.pw>
Subject: Re: [PATCH] powerpc/cacheflush: fix variable set but not used
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 27 Jun 2019 15:54:08 -0400
In-Reply-To: <1559829493-28457-1-git-send-email-cai@lca.pw>
References: <1559829493-28457-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On Thu, 2019-06-06 at 09:58 -0400, Qian Cai wrote:
> The powerpc's flush_cache_vmap() is defined as a macro and never use
> both of its arguments, so it will generate a compilation warning,
> 
> lib/ioremap.c: In function 'ioremap_page_range':
> lib/ioremap.c:203:16: warning: variable 'start' set but not used
> [-Wunused-but-set-variable]
> 
> Fix it by making it an inline function.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/powerpc/include/asm/cacheflush.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cacheflush.h
> b/arch/powerpc/include/asm/cacheflush.h
> index 74d60cfe8ce5..fd318f7c3eed 100644
> --- a/arch/powerpc/include/asm/cacheflush.h
> +++ b/arch/powerpc/include/asm/cacheflush.h
> @@ -29,9 +29,12 @@
>   * not expect this type of fault. flush_cache_vmap is not exactly the right
>   * place to put this, but it seems to work well enough.
>   */
> -#define flush_cache_vmap(start, end)		do { asm
> volatile("ptesync" ::: "memory"); } while (0)
> +static inline void flush_cache_vmap(unsigned long start, unsigned long end)
> +{
> +	asm volatile("ptesync" ::: "memory");
> +}
>  #else
> -#define flush_cache_vmap(start, end)		do { } while (0)
> +static inline void flush_cache_vmap(unsigned long start, unsigned long end) {
> }
>  #endif
>  
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
