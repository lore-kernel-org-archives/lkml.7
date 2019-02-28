Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3254C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8312171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbfB1Hds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:33:48 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46728 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfB1Hdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:33:47 -0500
Received: by mail-ot1-f66.google.com with SMTP id c18so16774295otl.13;
        Wed, 27 Feb 2019 23:33:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2sOut2gTeCqv2k5ZCeFWMlqYNFLX+NTFC0xPO6pLSTo=;
        b=BnMIyMDQ/ISAQ1FwTiF4TzyoLuvvZuU3bc/cEpKI/pIMfOwY9yZJTQQSPnCG7/b1Dd
         PVBrY/AxYVUspHC5C3jGhhkYFuML0uUTmLocWN0zeoEhYyXVk0NTivJnjqR3BSTKKF3P
         HyjeKjYDnyah69We3G8xho5dG7vcGvuUQcTQ/Wnb8nyNRA8Qb+b3hZgBmDAZyzhH5kgs
         OEVMvOQyort67FO+j8Z9ZvojIxqX93l0wb25eFqfnS7y3KEwd3MqBXwMm4E2C+pGcM6W
         EH2I8ql3TxqwL6b1ynY52jkhP5iy7F/IRlULi+p7i1MlszUjltAG7FHA9kwxScDt2Jhj
         mCMQ==
X-Gm-Message-State: AHQUAuaD2/tbjbdtazaxYig3CmVJN2TeS7s7F487D2IjB0ImMeHb3klp
        xiHW0Gu/mHeV5J8eZf6BW8k3KgFfZnfuxFp/KN/V7Lc3
X-Google-Smtp-Source: AHgI3IaWkTdHjJFUbtFOG11qSjKzkKC1+eXrp1YzdjS/LpqUGVfCIztH8sWL+VM1mZhTsKHyaiOviJTjek/WXLSx+lQ=
X-Received: by 2002:a9d:67d2:: with SMTP id c18mr5002000otn.339.1551339226560;
 Wed, 27 Feb 2019 23:33:46 -0800 (PST)
MIME-Version: 1.0
References: <20190215163220.20041-1-paul.kocialkowski@bootlin.com>
 <387ed483-b205-beda-319d-6f2b8ea55601@gmail.com> <38f6708476e9beca4583ccc2a62e238a4981b735.camel@bootlin.com>
 <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com> <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
 <20190219172515.GC13075@lunn.ch> <f0020e39-7ace-e1e0-e629-b84d6f92b841@xilinx.com>
 <adbb183836e22dfc4558beaa818677c24bacf3a8.camel@bootlin.com>
 <9cb2f7a8-a8cf-ef80-d260-cc67c072b5c5@xilinx.com> <8bb813fb-102b-00c9-fb6f-a3e928965051@xilinx.com>
 <CAFcVECJPtc3VQjK4WLCz1Wc4nopXnsLTKXFFY1ZpecgC+_PhyA@mail.gmail.com>
In-Reply-To: <CAFcVECJPtc3VQjK4WLCz1Wc4nopXnsLTKXFFY1ZpecgC+_PhyA@mail.gmail.com>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Thu, 28 Feb 2019 13:03:35 +0530
Message-ID: <CAFcVECJ8G99XiqHpYYh=3Aj4Bt_2V4kfDdBmLQqpdo59BRjs-Q@mail.gmail.com>
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Feb 27, 2019 at 2:35 PM Harini Katakam <harinik@xilinx.com> wrote:
>
> Hi Andrew, Paul,
>
> On Wed, Feb 27, 2019 at 2:15 PM Michal Simek <michal.simek@xilinx.com> wrote:
> >
> > On 21. 02. 19 12:03, Michal Simek wrote:
> > > On 21. 02. 19 11:24, Paul Kocialkowski wrote:
> > >> Hi,
> > >>
> > >> On Wed, 2019-02-20 at 07:58 +0100, Michal Simek wrote:
> > >>> Hi,
> > >>>
> > >>> On 19. 02. 19 18:25, Andrew Lunn wrote:
<snip>
> > >> Understood. I think we need to start a discussion about how the general
> > >> design of this driver can be improved.
> > >>
> > >> In particular, I wonder if it could work better to make this driver a
> > >> PHY driver that just redirects all its ops to the actual PHY driver,
> > >> except for read_status where it should also add some code.
>
> Thanks, I'm looking into this option and also a way to expose the correct
> interface mode setting as you mentioned below. I'll get back before the
> end of the week. Please do let me know if you have any further suggestions.
>
This IP does not have a PHY identifier or status register that can be accessed
from the phy framework. We could discuss with our design team to add these
in the future. But that would take sometime and this version should be still be
supported. Also, if this IP has a PHY driver, then two phy drivers would have
to be probed which are connected in a serial manner and I believe I'll have to
update the framework to support that. Could you please let me know if you have
any inputs on this?
OR since this is just a bridge IP, is it acceptable to address the error cases?
-> Module loading/unloading
-> Spinlocks for protection
-> Correct phy mode information to the driver.
-> Any other concerns
I could do a respin of this patch after addressing Andrew's comments:
https://patchwork.kernel.org/patch/9290231/

Regards,
Harini
