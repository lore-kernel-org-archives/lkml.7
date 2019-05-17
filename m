Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3607CC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0022720833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGkZXfwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfEQJGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 05:06:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38947 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfEQJGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 05:06:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id w22so3007343pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GgShVfrJdzVX4OHpBlPpeZRiwTUzDnQ/1+vh7MIr97A=;
        b=rGkZXfwzMhy0gz3wN4E2bBh+lCxHuu6IdIpe86W1vX8CZoM+/oI+WtufMyZXsy5z+D
         ZVKMXCukQQlQD6e8qb7xN55Rq5MNaPI8rMC/hxcqCwPKLz0G9QS4hnGfmGfcKJdMAs9f
         71rKxD7hM0STMDHwahaeYvC4LcU4duF5oCEZoAjquog1LNdkmKxpu1+wCBBJIAfCypq+
         Fv0tbclO+Ffl99VijsyVB2z7YFmb8EuNnDDw2rEGxMZ2eA0Hbmnwj8XLKudQTen6nghW
         q1NO0qEroof+FXs1Dw38Fd7DYCcocmH/Tm74FEEUiHhAY5JzQrsNqxQ5VYFckKlVoAAE
         M8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GgShVfrJdzVX4OHpBlPpeZRiwTUzDnQ/1+vh7MIr97A=;
        b=lFMqmprCn43K/YESmyOMZykmYRD2mlLAGA/38bHHY/NL/NLv1qkfrRTKow9CbpgNsn
         UQM23uql1WAY/6PpGLKPAWRtByZYWDa7Bpr3OwoM6GSfzaGtE2mMac9bimz9kgf5e5d9
         IHwz85E4Bg8iKK9OvPXPJg8CFuKyYwUYa0SumpWoyDflQIx8kJwi1u3U/r9GVdxW6DeE
         me0705/DAcx33ITMFe3u9o1M+BC6hGXYcx9cNBfZEWBncj146M0kDkbv7le8eW1b7tH1
         ZdUkvqmRlMF34GDZ1ca48Oe5hrqP1e+U+tNgQ+ibr+AGyzkDr2k6rNvea4s4Yt+kww+n
         xEvg==
X-Gm-Message-State: APjAAAWmower8QUqkVQtGYPZnPjNr3l4CqEWHEwVnkBDeGQgAax1BBzB
        QRme78WXJ3h0H7gLU3YdOrL2LXJwXFs=
X-Google-Smtp-Source: APXvYqx9ltdJabmG9EajLLgAw51/p+NhG8d/rygZJA1v7m1seb7Sea3eMHXlFcnxH4ZRXZ90Wsn1cg==
X-Received: by 2002:a62:30c2:: with SMTP id w185mr59918683pfw.175.1558084013478;
        Fri, 17 May 2019 02:06:53 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id n2sm10663440pgp.27.2019.05.17.02.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 02:06:52 -0700 (PDT)
Date:   Fri, 17 May 2019 17:06:28 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi_64: Fix a missing-check bug in
 arch/x86/platform/efi/efi_64.c of Linux 5.1
Message-ID: <20190517090628.GA4162@zhanggen-UX430UQ>
References: <20190517082633.GA3890@zhanggen-UX430UQ>
 <CAKv+Gu98JNK34Q6MNOe3aq0W5rbv6hUFiuc7cHxHJat5aTk_gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu98JNK34Q6MNOe3aq0W5rbv6hUFiuc7cHxHJat5aTk_gg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 10:41:28AM +0200, Ard Biesheuvel wrote:
> Returning an error here is not going to make much difference, given
> that the caller of efi_call_phys_prolog() does not bother to check it,
> and passes the result straight into efi_call_phys_epilog(), which
> happily attempts to dereference it.
> 
> So if you want to fix this properly, please fix it at the call site as
> well. I'd prefer to avoid ERR_PTR() and just return NULL for a failed
> allocation though.
Hi Ard,
Thanks for your timely reply!
I think returning NULL in efi_call_phys_prolog() and checking in 
efi_call_phys_epilog() is much better. But I am confused what to return
in efi_call_phys_epilog() if save_pgd is NULL. Definitely not return
-ENOMEM, because efi_call_phys_epilog() returns unsigned long. Could
please light on me to fix this problem?
Thanks
Gen
