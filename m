Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4E3C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1B220709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6pquKxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKNVCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:02:43 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35300 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfKNVCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:02:42 -0500
Received: by mail-io1-f67.google.com with SMTP id x21so8460421ior.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 13:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJBKOKwM5iW599/3PXPapFgko2uf1vvK5qJNHvXkEvA=;
        b=m6pquKxI4tETRrClr728OIAj7DTVhy29VH8PJJnNux08Ye4bolkgPRVFsBD8+AXlgf
         GdR+UACzBDaQs+1VNv5McBiMGmHUPYhI7e3StEwAuoQLoxndNoy7eUwosL0ZwCc2g/IF
         XRCjKwRaprlcahHNv4vCZMnn1mC36vklMsd1uEwVUWw5eL2+PixU+6dB/TPgTSa2Mx7H
         W7OdSU6Aqa0vqFD95FOoR9vq+w9gh0BdFS5jX+LHTokw6qXIvpnIEWZ55jDn8iuAmx03
         56S9vmiD0TQGGRoqIZvjMszL3KZzq82MAgu1AANUsopCj8I91sp+yLlnYV7dIYpQpca8
         FT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJBKOKwM5iW599/3PXPapFgko2uf1vvK5qJNHvXkEvA=;
        b=Jy8nFqk2i/TTKhigCpbR6aSPVbkaBATW00zTvZijz9HXELN9Sp8ItmTBq4SamV/IcI
         bdzOXA6bhHsNSf8JvtQds7JPgUA0+oUzrtX2z8d6jzB6ngmDueNUHaO02/jhAINpZSaJ
         RzbjaYcI1UYotceQd2MpY/SB4CZ/XbxxDDHcmDJFsC0INZiYGwe72Xgj0VetOSpX8yOy
         F8apAvprycNYSVzWMtOSd5//ta3alPs9D4tYpAbzUwDUNmWLwp0YqApyMpMkOrAyPvv1
         +YNwVGL5JERFuk1kH3L6WP9KOKWbBuFQAoPqCluf8biD/LgMvzwCYrVtTTk48WpFVy2o
         2Iqg==
X-Gm-Message-State: APjAAAX5RkVFgdaFfvANW2DDxNyGHO5McMo32B/0Og+j+oGoWX3ImFeY
        IpNBjXjW2QPHamCfsqp3ak0DyHuhO6jjn+6+V+PTyQ==
X-Google-Smtp-Source: APXvYqxynaYSurYk47xcjrOqbqAQBuVKxdYBSiGXLLrIBieS6FdrGnE361Q6RfBMXentbWd450Oxj+nrUALkwZBgnjc=
X-Received: by 2002:a6b:8d8f:: with SMTP id p137mr822567iod.53.1573765359791;
 Thu, 14 Nov 2019 13:02:39 -0800 (PST)
MIME-Version: 1.0
References: <20190710201244.25195-1-brijesh.singh@amd.com> <20190710201244.25195-6-brijesh.singh@amd.com>
In-Reply-To: <20190710201244.25195-6-brijesh.singh@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 14 Nov 2019 13:02:28 -0800
Message-ID: <CAMkAt6rwbq6XC_K64arBUmqsTzSWk7Zoazq-YcqLvjc-rmW8BA@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] KVM: SVM: Add KVM_SEV_RECEIVE_UPDATE_DATA command
To:     "Singh, Brijesh" <brijesh.singh@amd.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +       /* Check if we are crossing the page boundry */
> +       offset = params.guest_uaddr & (PAGE_SIZE - 1);
> +       if ((params.guest_len + offset > PAGE_SIZE))
> +               return -EINVAL;

Just curious spec only says that "System physical of the guest memory
region. Must be 16 B aligned with the C-bit set." and "Length of guest
memory region. Must be a multiple of 16 B and no more than 16 kB". Why
do we want to avoid crossing a page boundary?

Also is there an overflow concern in the conditional because
params.guest_len is not checked before this?

> +
> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       hdr = psp_copy_user_blob(params.hdr_uaddr, params.hdr_len);
> +       if (IS_ERR(hdr)) {
> +               ret = PTR_ERR(hdr);
> +               goto e_free;
> +       }
> +
