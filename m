Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A44DC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFE2208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FX032XFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfF0Tzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 15:55:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43925 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0Tzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:55:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id w17so3811497qto.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 12:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hfC5ksK/27L7g+gphc+1CirxCd90pDX9jOTKCz1pz8E=;
        b=FX032XFU1FEy5o1G1ny4HF81Jkl0PmBCXyXoTWiPPCO4Px86xkOmT20mjbjWJ7mAaB
         gdnJDtceV7a6Vwl5civebrg8rKxMhBMhJhDrkMbnlXJXXV88Uhfa6ufOnmxtlToTAo9d
         6l9NgiaUkt2ZGb2OYru+H2aWa3yhwO/rrxy5lg3OoU1ZJ0MxY2yq6elR6b/eBNawBske
         Z6RLumSPzTQTRP+i9nfmzfYS0fcHMJ1ep8qhJnY61y9hY178VNZEMEli8p0P4gCrOkDN
         odJALjYbg85GmHnuO0FTS7RG20N1ajNRUu/bW0Qoian5Sj49Q9Y1TG4InCLvqRFOVRhL
         Go4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hfC5ksK/27L7g+gphc+1CirxCd90pDX9jOTKCz1pz8E=;
        b=FbE+ANxZJ3YmEAFtvxQwPO/nKYcj6lia3hZ8mDwQOQ8aAiQIrFg3gTrZYccsMB1Er3
         Ju70jj0m/9iS24UYpJdHSmlmO2K7VFKwveRR95q2EKKjibCagw8WAx3XjejRdfI+GjBf
         znXz6LyKolXxW3yfmQEInm4vPrIoEsqPDtXB6qCiJFt41VDqs8BSuKe3BpgGf03o3R3q
         /ohLkRamnMAs1py429JTwJK/xyJj5JBJ8Hq58NV5+5Hch/Xt5hUTCvbbABXoOkD/Xpn3
         fjPSUcAPPHpJSpE5dTw91J+kbCEvFIsDCDPIZf33WHjerFOTl6yT04jyO4IgLckmMwR+
         vYBw==
X-Gm-Message-State: APjAAAXaQsaK91XI4L2BmDKpB+zuqc6vAEEhp/x1iNmpEs7KFYZNJ80J
        3tkBZAJ7mfH/72xC9+pbfiVMBw==
X-Google-Smtp-Source: APXvYqx62wNXdlmsPb5THkuZIKClAG6aQwB4J9Ba+Vjn/LH6v5Y9RCJZlJofdtZlE0wrf/W7HR8j2g==
X-Received: by 2002:a0c:9687:: with SMTP id a7mr4972347qvd.163.1561665341568;
        Thu, 27 Jun 2019 12:55:41 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k55sm47300qtf.68.2019.06.27.12.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 12:55:41 -0700 (PDT)
Message-ID: <1561665339.5154.92.camel@lca.pw>
Subject: Re: [PATCH] powerpc/eeh_cache: fix a W=1 kernel-doc warning
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 27 Jun 2019 15:55:39 -0400
In-Reply-To: <1559767579-7151-1-git-send-email-cai@lca.pw>
References: <1559767579-7151-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On Wed, 2019-06-05 at 16:46 -0400, Qian Cai wrote:
> The opening comment mark "/**" is reserved for kernel-doc comments, so
> it will generate a warning with "make W=1".
> 
> arch/powerpc/kernel/eeh_cache.c:37: warning: cannot understand function
> prototype: 'struct pci_io_addr_range
> 
> Since this is not a kernel-doc for the struct below, but rather an
> overview of this source eeh_cache.c, just use the free-form comments
> kernel-doc syntax instead.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/powerpc/kernel/eeh_cache.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
> index 320472373122..05ffd32b3416 100644
> --- a/arch/powerpc/kernel/eeh_cache.c
> +++ b/arch/powerpc/kernel/eeh_cache.c
> @@ -18,6 +18,8 @@
>  
>  
>  /**
> + * DOC: Overview
> + *
>   * The pci address cache subsystem.  This subsystem places
>   * PCI device address resources into a red-black tree, sorted
>   * according to the address range, so that given only an i/o
> @@ -34,6 +36,7 @@
>   * than any hash algo I could think of for this problem, even
>   * with the penalty of slow pointer chases for d-cache misses).
>   */
> +
>  struct pci_io_addr_range {
>  	struct rb_node rb_node;
>  	resource_size_t addr_lo;
