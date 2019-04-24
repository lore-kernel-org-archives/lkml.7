Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F95AC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CD1208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aWEfAn4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfDXStv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:49:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33309 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfDXStv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:49:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so9826806pgh.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLVXijWOwNwMQYVrWlAGaybWHfEewsaKBtmpqpOoowY=;
        b=aWEfAn4osyXThukIpO+zR0sD4/1ltQOAm9RTo7YLIn1G2sTz7WwA/j/hbN9PmdrYjJ
         BwFQ77ZjlTfLmxGYb1g+lJOAjGqbadYI3cKdGNO/9CdLzL1GJG/RZCvealiAC2gU+oXu
         U29bH+UP/U9A1W0IBKDei8ca9QtlehYQE5epSKUg1IuorKUqbrNbAHeIzaTuZKQ9slIE
         KVCV9eNjFzyT2PMFg9Myzfq0O8fT1onwpUZe658DoC6e8/Sa0sZT6NrLLTfpkWU6L9Xh
         tG09zEdEaAIglFX0yjHKkNI+o/+fgg3curTAuOs7IK1TQGECSlKJhW5Q3lNghuztkjRv
         XqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLVXijWOwNwMQYVrWlAGaybWHfEewsaKBtmpqpOoowY=;
        b=rAbdEyxxML5PeRmB4GXwCpbRqBVZdhnchYSWh0FlB32xbItofzt436W9+iMzBh/CmS
         mmJAatFWVVuQ2cm2ezowR02/LremEama9RDFRQ+MruwegfKeldNNt6GPCnSa/br5EWrX
         7PmYdYEc1Awe+Zx0yQnP2AiqXlIvtfcblFuDCC2GGYZrnuL8+MjXYhyhs8D0oUbQ8xev
         J5gccjS4VJF4VHVAGJEKlzEqhj9PcVGpgq86zt+FfmN4+NGXeMB4ITL1PXazkQScV/1X
         2L9Y041Y0WEXaGz5QkkoywdzAIGwN/phVky2eLs35sS6PFjfXI0n+Y9nkgBkusC+KNEa
         2Yrg==
X-Gm-Message-State: APjAAAVOicivJ4mEMXN7G3iY6JTlUw5Bsn9aaU+iuSnCDjNI1XE16tYj
        8EuCzq+Hf2SFoANjGrObvbQyigjNS7vt5+Oe+8BmIg==
X-Google-Smtp-Source: APXvYqyGMY22DSWHcF4a29C+TJFuRk9C7Sx4vkx6Pko36iK8Gf0eJhnYMDJzjNBe25whsj3Xhil2roFw0uDrgh/amco=
X-Received: by 2002:a63:f817:: with SMTP id n23mr22699288pgh.302.1556131789616;
 Wed, 24 Apr 2019 11:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190424183413.13854-1-natechancellor@gmail.com>
In-Reply-To: <20190424183413.13854-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Apr 2019 11:49:37 -0700
Message-ID: <CAKwvOdkHiBhFsgEvLrr6oD84GKetDFV2b=n1DYDewCUyHWf7oA@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Make priority unsigned in struct tb_path
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:34 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/thunderbolt/tunnel.c:504:17: warning: implicit truncation from
> 'int' to bit-field changes value from 5 to -3
> [-Wbitfield-constant-conversion]
>         path->priority = 5;
>                        ^ ~
> 1 warning generated.
>
> The priority member in struct tb_path is only ever assigned a positive
> number:
>
> $ rg -n priority drivers/thunderbolt/path.c
> drivers/thunderbolt/tunnel.c:99:        path->priority = 3;
> drivers/thunderbolt/tunnel.c:308:       path->priority = 2;
> drivers/thunderbolt/tunnel.c:323:       path->priority = 1;
> drivers/thunderbolt/tunnel.c:504:       path->priority = 5;

LGTM.  Looks like drivers/thunderbolt/tb_regs.h also defines it as u32
(no change needed here).
Triple checking it's uses, looks like it gets assigned:
drivers/thunderbolt/path.c#L492:
hop.priority = path->priority;
hop is an instance of a struct tb_regs_hop, which is the definition I
was looking at above.  LGTM thanks Nathan!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Furthmore, that value is only assigned to an unsigned integer in
> tb_path_activate (the priority member in struct tb_regs_hop).
>
> Fixes: 44242d6c9703 ("thunderbolt: Add support for DMA tunnels")
> Link: https://github.com/ClangBuiltLinux/linux/issues/454
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/thunderbolt/tb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index 15d225dcb403..b12c8f33d89c 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -225,7 +225,7 @@ struct tb_path {
>         enum tb_path_port ingress_fc_enable;
>         enum tb_path_port egress_fc_enable;
>
> -       int priority:3;
> +       unsigned int priority:3;
>         int weight:4;
>         bool drop_packages;
>         bool activated;
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
