Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4858C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E6A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ODxVbkR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfC0XPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:15:40 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36886 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC0XPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:15:39 -0400
Received: by mail-vs1-f65.google.com with SMTP id w13so11015312vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 16:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbXO/VWyJiCmltAKiBOIF6+4WZxY/EdHeUCq/+V/gkU=;
        b=ODxVbkR6cVb59Srw7EmkVqTJ3SDl2tx485kKU493XWp55lV+lw5+LNag/5755s106R
         rqtbccvR3wEnv0m6Ub8/cMUpkHV6696pQBYMRd3+CobEb6YFpciVhR01VdBck7x855Ii
         js0hxSLwvcnCHW33h7m6+dFY8BVUUycLFxv2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbXO/VWyJiCmltAKiBOIF6+4WZxY/EdHeUCq/+V/gkU=;
        b=h8Uz7s5xjtLCX09SqZkSzy4LNU6QjJJwwP12rO39lF7XmHdUCsMB5+JGkckOl/j9nE
         Ctx6uAzMU/J5hArvCKysW45Wrcs/mFtClXLLOWa6Yvzvnjlgs8Z5MMk5HjLjsv3zCZrJ
         cur2c0KvSGQajTCTHLuB6tWiN11ZNkAe5iRgsNe5dYtODmoDxuCSNL9VkMDQLRHGx7j6
         PbOLqRkg232tTlHn/F/kXs5/NBLMPvPUbkGmUjYrngtMXjC/xyywbYlE8EuA4U78mohl
         8spkyoxqDnCyCSuSKTZ2zY9VvAgObG1zhbEIv4yTkClI3lhAWXHh4sXfC+kI5b1cdcJO
         CnUA==
X-Gm-Message-State: APjAAAUe5ee6x/gG30Z2yO+4KxzEBxTD2MJEIzMNx/Ort6g83Fi2qvmH
        9R8UlyZzMZ3KteUhkBbuSApAoXx6D68=
X-Google-Smtp-Source: APXvYqzL0Cevn+29WqRS7GRpDrwS5hTpfJqwQHRgg4J4ABC4aCO//JrM/kIO2pLcwwMRMaM6Z9+gIA==
X-Received: by 2002:a67:2f4a:: with SMTP id v71mr6426254vsv.225.1553728538597;
        Wed, 27 Mar 2019 16:15:38 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id c202sm5768219vke.44.2019.03.27.16.15.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 16:15:37 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id j184so11011688vsd.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 16:15:37 -0700 (PDT)
X-Received: by 2002:a67:bc01:: with SMTP id t1mr24650125vsn.149.1553728537476;
 Wed, 27 Mar 2019 16:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190327230801.3650-1-qiaochong@loongson.cn>
In-Reply-To: <20190327230801.3650-1-qiaochong@loongson.cn>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Mar 2019 16:15:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Unvv6qNyx-1A_5KUOr-PxjuctaAf5e+Ea0tpJ1c17vKg@mail.gmail.com>
Message-ID: <CAD=FV=Unvv6qNyx-1A_5KUOr-PxjuctaAf5e+Ea0tpJ1c17vKg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: KGDB: fix kgdb support for SMP platforms.
To:     Chong Qiao <qiaochong@loongson.cn>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 27, 2019 at 4:08 PM Chong Qiao <qiaochong@loongson.cn> wrote:
>
> KGDB_call_nmi_hook is called by other cpu through smp call.
> MIPS smp call is processed in ipi irq handler and regs is saved in
>  handle_int.
> So kgdb_call_nmi_hook get regs by get_irq_regs and regs will be passed
>  to kgdb_cpu_enter.
>
> Signed-off-by: Chong Qiao <qiaochong@loongson.cn>

Since you didn't really change any content, you could have just
carried my previous review.  In any case I'll add my tag again:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'd also note that it's nice if you version your patches and include
version history.  If you need help you might consider using patman to
help you send upstream patches.  See:

http://git.denx.de/?p=u-boot.git;a=blob;f=tools/patman/README

...never mind that it lives in the U-Boot tree--it's great for kernel work too.

Thanks for contributing to the kernel!  :-)

-Doug
