Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0881C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940BE222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dDPyXc1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLSA5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 19:57:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37643 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSA5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 19:57:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so2182976pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 16:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mbuT0JJHwTyZYVzxrDyFt/bnaie5VB+uglFVwOpLv0U=;
        b=dDPyXc1BsjDtKwsxqUyIMuO21OAI8x5NEEoTYkpCA44GzSlCJfRAIVWIYm/uy33xUS
         k9O5wo63vdQCClODHaW7jF/hNMsT2Ag0uBExymZ5NXooju90hPhCk/zGYSg54zQcFXX2
         nAOY2uM6kquy64hlfJh5qtHKJ4FfbkDhRhmNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mbuT0JJHwTyZYVzxrDyFt/bnaie5VB+uglFVwOpLv0U=;
        b=pTatQjwKa5ymY7FnOSp4jkOhkptz4BqFllcNx/vCknzSRPeAfz1j2Fk3ZzRYiu4VER
         A9whYivjrj5rrlPOlUajahgHsIRoGf5pVCczmyi6jm5cWNiMqJADvPSrQX3ajmwCcq/6
         mvIpkIMgOdF5cIl/hSbxIma7owGL51lBeYgjYtXw4u0D2WMjn8oHvWB1QJAg1UawjGHc
         MqMJVgJHF54QznJGPxdgfrd2WtLYdEihbgPbwIQhy2GZzvhkwT2Sqco2sR/dRwFd4Gc3
         iHcurFvn91kRzcBdOoKSYrDWgKbQZ7Zy0ZO+nYvRH+kxavcHUYnNwIoFYL7xaEvsheyu
         xcwQ==
X-Gm-Message-State: APjAAAVlrRz6TmXQAH/EVoaZD/5cf3AueZxkonq43bpjPRDyAGwljRDu
        6KW/T9Cl3fGPIwJKh7JmP7cZaw==
X-Google-Smtp-Source: APXvYqzbTJaJ+GxpwyJ1kQAKHz+QcGU0g7sipCali9NdKzdQ93j7wrSbSLZ/Udd3ryi5SFoaw8+bOg==
X-Received: by 2002:a63:f403:: with SMTP id g3mr6263388pgi.62.1576717021228;
        Wed, 18 Dec 2019 16:57:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 91sm4341377pjq.18.2019.12.18.16.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 16:57:00 -0800 (PST)
Date:   Wed, 18 Dec 2019 16:56:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH] ath11k: Use sizeof_field() instead of FIELD_SIZEOF()
Message-ID: <201912181656.01259B85@keescook>
References: <201912180919.2A471217@keescook>
 <87d0cl8q46.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0cl8q46.fsf@kamboji.qca.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 08:07:05PM +0200, Kalle Valo wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > The FIELD_SIZEOF() macro was redundant, and is being removed from the
> > kernel. Since commit c593642c8be0 ("treewide: Use sizeof_field() macro")
> > this is one of the last users of the old macro, so replace it.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Please also Cc linux-wireless so that the patchwork sees this.

Ah, okay. It wasn't listed in MAINTAINERS, so I didn't remember. Sorry;
I'll resend.

-- 
Kees Cook
