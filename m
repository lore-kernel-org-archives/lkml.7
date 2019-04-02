Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F365C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC751204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="FaqH9Zq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfDBQRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:17:15 -0400
Received: from mail.nic.cz ([217.31.204.67]:52097 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729063AbfDBQRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:17:14 -0400
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id DCF8560502;
        Tue,  2 Apr 2019 18:17:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1554221832; bh=btd8RMNTrdk/EAHpKZPc6c9gnCVIpb4hy6nI+OenWS4=;
        h=Date:From:To;
        b=FaqH9Zq/75+rCyibykY5ANIIi7afNTt6t9I78YdRxdIJecniVMT0zPGvknM7YxBS6
         +4bh1AQ/9ldYFmzS71yBLg7CuBvsqEo6ZfKRSTKDEmwNhNGzO/OV2WaUrSXMU7usRD
         Aje3f91R5PhCkh8fS2/qSUuNmiJhC0l+RZQX2BJ8=
Date:   Tue, 2 Apr 2019 18:17:12 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Pavel Machek <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <jacek.anaszewski@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
Subject: Re: [RFC PATCH 2/5] dt: bindings: Add multicolor class dt bindings
 documention
Message-ID: <20190402181712.3eccdb4b@nic.cz>
In-Reply-To: <f8655180-0c3a-7292-3a49-57d997473992@ti.com>
References: <20190401173400.14238-1-dmurphy@ti.com>
        <20190401173400.14238-3-dmurphy@ti.com>
        <20190401212921.GB14681@amd>
        <f8655180-0c3a-7292-3a49-57d997473992@ti.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019 06:40:53 -0500
Dan Murphy <dmurphy@ti.com> wrote:

> I have had off line conversations with Jacek about this brightness model node.
> 
> Your concern was actually one of my concerns as well.  Not only millions of entries but also having a huge
> DT binary.
> 
> We wanted to RFC this to get feedback.  And this is why I have not added any support for this in the framework code.
> 
> Dan
> 

What if we just stuck to color spaces and defined channel curves in the
device tree?

The curve could then be defined via an array of integer pairs, which
would be interpreted as points via which the curve passes and the curve
would be approximated by linear segemts...

  led@0 {
    colorspace = <COLOR_SPACE_ID_RGB>;
    red-curve = <0 0>, <255 255>;
    green-curve = <0 0>, <255 128>;
    blue-curve = <0 0>, <255 128>;
  };
