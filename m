Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FCAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 04:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDFC2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 04:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6CQE8zB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfCTEep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 00:34:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43150 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfCTEep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 00:34:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id m35so765121ede.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 21:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3Oc4RW7YmPe7UaqGSha1b2EP139AioJbd+R0awb6GQ4=;
        b=G6CQE8zBrqzIj5nMVkQXr/4TMREUxUs0mrv68YArRVL3G/rt5eS1BzutRjSnQqQvpg
         Rppz/xCmfWTlta0NtduQIxPHVnYb9nxVwlgAVU2i1jXgw598wJaTwzY2ghxE1OUthgj+
         AQtheH03YA8DVMTQPYzw3gsHQZhD8CkLIY1UGgFpgPRryv6Y5EgggwL4ZiNdQsTJAzz2
         nqyaDVP7Z+1ySBaPASwl5P6I6Lk+2BowLpMCf1DUxHZSfX9mUAAU0uJoJek+gjkqm0H9
         UcPmHDdvJhCd6J11nLn9Qey0Im1MOIcnsVrK3Ob+uGfqO2f6Ts99zdglNaTtldo3pj76
         xt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3Oc4RW7YmPe7UaqGSha1b2EP139AioJbd+R0awb6GQ4=;
        b=d55yiL3/B1mWk6sZmSwY/Nvnj4QlUjdERpd48uGFwHLtkyvEvb5CxCIR6+P5RAITKD
         9lqvLvrGc3ql7qM9iCGj7UseCnV5sKvLzFFkg+YV0lZV7y/cXnwPzEYSglgzrKH4okiY
         LJZBOUKtRdQNvsl6WbMteC56PT+J+YbjCq0X7FbqMu7C5kZEAqiXShqVi5lzbdztT8yK
         SpEtwPDtNaCKVWQLY8+nRYzAfNaatBa91M2c7C3GA8i5KGbRVdtiXbGCAFKto31JRpsx
         hfETzPcIOJJdRNhytMvVAV6viBQFqKm4G73pYSbU62kKtkYnt8KP5A/5JrXSZ/D1n9bE
         8ZjQ==
X-Gm-Message-State: APjAAAV4O5omRbF1jXg0tgawFklu/9b8EHG5Co3b7iePdLQxhvsqe3BU
        QQcoAzLQDiKT5Qq0HT2wBEo=
X-Google-Smtp-Source: APXvYqxj4fM6xC29UxxDO343/HmhM70mZH68+tnACBbtkc/K+zrYk6RHSXms/crIOKNhbc7hSzk2CA==
X-Received: by 2002:a17:906:2594:: with SMTP id m20mr15388842ejb.91.1553056483248;
        Tue, 19 Mar 2019 21:34:43 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id v1sm166708eja.7.2019.03.19.21.34.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 19 Mar 2019 21:34:42 -0700 (PDT)
Date:   Tue, 19 Mar 2019 21:34:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
Message-ID: <20190320043440.GA23335@archlinux-ryzen>
References: <20190320005406.GA16412@archlinux-ryzen>
 <SN6PR12MB280017BDAB60B61088B221C287410@SN6PR12MB2800.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR12MB280017BDAB60B61088B221C287410@SN6PR12MB2800.namprd12.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 01:31:27AM +0000, Pan, Xinhui wrote:
> these two enumerated types are same for now. both of them might change in the future.
> 
> I have not used clang, but would  .block_id =  (int)head->block fix your warning? If such change is acceptable, I can make one then.
> 
> Thanks
> xinhui
> 
> 
> -----Original Message-----
> From: Nathan Chancellor <natechancellor@gmail.com> 
> Sent: 2019年3月20日 8:54
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; clang-built-linux@googlegroups.com
> Subject: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> 
> Hi all,
> 
> The introduction of this file in commit dbd249c24427 ("drm/amdgpu: add amdgpu_ras.c to support ras (v2)") introduces the following Clang
> warnings:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:544:23: warning: implicit conversion from enumeration type 'enum amdgpu_ras_block' to different enumeration type 'enum ta_ras_block' [-Wenum-conversion]
>                         .block_id =  head->block,
>                                      ~~~~~~^~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:545:24: warning: implicit conversion from enumeration type 'enum amdgpu_ras_error_type' to different enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
>                         .error_type = head->type,
>                                       ~~~~~~^~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:549:23: warning: implicit conversion from enumeration type 'enum amdgpu_ras_block' to different enumeration type 'enum ta_ras_block' [-Wenum-conversion]
>                         .block_id =  head->block,
>                                      ~~~~~~^~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:550:24: warning: implicit conversion from enumeration type 'enum amdgpu_ras_error_type' to different enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
>                         .error_type = head->type,
>                                       ~~~~~~^~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:650:26: warning: implicit conversion from enumeration type 'enum amdgpu_ras_block' to different enumeration type 'enum ta_ras_block' [-Wenum-conversion]
>                 .block_id = info->head.block,
>                             ~~~~~~~~~~~^~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:651:35: warning: implicit conversion from enumeration type 'enum amdgpu_ras_error_type' to different enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
>                 .inject_error_type = info->head.type,
>                                      ~~~~~~~~~~~^~~~
> 6 warnings generated.
> 
> Normally, I would sent a fix for this myself but I am not entirely sure why these two enumerated types exist when one would do since they have the same values minus the prefix. In fact, the ta_ras_{block,error_type} values are never used aside from being defined. Some clarification would be appreciated.
> 
> Thank you,
> Nathan

Hi Xinhui,

Yes, explicitly casting these six spots to int would resolve this
warning.

Thank you for the quick response!
Nathan
