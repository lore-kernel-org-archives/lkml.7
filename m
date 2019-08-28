Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5F7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7AA2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfH1Pg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:36:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45231 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfH1Pg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:36:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id x19so467943eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 08:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oogvn6vF7Pf2rONF81W04w/IDYP5ozxhqqC9gM+xMtE=;
        b=pSVPqck1aIgXUiaZj4ssqTEnv1kgToIg1B/0BBrMlrA9fImJDxOmSpY5+1aLxHc5CS
         FAJpE9dxbT0ego8xzfuGw6hACBSsDwse5PHps4hNFJeNkx8UNh/rqZwubs/FpTvNuLum
         zQRSIIzcfI4o6Fc1OjIisQ2FUBwp9qDQqFp9Ly1y1OlOg1xYYho+VHgcANrkZCOiabi7
         4Oo10BEByXnCdJEUpKHuMraLT/PRl9/RFNxF522lYHOc+p9g4vV1C4T4Jrbw/17/Sp9q
         O1S5if/relNEoZoB2KCgfu74toJMVbr5a+vGg9xc4e4+v0sZLdPBJt2odmVjZQM37ndr
         K5ZA==
X-Gm-Message-State: APjAAAVHlgnSmmxdIAX4r3ZmSOKlFBcNzgsqS7nOrVbX4O9arYnb8we8
        jOl95id1Rq7MNeRa7wNaSKCbpBt5
X-Google-Smtp-Source: APXvYqwa94NA1+VFyiM6z1Tx0exM/S+TS2Dc2CSSOf5MA/bBRcQNH4yof8qP5EnZ1VIfh5hF9rogPA==
X-Received: by 2002:a17:906:f187:: with SMTP id gs7mr3774379ejb.130.1567006615047;
        Wed, 28 Aug 2019 08:36:55 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id b40sm525355edc.53.2019.08.28.08.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 08:36:54 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [PATCH v2] checkpatch: check for nested unlikely calls
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20190827165515.21668-1-efremov@linux.com>
 <20190828133256.13630-1-efremov@linux.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <9655ddea-a98d-073c-f130-e9345517f44f@linux.com>
Date:   Wed, 28 Aug 2019 18:36:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828133256.13630-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/19 4:32 PM, Denis Efremov wrote:
> IS_ERR, IS_ERR_OR_NULL, IS_ERR_VALUE already contain unlikely optimization
> internally. Thus, there is no point in calling these functions under
> likely/unlikely.

It looks like this rule could be extended with this list:
CHECK_DATA_CORRUPTION
GLOCK_BUG_ON
SPIN_BUG_ON
RWLOCK_BUG_ON
DCCP_BUG_ON
GEM_BUG_ON
BUG_ON
WARN
WARN_TAINT
WARN_ON_ONCE
WARN_ONCE
WARN_TAINT_ONCE
WARN_ON_SMP

However, grep shows that maybe only BUG_ON, WARN_ON, WARN, WARN_ON_ONCE worth checking:
git grep 'likely(\s*\(CHECK_DATA_CORRUPTION\|GLOCK_BUG_ON\|SPIN_BUG_ON\|RWLOCK_BUG_ON\|DCCP_BUG_ON\|GEM_BUG_ON\|BUG_ON\|WARN\|WARN_TAINT\|WARN_ON_ONCE\|WARN_ONCE\|WARN_TAINT_ONCE\|WARN_ON_SMP\)' .
drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c:       if (unlikely(WARN_ON(!mixer))) {
drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c:       if (unlikely(WARN_ON(ctl_cfg->count > MAX_CTL))) {
drivers/gpu/drm/msm/disp/mdp_format.c:  if (unlikely(WARN_ON(type >= CSC_MAX)))
drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c:     if (unlikely(WARN_ON_ONCE(tls_ctx->netdev != netdev)))
drivers/net/wimax/i2400m/tx.c:          if (unlikely(WARN_ON(pad_buf == NULL
drivers/xen/events/events_base.c:       if (unlikely(WARN(irq >= nr_irqs, "Invalid irq %d!\n", irq)))
fs/open.c:      if (unlikely(WARN_ON(!f->f_op))) {
fs/xfs/xfs_buf.c:       if (unlikely(WARN_ON(!bp->b_ops || !bp->b_ops->magic[idx])))
fs/xfs/xfs_buf.c:       if (unlikely(WARN_ON(!bp->b_ops || !bp->b_ops->magic16[idx])))

> +# nested likely/unlikely calls
		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*((?:IS_ERR(?:_OR_NULL|_VALUE)?)|(?:BUG_ON|WARN(?:_ON(?:_ONCE)?)?)))/) {
or maybe even to match all possible WARNs:
		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*((?:IS_ERR(?:_OR_NULL|_VALUE)?)|(?:BUG_ON|WARN)))/) {
> +			WARN("LIKELY_MISUSE",
> +			     "nested (un)?likely calls, unlikely already used in $1 internally\n" . $herecurr);
> +		}

Any suggestions for v3?


Thanks,
Denis

