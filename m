Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91790C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F99F2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSxP5So5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfDWOzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:55:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35406 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfDWOzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:55:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so7750559pgf.2;
        Tue, 23 Apr 2019 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y2qVkcnIUTAOloMt/bR+PD8mCA6y24Iai13NIuYAAx0=;
        b=cSxP5So5UPVb4bYO41L1CXSjd3gFYSy5Zdqfmft6gpiY7zMBiSJG3D1hWOPtjwRa8q
         xV9bQi2egy/ecTiAq1oOwbrPbxvmcspZlpLqXk0Bgo3ah4DMidMn6vLgmWE2xwXi+hyQ
         D0ZuFNDtokw8r/Ae/U/U0dMf4ySFMoiuwL85EghyenjfpSsLFKP2gIUl9B5OWqqHCXtU
         XqF0h04byjZ40mbFx0tIu6VOHVqLRSLaZGkG5QJRIBxBXEaogvVsT+K5FNQf/Q7AhdqQ
         /H7YUFUc4uXKOi2dVsUdhrMegVRLJeNUZcVxTNriu3tvu8w9FYyf4tK3im18ZuRyWcdp
         9MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y2qVkcnIUTAOloMt/bR+PD8mCA6y24Iai13NIuYAAx0=;
        b=Ki7w0nM1QKNKT0Wrx6FxXnMtQgbc08n2FEYkE1/pI7pjFuAcQkq4XvTpj0DqrsMIu6
         TVtEF4tewpg51cOxcj30Phy/gYDl9zflQnZ7cb4VA/KE68Fn95NxChsYoYa6Jc5CmXab
         rvQnC7EzVvz+/7j6wuslWNS314SUKXB3PQuo3oD1ix6c0rVtwqRYhivNN+IyfL+pqXqC
         CTfXMvpPyJLpOZTyj1h2yRQkXObaxJadVsjkYErtMoucYDZt26h4vJZlnb1hn22xERv9
         vE238MKdmyQpfa6L7jn4VmooJNtrfrXUqMZT7KQCZ03D0xNFfs/wzRTWYdwHDgA3oo/H
         ihBw==
X-Gm-Message-State: APjAAAXLE7mKVTBNGATyhfwejxjhJi6NVwhmUhJOwlUPUcpD3D2QJ5X+
        W/Sxke3GnvyJGy6XYVJb5kTvYL0o
X-Google-Smtp-Source: APXvYqzlxpQhz0schRp/IdbKtHFpTSZFpXpRPadcfamVdn/C0zYv2rYcuZsIzjxjInERWCerPHYdnw==
X-Received: by 2002:a62:b602:: with SMTP id j2mr27272264pff.68.1556031332071;
        Tue, 23 Apr 2019 07:55:32 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id f27sm3319300pfk.111.2019.04.23.07.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 07:55:31 -0700 (PDT)
Date:   Tue, 23 Apr 2019 20:25:21 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, jannh@google.com,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: Force type conversion in xattr_hash
Message-ID: <20190423145521.GB3609@bharath12345-Inspiron-5559>
References: <20190417115200.GA10168@bharath12345-Inspiron-5559>
 <20190418155019.ab5189e4e317df2b36861012@linux-foundation.org>
 <20190421170235.GI2217@ZenIV.linux.org.uk>
 <20190422122705.9df141f5c9b4e842e170e72a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422122705.9df141f5c9b4e842e170e72a@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 12:27:05PM -0700, Andrew Morton wrote:
> On Sun, 21 Apr 2019 18:02:35 +0100 Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > IOW, what sparse has caught here is a genuine endianness bug; images
> > created on little-endian host and mounted on big-endian (or vice
> > versa) will see csum mismatches when trying to fetch xattrs.
> 
> OK, thanks.  I'll drop the patch - we shouldn't hide that reminder of a
> bug.
> 
> Perhaps someone could prepare a patch which adds a comment explaining
> these issues, so someone else doesn't try to "fix" the sparse warning.
>

Hi Andrew,

I will send a patch CCing Al to add a comment explaining these issues.

Thanks
Bharath
