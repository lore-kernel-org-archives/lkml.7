Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9891C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17B4205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtV9AEGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfGIQe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:34:26 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:40621 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfGIQeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:34:25 -0400
Received: by mail-wm1-f43.google.com with SMTP id v19so3914919wmj.5;
        Tue, 09 Jul 2019 09:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dmI53Fe6ja6YvtBlOYuS2C3Quf7woGdreNXKMWpwq/Y=;
        b=TtV9AEGZZZvxyteeYkcQf9GHSSzWpvppVjkkrE1hTNQ8SKZD2a7U8c7y/9ccK1uCFj
         gjlSEdZgbju2PcUVdlPKP2P+IwHarrxZ+dFcPqkQB9LM0weOehmsO3l2o3OWY+aX2Gh6
         LEzRrtynKUcYfZu5sx+w/sg6vn/xR/QiONYy8H7ubeI0CKukiWyxssB3DUX8qLPHTXuP
         H2KTxa74WfPgZktrhNdbjYr2/B48rMGpZ8+9171y6KhUdSZoQo3bnRuKi3qiCpfg2zsJ
         Leyp4TsR3MM3Bhsy3Q64sj+pZM5rVzaap32rGpWcCoabwD0csHUIp4wOFP0/7pEDCIQp
         J4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dmI53Fe6ja6YvtBlOYuS2C3Quf7woGdreNXKMWpwq/Y=;
        b=uaMjaxN9yy/Wbpr8+rpvvLmlBqkkJTuklWSus/eG258lS2n8XIMv2g8EY/QVzg90sT
         MlHS2FpVWsG3PGg+7zUYqTIrzTT8H3aVBo8uHruahrHExYN/JsnL6xPdYvO6YW1wsdgq
         XBufYxlnfN94p1RCgUUmZvEnm/qqSZMzOLqjfnWJtTOGHh9bgizotaWh3+ngLvDIN3VX
         q0iv0A7O3UW9Xep8I7Tu97OvYBHLQMJcxP3dkwuRDuo/y/bxO9+3gkUqYKR3qMaItAAb
         Ix92Y3f/QmdzfhWOX9NVuOLbMDfXXx9+z1Xojh+ULjjuYCDgwRUoge1EBzkN50GP4A06
         nmlw==
X-Gm-Message-State: APjAAAUs6cyOHEIpu0w7NhoK8P6zvJ0vCccSrQv1X/ODeg+PgEsNIxai
        YmyEsHyiX8Ef9A2syPimBnth0lnxUWnYRQ==
X-Google-Smtp-Source: APXvYqxGtMKm4ZllrIQdJW5DabmzGQ6c9JVgIl91CqdgTkS5K1OiFPQBEQlbQD3GfGIkbaKEDj8kMg==
X-Received: by 2002:a1c:a019:: with SMTP id j25mr704612wme.95.1562690063636;
        Tue, 09 Jul 2019 09:34:23 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id u186sm5323219wmu.26.2019.07.09.09.34.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 09:34:23 -0700 (PDT)
Date:   Tue, 9 Jul 2019 09:34:21 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        alexander.deucher@amd.com, Philip.Yang@amd.com,
        Felix.Kuehling@amd.com, sachinp <sachinp@linux.vnet.ibm.com>
Subject: Re: [linux-next][P9]Build error at
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h:69 error: field mirror has incomplete
 type
Message-ID: <20190709163421.GA87363@archlinux-threadripper>
References: <1562689597.26515.7.camel@abdul>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562689597.26515.7.camel@abdul>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 09:56:37PM +0530, Abdul Haleem wrote:
> Greeting's
> 
> linux-next failed to build on Power 9 Box with below error
> 
> In file included from drivers/gpu/drm/amd/amdgpu/amdgpu.h:72:0,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:39:
> drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h:69:20: error: field â€˜mirrorâ€™
> has incomplete type
>   struct hmm_mirror mirror;
>                     ^
> make[5]: *** [drivers/gpu/drm/amd/amdgpu/amdgpu_drv.o] Error 1
> make[4]: *** [drivers/gpu/drm/amd/amdgpu] Error 2
> make[3]: *** [drivers/gpu/drm] Error 2
> make[2]: *** [drivers/gpu] Error 2
> 
> Kernel version: 5.2.0-next-20190708
> Machine: Power 9 
> Kernel config attached
> 
> -- 
> Regard's
> 
> Abdul Haleem
> IBM Linux Technology Centre
> 

This should be fixed on next-20190709:

https://git.kernel.org/next/linux-next/c/e5eaa7cc0c0359cfe17b0027a6ac5eda7a9635db

Cheers,
Nathan
