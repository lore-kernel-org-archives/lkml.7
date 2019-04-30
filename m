Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7A9C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C09120835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzF1u1Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfD3OdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:33:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44302 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfD3OdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:33:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id z16so6916046pgv.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqS0xUpYWHV2KKYrwWSzkNORD9GWhMTFKscheBDY6SY=;
        b=tzF1u1RoWkduWv0+xPHHl/FHoW82nr4RoepicXe75nIhkhv0Z83aSutJv7RXUnvvln
         b+YHzaJJuyiwfYl3Bhe6GeQriNX6ezzisbujhkoyGZi3eRBZ9Ssv6OaR9dU26gHb6PQ1
         sIIVc6FzIk8ALMa4f8suqQ8w/UavtYgxMGdRZEjcZO8JDrI2uMS8E42mIosE2ysx7JUR
         jPIBaf22MwBo+TaHdyBYYg3jReUyJkIAA8oH4zudbloeGwRe3g146yEYU0i/vFgK+ZVx
         lQH/EmbB9Z9DSN9YuNMTcgsJJyM8AcpHJC3/xnG9xHggRInbWiwwk/QFJr7huyuWBUDY
         6bLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqS0xUpYWHV2KKYrwWSzkNORD9GWhMTFKscheBDY6SY=;
        b=F0pAwwi06T6OeWITx5REIqdyZIRgRrWBCmNqDfYf7XSiXkMjh240gyyr+L5QaYwYnO
         SbPgmEMK0HzE0ToTnSavlgQIl7+/xCX5HH8bKQq1mzt2UwXy2guiE/hYHbnohGb/0sHw
         uQqJVlIKlijf8aljshh6dWu3NRLEDN4BYpePcCQRmZOWhWS3w2DbcdOapSbiscoiOlNq
         n+IH3EYA+wAIF7sYSEtZvqrVDgkOAFjUL6hMYKwLTnaVBQtP0FSC8uUymCxQW2gR5C8t
         UgOBWjyjEDH5R54t1sgpzBrS0drse+cSNF8TCBRvfcurYlzFvFYaz+N4IksG4QNrzjw+
         fPjQ==
X-Gm-Message-State: APjAAAV2WEfJUoHKfIVLxbZ7cMsZ57wgnuWf5GEzbkYfkGM316AfB5r7
        pjPyY4RTCEet53UulxQ8YglmSE+uazqepvayqFGwXQ==
X-Google-Smtp-Source: APXvYqzoXmDdXU1unld0QhbwYUzlQK4qL/xbHvJGqsh7X8UsgwzODrG87qfn7g+7upf/9T11B0K8fGClva2frt9ZL0k=
X-Received: by 2002:a63:5c24:: with SMTP id q36mr15138678pgb.314.1556634787476;
 Tue, 30 Apr 2019 07:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190416154138.124734-1-venture@google.com> <20190430004211.GA28272@bogus>
In-Reply-To: <20190430004211.GA28272@bogus>
From:   Patrick Venture <venture@google.com>
Date:   Tue, 30 Apr 2019 07:32:56 -0700
Message-ID: <CAO=notwuAhWQry-yO9-5zQud7Mo_3=Q5gKaE4doijSrS=v_pXw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: Add ir38064 as a trivial device
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, trivial@kernel.org,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 5:42 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Apr 16, 2019 at 08:41:38AM -0700, Patrick Venture wrote:
> > The ir38064 is a voltage regulator from Infineon.
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Patch 1 and 2 applied.

Thanks!

>
> Rob
