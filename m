Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD3DC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913D62085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SdRO1o4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfFTSlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:41:35 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36006 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfFTSle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:41:34 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so522710ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 11:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bnNSwv6vtlQWGp/eiIohBlhjTQOOeCXZtmIH40KDQI=;
        b=SdRO1o4Dv3uJylFNXAeVIYPkEvywun2pv/WsTGBkVrhdWiMDQaDvJkWuUBD3ptdZfo
         KHsZAqb/0VXSI+pg2lzg4DoyPEX18u70VhZS25BdeR5UV9c1UqqFsyl5R7qIvcx/Qhvh
         wrcSjmNaZwYvCxLetHHCHVQlBO5p+fbTWGsm2Uh48nze5wONwuRGz5gtqlNhU0Zz7R9y
         KMZ+pDKB90OZkvm+vrfE+j3F71NSQYYfTsvbMvJz7ajW410iXCVQ+8NOlZVRcYwEnnHm
         h9Nw4Dcv/WDBmISX0zrdhrlBoczoWjv22Ym1uwfB8UMT+U+Gccu05KZiCLzg1r4ZqPHv
         OjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bnNSwv6vtlQWGp/eiIohBlhjTQOOeCXZtmIH40KDQI=;
        b=cKANEQCc9vxdzhvxv/KpidRMGMfYfW6szVcVzeIqwPbScywdOV8LSPCl1LHZg2ftNF
         AP7hsnagguufcZjXCacDtdHjIl3VdGZrGOVvXCiTdylFGW1CWtgx+rjPq9R6pywlCN1U
         PbPbkoL0PVcZF7+ulUf7UAyIEUtlgq0fH6SB+K6L+sci1y4GHpR19T/lHWaHoxot8nhh
         addjGWYVODMaWEoW1/D3exnASPIOCrG9NXnEPVGWy+SMr9Xunc0W462tb5PI8Aaf+TRK
         2cw3Ws2wiWjFk9vY8VlejA5X3GVRlLL+Bh56n5/8pOel0frbOT9RUO/q5ZcomHdNgdIy
         8krQ==
X-Gm-Message-State: APjAAAULWXfSBj+B0lC2lD4lPOU+9Ut9D/DOChp0DMuLQqNXoBwkzkIA
        DklyRWrFo3j4OszTAdgnF/3Xt1P1Bo5Oniv7HP8JBQ==
X-Google-Smtp-Source: APXvYqxfGPRpdr5RB5w/4lIohLuEV2fFxQOtLYCVm+Two3E6fxDYIpOgEEnkOnjHIO6BGcdWZ8MyOKh7vcd+kfN6aO4=
X-Received: by 2002:a6b:f80b:: with SMTP id o11mr55413954ioh.40.1561056093467;
 Thu, 20 Jun 2019 11:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190620110240.25799-1-vkuznets@redhat.com> <20190620110240.25799-6-vkuznets@redhat.com>
In-Reply-To: <20190620110240.25799-6-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 20 Jun 2019 11:41:22 -0700
Message-ID: <CALMp9eQo3KW_qjW=8KPbJuggs-VOWsBgLjXYi1F6_1aoJ0kfsg@mail.gmail.com>
Subject: Re: [PATCH RFC 5/5] x86: KVM: svm: remove hardcoded instruction
 length from intercepts
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 4:02 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Various intercepts hard-code the respective instruction lengths to optimize
> skip_emulated_instruction(): when next_rip is pre-set we skip
> kvm_emulate_instruction(vcpu, EMULTYPE_SKIP). The optimization is, however,
> incorrect: different (redundant) prefixes could be used to enlarge the
> instruction. We can't really avoid decoding.
>
> svm->next_rip is not used when CPU supports 'nrips' (X86_FEATURE_NRIPS)
> feature: next RIP is provided in VMCB. The feature is not really new
> (Opteron G3s had it already) and the change should have zero affect.
>
> Remove manual svm->next_rip setting with hard-coded instruction lengths. The
> only case where we now use svm->next_rip is EXIT_IOIO: the instruction
> length is provided to us by hardware.
>
> Reported-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
