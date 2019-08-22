Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008DEC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50662089E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxLNyw2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbfHVGzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:55:33 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:42705 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbfHVGzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:55:33 -0400
Received: by mail-ot1-f54.google.com with SMTP id j7so4498284ota.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 23:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wGjwZaiHKgNAjthbyA6/Ig/piBsbiLnPz4lWq180/QQ=;
        b=UxLNyw2mvZO6h2o2qOJ+/NNQHsFwSSMywdsoqCzar+74gxc+J3zM0TjZkAI5mi5FPa
         MLhPdxOIjEej6Mx1Nx5K4hGIP+asFxvT7acNrKVN1h0F4ubmswe4bWf7282DBPBMBwLv
         URCjCuBz/Wkr7Qaa1Sow8RCzkYzf6K7TiuPzWpj4EYirmfDzgJAKQZ6L8YPtkL9ZwI55
         MneM8loMvWSkY0+1YqNz5eyWN+CI4g4ortxszhAWtTbBjZMuEIh+uh0L/pBZ8Ajncrn7
         vVvyhyOzAMrAkQ+CzHf/CMkp4AimPNZnJCBuPVxAicVDiNikG9D/d4ZeqhfS3JjOwQry
         osrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wGjwZaiHKgNAjthbyA6/Ig/piBsbiLnPz4lWq180/QQ=;
        b=kc4q9m5GfYqWjwoEsJEBG/QnFzph2rpgskCFkOe0zD7uw47YpR/1KlOqDyE39IjGbW
         mtlyVcOokMCI9XzzTG8/i8ZNNsJBXnvlOBGL01BXiitDXWEiXHkTA+3r1v4vo5TMmCXo
         rA6x4gj5zrCQAB/ihVfo+53NnhL/OCPlBUocx/+oAYH8Q8CYj1rITVXscXJ417VO+dxg
         UPf2wnGKVb3me9DriY3JUt8gbJFkKcy76twJ4ygVHjV43YfNwxeHkOq3M1G6we7igofU
         SxP08CaUQFgKS6AJ23medhf53I0dW5fEYsWmr99GugzDaZGZ+Zpre6TwXzNYBxVRbUtZ
         ECnA==
X-Gm-Message-State: APjAAAXXlaVcDLFheghPy1CZl0G7OCIe5AGGKAbDlzj/L2IfMx9UoniN
        eff0LHga++JJiPkSt+PVy9R/RLiqMT80AFVuTfc+OA==
X-Google-Smtp-Source: APXvYqwOfj0jfXAc9u28DfT5cfMsPDAbxO450ATlTMxpOWsRxa3/1BcJ/42ZslHDDQeVxQjYkxVtI6HkNNhJCPs+wP8=
X-Received: by 2002:a9d:6b1a:: with SMTP id g26mr11704743otp.195.1566456932065;
 Wed, 21 Aug 2019 23:55:32 -0700 (PDT)
MIME-Version: 1.0
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 21 Aug 2019 23:54:55 -0700
Message-ID: <CAGETcx_pSnC_2D7ufLRyfE3b8uRc814XEf8zu+SpNtT7_Z8NLg@mail.gmail.com>
Subject: Adding depends-on DT binding to break cyclic dependencies
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Frank, Greg and I got together during ELC and had an extensive and
very productive discussion about my "postboot supplier state cleanup"
patch series [1]. The three of us are on the same page now -- the
series as it stands is the direction we want to go in, with some minor
refactoring, documentation and naming changes.

However, one of the things Frank is concerned about (and Greg and I
agree) in the current patch series is that the "cyclic dependency
breaking" logic has been pushed off to individual drivers using the
edit_links() callback.

The concern being, there are going to be multiple device specific ad
hoc implementations to break a cyclic dependency. Also, if a device
can be part of a cyclic dependency, the driver for that device has to
check for specific system/products in which the device is part of a
cyclic dependency (because it might not always be part of a cycle),
and then potentially have cycle/product specific code to break the
cycle (since the cycle can be different on each system/product).

One way to avoid all of the device/driver specific code and simplify
my patch series by a non-trivial amount would be by adding a
"depends-on" DT binding that can ONLY be used to break cycles. We can
document it as such and reject any attempts to use it for other
purposes. When a depends-on property is present in a device node, that
specific device's supplier list will be parsed ONLY from the
depends-on property and the other properties won't be parsed for
deriving dependency information for that device.

Frank, Greg and I like this usage model for a new depends-on DT
binding. Is this something you'd be willing to accept?

Thanks,
Saravana

[1] - https://lore.kernel.org/lkml/20190731221721.187713-1-saravanak@google.com/
