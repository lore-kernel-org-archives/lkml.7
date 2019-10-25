Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95EACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D05F20679
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4GQskO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfJYTYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:24:47 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:36844 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfJYTYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:24:46 -0400
Received: by mail-vk1-f195.google.com with SMTP id r85so736828vke.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1KNKNAvei7RdsNFTjOCPFJdbKge4JWaaDzIh5QD5WU=;
        b=B4GQskO1pBnqkDlZ8HZ8x5c1vhCFZEW3X1j49w0bM7B18rvKIKDxfC7joa+DwOV5Vc
         6mh8e55rxeRH5ENNIRbSFdpc4Nh+5atNEe8sNssBKJ9XjsSSar2EG+qy45G8otOvHTmf
         44KVb2wwSKDA1+xgpzIIX2vx9nzpS4E6myim+/Oh+1q43BEhwKqUu/JmNYikfa5KyNWV
         1iOlg2gSv7/W5mcA1DU1YxNT/6x9K2zHfgklyJ7/ytVFeVZ5QDd5kH3Gr94p0ehppWx2
         PnfJTJ9tbP7fJYy5sGjgyqirYK5pwV8HQ9Phq/+6VkTITjeJCpYwL0osN6AX8s8CJ3/t
         92hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1KNKNAvei7RdsNFTjOCPFJdbKge4JWaaDzIh5QD5WU=;
        b=cY3Hz8qE6WUcwGQGRBZnkgKN6fDj6PMcpODFtVpjOqWR6MxsPSxZRJ6lpuzVCkVnLu
         s8dr0vwLaclSylC2J2dYPFnvUDmXCuPIWEzGOIAK7aqSYtVEUlGt+7z0cVmKlPmbd5SF
         0wu/gJZ4ybS+yrWvZXOKM2XJETZ7qts/kHUY6rI/acmCgojUqdUlMeb6PBnK+TLJhgoM
         OfKQlo97CxsW+cw/sFfQKv+MqTFsmauDf5/ZtwngZ8WjT0/Jq8DePlpqVtyRs0o5e/ey
         OEsdQmxXz0LTLPfKDpphpIlOQs9mHEWytVRSXWTapUqDk1vtJRz6+2vJ423h55jsXzUH
         5yqA==
X-Gm-Message-State: APjAAAVwEVk6QYjSjpOfpV46abN015qHT8HgQg7nDufMOozMMOe+j6TB
        E3QSwMb0NADcxW7K+fR4uDtjfHE3/jECibZkXxixKw==
X-Google-Smtp-Source: APXvYqyNGrPZJ0eMOQynE8OcxFRJ+vW6Age9LhpyOufu31lfdbamMEtUIyKoPDjLtJVIa6dmx+KdXEfZL4h57Ja1Nx0=
X-Received: by 2002:a1f:7d88:: with SMTP id y130mr2977044vkc.71.1572031484800;
 Fri, 25 Oct 2019 12:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191024225132.13410-1-samitolvanen@google.com> <20191024225132.13410-17-samitolvanen@google.com>
 <CAK7LNATPpL-B0APPXFcWPCR6ZTSrXv-v_ZkdFqjKJ4pwUpcWug@mail.gmail.com>
In-Reply-To: <CAK7LNATPpL-B0APPXFcWPCR6ZTSrXv-v_ZkdFqjKJ4pwUpcWug@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 25 Oct 2019 12:24:33 -0700
Message-ID: <CABCJKuegPN+=rHp4E+QMtfAB0w=MikZVG7vxoTBpLkE56UR4HA@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] arm64: disable SCS for hypervisor code
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 6:31 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> $(subst ... ) is not the correct use here.
>
> It works like sed,   s/$(CC_CFLAGS_SCS)//
> instead of matching by word.
>
>
>
>
> KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
>
> is more correct, and simpler.

Thanks, I will change this in v3.

Sami
