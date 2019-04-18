Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79082C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442A521479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyY+dwTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389358AbfDROJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:09:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46503 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbfDROJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:09:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id k18so1725425lfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M5siCfHP6BRRv+5HIBdrYDPCmhboYZvbHLTv7FcSa9I=;
        b=JyY+dwTc08oWjbHxleqxC0ncbbwBF4oMaUwb7ZCNU2WOmjt/quOO1tXrYYzyCyutWC
         MkvSFQRQoEJiuaxY+6kKHQ2sPvWcr/lTFjEAPqtPCCw6/sdbzvAQtu3yULUJXzxjtibv
         8k+Bw0sQElny79mVcnmTijLpGjhiWs5PBh+zGVPdwy55UvoYI8pQh9iz4EHXM7qIkVQ4
         BP2CMdn13gGWO3tBbgNChg+k4K5HlKLv9mwaxLirITdao27RB6hCdgcr46bV/al1mi3c
         OFJDIPBad2L1bYlzkHvi0VOYFEe+orW4Z6SP+qxgZvI6KDeMcCsUYeO+dTau1Y0x0oCx
         vcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M5siCfHP6BRRv+5HIBdrYDPCmhboYZvbHLTv7FcSa9I=;
        b=FBvAsxp7POj8TmE/Zlgt9LpRM72ZkRJNEhS58PSNwQwmM1sBfc4uQwO8Rdo7eQtGw1
         oIHZhiHJqDz3Z8Kyf5o8lY8ccOHrlhq8/kBPk66seKTVwZc/bjC3KwYW7mJvtrz9+3ak
         yofTuZ/OxWYUUBTwQfEoyyvYG1oP5d294CYP8GQ/yLAp2gqMIVGF1wdORFUAwrNx1Pbt
         NKSa5iC0HqIab+Yq0ZB7SWlJkKbWa7FeJ4mFC+d1/KJg3/48h3s0JGgfDsWAQm5wJScy
         BZ3qClzox9LLQFfAAiLpifzBAyInEppacN+I8BrRH6hKDI/LoRPllIvDouH9Rg6k0K3u
         Bgsw==
X-Gm-Message-State: APjAAAWT+mpLg6SpOZqIBLTxG/SkzEixeXeT5WjtEvzQmdnldyn7m3BT
        lujtjQFEo1nQoOa1r2DJ120=
X-Google-Smtp-Source: APXvYqzrj4shwzX3in9UPpImegqkTdLb+e4i4bJgo5k2iLRrydA3y8BLZAB2Obk207TGMdal3y75qQ==
X-Received: by 2002:a19:f001:: with SMTP id p1mr9821667lfc.27.1555596593484;
        Thu, 18 Apr 2019 07:09:53 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id 30sm471858lfr.22.2019.04.18.07.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 07:09:52 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 06858460E0B; Thu, 18 Apr 2019 17:09:52 +0300 (MSK)
Date:   Thu, 18 Apr 2019 17:09:51 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        arunks@codeaurora.org, brgl@bgdev.pl, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, rppt@linux.ibm.com, vbabka@suse.cz,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH] prctl_set_mm: downgrade mmap_sem to read lock
Message-ID: <20190418140951.GH3040@uranus.lan>
References: <20190417145548.GN5878@dhcp22.suse.cz>
 <20190418135039.19987-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190418135039.19987-1-mkoutny@suse.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 03:50:39PM +0200, Michal Koutný wrote:
> I learnt, it's, alas, too late to drop the non PRCTL_SET_MM_MAP calls
> [1], so at least downgrade the write acquisition of mmap_sem as in the
> patch below (that should be stacked on the previous one or squashed).
> 
> Cyrill, you mentioned lock changes in [1] but the link seems empty. Is
> it supposed to be [2]? That could be an alternative to this patch after
> some refreshments and clarifications.

Yes, seems so. From a glance the patch shold be ok. Michal will review
it more carefully today. Thanks!
