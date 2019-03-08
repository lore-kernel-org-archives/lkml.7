Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417F5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1648820857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SuEboZJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfCHSwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:52:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37107 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfCHSwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:52:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id s22so14778717pfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zJ1s7QBmJPYQeio5yPNSS0BtdP9dcnIhV561/zFBAjc=;
        b=SuEboZJcKxlqU4fK5KSrbXuFADC3O2oSaNW1Mkowjxjtv3nGhqBUxnKIfGiei/sC/n
         Z4dBc+BOThmsc1meXoNLeSlxJ3um99yn0HdSmjB3pB4aMSuJojbgtc1lJV9ECk4t2PCz
         1k29sm2RMymvQUESe35oMDU5ty+cT0ucTJT9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zJ1s7QBmJPYQeio5yPNSS0BtdP9dcnIhV561/zFBAjc=;
        b=q3GY93e9uN+Wy1PmG18quxWZFzGVkmk5I3pPGA26nfHI8s4tqfmMsZN5fZTURcCGCF
         Rev0TSmuzQEM7opgXtKyFOBL694mwf3iw1kQVcVO0xKBtwugVuu+mHZizM4l5PCWHktk
         0nMC7MxvtViPbO4gpS0khiLlhmjL9fl3Ha6/cHI+gJB6htTrRXfJdoIg15va1MoKe3eA
         K2I9b5fEFqBnOo0sFcOThGTDRo6hO6siRJI/nEAZrfg/zDoHnlGo9A5Q/inwdcm8jhj3
         1oO3VjB70DyV+tPhe6M+XBRlBzOAo/aD0o2ylBHtI+Kz9l/H/MfB6pRhwpAQmmZ7Ye2J
         962A==
X-Gm-Message-State: APjAAAVRw/YssJRryXywTsK4/dnuCUAiFIjkNxzMUP+K64w2UD/hOlyG
        HlmZcv+nPf5op3gfAcxFDbXpjw==
X-Google-Smtp-Source: APXvYqx+JBE3cF7tbw5ZYeAmWTjvXZWUP1lHxgOCu0wf6hBui0Vq/eMt0E0/lcT9y6s3cpW2kxg0kA==
X-Received: by 2002:a17:902:20e3:: with SMTP id v32mr20295293plg.213.1552071153671;
        Fri, 08 Mar 2019 10:52:33 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id h10sm11654799pfo.128.2019.03.08.10.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 10:52:33 -0800 (PST)
Date:   Fri, 8 Mar 2019 10:52:32 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        rjliao@codeaurora.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Enable the ldisc for ROME for x86
 platforms.
Message-ID: <20190308185232.GB69116@google.com>
References: <20190307101722.25871-1-bgodavar@codeaurora.org>
 <20190307204224.GD138592@google.com>
 <6e0abe10b3ed44053e92ad6a21c75d93@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e0abe10b3ed44053e92ad6a21c75d93@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:43:14AM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2019-03-08 02:12, Matthias Kaehlcke wrote:
> > Hi Balakrishna,
> > 
> > On Thu, Mar 07, 2019 at 03:47:22PM +0530, Balakrishna Godavarthi wrote:
> > > When using btattach to setup Rome over ldisc we observed a crash
> > > in qca_setup as it will try to access the serdev which is not
> > > available in the ldisc proto. This patch will fix the crash by
> > > support both the ldisc and serdev way in the qca hci_uart driver.
> > > 
> > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > 
> > Oh, I wasn't aware of the instantiation through ldisc and was actually
> > considering to *remove* some of the seemingly unnecessary serdev
> > checks.
> > 
> > > ---
> > >  drivers/bluetooth/hci_qca.c | 47
> > > ++++++++++++++++++++++---------------
> > >  1 file changed, 28 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > index 237aea34b69f..0a5c98d46864 100644
> > > --- a/drivers/bluetooth/hci_qca.c
> > > +++ b/drivers/bluetooth/hci_qca.c
> > > @@ -963,7 +963,7 @@ static int qca_set_baudrate(struct hci_dev
> > > *hdev, uint8_t baudrate)
> > >  {
> > >  	struct hci_uart *hu = hci_get_drvdata(hdev);
> > >  	struct qca_data *qca = hu->priv;
> > > -	struct qca_serdev *qcadev;
> > > +	struct qca_serdev *qcadev = NULL;
> > 
> > In many cases the only field that is accessed is qcadev->btsoc_type. I
> > think something like 'qca_get_soc_type(struct hci_dev *hdev / struct
> > hci_uart *hu)' would make things more readable.
> > 
> [Bala]: sure will update this in other patch once this change is landed as
> this has to
>         go in priority as we have crash coming.

That's not how things should work, especially for fairly trivial
changes. It requires reviewers to first spent time to review the patch
that adds clutter and later spend more time to review the one that
removes it. It's also easier to get a clean patch merged in the first
place, rather than a noisy one.

Anyway, here is my take at it: https://lore.kernel.org/patchwork/patch/1049014/

Please help with testing for ROME, unless you disagree with the
approach.

Thanks

Matthias
