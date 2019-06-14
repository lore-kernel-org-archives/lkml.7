Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51E6C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB2A2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MPl9AGMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfFNQix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:38:53 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36026 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfFNQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:38:51 -0400
Received: by mail-ua1-f68.google.com with SMTP id 89so391421uab.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdEh8Hj2Clq+kDMcSVX4CedsJJo6mgn0qth+pnhpxfk=;
        b=MPl9AGMjmoNFxoC+q/LqmrAuv03V+OnvpDb1T2jOEFfQr1ybdUYboQYZPsQk7BPBH5
         wpwjgQmzEr+uSKzyd5eykA2lnqJFEWo4AqFqsNv+kwS/HoGFi3WWX5tU1iHIzcRPsiF5
         ERXHdmkt3SQzDx2AtHIxbcJeIEQ0DyJvFUU/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdEh8Hj2Clq+kDMcSVX4CedsJJo6mgn0qth+pnhpxfk=;
        b=AzL0VV3BjwG5v14zYbPyuZduCkUvXjYqmLAb8/ROBYsxsG8xrUjnXeeuk0uC8Xod1O
         PbqH5ph5PJ97mUCevg/e9vF63p+SqNvHQtV8+sKIRQ4YVYdxmk0blAvN69O2uIneGnhm
         hUrN4Z9Aumy+o25JrnLsJbQjcO1D8khvocs7NnxH4E20GgWxlPtcW37ocPPsXeaBkNlL
         O9ETln9iIvadTj/bnx0PS7pfK9Wz/8yYPEF/9RRX0jxOK2QoB3GDXqF1s9hJr7WEDz5G
         iIXaKmZnTHJdC+2xwkxuA1+nT9MxumTMv8OfZxW9QE8jP+Ou5yNYNrhbDMvGP4pCuywO
         fdbw==
X-Gm-Message-State: APjAAAXachabkHh3de+HQwOgLbPDDZLchrd4uNsc8Iv280PtI471Tdx7
        jrGU+QMdHauKX5OPNPN5OzS0JI0NGbo=
X-Google-Smtp-Source: APXvYqzubDNgAR1MeihK7CXDSWaA0+xMabmZ7eXXkbEhj6HSkusftXnLx/FGi9E20gSKe46IrKE1KQ==
X-Received: by 2002:ab0:45e3:: with SMTP id u90mr1687040uau.126.1560530329994;
        Fri, 14 Jun 2019 09:38:49 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id v21sm718296vso.14.2019.06.14.09.38.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:38:49 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id o19so1107298uap.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 09:38:48 -0700 (PDT)
X-Received: by 2002:ab0:2a49:: with SMTP id p9mr2181727uar.0.1560530327904;
 Fri, 14 Jun 2019 09:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190613234153.59309-1-dianders@chromium.org> <20190613234153.59309-5-dianders@chromium.org>
 <CAPDyKFrJ4+zn7Ak0tYHkBfXUtH3N7erb5R7Q+hgugchZmCRGrw@mail.gmail.com>
In-Reply-To: <CAPDyKFrJ4+zn7Ak0tYHkBfXUtH3N7erb5R7Q+hgugchZmCRGrw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 14 Jun 2019 09:38:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wuj=gANR2im_o4ZnoLEB+U6FqzKe4noLdQyi1vw+K2xw@mail.gmail.com>
Message-ID: <CAD=FV=Wuj=gANR2im_o4ZnoLEB+U6FqzKe4noLdQyi1vw+K2xw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mmc: core: Add sdio_retune_hold_now() and sdio_retune_release()
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        netdev <netdev@vger.kernel.org>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 14, 2019 at 5:10 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 14 Jun 2019 at 01:42, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > We want SDIO drivers to be able to temporarily stop retuning when the
> > driver knows that the SDIO card is not in a state where retuning will
> > work (maybe because the card is asleep).  We'll move the relevant
> > functions to a place where drivers can call them.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> This looks good to me.
>
> BTW, seems like this series is best funneled via my mmc tree, no? In
> such case, I need acks for the brcmfmac driver patches.

For patch #1 I think it could just go in directly to the wireless
tree.  It should be fine to land the rest of the patches separately.

For patch #2 - #5 then what you say makes sense to me.  I suppose
you'd want at least a Reviewed-by from Arend and an Ack from Kalle on
the Broadcom patches?

I'd also suggest that we Cc stable explicitly when applying.  That's
easy for #2 and #3 since they have a Fixes tag.  For #4 and #5 I guess
the question is how far back to go.  Maybe Adrian has an opinion here
since I think he's the one who experienced these problems.


Thanks!
-Doug
