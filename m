Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3BBC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FEF2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNUHr0L5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404053AbfDXRkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:40:11 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40793 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392215AbfDXRhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:37:34 -0400
Received: by mail-vk1-f193.google.com with SMTP id l17so4222531vke.7;
        Wed, 24 Apr 2019 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lr5KCxut/L7a1sDO0oQgy6JcEdg3hJTt2nO//Py2EQI=;
        b=TNUHr0L5AIVWY92JBDj34+qJBX/3rpQAH+oICPnBJRK0genIIGhr6SzC1jrrv1vS4X
         pbl1aaeJV+Bn1w6x6x795JfJ2MLFjqH67DirhURoicZiQnqiHgk01dqDOfnKxAw4roV4
         sn4sNZCTE/6bazYoBYhjlk+Wllq6nNZDCaudD34Q3ZYxJ2fMQqfGnnJBNRKTqQHXp1Fs
         CprSuYvJfe4zDyxxLq+8XKUJDHE03v7Fa86rfiqrNvV+P/TuNi8gTNN6YroYF/lkc8od
         qwGUS2+XCNEL9ufUFBVlXUXIW1DrkFIowubWnDmqHOlXWMYBmy0QG0oJ8Z1Q+7v3pRUn
         Y8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lr5KCxut/L7a1sDO0oQgy6JcEdg3hJTt2nO//Py2EQI=;
        b=G0m1fN76MrAg4mniIHHLEOZD/I+ULK7OJj8wlx06UXI9JTk5eiKAXXUzfXlH9kdlsH
         RZon5vSyjsuVsPwpt6kC2cJv3ggaZ2oW+rNJALMkij4imhQjBLZ4DTFn4GTEyuGyCkRN
         U8As8vZVt+irbszXX9eP1x6ZCOt0ZmpXl7BcXFGwT8XBaOZTshY9VtmniLSRo00y5qJb
         ezd1smg7cBFUW5CkywNBfU4lTRqefjeoXj34aBtMJy/0NgOBtQ7w5p+NqXfYFfMLi9q8
         07mASAC1e3ks9DINBiHY3hKXWIvy0+i+ZTRgEfu+i7TBT1G2HjFSEYIrhmRsdSx1Min9
         vsVw==
X-Gm-Message-State: APjAAAX+9fNKUA2ooAUX3K3Km/uGKQkAgnm2+ZABwNVoqWL3HY83jPDJ
        5snpB9ZWZgZ3UecxfnWiPtcf2pCBQ0/tbZtg3PE=
X-Google-Smtp-Source: APXvYqzsYfdxWBGhskCVplULzwaeUR/I5DqRjV6bd8nEONO/Y+tUlQCLhk8sgfSRYFKtZr3JmFId19h+6N+qV45gDM8=
X-Received: by 2002:a1f:8b8d:: with SMTP id n135mr18361167vkd.89.1556127452773;
 Wed, 24 Apr 2019 10:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <1556116431-7129-1-git-send-email-robeholmes@gmail.com> <20190424160609.EE5ED21901@mail.kernel.org>
In-Reply-To: <20190424160609.EE5ED21901@mail.kernel.org>
From:   Robert Holmes <robeholmes@gmail.com>
Date:   Wed, 24 Apr 2019 18:36:56 +0100
Message-ID: <CAD_KW27rN-GefFqegdBTYNf4393cF5Kc+jP=au45GfSvmTSn9g@mail.gmail.com>
Subject: Re: [PATCH v2] KEYS: Make use of platform keyring for module
 signature verify
To:     Sasha Levin <sashal@kernel.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the v5.0.9 stable tree we also require also cherry-picking commits

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D219a3e8676f3132d27b530c7d2d6bcab89536b57
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D278311e417be60f7caef6fcb12bda4da2711ceff

which, arguably, should be on stable anyway, since it has already picked up

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dlinux-5.0.y&id=3D9dc92c45177ab70e20ae94baa2f2e558da63a9c7
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dlinux-5.0.y&id=3D60740accf78494e166ec76bdc39b7d75fc2fe1c7

Robert.

