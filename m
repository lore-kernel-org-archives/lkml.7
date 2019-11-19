Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99761C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEEA222A2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRTq1aw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfKSPn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:43:58 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38981 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfKSPn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:43:58 -0500
Received: by mail-io1-f66.google.com with SMTP id k1so23720748ioj.6;
        Tue, 19 Nov 2019 07:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vuax9dttw4kzq0yvrDA3+EcDha5MuMEK6ksSvHGWZ/Y=;
        b=kRTq1aw2GWfg7mkmo+9GlcKsPuklqqbeI3d76GAGrD2aOQUq1qmhWrJQEtR8RfYsRl
         BJcrS09hXqvxZ+hMR7e/72HlvOCi9S+eFLP3lUWpxQQvqGtCPrmKkB1twHpgF6enlmeS
         fVMPok0aHher3UTkiDRlgTGhLjUllsV4Hblr7k/PpY9LLaPOrRnkbnH1SdU4uCMc3695
         h6oEshILJnc3DYvteQyD2CYayQyvNVMdqX0t4r5oztin4Tc4c8i416EDhZL2Q0tuHnfV
         8mlX+1VsAjYLzSRxoY/IPPbK5tAyS9laWIPjMGZQo6aktNur6dGAHIvt8OdYIjQD62te
         jAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vuax9dttw4kzq0yvrDA3+EcDha5MuMEK6ksSvHGWZ/Y=;
        b=Fv5mDURXuEwVTJQAgcDg2+Y2w7zxFqYWQVNP8gH4Uqf3QEhS469/XwvQ2E+bDWNiUa
         Z9LwZT7h8dZjlq5D7IQ11RYR+dfnlurKwncfGSQqKl997WMNtqgAyZKP1teA0ZAPwyff
         0iulYqKr5WBh8VPiSwRZsOVFd3dBEL6TDMAKVerxpNbnWk0dZApzDnqnI2u64DZQlZ8u
         hyj9HpusJpQGQ+F4FWafG9cUalIHMdjELj1CzWI6JxywCEdohSufVN2BBDwTwre8F9+b
         kP+84kqmkkN8A71TerNojzn/OgmdS3q42dGmJuGg7u4nYnq8ywIlS+Fgp5aaOzqDjWAA
         PKYA==
X-Gm-Message-State: APjAAAXiIQFys/VCtJBhvxNS4rKBFe6XDMRkVpGa30ngg24axKYnlAsE
        lJ7dkaIprdGIOyXNJntfsye+Oly8S9nQuiNoi6I=
X-Google-Smtp-Source: APXvYqwNN8997lQCnWgGxSSAMfdaYkKc0mXB6oB/kFWVziig45hb5F78tZi8QP2XCiupJKmfYeq1DwErN4K90db8QUc=
X-Received: by 2002:a5e:8a04:: with SMTP id d4mr6062052iok.42.1574178236758;
 Tue, 19 Nov 2019 07:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20191118214250.14002-1-sibis@codeaurora.org> <0101016e80782dd7-2617455b-7d73-4e68-8a9a-b63c29e9ad76-000000@us-west-2.amazonses.com>
 <CAOCk7Nou94bxk_48JArrXhQw2KR+3bKanLe+hb2=d7_j6y3VbQ@mail.gmail.com> <0101016e844504f1-d8bd27a5-c0bf-4b0b-8301-7bd8a890be80-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016e844504f1-d8bd27a5-c0bf-4b0b-8301-7bd8a890be80-000000@us-west-2.amazonses.com>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Tue, 19 Nov 2019 08:43:45 -0700
Message-ID: <CAOCk7NpVDNRxkPUTHbsG_WC4MrjU8_JcdgiuyYbb36RPTMrOWQ@mail.gmail.com>
Subject: Re: [PATCH 01/16] remoteproc: q6v5-mss: fixup MSM8998 MSS out of
 reset sequence
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mark Rutland <mark.rutland@arm.com>, p.zabel@pengutronix.de,
        MSM <linux-arm-msm@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 8:25 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Hey Jeff,
