Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E5FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F2C2190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Zi5ZwJ9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfCUSRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:17:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40161 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUSRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:17:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id x12so7702325qts.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nq8thke8AAguuyUY8uu9Lf6Dq379TbWozTWnKwSQ0mI=;
        b=Zi5ZwJ9PlIvYa8DSIECnCbalBEUOgpuIjs0WSCG2SBnJE3ZhZkUFul6HDdWAPJOpm/
         piNYKFb/BK51xfBlq6w+3wwCe3eqEhGAPLmvFGltK1Ht4S5KdIAAixYx9+nSOYDvcd3I
         D0/DmsQB8QLDsVb+5TTjidvoroLdSDYNPAnrCx1lr9OIGPoqFzmcl6K0eVH6kXQPcmFW
         s1xCXBYk3n8A0Q27DgEkin8ZicHNgBWqWB5bU7lRwF7qCFB98N1fFnDWM6mB/yQFmjbC
         lr8JiyF6yc9sdanvfv0IorpMOnScmhIiiOwlQx9Z9LilQEymcGGTYGhk345mlqW1hRrE
         RNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nq8thke8AAguuyUY8uu9Lf6Dq379TbWozTWnKwSQ0mI=;
        b=TliwwqtOQ/usFUFmBhXLo6amkOJP/W/BP8C99k0sbabhw+TxWeIzNtnykepRy4vxDj
         kRsDwawf8jbu1/XA27V25thon9m6j/HmANUkj77b6yKmWBp9+vi4ELYG5Ib1+bjyESoo
         A0ILgIhAmF9ObwAZZNQbvdYlMGsYfiKIsISG2QKnjL22MIOCZG/rNBbLBgnJmdUMbFSH
         pYwx/5LTEj+Qre8D2HEXtXlWhbCZxRpOaZUb15yKR7xBgYVEOwJAE2nfHLgpt90qVxD2
         9lpaGmRp2T19o36bU1o6BIzIlruFoZ8Ekvdgir6p5XGDF6BPSYSf8vVGnN1ykTFMqtxT
         61xg==
X-Gm-Message-State: APjAAAWyQI9SWtWG/GgNWeGTInrGaiHbWJXjVhRAXcnxLmM6EZTXJyMs
        wYK2CmMC9xJLBflC6eZseiJ5Iw==
X-Google-Smtp-Source: APXvYqzH4lZLJtvN18IQVcBYAAWDGWi+UZTAC3zqVsSviENEchLNO0/tfVB35Kl8u2oUO+FPu+1H4A==
X-Received: by 2002:ac8:3113:: with SMTP id g19mr4420688qtb.356.1553192268668;
        Thu, 21 Mar 2019 11:17:48 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y17sm3021889qtf.72.2019.03.21.11.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 11:17:48 -0700 (PDT)
Message-ID: <1553192266.26196.16.camel@lca.pw>
Subject: Re: [PATCH] kmemleak: powerpc: skip scanning holes in the .bss
 section
From:   Qian Cai <cai@lca.pw>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Date:   Thu, 21 Mar 2019 14:17:46 -0400
In-Reply-To: <20190321171917.62049-1-catalin.marinas@arm.com>
References: <20190321171917.62049-1-catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-21 at 17:19 +0000, Catalin Marinas wrote:
> The commit 2d4f567103ff ("KVM: PPC: Introduce kvm_tmp framework") adds
> kvm_tmp[] into the .bss section and then free the rest of unused spaces
> back to the page allocator.
> 
> kernel_init
>   kvm_guest_init
>     kvm_free_tmp
>       free_reserved_area
>         free_unref_page
>           free_unref_page_prepare
> 
> With DEBUG_PAGEALLOC=y, it will unmap those pages from kernel. As the
> result, kmemleak scan will trigger a panic when it scans the .bss
> section with unmapped pages.
> 
> This patch creates dedicated kmemleak objects for the .data, .bss and
> potentially .data..ro_after_init sections to allow partial freeing via
> the kmemleak_free_part() in the powerpc kvm_free_tmp() function.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Tested-by: Qian Cai <cai@lca.pw>