On Wed, Apr 24, 2019 at 5:06 PM Sasha Levin <sashal@kernel.org> wrote:
>
> Hi,
>
> [This is an automated email]
>
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
>
> The bot has tested the following trees: v5.0.9, v4.19.36, v4.14.113, v4.9=
.170, v4.4.178, v3.18.138.
>
> v5.0.9: Build failed! Errors:
>     kernel/module_signing.c:92:11: error: =E2=80=98VERIFY_USE_PLATFORM_KE=
YRING=E2=80=99 undeclared (first use in this function); did you mean =E2=80=
=98VERIFY_USE_SECONDARY_KEYRING=E2=80=99?
>
> v4.19.36: Failed to apply! Possible dependencies:
>     e84cd7ee630e ("modsign: use all trusted keys to verify module signatu=
re")
>
> v4.14.113: Failed to apply! Possible dependencies:
>     81a0abd9f213 ("module: make it clear when we're handling the module c=
opy in info->hdr")
>     e84cd7ee630e ("modsign: use all trusted keys to verify module signatu=
re")
>     f314dfea16a0 ("modsign: log module name in the event of an error")
>
> v4.9.170: Failed to apply! Possible dependencies:
>     3e2e857f9c3a ("module: Add module name to modinfo")
>     490194269665 ("module: Pass struct load_info into symbol checks")
>     71810db27c1c ("modversions: treat symbol CRCs as 32 bit quantities")
>     71d9f5079358 ("module: Fix a comment above strong_try_module_get()")
>     81a0abd9f213 ("module: make it clear when we're handling the module c=
opy in info->hdr")
>     96b5b19459b3 ("module: make the modinfo name const")
>     e84cd7ee630e ("modsign: use all trusted keys to verify module signatu=
re")
>     f314dfea16a0 ("modsign: log module name in the event of an error")
>
> v4.4.178: Failed to apply! Possible dependencies:
>     136cd3450af8 ("powerpc/module: Only try to generate the ftrace_caller=
() stub once")
>     20ef10c1b306 ("module: Use the same logic for setting and unsetting R=
O/NX")
>     3e2e857f9c3a ("module: Add module name to modinfo")
>     490194269665 ("module: Pass struct load_info into symbol checks")
>     4c91bd6eeabb ("powerpc: Merge the RELOCATABLE config entries for ppc3=
2 and ppc64")
>     71810db27c1c ("modversions: treat symbol CRCs as 32 bit quantities")
>     7523e4dc5057 ("module: use a structure to encapsulate layout.")
>     81a0abd9f213 ("module: make it clear when we're handling the module c=
opy in info->hdr")
>     96b5b19459b3 ("module: make the modinfo name const")
>     a5967db9af51 ("kbuild: allow architectures to use thin archives inste=
ad of ld -r")
>     b67067f1176d ("kbuild: allow archs to select link dead code/data elim=
ination")
>     be7de5f91fdc ("modules: Add kernel parameter to blacklist modules")
>     cd3caefb4663 ("Fix subtle CONFIG_MODVERSIONS problems")
>     da4230714662 ("powerpc/32/booke: Fix the build error when CRASH_DUMP =
is enabled")
>     f314dfea16a0 ("modsign: log module name in the event of an error")
>     faaae2a58143 ("Re-enable CONFIG_MODVERSIONS in a slightly weaker form=
")
>
> v3.18.138: Failed to apply! Possible dependencies:
>     136cd3450af8 ("powerpc/module: Only try to generate the ftrace_caller=
() stub once")
>     3e2e857f9c3a ("module: Add module name to modinfo")
>     490194269665 ("module: Pass struct load_info into symbol checks")
>     4c91bd6eeabb ("powerpc: Merge the RELOCATABLE config entries for ppc3=
2 and ppc64")
>     6da0b565150b ("kernel:module Fix coding style errors and warnings.")
>     71810db27c1c ("modversions: treat symbol CRCs as 32 bit quantities")
>     7523e4dc5057 ("module: use a structure to encapsulate layout.")
>     7d485f647c1f ("ARM: 8220/1: allow modules outside of bl range")
>     81a0abd9f213 ("module: make it clear when we're handling the module c=
opy in info->hdr")
>     926a59b1dfe2 ("module: Annotate module version magic")
>     96b5b19459b3 ("module: make the modinfo name const")
>     be7de5f91fdc ("modules: Add kernel parameter to blacklist modules")
>     cb9e3c292d01 ("mm: vmalloc: pass additional vm_flags to __vmalloc_nod=
e_range()")
>     cd3caefb4663 ("Fix subtle CONFIG_MODVERSIONS problems")
>     da4230714662 ("powerpc/32/booke: Fix the build error when CRASH_DUMP =
is enabled")
>     f314dfea16a0 ("modsign: log module name in the event of an error")
>     faaae2a58143 ("Re-enable CONFIG_MODVERSIONS in a slightly weaker form=
")
>
>
> How should we proceed with this patch?
>
> --
> Thanks,
> Sasha
