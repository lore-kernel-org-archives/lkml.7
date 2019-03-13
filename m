Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1215C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C565E20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfCMUNM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:13:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41029 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfCMUNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:13:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id t7so2969673otk.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L6gmyEFlOHG4CkXi67ykOuLwFFs5zi3k3f8mGPiMx1w=;
        b=D01pWDlxYaLUJnR5vyA6GPcHcNbh1GCFGX+JzZy5LZIMfQahcIGICnPYn5wI9H3O70
         exI3a4c8zpBYiyLMfv7+xRcgnZAbePC22IA71Hga1EnVqSHu++g5dW4ObZvUmZ8kn2AE
         0oiQ7VtY+pdO7AZF38BEtUieFFu1nqTgtHmxvWozOxZpEm2t295pCiOIwGgoMn+lkMW0
         MM8lcmLmaTJjzuLsJcinDPfMiQ5u3bcGjtFdhMhkBXfjFs/3wbH9NJDr6rMkt17WE07R
         Sh6kPEwzA0X04rZHlrrOMM9AmKBQwqJfhVZid4Gf4uYB+b0MeYr6y54rW3j+rYVdeU6c
         CzeA==
X-Gm-Message-State: APjAAAXazrEG9qWZAAQn3prR6iG5JOUE2Q4qBia+cvdhc76ObOcoet+J
        pv3irReZk4cPU/a4Ig4MgqROoa1kCwicaT8NEeM65w==
X-Google-Smtp-Source: APXvYqwDDarbEXYPAC8J2SutbdlxKHrmfvedVgw51YdaAG3IhupTJ6Kn1B/I/B+Lassa7IUamDVvECvVuYyjFGGA9lU=
X-Received: by 2002:a05:6830:16cc:: with SMTP id l12mr29209028otr.58.1552507990675;
 Wed, 13 Mar 2019 13:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190312203140.31785-1-malat@debian.org> <607b412d-e5a2-5d08-7fb9-53a24e6c76d4@c-s.fr>
In-Reply-To: <607b412d-e5a2-5d08-7fb9-53a24e6c76d4@c-s.fr>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 13 Mar 2019 21:12:59 +0100
Message-ID: <CA+7wUszPviAFVjyU-=qAJfOpe_NxmimWd2-tc148NLUEc4Oj0w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Make some functions static
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:14 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 12/03/2019 à 21:31, Mathieu Malaterre a écrit :
> > In commit cb9e4d10c448 ("[POWERPC] Add support for 750CL Holly board")
> > new functions were added. Since these functions can be made static,
> > make it so. While doing so, it turns out that holly_power_off and
> > holly_halt are unused, so remove them.
>
> I would have said 'since these functions are only used in this C file,
> make them static'.
>
> I think this could be split in two patches:
> 1/ Remove unused functions, ie holly_halt() and holly_power_off().
> 2/ Make the other ones static.

Michael do you want two patches ?

> Christophe
>
> >
> > Silence the following warnings triggered using W=1:
> >
> >    arch/powerpc/platforms/embedded6xx/holly.c:47:5: error: no previous prototype for 'holly_exclude_device' [-Werror=missing-prototypes]
> >    arch/powerpc/platforms/embedded6xx/holly.c:190:6: error: no previous prototype for 'holly_show_cpuinfo' [-Werror=missing-prototypes]
> >    arch/powerpc/platforms/embedded6xx/holly.c:196:17: error: no previous prototype for 'holly_restart' [-Werror=missing-prototypes]
> >    arch/powerpc/platforms/embedded6xx/holly.c:236:6: error: no previous prototype for 'holly_power_off' [-Werror=missing-prototypes]
> >    arch/powerpc/platforms/embedded6xx/holly.c:243:6: error: no previous prototype for 'holly_halt' [-Werror=missing-prototypes]
> >
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > ---
> >   arch/powerpc/platforms/embedded6xx/holly.c | 19 ++++---------------
> >   1 file changed, 4 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
> > index 0409714e8070..829bf3697dc9 100644
> > --- a/arch/powerpc/platforms/embedded6xx/holly.c
> > +++ b/arch/powerpc/platforms/embedded6xx/holly.c
> > @@ -44,7 +44,8 @@
> >
> >   #define HOLLY_PCI_CFG_PHYS 0x7c000000
> >
> > -int holly_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
> > +static int holly_exclude_device(struct pci_controller *hose, u_char bus,
> > +                             u_char devfn)
> >   {
> >       if (bus == 0 && PCI_SLOT(devfn) == 0)
> >               return PCIBIOS_DEVICE_NOT_FOUND;
> > @@ -187,13 +188,13 @@ static void __init holly_init_IRQ(void)
> >       tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
> >   }
> >
> > -void holly_show_cpuinfo(struct seq_file *m)
> > +static void holly_show_cpuinfo(struct seq_file *m)
> >   {
> >       seq_printf(m, "vendor\t\t: IBM\n");
> >       seq_printf(m, "machine\t\t: PPC750 GX/CL\n");
> >   }
> >
> > -void __noreturn holly_restart(char *cmd)
> > +static void __noreturn holly_restart(char *cmd)
> >   {
> >       __be32 __iomem *ocn_bar1 = NULL;
> >       unsigned long bar;
> > @@ -233,18 +234,6 @@ void __noreturn holly_restart(char *cmd)
> >       for (;;) ;
> >   }
> >
> > -void holly_power_off(void)
> > -{
> > -     local_irq_disable();
> > -     /* No way to shut power off with software */
> > -     for (;;) ;
> > -}
> > -
> > -void holly_halt(void)
> > -{
> > -     holly_power_off();
> > -}
> > -
> >   /*
> >    * Called very early, device-tree isn't unflattened
> >    */
> >
