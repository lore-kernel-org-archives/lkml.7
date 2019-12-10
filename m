Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757A5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466C02077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575992245;
	bh=1vwTuyeGNMoWzMSycC968byapHd+NyJvdWDj4S+IGzk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F1dW2zb46cWLhuzfRK17kJyT/0YX11hZLDaiE6tzYAs0NaeyRdiQvlz/d/s64nxf7
	 UKJXccAwZF0zXL3LklWMYhaOjAFzLH50RhM+EtE/7cujHfV4BV3ubqt3vzr694/dE4
	 6dnQax93K2utFzpAMB8iq1k4RY+8AWbcFSkFoa9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfLJPhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:54850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfLJPhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:37:23 -0500
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B89B622B48
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575992243;
        bh=1vwTuyeGNMoWzMSycC968byapHd+NyJvdWDj4S+IGzk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tmzVi/9qM6uBnYYEyG0XC7YXoHByQZfteOHBN3MQTZWHeRD4QKCV1uf5IVDVxVbAe
         0ydyQauqJL5JD7nzoY2w9NE92E7m2Trq62q55XHVaFNmRQ1Z3Yhq4Dre3ExkLmY/65
         4t3mLfG3K06iteG2xHwmX4KlMsQSvLyVRGDcQKDM=
Received: by mail-lf1-f54.google.com with SMTP id n25so14138516lfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 07:37:22 -0800 (PST)
X-Gm-Message-State: APjAAAU9MPXILj6rrCS5VeS/PsRXMm5Q/1wRzDG3OtPt7btUEqDBcrS9
        VUxsZAXRvi9s8uUPtZt/N4EzjouTh3Vf1AJVByE=
X-Google-Smtp-Source: APXvYqw2TGCWM9w3To7VtUpYrgW5dwe3lTLc9vGX+5JsCfHY9qfQzI77/YfYqCJgCYQdQyc2H+RF2TLfxLxq+1g4uO8=
X-Received: by 2002:a19:c205:: with SMTP id l5mr18943583lfc.159.1575992240859;
 Tue, 10 Dec 2019 07:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20191210145657.105808-1-oleksandr@redhat.com>
In-Reply-To: <20191210145657.105808-1-oleksandr@redhat.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 10 Dec 2019 16:37:09 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfN4r+fi5R0GOyvQnQ6yn7hQvi+cScDD5THqF8X0nOX7w@mail.gmail.com>
Message-ID: <CAJKOXPfN4r+fi5R0GOyvQnQ6yn7hQvi+cScDD5THqF8X0nOX7w@mail.gmail.com>
Subject: Re: [PATCH RFC] init/Kconfig: enable -O3 for all arches
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>, Tejun Heo <tj@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        David Howells <dhowells@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 at 15:57, Oleksandr Natalenko <oleksandr@redhat.com> wrote:
>
> Building a kernel with -O3 may help in hunting bugs like [1] and thus
> using this switch should not be restricted to one specific arch only.
>
> Thus lets expose it. If for some reasone we have to hide it, lets hide
> it under EXPERT.

You are not hiding it under EXPERT so no need to document in commit
log theoretical future decisions.

> The commit is made against next-20191210 tag.

This does not belong to commit message. You can put such under the ---
separator.

Best regards,
Krzysztof

>
> [1] https://lore.kernel.org/lkml/673b885183fb64f1cbb3ed2387524077@natalenko.name/
>
> Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> ---
>  init/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index a34064a031a5..b41b18edb10e 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1228,7 +1228,6 @@ config CC_OPTIMIZE_FOR_PERFORMANCE
>
>  config CC_OPTIMIZE_FOR_PERFORMANCE_O3
>         bool "Optimize more for performance (-O3)"
> -       depends on ARC
>         imply CC_DISABLE_WARN_MAYBE_UNINITIALIZED  # avoid false positives
>         help
>           Choosing this option will pass "-O3" to your compiler to optimize
> --
> 2.24.0
>
