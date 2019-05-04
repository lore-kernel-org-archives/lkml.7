Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA373C04AAA
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 11:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95D320675
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 11:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riV8JEoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfEDLBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 07:01:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38409 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfEDLBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 07:01:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id v1so6103133lfg.5;
        Sat, 04 May 2019 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ATLiVoBxxhEOS8NvRMpVfm5vp0+xIW6FH1duvNVR9Kc=;
        b=riV8JEozmHsz1uD5VmVavAtEwwNzMYJxpNxhpAg1JpSnZp7niXJBdOEsWf4OWCpTQ1
         SwL3TzEzZWyTlMj1uDlrhWadFFJvEHLVyJu5L10G4RKgkHmTOO5iOrZpT1+7rIKetI/1
         pVvjivPdighZuIA6hmDPkrD7zI0Fb/rly2K2h439HKSZrKfDk4XwIM4p6buyEIlp11ou
         FMfG4Plm5VhQA1Tgui1k6EvqOfuAJstYZQnc1xynM/W2hRWnv4bgCjIANw1kFRg9s9vI
         VM3QeMg5cM+U6uGUIGjRXxG2uz58tZSSoNVm2kXiqJ8cGgIl1UehspMRyRTIedw3JMHf
         rWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ATLiVoBxxhEOS8NvRMpVfm5vp0+xIW6FH1duvNVR9Kc=;
        b=cMUyrvG69LShemS+qQYi7o6dK/qu4gQOShYQ7K+WZU/+PqKbqyHr96R49lFXNb10PF
         +YV9gAKsfxl+IkniQx0OADzQlH0V4rEiOd7WLJDbMCKMr4C9+zXEn5/ErqUaf/cC7TAg
         dJWXdjm/q+UybJNSHOhACMiNa3/YWHlCDe2Aaae0cbbshf6aVSUJx+dY4UzgM9Cx2Dil
         XwigJL7zbFAXr2GBFWDVl3Jkgizj/v3MaCxHCw37Yo6dF2eEl8nFFrN7yGuYJwNwaYGG
         jMUp2C2MKdWi+vpet5cqV3xmNpTqGSY2V9jal4+EhC/R1YAzNIgvKaPS6ec04sidfALP
         48Qg==
X-Gm-Message-State: APjAAAVOmvhX9Ggv1A+KZLhx3qXT1AtFMeMnXcgavKYGrLlUJFQPgXjc
        RD20ryIiMF2LGUqZ16XVW496g1wYhPwe1Afaa2M=
X-Google-Smtp-Source: APXvYqzH5Ak7RQ55w0jmSuQwoqPOIw9XWF1XR9OwgNlmv9dSRHmaVwCW1d/wpdTvIu9yqSxaHmFDH+iPeFVnzosIBnU=
X-Received: by 2002:a19:c7c3:: with SMTP id x186mr8350944lff.107.1556967690885;
 Sat, 04 May 2019 04:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <1556190810-19690-1-git-send-email-liuk@cetca.net.cn>
In-Reply-To: <1556190810-19690-1-git-send-email-liuk@cetca.net.cn>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 4 May 2019 08:01:30 -0300
Message-ID: <CAOMZO5AM-Ee_8ScFEk3hSrujKqH2+XiLHPto3ES3r9AbDkUnkg@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] clk: imx6sx: Remove unexisting IMX6SX_CLK_ENET_AHB clock
To:     Kay-Liu <liuk@cetca.net.cn>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Yongcai Huang <Anson.Huang@nxp.com>,
        Rob Herring <robh@kernel.org>,
        root <root@localhost.localdomain>, tiny.windzz@gmail.com,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kay-Liu,

On Thu, Apr 25, 2019 at 8:14 AM <liuk@cetca.net.cn> wrote:
>
> From: Kay-Liu <liuk@cetca.net.cn>
>
> The imx6sx's dts file defines five clocks for fec, the
> 'ahb'clock's value is IMX6SX_CLK_ENET_AHB, but in the
> i.MX6SX Reference Manual there is no such enet ahb clock,
> there is only one "enet clock" in the CCM_CCGR3 register
> which is controlled by bits 5-4, the enet clock is defined
> for the 'ipg' clock, this can cause problem.
> The original phenomenon is using imx6-solox processor and
> Marvel 88E6390 switch with linux OS, the kernel will hang
> during the startup of the linux OS.
> After analyzing the phenomenon, the reason of CPU hang is
> read/write enet module's register when the enet clock
> is disabled. The kernel code try to avoids the problem
> by resume enet clock before read/write enet register.
> But the enet module's clock config will cause a special
> environment which can bypass the clock resume mechanism.
> The CPU has only one enet clock, after kernel parses
> the dts file, the two clock variables 'ipg' and 'ahb'
> finnaly point to the same enet clock register. This will
> cause enet clock be disabled after fec probe over.
> Because the power saving module will affect the BUG, so
> there are two situations for this problem:
> 1)Turn off power saving
> Turn off power saving means that the resume mechanism is
> disabled, so after fec probe over if any one read/write
> enet module's register, the CPU will hang because no one
> could resume the enet clock.
> 2)Turn on power saving
> Turn on power saving could resume enet clock before
> read/write enet register by enable 'ipg' clk, this will
> cause 'ahb' variable state and enet clock register value
> don't match.If any task read/write enet at a high
> frequently, the kernel will keep resume state and never
> enter suspend process, this means that the kernel will
> only modifies the register value during the first resume.
> But the kernel init will check unused clock variable in
> the late initcall, the 'ahb' clock will be treated as
> unused, at this time, the enet clock will be disabled
> bypass the resume mechanism, then the next read/write
> enet module's register will cause the CPU hang.
> Proposed solution is delete the 'ahb' clock's definition
> in the clk-imx6sx.c, and modify fec device=E2=80=99s clocks in
> the dts file, point =E2=80=98ahb=E2=80=99 from IMX6SX_CLK_ENET_AHB to
> IMX6SX_CLK_ENET
>
> Signed-off-by: Kay-Liu <liuk@cetca.net.cn>

This matches the mx6sx reference manual:

Reviewed-by: Fabio Estevam <festtevam@gmail.com>
