Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EF7C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E4D2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WYfvbX9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389529AbfETP7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:59:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45192 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733173AbfETP7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:59:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id a5so6894412pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 08:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i3Ugz84+ys27xv4V2R0/61jJfVNZvoPzkrhwTJb4UEI=;
        b=WYfvbX9ZyUpY7CCe5xuLsIwy54mfmpxnIz2YroJI5lRt4z4Pta5CB6Zb1lGY1+0WWK
         HyAvNMXYv6Z2SgJPbKsA76TpOAQ09fjBxpYxJ1iXSdYPwYm1vtjyBp0vLfoJhr8sLYas
         jp7uEtGAS9dWJegOQFLCUO+jjsDpx6cqQsIaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i3Ugz84+ys27xv4V2R0/61jJfVNZvoPzkrhwTJb4UEI=;
        b=aBaGqcHAiTWieRnxOwd05JsztCeO+ZvNmo/+dco0OLAIts2nDY6XfyFObr2IE1Hmxu
         YgsVivnRp4OhDNfhBedMyUf8qrRJgDvpWSDLA53t20zplHUgyiH3lV5+4GDQuzFUkoZj
         jVCTQ34gLrhuA9ERzSWFlxuSf8YlGbIau1skl8u47L7AhAjpJ2VqWYRzEthu9GDW54p7
         P6zc2wf+HXMGJXFR5GtFXDFXWNgFbM3m98Lp0IWfIpt4ZIqbwCsm8s+niGCQ2jGXDYwc
         L7N2HQgUmkwBtvvlQOjXj4vZksuKsyzoPLdewz+z4HQbNGSENhKyeQboJKV1EC/z9j0q
         Nqdg==
X-Gm-Message-State: APjAAAVqNCr0E6gK4ERBVXEBduo3ScHRqhpwA3+5QrASa1TxMTNyFRLm
        B97A+dwjWEGrvHOLGuhUFJETug==
X-Google-Smtp-Source: APXvYqxsJyCn04YGpylP3HzZWHrLHYtpXd+pqdRh0wVgFGGWU5n+9GOPaiKREbcX+0J1kaNT+NOSgQ==
X-Received: by 2002:a17:902:7592:: with SMTP id j18mr16845836pll.213.1558367992533;
        Mon, 20 May 2019 08:59:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h123sm27975870pfe.80.2019.05.20.08.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 08:59:51 -0700 (PDT)
Date:   Mon, 20 May 2019 08:59:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [BUG v5.2-rc1] ARM build broken
Message-ID: <201905200855.391A921AB@keescook>
References: <4DB08A04-D03A-4441-85DE-64A13E6D709C@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DB08A04-D03A-4441-85DE-64A13E6D709C@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 05:15:02PM +0200, H. Nikolaus Schaller wrote:
> Hi,
> it seems as if ARM build is broken since ARM now hard enables CONFIG_HAVE_GCC_PLUGINS
> which indirectly enables CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK. Compiling this breaks
> on my system (Darwin build host) due to conflicts in system headers and Linux headers.
> 
> So how can I turn off all these GCC_PLUGINS?
> 
> The offending patch seems to be
> 
> 	security: Create "kernel hardening" config area
> 
> especially the new "default y" for GCC_PLUGINS. After removing that line from
> scripts/gcc-plugins/Kconfig makes my compile succeed.

The intention is to enable it _if_ the plugins are available as part of
the build environment. The "default y" on GCC_PLUGINS is mediated by:
        depends on HAVE_GCC_PLUGINS
        depends on PLUGIN_HOSTCC != ""

So it seems that something isn't working in the plugin detection maybe?
Can you send your build error, compiler version, .config, etc? I've not
been able to reproduce this problem. (And I'm not aware of any of the
automated build systems failing in this area yet either...) Perhaps it's
something specific to building under Darwin?

Thanks!

-- 
Kees Cook
