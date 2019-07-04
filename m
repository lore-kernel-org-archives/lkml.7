Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA01C46484
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0408D21852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="OuyCIoqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfGDPj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 11:39:59 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:36435 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfGDPj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:39:58 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jul 2019 11:39:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1562254795;
        s=strato-dkim-0002; d=fpond.eu;
        h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=gou5Zh0HIbQCcM7c2CWEWnJ04+a+qFsD/mEWP+ODjjE=;
        b=OuyCIoqmsQhbJTbv0dWCKhxJOxfFJ9CnNnTYIoPD7RabOLrTIPqiWSJu0WBN/RMvkI
        LEQEVp4NzUIxfUl+igoTTETz555+ZoaMH2WyB6N7DtgzreFgvP6rqr7O9QVlOnjMq3tl
        lAf/eCisAIGpPqaagIs9Br9pYJ+/qHBUDW4ASHlxE70wXSGvlQzZ+48AHbPplswVMnoQ
        eMEOtd1S+eJcGhYCtgTlrnHI8GYqb1JG1q/K6pBckWwQRrSbevmuNMdgDI2VHzlrV8pV
        mhYtSU1hjzLpjb2fEnxCfMFgik4rpr4bN60AWkYKbsQ7hFqlcwd45rTMiFA5MB6jx5+3
        cPFA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp01-01.back.ox.d0m.de
        by smtp-ox.front (RZmta 44.24 AUTH)
        with ESMTPSA id h0a328v64FXe11g
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Thu, 4 Jul 2019 17:33:40 +0200 (CEST)
Date:   Thu, 4 Jul 2019 17:33:40 +0200 (CEST)
From:   Ulrich Hecht <uli@fpond.eu>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        Matthias Brugger <mbrugger@suse.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Sean Wang <sean.wang@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        matthias.bgg@kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Message-ID: <100944512.353257.1562254420397@webmail.strato.com>
In-Reply-To: <84d1c444-d6cb-9537-1bf5-b4e736443239@gmail.com>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-9-matthias.bgg@kernel.org>
 <20181116231522.GA18006@bogus>
 <2a23e407-4cd4-2e2b-97a5-4e2bb96846e0@gmail.com>
 <CAL_JsqKJQwfDJbpmwW+oCxiDkSp5+6mG-uoURmCQVEMP_jFOEg@mail.gmail.com>
 <154281878765.88331.10581984256202566195@swboyd.mtv.corp.google.com>
 <458178ac-c0fc-9671-7fc8-ed2d6f61424c@suse.com>
 <154356023767.88331.18401188808548429052@swboyd.mtv.corp.google.com>
 <a229bfc7-683f-5b0d-7b71-54f934de6214@suse.com>
 <1561953318.25914.9.camel@mtksdaap41>
 <84d1c444-d6cb-9537-1bf5-b4e736443239@gmail.com>
Subject: Re: [PATCH v5 08/12] dt-bindings: mediatek: Change the binding for
 mmsys clocks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev59
X-Originating-IP: 85.212.144.69
X-Originating-Client: open-xchange-appsuite
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On July 4, 2019 at 11:08 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> You are right, it took far too long for me to respond with a new version of the
> series. The problem I face is, that I use my mt8173 based chromebook for
> testing. It needs some downstream patches and broke somewhere between my last
> email and a few month ago.

If that Chromebook is an Acer R13 and you need a working kernel, you may want to have a look at https://github.com/uli/kernel/tree/elm-working-5.2 .

CU
Uli
