Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A6AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2B220693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cfYw3vGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfCLPwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:52:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36018 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfCLPwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:52:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id r124so2152326pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kCeY8EfNcf3m/u9+AbfHhmbxZhu8wEhh5kmg/4MjREY=;
        b=cfYw3vGh3/pbSvCvvdbm4moJ7S0RRKtebTwoAZfGcmlzGVZoGTMnilBFttRXFAitWP
         t2ohR1fVZ/4OgN15kD2EHJFmJA13DA1HZeq9sE9uxCL2Hu6p8mgcBZ3Z0WVwZAF5s1qO
         wFnaWThFbDnHmNNZFN1E1rvHVhzk0oXrTfC3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kCeY8EfNcf3m/u9+AbfHhmbxZhu8wEhh5kmg/4MjREY=;
        b=G/YqZO6GGP+yENZihgrK/dmYbAhL2Gn3HPseYTQhjs08Be6C49ZdoxY7thJHGR4APR
         JIvy83CdZMIcYK9KaEvd862w35b2kkOMdIASR6+gy+GKCgPtQ16xXgPmDtiH5OobvEuQ
         cTBd/djRs3Nvh9d6K6ETJlCVXNnmVfqN39+Cg0HgfRNPQd4V364oVAKNujge8naDGvhA
         q8m91t2Zd0k7D4m5tHmmnBgGz7aBJ80BMxeYlTDN2e+15aM9VcjDcgkb42C+akRa1RjJ
         QifktndFq1RDROiOREcdBJdXyn7GcfgX2vk84J/df+lCyXzbpUrXIvinYOsiJrH5YKur
         iWiA==
X-Gm-Message-State: APjAAAVRugU3EFURyhFk40RVyJP+Y3Tgma/7RBemRKcO17gnJFW07iuC
        Tgt0lfI3oY7i1MoR+3VX73MNQPoVG44=
X-Google-Smtp-Source: APXvYqxO4GsR18qiIRJjLUhrVVCCfaCQIKYaTitwonLG6N1V7Evu/AvsfiZ9IrMQm7bDQ9xNnSAdGg==
X-Received: by 2002:a17:902:a5c6:: with SMTP id t6mr11191806plq.221.1552405963491;
        Tue, 12 Mar 2019 08:52:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f192sm24494872pfc.180.2019.03.12.08.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 08:52:42 -0700 (PDT)
Date:   Tue, 12 Mar 2019 08:52:41 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     rjliao@codeaurora.org
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Enable the ldisc for ROME for x86
 platforms.
Message-ID: <20190312155241.GB200579@google.com>
References: <20190307101722.25871-1-bgodavar@codeaurora.org>
 <20190307204224.GD138592@google.com>
 <6e0abe10b3ed44053e92ad6a21c75d93@codeaurora.org>
 <20190308185232.GB69116@google.com>
 <1042d21dde881e886541d32b8f0dff63@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1042d21dde881e886541d32b8f0dff63@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rocky,

On Tue, Mar 12, 2019 at 05:01:59PM +0800, rjliao@codeaurora.org wrote:
> 在 2019-03-09 02:52，Matthias Kaehlcke 写道：
> > On Fri, Mar 08, 2019 at 10:43:14AM +0530, Balakrishna Godavarthi wrote:
> > > Hi Matthias,
> > > 
> > > On 2019-03-08 02:12, Matthias Kaehlcke wrote:
> > > > Hi Balakrishna,
> > > >
> > > > On Thu, Mar 07, 2019 at 03:47:22PM +0530, Balakrishna Godavarthi wrote:
> > > > > When using btattach to setup Rome over ldisc we observed a crash
> > > > > in qca_setup as it will try to access the serdev which is not
> > > > > available in the ldisc proto. This patch will fix the crash by
> > > > > support both the ldisc and serdev way in the qca hci_uart driver.
> > > > >
> > > > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > >
> > > > Oh, I wasn't aware of the instantiation through ldisc and was actually
> > > > considering to *remove* some of the seemingly unnecessary serdev
> > > > checks.
> > > >
> > > > > ---
> > > > >  drivers/bluetooth/hci_qca.c | 47
> > > > > ++++++++++++++++++++++---------------
> > > > >  1 file changed, 28 insertions(+), 19 deletions(-)
> > > > >
> > > > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > > > index 237aea34b69f..0a5c98d46864 100644
> > > > > --- a/drivers/bluetooth/hci_qca.c
> > > > > +++ b/drivers/bluetooth/hci_qca.c
> > > > > @@ -963,7 +963,7 @@ static int qca_set_baudrate(struct hci_dev
> > > > > *hdev, uint8_t baudrate)
> > > > >  {
> > > > >  	struct hci_uart *hu = hci_get_drvdata(hdev);
> > > > >  	struct qca_data *qca = hu->priv;
> > > > > -	struct qca_serdev *qcadev;
> > > > > +	struct qca_serdev *qcadev = NULL;
> > > >
> > > > In many cases the only field that is accessed is qcadev->btsoc_type. I
> > > > think something like 'qca_get_soc_type(struct hci_dev *hdev / struct
> > > > hci_uart *hu)' would make things more readable.
> > > >
> > > [Bala]: sure will update this in other patch once this change is
> > > landed as
> > > this has to
> > >         go in priority as we have crash coming.
> > 
> > That's not how things should work, especially for fairly trivial
> > changes. It requires reviewers to first spent time to review the patch
> > that adds clutter and later spend more time to review the one that
> > removes it. It's also easier to get a clean patch merged in the first
> > place, rather than a noisy one.
> > 
> > Anyway, here is my take at it:
> > https://lore.kernel.org/patchwork/patch/1049014/
> > 
> > Please help with testing for ROME, unless you disagree with the
> > approach.
> > 
> > Thanks
> > 
> > Matthias
> 
> Hi Matthias,
> 
> I will test your patch and update to you, and you are correct that AR3002 is
> not part of Rome family, you should use QCA_ROME as the default return of
> qca_soc_type.

Thanks for the confirmation!

> Could you also loop me in
> https://lore.kernel.org/patchwork/patch/1049014/?

This patch has been superseded by a newer version:

https://lore.kernel.org/patchwork/patch/1049696/

It already landed in bluetooth-next.

Testing with Rome and ldisc would still be appreciated, since I don't
have such a configuration.

Thanks

Matthias
