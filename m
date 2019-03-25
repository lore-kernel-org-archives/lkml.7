Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9971A2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3FKXW+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbfCYSGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:06:01 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34158 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYSGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:06:00 -0400
Received: by mail-it1-f196.google.com with SMTP id l4so605589ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hqPBitboFBMDhwQZl8TMLcDe8/MC76lnhaBMak8C8A=;
        b=v3FKXW+lAAclJn5qW6FcwJGdAURaaipmZB4GG/uMlsiYNRBcT1mHbe+uvAmzt677+q
         WtwRH/REPw8gDg6ajEjseigHpbBmUV5fA/omVuk47x4Klbiou2IUFNfb4xMTMdNxwHl8
         ydCjXUHsDRtctkPhDgnwm+88r9m3yUokjlkHg3LB63zbwtr0U/gW+vFATX7wlkNjNexE
         LNM04lvIlmRuVYDYFn+SEn1drsMiW0SIHYZzt00Iw+NC2lVjUXHliy7ZvEx0CMcrfZeH
         /AjOkdM6gydhDIz63eCSf5gHaNJgD3RVsDsQ96AYEt9xxL3EFMBUS5/j9vDwETZWCRtF
         oO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hqPBitboFBMDhwQZl8TMLcDe8/MC76lnhaBMak8C8A=;
        b=lhDaX5hv11TNvf2vModT3KI266li8urJ+F0pIdy+3dHAJ/hId46PhowAb3dSv6xRlj
         culm/EdKVhnZKOzYuPLChv/V+2+b3AEHknRDqTyA8lEyyeBev5bzHNLAnuN/DFx5ntQr
         +3mGP1/7HSggvdqOSy5jBQ3q0Oc0k9+QS8dqcX3JYCeTnb/D5d4Al9uHrdoRoqQ7a2nK
         fc8SNQ4K/ZAplUUtVvlh5hy14L3RHb1eniNxBqsxPlfj5w/s+XkZxhcTyIawETw7R/XU
         a3rsTaR842OmmOWI+qLNrSawOq5oDw7Yz2Pb+bAyyh4uD6J5POWA5dwODnvZbkUakS0X
         MxvQ==
X-Gm-Message-State: APjAAAVnXl0TW76+D05EnTbmbYsQ9DjWqB+SNQcTEwRsJU0hhKGPv7uq
        LMcKgj+0vIjVGNatx4RArS7VbYvZKa1mVhz/gKa6UQ==
X-Google-Smtp-Source: APXvYqy2RzURUmTGOt7zWUc0tt4leBae7kP+fYLG6W5Uy5x0FtfG2kUxfrm1ZnmAsrFWlOiaO2zMRA3EgaiboOB76ZI=
X-Received: by 2002:a05:660c:b44:: with SMTP id m4mr11336397itl.132.1553537159682;
 Mon, 25 Mar 2019 11:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190325171649.7311-1-bp@alien8.de> <20190325171649.7311-2-bp@alien8.de>
In-Reply-To: <20190325171649.7311-2-bp@alien8.de>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 25 Mar 2019 11:05:48 -0700
Message-ID: <CALMp9eTX5x9vchMje6J-Fji6jGfHnz=sPVmSKwO-3zdChAZz=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] kvm/x86: Move MSR_K7_HWCR to svm.c
To:     Borislav Petkov <bp@alien8.de>
Cc:     KVM <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:17 AM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> This is an AMD-specific MSR. Put it where it belongs.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/kvm/svm.c | 14 ++++++++++++++
>  arch/x86/kvm/x86.c | 12 ------------
>  2 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index b5b128a0a051..00eb44a2a377 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -4201,6 +4201,9 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>         case MSR_F10H_DECFG:
>                 msr_info->data = svm->msr_decfg;
>                 break;
> +       case MSR_K7_HWCR:
> +               msr_info->data = 0;
> +               break;

If the guest has written a non-zero value to this MSR, shouldn't it be
able to read that value back?
