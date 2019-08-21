Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154E3C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC8322DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDro1+YO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfHUBfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 21:35:53 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38360 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfHUBfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:35:53 -0400
Received: by mail-io1-f68.google.com with SMTP id p12so1357533iog.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 18:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZDgziPohWADEElmbUwXxheNxG1YHZXMADSP7m0rXEeM=;
        b=TDro1+YOlLRwEz2x+hVIva0NLZYpDkw3j6J/eDF3Hi98b1r+Z3u35q2AKgmdeacGhM
         2XKwKFQPXHWH8lSSJQNwFvrPa20kWXAzZr+ruKlkZmdxiKKxTE6fOwCfH+wMTI2xSX9K
         6tfNv6efBXqYkBavG8PB+p4aLfz6cL+Bh/00xe3T4ZibXeo/Ub5B9sF+2AINBHF9agcG
         TogAsURqAWC5l6AKTFHqyrpweZMgZKmSm+KkXT926gKOyqKWcSNB3jgX9t3y7f9VigIH
         tH1Voekk3JuyeBXs+74IygFEjxl/+CkyKKIgXIF+1g03uy4t0CkM3zKg6xL2l6BBlt0O
         yThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDgziPohWADEElmbUwXxheNxG1YHZXMADSP7m0rXEeM=;
        b=FxKClTILl4e7CwsH1/l1i7zr98Js5n57Y6BHasYLXNAuOS693mDU1bNaQpT9Tb2ive
         3TTT93L5j6E8Jlhw2WiZK7VUn4IQ2EO2++mER/1TkBL4AXFhmsIIhN/iqdD7GGJiEBLY
         28YHTE1cyay70oSVIk+GgUWaPRu1TUOBfR7guo26iwm4Uf2ZQeH5fQoHyJBEnDrbO0PH
         WpZV9cq8LZgppLJFwcl0OdPjJmXcVe8WaXZCA9NEit521Ai5aAUSHZklFXkHrs+C+wdZ
         CN+A4HOug9hp9aHpJsZQDevqLH4Dd7Dz8HtfS1gRu9h6b9sa4bE4tw7l2kX3JQCP2MLY
         3cIg==
X-Gm-Message-State: APjAAAU+s13jytDZAJ+lYCgi5HPpoFjLK0juTwrYLAmCtW6qumtlYMy1
        g3zSZOAZW0LjnMS3RMqEZeJBF289sVxFyeTioc4=
X-Google-Smtp-Source: APXvYqzGkWkC1ql6DLZKPAVJGxobBSSWVEse2A37iCP/RxU0eQUfxK/dzMTVThVz57XsmXKb4DJnE8wZpvnDg7w1K4M=
X-Received: by 2002:a6b:720e:: with SMTP id n14mr37064857ioc.139.1566351352532;
 Tue, 20 Aug 2019 18:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190820030804.8892-1-andrew.smirnov@gmail.com> <20190820152928.GK29991@lunn.ch>
In-Reply-To: <20190820152928.GK29991@lunn.ch>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 20 Aug 2019 18:35:40 -0700
Message-ID: <CAHQ1cqHhF6_2Mx3B=w7GEUWDa0RegpUwe=ETCr71PXsDjKRJDQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-cfu1: Slow I2C0 down to 100kHz
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 8:29 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 19, 2019 at 08:08:04PM -0700, Andrey Smirnov wrote:
> > Fiber-optic module attached to the bus is only rated to work at
> > 100kHz, so drop the bus frequncy to accomodate that.
>
> Hi Andrey
>
> Did you review all the other ZII platforms? I could imaging the same
> problem happening else where.
>

Yes, AFAICT, fiber-optic modules are present only on SCU4
(vf610-zii-scu4-aib.dts), CFU1 (vf610-zii-cfu1.dts) and VF610 Dev
board rev. B/C (vf610-zii-dev*.dts[i]). Of all three only CFU1 has
corresponding I2C bus running @ 400 kHz.

Thanks,
Andrey Smirnov
