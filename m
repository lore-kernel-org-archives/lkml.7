Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02875C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F3F23403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmaluovg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfH2OWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:22:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34011 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfH2OWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:22:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id z21so2704715lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZ9gxoV4mr1pi6Ly1BjKDE84gbCclEjPLCjdMs2YNBw=;
        b=Tmaluovgbuehsmnbd5AjWhFUMXYmgo/wPp8c9goG13gWLaT/qmIgmDE1aQUFqJG1x4
         iZBXGV7RiurmiwLAQ+E1CMBrW1Lfzaz4wAaYxjeTJbGQRdUytBs94xmNvMPsdm6Qe9LM
         qUzPqQLPVEYsmNh9qOkhEThnrgOKGs9PN4qlmtYCREzHjYD5h6RsOR6JG6o89CQa8XOV
         Y7U+Td+YmqP1l9PNhSHF+RQds/0ijbCG9/GiB7iwUydWVDArRoexlcJcInKWhBvTkFhz
         kZNLCUFNslSOQAhcrby7m525RTPCjSMpoNdXdG+7slMCt4qgr4KInVHqV0PJtOrn/bRL
         w5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZ9gxoV4mr1pi6Ly1BjKDE84gbCclEjPLCjdMs2YNBw=;
        b=Z8Pil+Iv+3rU7HM9FfQDgPssHfiofabuetkcXXjXykjl4GzW9skf3ebAsK+86UjeMz
         1oDCnfwsmar5zI4LSnbyYaIuFqq4xDQKymyXWHCHQve3tbQ3OA3UVpvL2hx3pKrPN0u5
         py07I4o1t4bphUsDMxf+droB2PXk1sAcwB0PNSIGOMfrZ0N0YUkhSQ7vxjWkOQPfDsLF
         A3uyDeV+4jzN8lPg/WZ/NOmNdm6uYiTvnOJSNq3RaDquCVptmJFQC9PVnp5YoFxy2szA
         tPyttMUo+k8ksqMsUnjndHSR3VC709xB+qmm6DZJs3kseuyixTY2stQegL1C+sAIFFLX
         I69A==
X-Gm-Message-State: APjAAAVcIxdhGoiayqsCU+LD0osz3+UwRdYwKxISYU6xp1bK/8uMkubc
        B/ZBJosvHo+Dsj0/rhK3A22GoMMA3BwNz+OEAvdRiWvp
X-Google-Smtp-Source: APXvYqy+hhzK4U5bgwmL3VErChiqOPTa5u80HCsXmI6xesXDwKzjN/AiiIjI+yhMpjyc7BLdgdN1947yt7vbpKgxa5I=
X-Received: by 2002:a19:428f:: with SMTP id p137mr6519522lfa.149.1567088536577;
 Thu, 29 Aug 2019 07:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com>
 <20190828225535.49592-11-ndesaulniers@google.com> <CANiq72mQihii6xaP1pBfyDin3wZOOuMdh9PGAKbmuAPovhV7gQ@mail.gmail.com>
In-Reply-To: <CANiq72mQihii6xaP1pBfyDin3wZOOuMdh9PGAKbmuAPovhV7gQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 29 Aug 2019 16:22:05 +0200
Message-ID: <CANiq72mTMdwXKBOEvfqA_KzuTjwnsHQ4rNdNczAXeX_5nzYo4g@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] x86: prefer __section from compiler_attributes.h
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>, Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        David Miller <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 4:14 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Aug 29, 2019 at 12:56 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > diff --git a/arch/x86/include/asm/iommu_table.h b/arch/x86/include/asm/iommu_table.h
> > index 1fb3fd1a83c2..7d190710eb92 100644
> > --- a/arch/x86/include/asm/iommu_table.h
> > +++ b/arch/x86/include/asm/iommu_table.h
> > @@ -50,9 +50,8 @@ struct iommu_table_entry {
> >
> >  #define __IOMMU_INIT(_detect, _depend, _early_init, _late_init, _finish)\
> >         static const struct iommu_table_entry                           \
> > -               __iommu_entry_##_detect __used                          \
> > -       __attribute__ ((unused, __section__(".iommu_table"),            \
> > -                       aligned((sizeof(void *)))))     \
> > +               __iommu_entry_##_detect __used __section(.iommu_table)  \
> > +               __aligned((sizeof(void *)))                             \
> >         = {_detect, _depend, _early_init, _late_init,                   \
> >            _finish ? IOMMU_FINISH_IF_DETECTED : 0}
> >  /*
>
> I see other patches that reduce unused -> to __unused, but is this

s/unused/other attrs like aligned and print/

Cheers,
Miguel
