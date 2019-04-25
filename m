Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D5EC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD3920685
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fndoZu57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfDYSPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:15:47 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45431 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDYSPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:15:46 -0400
Received: by mail-ua1-f68.google.com with SMTP id o33so282339uae.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TQLgG97dgP+LAcJARy+HeEVPUWpQAXRDJse4J8Yqksc=;
        b=fndoZu57/uSjDnDsOB8vKFRDbouEL0l5f/xch1VjgyLz9v1vZ5DmF7dh1EeXxqzMHt
         MEINOdPyCer56YQiGTGCzyIgIVwjUQiYOzRX8tyBbXB2Q0+5iaOXps3DuqZpLC3rLFIU
         YewgAH2ZA4cLnl0GCLlvS1LHbf8unD/6+sj0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TQLgG97dgP+LAcJARy+HeEVPUWpQAXRDJse4J8Yqksc=;
        b=ZlS6fnvw2dVSD+KVT3OCyP283TxVqFVwqBa5V2z/I64LMtFcfzTfxFcntteEQ3u2vt
         5G9ji3dUZE5cDVgE2F4Ga9/8Qmd4v/IDP5sJOHopOfxuPASIggWDLIVH2/Pkv58EptFg
         OvgibqMaDu4mYQypdsecFu2YCcmoZEbadH7ozRPUV25bau8XbteoSnxXLwj9ZqjQboCW
         HRhum+lG4t2OLelvy7OJF/iKI8vQht1Ir8eQrCvmHirwgcKleXb/XbX16SwJ5H7oNmee
         Q6RdMNOdz567bClT1a2pVh037PcmZaPwUlbHyidicKo2o8U6BNALXPUPylDBRFRZowrd
         4zTQ==
X-Gm-Message-State: APjAAAWUirX1a5A3PRs4IiAibROB/UJ7XdkLEpVBRmxYfqULoywelkJQ
        QBDNfPaVcgwT7u30WnNVYN0WBOc4sXM=
X-Google-Smtp-Source: APXvYqxE9PRNBZa+c0Kh3mDif1P2VcV+GJ+kgrpec/D+9zXaNVnEOXflfcutlkFcHdIALBcGiEPFdw==
X-Received: by 2002:ab0:6704:: with SMTP id q4mr20584910uam.132.1556216145371;
        Thu, 25 Apr 2019 11:15:45 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id l9sm3802494uae.1.2019.04.25.11.15.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 11:15:45 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id t15so297934uao.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:15:45 -0700 (PDT)
X-Received: by 2002:a9f:204a:: with SMTP id 68mr2037252uam.19.1556215810968;
 Thu, 25 Apr 2019 11:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190418001356.124334-1-dianders@chromium.org>
 <20190418001356.124334-4-dianders@chromium.org> <87pnpas1fx.fsf@linux.intel.com>
In-Reply-To: <87pnpas1fx.fsf@linux.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Apr 2019 11:09:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V=6dUkXAsX0+XR2y=688VcyDa8aPvD8JkKHTFZrs=YDg@mail.gmail.com>
Message-ID: <CAD=FV=V=6dUkXAsX0+XR2y=688VcyDa8aPvD8JkKHTFZrs=YDg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] Documentation: dt-bindings: Add
 snps,need-phy-for-wake for dwc2 USB
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        William Wu <william.wu@rock-chips.com>,
        linux-usb@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, Chris <zyw@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Julius Werner <jwerner@chromium.org>,
        Dinh Nguyen <dinguyen@opensource.altera.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 25, 2019 at 5:40 AM Felipe Balbi
<felipe.balbi@linux.intel.com> wrote:
>
> Douglas Anderson <dianders@chromium.org> writes:
>
> > Some SoCs with a dwc2 USB controller may need to keep the PHY on to
> > support remote wakeup.  Allow specifying this as a device tree
> > property.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > For relevant prior discussion on this patch, see:
> >
> > https://lkml.kernel.org/r/1435017144-2971-3-git-send-email-dianders@chromium.org
> >
> > I didn't make any changes from the prior version since I never found
> > out what Rob thought of my previous arguments.  If folks want a
> > change, perhaps they could choose from these options:
> >
> > 1. Assume that all dwc2 hosts would like to keep their PHY on for
> >    suspend if there's a USB wakeup enabled, thus we totally drop this
> >    binding.  This doesn't seem super great to me since I'd bet that
> >    many devices that use dwc2 weren't designed for USB wakeup (they
> >    may not keep enough clocks or rails on) so we might be wasting
> >    power for nothing.
> > 2. Rename this property to "snps,wakeup-from-suspend-with-phy" to make
> >    it more obvious that this property is intended both to document
> >    that wakeup from suspend is possible and that we need the PHY for
> >    said wakeup.
> > 3. Rename this property to "snps,can-wakeup-from-suspend" and assume
> >    it's implicit that if we can wakeup from suspend that we need to
> >    keep the PHY on.  If/when someone shows that a device exists using
> >    dwc2 where we can wakeup from suspend without the PHY they can add
> >    a new property.
> >
> > Changes in v2: None
> >
> >  Documentation/devicetree/bindings/usb/dwc2.txt | 3 +++
> >  1 file changed, 3 insertions(+)
>
> checking file Documentation/devicetree/bindings/usb/dwc2.txt
> Hunk #1 FAILED at 37.
> Hunk #2 succeeded at 52 (offset -1 lines).
> 1 out of 2 hunks FAILED

Yeah, as Minas pointed out in the cover letter [1] my series conflicts
with Artur's.  I have it on my list to try out his series and see if,
perhaps, it allows me to enable the partial power down and also just
generally rebase.  It's fairly high on my list to do that--hopefully
in the next week.

[1] https://lkml.kernel.org/r/e4b3cd69-1c91-dfbe-bea7-bbca89ca1348@synopsys.com

-Doug
