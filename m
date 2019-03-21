Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0769AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E072184E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="KdiXkPly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfCUBWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:22:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41697 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbfCUBWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:22:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so3935008lja.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYd+AQ6KOP+KgeMip92o40gSzJtQMXkBsnx5zCYSFio=;
        b=KdiXkPlyGrxalfDIs0pFwG6HU9GZBT8bjd6HJY3dUxfl+qjIHu7JzbOBiXVnwuEzaC
         a8CTevcLPdBAx8BROVhMCK7f1WtqOdPwXK9tbHWgT+GCNtXd8ppag6oYECURjiRsee29
         S/Otwezm99p/UiO3R9fW/bO6Vk73veCHX1mlh0QBPpHytWCied0mx7+7IgiHP2YYT9IG
         +UGzn+82hJDOc8FniYyi0K1MiS/7aujeckrsXodZK5ENVyD9P8I4xJIFfI4KyZa7AWhP
         wMd/GdmxgONUst5B+vLsgHSaW4+7RrqbPVuC4DQ5xYSUiJ+NFQJhd2X6R5jAK6XwsJPR
         sZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYd+AQ6KOP+KgeMip92o40gSzJtQMXkBsnx5zCYSFio=;
        b=ojUpADF56U5dy8CJOM5oTdABZlOrNs9P2UJiBj8jGyzl5k30v1r8tI/gbVLi3XpS+T
         pKRDQ6/b80UMd25twDuvn3m2FyyjuxSGvAhwGsB7W2zjOwLOhOFNZiq/sIn+xUTc1ozT
         PktAK7tzN90ZUcu9qmVufNebBPuaqNlqAuMh6Xd8HVIHqckNbLnBdLdl8svF23VjZrut
         f0saUo61KDaNOEAqcml0AvgVj1fFQQPwPIVr7qbUhmwYDq05wlxh/POe+R14aCkqpk9+
         8eESfgWN0LXl+c9tnNd540BLni2pN7lvaR8cmibu2JCzou29ss12tCmYgOwoam661Oc7
         VZBg==
X-Gm-Message-State: APjAAAVQKgi975bxeTYmu5+g7ZyEhuVBByg85iHiqXEaH6FLAkuQXCnL
        0K5+T/Q6+N0hcL3zMnVBOFTOYodk6f5hsGfPW+Jw
X-Google-Smtp-Source: APXvYqxSl52iIVPtT75hNTmo4yQ0vtWcJixV3fOO2mRpcTCBd2W3da9KuyyNHLzR42l0w8mw9FeDPs+MX/W0k/2zncg=
X-Received: by 2002:a2e:413:: with SMTP id 19mr482400lje.196.1553131320720;
 Wed, 20 Mar 2019 18:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190317233006.GL16301@altlinux.org>
In-Reply-To: <20190317233006.GL16301@altlinux.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 21:21:49 -0400
Message-ID: <CAHC9VhQTvv1htaDZPXAfKd=i2Z-sLRNiWJwck9_LjpROtyxCDw@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] Move EM_UNICORE to uapi/linux/elf-em.h
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Guan Xuetao <gxt@pku.edu.cn>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:30 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> This should never have been defined in the arch tree to begin with,
> and now uapi/linux/audit.h header is going to use EM_UNICORE
> in order to define AUDIT_ARCH_UNICORE which is needed to implement
> syscall_get_arch() which in turn is required to extend
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: unchanged
>
>  arch/unicore32/include/asm/elf.h | 3 +--
>  include/uapi/linux/elf-em.h      | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
