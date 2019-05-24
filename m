Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E2DC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6794C21848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558733959;
	bh=98E/Odyc4007VfewM+B7Nwy34zdvMWtB0bDHCMdMAoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q9Ez0k5d541VW3YjRanbGCyXN6Nhrwt1+BmrY0A4q6ecMDjcV3Yi+jJP5MdTfz7eg
	 CnP5ce+6OcrhuOa4iQZDMFbtkeumeDDNs5vzv7JwRB8YAd2iOijY0jy0g/KnOmV636
	 RXwvxoLQOa/I/gh7DUiEgNWZenFxnHTpV09pyaVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404291AbfEXVjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 17:39:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37707 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404266AbfEXVjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:39:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id r10so9994913otd.4;
        Fri, 24 May 2019 14:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jFmfOmxoP2erOCA/DD6rKTItS2Yc+t9CAxvODPO2ywA=;
        b=TVO+ZUJj14kTEphPgwAYkSreMwtbwPko48+h7XFjQtcCmj+y2iJaft9MscDsRoLrRb
         cGsza7i1bBuVFBUNB9c+Ksp6sJvplQoYyNTX1dpDWzXqAFF18zACOSMTH1VVpkh29Cgq
         CUUMWAcFRMhQzTBa7tPPn49Q9OV8CiYvEMZUTaqXj3+mHAVCI8XKKtouXv9N9UaVtyPo
         RpbVUTJcEueoa1LHplIFV1cne4FSYofD70GpObtd5bGAHmKt1JFhCXDgY45akNsRb+Ul
         L7P0ZESTLFPjEr/LNLk4t8t6QcTzwzeWbEqbu1uuiYtUH09/vWoIjjVXSaSfylSUdgHu
         +Uag==
X-Gm-Message-State: APjAAAUrxcDfzxfKA0egBm5rjZPdbTkHGT7FeZVmPgVMTaMm5oJpFDrm
        83NacNsvvNYegcNRv/QFxCjpXn4=
X-Google-Smtp-Source: APXvYqzoSUr+ckC4NAFlu3VGoylyPwGaqn6H99+Tluf1/a4qzehwxr4yL4x72G6kNSygI+voDkzHPQ==
X-Received: by 2002:a9d:6481:: with SMTP id g1mr19238443otl.138.1558733957057;
        Fri, 24 May 2019 14:39:17 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y4sm1336652oiy.56.2019.05.24.14.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 14:39:16 -0700 (PDT)
Date:   Fri, 24 May 2019 16:39:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v2 2/3] of/fdt: Remove dead code and mark functions with
 __init
Message-ID: <20190524213915.GA11208@bogus>
References: <20190514204053.124122-1-swboyd@chromium.org>
 <20190514204053.124122-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514204053.124122-3-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 13:40:52 -0700, Stephen Boyd wrote:
> Some functions in here are never called, and others are only called
> during __init. Remove the dead code and some dead exports for functions
> that don't exist (I'm looking at you of_fdt_get_string!). Mark some
> functions with __init so we can throw them away after we boot up and
> poke at the FDT blob too.
> 
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/of/fdt.c       | 37 +++++--------------------------------
>  include/linux/of_fdt.h | 11 -----------
>  2 files changed, 5 insertions(+), 43 deletions(-)
> 

Applied, thanks.

Rob
