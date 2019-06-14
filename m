Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5CBC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F2D2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LjN3BmyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfFNRRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:17:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37033 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNRRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:17:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so4513769eds.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 10:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=7TRyUZx1zoQSYNZ+ER0doTkq7zshmk9cidJxpZCUNN4=;
        b=LjN3BmyEOgpqPA02mygscd7VyN5kV9cjfsGWeoPqOr1iRbUnCUiGBfBlduft28awjQ
         3hOd0leEfRmAgFtf7bNKcIe0ghSeeAQFaYXwhsqNKIIS2BnS89LBPnw3azQX+cdslalu
         89o15ro4zPbbHmZG253IHizn846QyWeXGcwWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=7TRyUZx1zoQSYNZ+ER0doTkq7zshmk9cidJxpZCUNN4=;
        b=JM2XW6S0FY0ESR9fBEnMI6AUoIZI22GGuw3en5MxGVdEA7SDJC4SrlgR25441GrhPM
         o+/D518WAtlvMT6JOCNBAvNSMdJwaV3Rrkp1I6ljqNNbKCd4VCpo7s5QyvNBJDqE+IB0
         zSi0DyWlx+Wm1RXy6ooWjxaLZubm+tCwX00Dj19imoKL36nEqLakTWQ3H9ndqY57BpLL
         SgbrAXdg5UsOrYWAA67daRepcGeLdog4RJMzZXN5yIoQVHMbR1M3QzGrrt6GszH35HTT
         5iJuBIBWpJJ6oIs2R1M2xE3LAePAjGGLDM4ta05nyQnFu1C54fgo6K+Hc7ioQzuD0KPg
         jduw==
X-Gm-Message-State: APjAAAUMUm+RCTCfgRQsugsx2+LbIdK1G5p1ZIKC4h+93aFQZlfldEye
        eH2JpOkrBHRGcT0eEBkFxHiHBw==
X-Google-Smtp-Source: APXvYqxoDgfecrMxkY8vCct7UUGvuYQVCrnt17PA6/AGoy/4n4fyf0ayVe4kCK+cV82wiR4wYero6A==
X-Received: by 2002:a50:d791:: with SMTP id w17mr8370604edi.223.1560532634311;
        Fri, 14 Jun 2019 10:17:14 -0700 (PDT)
Received: from [192.168.178.17] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id h10sm764146ede.93.2019.06.14.10.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 10:17:13 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Doug Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        "linux-wireless" <linux-wireless@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        "Chi-Hsien Lin" <chi-hsien.lin@cypress.com>,
        netdev <netdev@vger.kernel.org>,
        "brcm80211-dev-list" <brcm80211-dev-list@cypress.com>,
        <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Avri Altman <avri.altman@wdc.com>
Date:   Fri, 14 Jun 2019 19:17:10 +0200
Message-ID: <16b56fe39f0.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAD=FV=Wuj=gANR2im_o4ZnoLEB+U6FqzKe4noLdQyi1vw+K2xw@mail.gmail.com>
References: <20190613234153.59309-1-dianders@chromium.org>
 <20190613234153.59309-5-dianders@chromium.org>
 <CAPDyKFrJ4+zn7Ak0tYHkBfXUtH3N7erb5R7Q+hgugchZmCRGrw@mail.gmail.com>
 <CAD=FV=Wuj=gANR2im_o4ZnoLEB+U6FqzKe4noLdQyi1vw+K2xw@mail.gmail.com>
User-Agent: AquaMail/1.20.0-1458 (build: 102100001)
Subject: Re: [PATCH v4 4/5] mmc: core: Add sdio_retune_hold_now() and sdio_retune_release()
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 14, 2019 6:38:51 PM Doug Anderson <dianders@chromium.org> wrote:

> Hi,
>
> On Fri, Jun 14, 2019 at 5:10 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On Fri, 14 Jun 2019 at 01:42, Douglas Anderson <dianders@chromium.org> wrote:
>> >
>> > We want SDIO drivers to be able to temporarily stop retuning when the
>> > driver knows that the SDIO card is not in a state where retuning will
>> > work (maybe because the card is asleep).  We'll move the relevant
>> > functions to a place where drivers can call them.
>> >
>> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>
>> This looks good to me.
>>
>> BTW, seems like this series is best funneled via my mmc tree, no? In
>> such case, I need acks for the brcmfmac driver patches.
>
> For patch #1 I think it could just go in directly to the wireless
> tree.  It should be fine to land the rest of the patches separately.

Agree.

> For patch #2 - #5 then what you say makes sense to me.  I suppose
> you'd want at least a Reviewed-by from Arend and an Ack from Kalle on
> the Broadcom patches?

Will do.

> I'd also suggest that we Cc stable explicitly when applying.  That's
> easy for #2 and #3 since they have a Fixes tag.  For #4 and #5 I guess
> the question is how far back to go.  Maybe Adrian has an opinion here
> since I think he's the one who experienced these problems.

I see if I can come up wit a fixes tag for #5.

Regards,
Arend



