Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD49C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 03:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3B020640
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 03:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405838AbfIWDVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 23:21:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:16502 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404102AbfIWDVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 23:21:04 -0400
X-UUID: 5bbca55a9982475e99c481f9372dab08-20190923
X-UUID: 5bbca55a9982475e99c481f9372dab08-20190923
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1964829612; Mon, 23 Sep 2019 11:20:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 23 Sep 2019 11:20:56 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 23 Sep 2019 11:20:56 +0800
Message-ID: <1569208857.4102.9.camel@mtksdccf07>
Subject: Re: [PATCH v9 07/11] dt-bindings: pwm: pwm-mediatek: add a property
 "num-pwms"
From:   Sam Shih <sam.shih@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, <linux-pwm@vger.kernel.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "John Crispin" <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Mon, 23 Sep 2019 11:20:57 +0800
In-Reply-To: <20190921002149.GB86019@mithrandir>
References: <1568933351-8584-1-git-send-email-sam.shih@mediatek.com>
         <1568933351-8584-8-git-send-email-sam.shih@mediatek.com>
         <20190921002149.GB86019@mithrandir>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5DE12F5DF2358BA2912DCBFA7D76065A5D51D8AAC23E3281B45386E5691BB84D2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-09-21 at 02:21 +0200, Thierry Reding wrote:
> On Fri, Sep 20, 2019 at 06:49:07AM +0800, Sam Shih wrote:
> > From: Ryder Lee <ryder.lee@mediatek.com>
> > 
> > This adds a property "num-pwms" in example so that we could
> > specify the number of PWM channels via device tree.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> > Changes since v6:
> > Follow reviewers's comments:
> > - The subject should indicate this is for Mediatek
> > 
> > Changes since v5:
> > - Add an Acked-by tag
> > - This file is original v4 patch 5/10
> > (https://patchwork.kernel.org/patch/11102577/)
> > 
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> You failed to address Rob's questions repeatedly and I agree with him
> that you can just as easily derive the number of PWMs from the specific
> compatible string. I won't be applying this and none of the patches that
> depend on it.
> 

Hi, 

Thanks for getting back to me.

New pwm driver (patch 04/11 : "pwm: mediatek: allocate the clks array
dynamically") can support different variants with different number of
PWMs by the new property <num-pwms>

For example:
1. Use "num-pwms" = <2> and assign clocks pwm1, pwm2 for mt7622
2. Use "num-pwms" = <6> and assign clocks pwm1, pwm2, pwm3, pwm4, pwm5,
pwm6 for mt7622.

If we just as easily derive the number of PWMs from the specific
compatible string in this document:

   - "pwm1-6": the six per PWM clocks for mt7622
   
This looks like all "pwm1", "pwm2", "pwm3", "pwm4", "pwm5", "pwm6" is
required property in DT, It doesn't make sense.
   
So we removed those descriptions and added  

   - "pwm1-N": the PWM clocks for each channel 
   
   
But the max number of clocks from the compatible string are still
important information that should be provide in this document.


What do you think of this?

   - "pwm1-N": per PWM clocks for mt2712, the max number of PWM channels
is 8

   - "pwm1-N": per PWM clocks for mt7622, the max number of PWM channels
is 6

   - "pwm1-N": per PWM clocks for mt7623, the max number of PWM channels
is 5

   where N starting from 1 to the maximum number of PWM channels
   - num-pwms: the number of PWM channels.

   
Thanks
Best Regards
Sam 

