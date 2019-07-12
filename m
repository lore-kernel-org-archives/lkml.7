Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC6FC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2072146E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfGLUWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 16:22:22 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38738 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfGLUWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 16:22:21 -0400
Received: by mail-qk1-f195.google.com with SMTP id a27so7400877qkk.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 13:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAXsy38vfUxAdaLQ2cHfBZxaN3gFCt2GL2KOlavUUwQ=;
        b=O7Q9YbNB0iO0B4HrAgmrPOqYAtR+dZF3CNlyTLri5xoCi4mlP2zlxQ3abiJgP3b7Iu
         HWhNXa1uZ8cZr+KVkUhCOqfB681IDb+D6gpg8aPsn595H9A6kcCPM68fb0tLLBHP8U/R
         JIaKNMartRb/AJUQprQnIn+19LC77vaO0zWq2oyHXCcI1aaYZnev/148aEq41RFU/Bpx
         JTcV9NtsBhleXCl6L7U5AUOa0R9lgmx/LQFuS1roKDTS1Rz7m9JRFHBLXT38r4yOQvDJ
         UgcsfLtJ/byaS9YqXdmG93LCShDDwj9jnsOEKghz02vezgoSnQdBcyE0Y0M+uAQOrM7p
         LfAA==
X-Gm-Message-State: APjAAAWtZ8Qxq+w9E8xnNiCKAQgM4pW7vQN+BhfHF6z2drF+/zT8IeuF
        qHHNnNImvyYW5rZE18TLvyWD8RXHx+Dq4AM9732lIbRZn3k=
X-Google-Smtp-Source: APXvYqwpYZCo9evjKCry92/VPntODrj6skVfA7DxlxAT3xv2z8F8wqoZqjjwl+fqDujGzPERH4MfFGzRBKLf84Qx9vs=
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr7976315qki.352.1562962940527;
 Fri, 12 Jul 2019 13:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190712094118.1559434-1-arnd@arndb.de> <CADnq5_McVegix-m87OwHUvk80NdsFZPQ7d0X8qQtUf84h+Fg1A@mail.gmail.com>
In-Reply-To: <CADnq5_McVegix-m87OwHUvk80NdsFZPQ7d0X8qQtUf84h+Fg1A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Jul 2019 22:22:03 +0200
Message-ID: <CAK8P3a3wqWxPvDDYSQXBTgr335ONZ3beztoANO0hMcnWPFr0Aw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: hide #warning for missing DC config
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jack Xiao <Jack.Xiao@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Huang Rui <ray.huang@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 8:02 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Jul 12, 2019 at 5:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > It is annoying to have #warnings that trigger in randconfig
> > builds like
> >
> > drivers/gpu/drm/amd/amdgpu/soc15.c:653:3: error: "Enable CONFIG_DRM_AMD_DC for display support on SOC15."
> > drivers/gpu/drm/amd/amdgpu/nv.c:400:3: error: "Enable CONFIG_DRM_AMD_DC for display support on navi."
> >
> > Remove these and rely on the users to turn these on.
>
> Is there some sort of informational message we could use instead?
> Unless you are a server user, most end users want this option enabled.

I don't think any compile-time output is a good idea here, a 'make -s'
build should really have no output whatsoever (and usually does).

I see that DRM_AMD_DC is already 'default y', which I would hope
to be sufficient. If you want something stronger than that, you could
make hide the option and leave it always-on unless CONFIG_EXPERT
is enabled:

diff --git a/drivers/gpu/drm/amd/display/Kconfig
b/drivers/gpu/drm/amd/display/Kconfig
index 2cfbbf3b85dd..9862a193349a 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -3,7 +3,7 @@ menu "Display Engine Configuration"
        depends on DRM && DRM_AMDGPU

 config DRM_AMD_DC
-       bool "AMD DC - Enable new display engine"
+       bool "AMD DC - Enable new display engine" if EXPERT
        default y
        select SND_HDA_COMPONENT if SND_HDA_CORE
        select DRM_AMD_DC_DCN1_0 if X86 && !(KCOV_INSTRUMENT_ALL &&
KCOV_ENABLE_COMPARISONS) && !CC_IS_CLANG