>
> On 11/19/19 3:24 AM, Jeffrey Hugo wrote:
> > On Mon, Nov 18, 2019 at 2:43 PM Sibi Sankar <sibis@codeaurora.org> wrote:
> >>
> >> Fixup the following in the MSS out of reset sequence on MSM8998:
> >> * skip ACC override on MSM8998.
> >> * wait for BHS_EN_REST_ACK to be set before setting the LDO to bypass.
> >> * remove "mem" clock from the active pool.
> >
> > Why any of this is necessary isn't explained.
>
> Honestly the above two fixes didn't seem to have any impact when I
> tested it on MSM8998 MTP just making sure that we allign with the
> out of reset sequence found on msm-4.4.

That should be mentioned in the commit text then.

>
> > Seems like it should be 3 separate patches.
> > Regarding the mem clock change, wouldn't it be an issue if we don't
> > vote for that?
>
> we already proxy vote for it though.

Ah, so we do.  That should be mentioned in the commit text.

>
> >
> >>
> >> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> >> ---
> >>   drivers/remoteproc/qcom_q6v5_mss.c | 23 ++++++++++++++++++++---
> >>   1 file changed, 20 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> >> index 471128a2e7239..2becf6dade936 100644
> >> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> >> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> >> @@ -100,6 +100,11 @@
> >>   #define QDSP6SS_XO_CBCR                0x0038
> >>   #define QDSP6SS_ACC_OVERRIDE_VAL               0x20
> >>
> >> +/* QDSP6v62 parameters */
> >> +#define QDSP6SS_BHS_EN_REST_ACK                BIT(0)
> >> +#define BHS_CHECK_MAX_LOOPS            200
> >> +#define QDSP6SS_BHS_STATUS             0x0C4
> >> +
> >>   /* QDSP6v65 parameters */
> >>   #define QDSP6SS_SLEEP                   0x3C
> >>   #define QDSP6SS_BOOT_CORE_START         0x400
> >> @@ -505,8 +510,9 @@ static int q6v5proc_reset(struct q6v5 *qproc)
> >>                  int mem_pwr_ctl;
> >>
> >>                  /* Override the ACC value if required */
> >> -               writel(QDSP6SS_ACC_OVERRIDE_VAL,
> >> -                      qproc->reg_base + QDSP6SS_STRAP_ACC);
> >> +               if (qproc->version == MSS_MSM8996)
> >> +                       writel(QDSP6SS_ACC_OVERRIDE_VAL,
> >> +                              qproc->reg_base + QDSP6SS_STRAP_ACC);
> >>
> >>                  /* Assert resets, stop core */
> >>                  val = readl(qproc->reg_base + QDSP6SS_RESET_REG);
> >> @@ -534,6 +540,18 @@ static int q6v5proc_reset(struct q6v5 *qproc)
> >>                  val |= readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
> >>                  udelay(1);
> >>
> >> +               /* wait for BHS_EN_REST_ACK to be set */
> >> +               if (qproc->version == MSS_MSM8998) {
> >> +                       ret = readl_poll_timeout(qproc->reg_base + QDSP6SS_BHS_STATUS,
> >> +                                                val, (val & QDSP6SS_BHS_EN_REST_ACK),
> >> +                                                1, BHS_CHECK_MAX_LOOPS);
> >> +                       if (ret) {
> >> +                               dev_err(qproc->dev,
> >> +                                       "QDSP6SS_BHS_EN_REST_ACK timedout\n");
> >> +                               return -ETIMEDOUT;
> >> +                       }
> >> +               }
> >> +
> >>                  /* Put LDO in bypass mode */
> >>                  val |= QDSP6v56_LDO_BYP;
> >>                  writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
> >> @@ -1594,7 +1612,6 @@ static const struct rproc_hexagon_res msm8998_mss = {
> >>          .active_clk_names = (char*[]){
> >>                          "iface",
> >>                          "bus",
> >> -                       "mem",
> >>                          "gpll0_mss",
> >>                          "mnoc_axi",
> >>                          "snoc_axi",
> >> --
> >> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> >> a Linux Foundation Collaborative Project
> >>
> >
>
> --
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
