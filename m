Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B846FC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926552083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dA8vBvHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfFFR44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:56:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46448 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbfFFR44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:56:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so1205627pls.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wg/L+X/jg6qit00t5YFiyAIPQXlMXYdfO4PWqxYv4KM=;
        b=dA8vBvHVwB5tyIZL6HFsZQA+oM7gbRX2BD/7asX66sUe55DoUOmY3CcZ++I+fKFlFs
         oRtoMCloCYkyyxraPI/r329rVZdvdMnaYRmrcMERLV9VjuzrrlGBvhJbHs2leafOmQKY
         x7NgGEAgtwYwYd70a+G1XOdwp/unQ7R3QOhLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wg/L+X/jg6qit00t5YFiyAIPQXlMXYdfO4PWqxYv4KM=;
        b=HyUhlikbD7fKMbu5yqcRr91of+ekV7jiB7/P0g1FbsIX8+aV8Mzl63eewZ9rAOEQVL
         pMK5EJg4jdtVauojUWvOzZEUFEAZxNYvUWbr6BGDnd7MTbR7hnP4HEeSRDPJXioBj5AT
         fapsGsGjUC//B6f4xME3XGhfRQH7dAHFhL0H5shR6cBM0BaGWaxFGHPuBmDAhvxES1Uv
         q+jcpnw7QsLqVYcjQfca3AHRqtJv1fXUxhkshJw/TeUWFqgOi0SJ/SN1i1VNhIwWSVJo
         dHGGx1OGZf8qoT2+F5IpDfrJtQUs4uN1f0sUMGIA/etXG07XXku71RTW6R8ONf/X3Gy5
         E3nA==
X-Gm-Message-State: APjAAAV1DDtcdRgSC8SB+Pp+l0gCnt2dRhBOuJKEWAL1ITA2LWNITHXc
        8Y2KPLNp4biNKTOhuAD2fNH5wA==
X-Google-Smtp-Source: APXvYqwmDqEW/o38wEXDtX8dBjNG0P26I5CKLLWhjKj39nna/Xy2ryhansQqw0pXWqo/EvXbqhoqvg==
X-Received: by 2002:a17:902:8a83:: with SMTP id p3mr52200787plo.88.1559843815549;
        Thu, 06 Jun 2019 10:56:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f13sm2645865pfa.182.2019.06.06.10.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 10:56:55 -0700 (PDT)
Date:   Thu, 6 Jun 2019 10:56:54 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 2/2] ARM: dts: rockchip: Configure BT_HOST_WAKE as
 wake-up signal on veyron
Message-ID: <20190606175654.GQ40515@google.com>
References: <20190605204320.22343-1-mka@chromium.org>
 <20190605212427.GP40515@google.com>
 <2828678.vPWIEPrON5@diego>
 <3394571.WlNFeu2Orz@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3394571.WlNFeu2Orz@phil>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 12:46:03PM +0200, Heiko Stuebner wrote:
> Am Mittwoch, 5. Juni 2019, 23:52:00 CEST schrieb Heiko Stübner:
> > Am Mittwoch, 5. Juni 2019, 23:24:27 CEST schrieb Matthias Kaehlcke:
> > > On Wed, Jun 05, 2019 at 11:11:12PM +0200, Heiko Stübner wrote:
> > > > Am Mittwoch, 5. Juni 2019, 22:43:20 CEST schrieb Matthias Kaehlcke:
> > > > > This enables wake up on Bluetooth activity when the device is
> > > > > suspended. The BT_HOST_WAKE signal is only connected on devices
> > > > > with BT module that are connected through UART.
> > > > > 
> > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > 
> > > > Housekeeping question, with the two Signed-off-by lines, is Doug the
> > > > original author, or was this Co-developer-by?
> > > 
> > > Good question, it's derived from Doug's patch for CrOS 3.14 and
> > > https://crrev.com/c/1575556 also from Doug. Let's say I did the
> > > porting to upstream, but I'm pretty sure Doug spent more time on it.
> > > 
> > > Maybe I should resend it with Doug as author and include the original
> > > commit message, which has more information.
> > 
> > It's just that the first Signed-off should be from the original author.
> > (And the sender the second)
> > In the co-developed-by case (see Kernel documentation) the order
> > doesn't matter.
> 
> Holding off on this patch till we could clarify the authorship.

I'd say let's attribute the authorship to Doug. FTR, the original
downstream Chrome OS patch is https://crrev.com/c/278190.

Not sure if the information in the commit message of the original
patch is relevant for the upstream version, in the end it seems LPM
was never implemented, so it should be sufficient to say what is
actually done today.

In summary, I propose to take the patch with the current commit
message, with Doug as the author. Heiko, can you change the authorship
or should I send a new version?

Doug if you have objections or want updates in the commit message
(yours tend to be more verbose ;-), holler.

Thanks

Matthias
