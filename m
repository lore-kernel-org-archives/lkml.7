Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6293BC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365F1206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agDss8fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfHSSai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:30:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34371 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfHSSah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:30:37 -0400
Received: by mail-io1-f68.google.com with SMTP id s21so6488235ioa.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 11:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXEsTOBJnzR8V+Y9Uq0cMUIxlbNrOE1nK5VfshXw+oA=;
        b=agDss8fdWoE+/7dTtIvtt0v7iNwRZWwbhMX87eSnL3GvmSPNS9dcVy/RSOPqbemdkD
         Nf/MeqE3RdJUnGIi2gBGTeJViK3jXdlvBDlxNQPiirLBC57rvTQkMDtjz6ZCI6UFNciQ
         0sAo97GIZ1uK6GDzq5qTNpPLLwzvDcY/TsYkLfnb3pVdMs2xyGznufaWf91YAZal84tS
         X63WQUez/ijOstMdliJfpmuI4vmpgNeqrCQvl0ITMlGxvQvM/BYn60hdI6VK5O+7xEg3
         7ryw2nlY+NPPCGQMJrAN2w+FWmQ446AkNy/QaF4QZgRpNW/4i3Ns2In77KUMs+PlLm8+
         jo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXEsTOBJnzR8V+Y9Uq0cMUIxlbNrOE1nK5VfshXw+oA=;
        b=T1NW8GhN/if+JWD7wOKiAueEg+9yONtxrrL1bJK2dzJxI/yvvxRqpGYytR1hqplz3m
         cm18yyL+V5UqNjpMR/YqanGZyyGNIdDAy52/DvaSy18ov/aiF7JCtPysJ4Mkm6qv3XNk
         WK49W1gTNaD1KvV6Ye5XS3K4oj0n7yG9HxJEwNX37LlDlzk1uDArAjmUAt2ljkzfnjpk
         9RE07uMMLZU/zwr3+wI8TJeEcohmRajnVPYFM7AY2eYAmTwOcnUQ6Y5cOdB1aWRo5BPl
         aouZlcGtliqflDYtYHWlHpkYYDbfDIvQwLFBMpa6UlU0o+k8cj0YCrnjWpbaQIeohCp6
         pQ9Q==
X-Gm-Message-State: APjAAAU9UZr3kcG4YZuzmvyo1ssW2kzl+v7VJEvtjyHuzqRMZvzpbrXp
        1QJ2ioVOfvERZn8aapfsqVMG7Mt6QMDr696en7xQag==
X-Google-Smtp-Source: APXvYqx1QYR7L9bAE7CbApiSe8V70bIgNZHt/NR58+gfJ9Vsp7y97IhF6AI4P/vWhRBRCH30OMWGlCIzp2yZWfx97Xo=
X-Received: by 2002:a02:8794:: with SMTP id t20mr7728050jai.24.1566239436695;
 Mon, 19 Aug 2019 11:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <1565854883-27019-1-git-send-email-pbonzini@redhat.com>
 <1565854883-27019-2-git-send-email-pbonzini@redhat.com> <CALMp9eQcRbMjQ_=jQ=qaYmh1Lavc3PYvm4Qcf3zY+N8j3zZe-w@mail.gmail.com>
 <0e29f624-10f5-7ab5-1823-280f32732b68@redhat.com>
In-Reply-To: <0e29f624-10f5-7ab5-1823-280f32732b68@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 19 Aug 2019 11:30:25 -0700
Message-ID: <CALMp9eT2uo+_tbV=Z3-pyzjU76kaEU-BNvVriEHU6yGMsiy5Dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86: fix reporting of AMD speculation bug CPUID leaf
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 8:18 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 16/08/19 23:45, Jim Mattson wrote:
> > On Thu, Aug 15, 2019 at 12:41 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> The AMD_* bits have to be set from the vendor-independent
> >> feature and bug flags, because KVM_GET_SUPPORTED_CPUID does not care
> >> about the vendor and they should be set on Intel processors as well.
> >> On top of this, SSBD, STIBP and AMD_SSB_NO bit were not set, and
> >> VIRT_SSBD does not have to be added manually because it is a
> >> cpufeature that comes directly from the host's CPUID bit.
> >>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >
> > On AMD systems, aren't AMD_SSBD, AMD_STIBP, and AMD_SSB_NO set by
> > inheritance from the host:
> >
> > /* cpuid 0x80000008.ebx */
> > const u32 kvm_cpuid_8000_0008_ebx_x86_features =
> >         F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
> >         F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON);
> >
> > I am curious why the cross-vendor settings go only one way. For
> > example, you set AMD_STIBP on Intel processors that have STIBP, but
> > you do not set INTEL_STIBP on AMD processors that have STIBP?
> > Similarly, you set AMD_SSB_NO for Intel processors that are immune to
> > SSB, but you do not set IA32_ARCH_CAPABILITIES.SSB_NO for AMD
> > processors that are immune to SSB?
> >
> > Perhaps there is another patch coming for reporting Intel bits on AMD?
>
> I wasn't going to work on it but yes, they should be.  This patch just
> fixed what was half-implemented.

I'm not sure that the original intent was to enumerate the AMD
features on Intel hosts, but it seems reasonable to do so.

Should we also populate the AMD cache topology leaf (0x8000001d) on
Intel hosts? And so on? :-)

Reviewed-by: Jim Mattson <jmattson@google.com>
