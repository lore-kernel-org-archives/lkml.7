Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B8AC31E42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EC72084B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xq/mB+cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfGKREt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:04:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42184 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfGKREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:04:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id v15so6511832eds.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKtFz5m3SJUoyJfannzFhRIi22aRe40IcnDLShyAIms=;
        b=Xq/mB+cljDpLj6RZErA+YWYh1tWZ0TFRNucp2cHzuiS2f1eND6fu+H2y045styTbIQ
         fEoozXGqxKJKa5WX2kcEOXu2M3EP4FduHJAFh1I93u6CxwVCJEAi12pZVflzW6KTLwRj
         Qs8x8zvsQxqW0il6sR9EBgUvAlY1JJhQbbs2nvH/PWwbFTRfrVR1iJklMeQFGu467CMm
         /mDjhB25cexBd5RbE23MesURCjRRpLf/czUryrZqZB7b4ndKDkRu4vgvvWsb9mCANWRJ
         usWAwGxjpqz3fzvuckYa/HDH/8A4RLcgCS4Mk1ZjSHFtw/GyicdVAs9HklwJOM6O/5RK
         jIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKtFz5m3SJUoyJfannzFhRIi22aRe40IcnDLShyAIms=;
        b=Hrkui+TdUX9hpuzBNzUAfRUHjh7/GVsbCcW9bNEo3HMWcXFB1M4w73BXaq6SwG1y99
         5GAB4mtya7cCaK9YDZENX5pHOURFk8l2Twq+SoS0bcN9dk5cpIb0vdz/Hxad1hAAAYpa
         I2g2zdE+HTprreaNIWcABJ19ldXty56pWP6/8ap46QGxg3dU1O4nSegZuySkoTJ88YN6
         kP69ESx/rS3dvfp17JzGMNTGQQlcJyBfeWifvBcpm0eOPkkQJ58QMV62ztGku3tSlFHf
         OLhAwH5+YCBb10MdAGUu+j2PqHGXVJmeyTWvPFfR9TvlxdEBQWLakR9fdujxkProeaMw
         zjRA==
X-Gm-Message-State: APjAAAVGOizxlQPbwM66AG+g3uXvIEaGxtdJiAuv5+wRFW6Mp0TOUEvG
        hhXq/ejWcmUjh5ltLJhK6hsjV8Gq5TsNNqkzofPv1A==
X-Google-Smtp-Source: APXvYqxYzE6AJdtimx3a2ee2fT+IYR4+blay3RGcsdDJWNPR7KKVyMnhBzG7emI231/T9nrCuC3b9cIey5cO58MJDd4=
X-Received: by 2002:a50:a511:: with SMTP id y17mr4619439edb.259.1562864687272;
 Thu, 11 Jul 2019 10:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAOyeoRUUK+T_71J=+zcToyL93LkpARpsuWSfZS7jbJq=wd1rQg@mail.gmail.com>
 <21fd772c-2267-2122-c878-f80185d8ca86@redhat.com>
In-Reply-To: <21fd772c-2267-2122-c878-f80185d8ca86@redhat.com>
From:   Eric Hankland <ehankland@google.com>
Date:   Thu, 11 Jul 2019 10:04:36 -0700
Message-ID: <CAOyeoRVrXjdywi-00ZafkVtEb_x6f5ZEmdMqq6v67XMedv_LKQ@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: PMU Event Filter
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wei Wang <wei.w.wang@intel.com>, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your help. The "type"->"action" change and constant
renaming sound good to me.

On Thu, Jul 11, 2019 at 4:58 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 11/07/19 03:25, Eric Hankland wrote:
> > - Add a VM ioctl that can control which events the guest can monitor.
>
> ... and finally:
>
> - the patch whitespace is damaged
>
> - the filter is leaked when the VM is destroyed
>
> - kmalloc(GFP_KERNEL_ACCOUNT) is preferrable to vmalloc because it
> accounts memory to the VM correctly.
>
> Since this is your first submission, I have fixed up everything.
>
> Paolo
