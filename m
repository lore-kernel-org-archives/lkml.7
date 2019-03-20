Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B15C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE382077B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8AAoeR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfCTAyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:54:11 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:37304 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfCTAyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:54:10 -0400
Received: by mail-ed1-f54.google.com with SMTP id v21so511197edq.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SIu1f/sjw06XHj4pPICcBegeKBWN4+eHSsg+jniAAUk=;
        b=q8AAoeR4h8TsrN4Y+jSwUb95HGe10gEyKV28DsjZHhYhhd/aSE1upt1HLKzGFUZvPq
         VvucMBs2pwdG29cCgBMKKtd81BguHPCw845RGI2hM5FOxFYf36kJuoXd7OKM3KhdkhVm
         p5Y2qZ53TDrh3YkS7fN36ae9Jn/7h1RETp5N1gwYMXeP9/58D80ajG72P0A3WDt3/wln
         bz/PK0cHMvEf8fo8qKyc+HgKzjpn64niJ7bLExmHIwqsc5mIkK90dIdU/y21d8jiOZhO
         vL9sB0zLkju8w6NtJztz/YDIPGJvs5Wh2YXDmN0HwSM2dkwI0u8tyaJQ+nUVGP/jAO3f
         Ez7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SIu1f/sjw06XHj4pPICcBegeKBWN4+eHSsg+jniAAUk=;
        b=Fvx2a5Ld4ns9YY3xK4+q14HvNUlL99nrlCDGt73SKVaVlxOt9fxCGikE0BF0e76Blm
         oOO5HHCmuSeU2uuQn1Vdiil7SYpi4yOQ0Wc+YCD3o/4sCo5BfLDMrWwtRPzQfa3ptDu3
         k7lEOAeI1BGNvfAhr9ATKNh21K9D6SoVR1T47wDznOmzRky0eEe+Z0s40FZCBSoq0Zb+
         50TVZkHgHp8rsk5h+Mfrp4QK59ga9QUrMinRPpHZtX5SpGODVT2k8pUzVJZEZvPPFhP8
         Khb+9REVHbi1cO7KdZMwAz8KYEn80EnOhvrUT2lffbcyq/mWLho0i4hsoWi4qnqR0jMH
         jEDw==
X-Gm-Message-State: APjAAAXVjvm+T3NbtP4BnBE2LzSxpV5wSuTA/oOwbB1Yp0kx0APKipH1
        MG5+8X0qZEJJQiV6gnrmckM=
X-Google-Smtp-Source: APXvYqzsRggGc+VQm56WC4vkrRpTZPBHiVpXWkrj+Iw6k6KKwC9xsMdO//5Kvn1JMxR9t3/FXYaH3w==
X-Received: by 2002:a50:97d5:: with SMTP id f21mr18125379edb.293.1553043249031;
        Tue, 19 Mar 2019 17:54:09 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id j34sm169742edb.30.2019.03.19.17.54.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 19 Mar 2019 17:54:08 -0700 (PDT)
Date:   Tue, 19 Mar 2019 17:54:06 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        xinhui pan <xinhui.pan@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
Message-ID: <20190320005406.GA16412@archlinux-ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The introduction of this file in commit dbd249c24427 ("drm/amdgpu: add
amdgpu_ras.c to support ras (v2)") introduces the following Clang
warnings:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:544:23: warning: implicit conversion from enumeration type 'enum amdgpu_ras_block' to different enumeration type 'enum ta_ras_block' [-Wenum-conversion]
                        .block_id =  head->block,
                                     ~~~~~~^~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:545:24: warning: implicit conversion from enumeration type 'enum amdgpu_ras_error_type' to different enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
                        .error_type = head->type,
                                      ~~~~~~^~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:549:23: warning: implicit conversion from enumeration type 'enum amdgpu_ras_block' to different enumeration type 'enum ta_ras_block' [-Wenum-conversion]
                        .block_id =  head->block,
                                     ~~~~~~^~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:550:24: warning: implicit conversion from enumeration type 'enum amdgpu_ras_error_type' to different enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
                        .error_type = head->type,
                                      ~~~~~~^~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:650:26: warning: implicit conversion from enumeration type 'enum amdgpu_ras_block' to different enumeration type 'enum ta_ras_block' [-Wenum-conversion]
                .block_id = info->head.block,
                            ~~~~~~~~~~~^~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:651:35: warning: implicit conversion from enumeration type 'enum amdgpu_ras_error_type' to different enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
                .inject_error_type = info->head.type,
                                     ~~~~~~~~~~~^~~~
6 warnings generated.

Normally, I would sent a fix for this myself but I am not entirely sure
why these two enumerated types exist when one would do since they have
the same values minus the prefix. In fact, the ta_ras_{block,error_type}
values are never used aside from being defined. Some clarification would
be appreciated.

Thank you,
Nathan
