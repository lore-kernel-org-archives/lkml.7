Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2775EC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2DD21D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="e6sF7fFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLTHlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:41:35 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:18595 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbfLTHlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:41:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576827694; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=60I1GO1QqfeFIjALPIIJlkirFBOU9o4iPlRijCDNvvU=;
 b=e6sF7fFaDeRdpsrfGG3BDwKBdfHU+7VeF59FwAVC5kGkPhwIDpnfsigQ7Sr+vCe54mlbVv/n
 OyQ3ezVzYp+88c2r+++PKI3fOgtJWyT3sRkvylonnxvhHh+q24v/mw5bm032ceYAJqT7eBjS
 TxEvEIztgcstDW2LHmEtL+05ElQ=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfc7b2b.7f3b3c1a90d8-smtp-out-n03;
 Fri, 20 Dec 2019 07:41:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4E457C4479D; Fri, 20 Dec 2019 07:41:31 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75C60C43383;
        Fri, 20 Dec 2019 07:41:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Dec 2019 15:41:30 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Asutosh Das <asutoshd@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] phy: qcom-qmp: Add optional SW reset
In-Reply-To: <20191220071015.GF2536@vkoul-mobl>
References: <20191219150433.2785427-1-vkoul@kernel.org>
 <20191219150433.2785427-4-vkoul@kernel.org>
 <ff83ac1f0ec6bca1379e8b873fd30aa2@codeaurora.org>
 <9ef99dcac59dbdc59c7e5eb1a8724ea2@codeaurora.org>
 <20191220042427.GE2536@vkoul-mobl>
 <e55185eda9d7dcbce80a671e630449ea@codeaurora.org>
 <20191220071015.GF2536@vkoul-mobl>
Message-ID: <b54f1f3a8938587b85aec74f7094006d@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-20 15:10, Vinod Koul wrote:
> On 20-12-19, 14:00, Can Guo wrote:
>> On 2019-12-20 12:24, Vinod Koul wrote:
>> > On 20-12-19, 08:49, cang@codeaurora.org wrote:
>> > > On 2019-12-20 08:22, cang@codeaurora.org wrote:
>> > > > On 2019-12-19 23:04, Vinod Koul wrote:
>> > > >
>> > > > >  	/* start SerDes and Phy-Coding-Sublayer */
>> > > > >  	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
>> > >
>> > > I thought your change would be like this
>> > >
>> > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c
>> > > b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> > > index 8e642a6..a4ab4b7 100755
>> > > --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
>> > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> > > @@ -166,6 +166,7 @@ static const unsigned int
>> > > sdm845_ufsphy_regs_layout[] =
>> > > {
>> > >  };
>> > >
>> > >  static const unsigned int sm8150_ufsphy_regs_layout[] = {
>> > > +       [QPHY_SW_RESET]                 = 0x08,
>> > >         [QPHY_START_CTRL]               = 0x00,
>> > >         [QPHY_PCS_READY_STATUS]         = 0x180,
>> > >  };
>> > > @@ -1390,7 +1391,6 @@ static const struct qmp_phy_cfg
>> > > sm8150_ufsphy_cfg = {
>> > >         .pwrdn_ctrl             = SW_PWRDN,
>> > >
>> > >         .is_dual_lane_phy       = true,
>> > > -       .no_pcs_sw_reset        = true,
>> > >  };
>> > >
>> > >  static void qcom_qmp_phy_configure(void __iomem *base,
>> > > @@ -1475,6 +1475,9 @@ static int qcom_qmp_phy_com_init(struct
>> > > qmp_phy *qphy)
>> > >                              SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
>> > >         }
>> > >
>> > > +       if ((cfg->type == PHY_TYPE_UFS) && (!cfg->no_pcs_sw_reset))
>> > > +               qphy_setbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>> >
>> > Well am not sure if no_pcs_sw_reset would do this and side effect on
>> > other phys (somehow older ones dont seem to need this). That was the
>> > reason for a new flag and to be used for specific instances
>> >
>> > Thanks
>> 
>> Hi Vinod,
>> 
>> That is why I added the check as cfg->type == PHY_TYPE_UFS, meaning 
>> this
>> change will only apply to UFS.
>> FYI, start from 8150(include 8150), QPHY_SW_RESET is present in PHY's
>> PCS register. no_pcs_sw_reset = TRUE should only be given to 845 and 
>> older
>> targets, like 8998, because they don't have this QPHY_SW_RESET in 
>> PHY's
>> register per their design, that's why they leverage the reset control
>> provided by UFS controller.
> 
> I have removed no_pcs_sw_reset and tested.
> 
> Well as you said even with UFS we have variations between various 
> chips,
> so I thought leaving it separate might be better than creating a chance
> of regression on older platforms!
> 
> Moreover, are we sure that the reset wont be there for other qmp phy's
> in future other than UFS...
> 
> Thanks

Hi Vinod

We are just removing the no_pcs_sw_reset for 8150, right? Why is it
possibly impacting 845 or older paltforms?

In future, we will no longer need no_pcs_sw_reset for any newer QCOM UFS
PHY designs, as it is only for 845 and older platforms.

I am sure QPHY_SW_RESET will be within PHY's address space since 8150.
Otherwise, it will be a regression in UFS PHY design. We had a lot of
discussion about this on 845 years ago, then design team decided to add
it on later platforms, so I don't see a reason to remove it again. :)

I am not sure about the other qmp phys, but so long as UFS PHY needs the
reset, we need to keep it, as phy-qcom-qmp.c is a common driver. I am
not sure if I get your point here. Please correct me I am wrong.

Thanks,

Can Guo.
