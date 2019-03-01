Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27258C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81CF20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okn1yVIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfCAPue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:50:34 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:38619 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfCAPue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:50:34 -0500
Received: by mail-ua1-f43.google.com with SMTP id d4so11766075uap.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 07:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wGU7fDOKYCdXJVTcbK8Nygb8SB6TIpOioDqhUiYr/Ik=;
        b=okn1yVIjz9FYwP3mLrSb2FTlvnfUV20ieu8Ge7epzydgFeFixEr1KJOQN45jNLmpU4
         HuGlxMq3hzvEq+Y9uaW01PMDSrq5VR9KJFEFNHF4Ew1y78/fcMGQf4e0BhsMc5RGf7w6
         Rut5TReJaBzGY7hxROLiW16X+/hS/Vr9SyMyBGe8ADHxuOEwsW39JIkfopTc8PKDfaDU
         5eYmHOurQZI6W7io/feu2Z1axyCHLV78kf4UpsOAEAxlZDqVmrST/n2aw1WZqrilEWVe
         ml5hMOVhtImv/n+Tcx3mfSWDIhIqW09frmlFViVZCdGl4NY/Jy9BM98Nn7REhFpurdHS
         H+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wGU7fDOKYCdXJVTcbK8Nygb8SB6TIpOioDqhUiYr/Ik=;
        b=GcPSrU3feH1UGoGdvxJgf/tpqgwsd/XOzgUEsKgfEfr5z8VMqSchrsemMv5C4xDpxt
         hfZm+zoqeUG+pGeXArnVoEnK/rQA4E4mHig0dti2GirzvoCL6UJ3Gtip0+12moDmmgro
         VI9slFGj8BjXTG077uBazElpS7na+2l18U5jZYFj8Jlm5Q3mRVdKrH9kpPK7c12++j7Q
         INn/D721ZZ9yJqvf3Wr+MZMepd07705gvGgV0PuQojLDaN5xbs+daTgLKVmA4TtaIWWC
         qRyjSLOmUP6rAAKVH9K0zHF78YyFcwxEHRY9Rdt89ZAXubhJDNLZTOq01sj4TyRbbr7f
         hfPg==
X-Gm-Message-State: APjAAAU2K1cSKMYM2iv02zKrDYFiPbRic7oA7dyrqO+hBjQJad9feg78
        YS+KsSBPCPm3d+3sD5OzmDHcydeColRDE72OAjs=
X-Google-Smtp-Source: APXvYqyk2vaScOVcHo+PXCbhRAvBq0yBM0zQfacFltb0mAXYdCiQGMBWO1AvBbFZxmNBicGrNmVwK5XaW/LqZD05fJs=
X-Received: by 2002:a67:ea18:: with SMTP id g24mr2882970vso.228.1551455432779;
 Fri, 01 Mar 2019 07:50:32 -0800 (PST)
MIME-Version: 1.0
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 1 Mar 2019 17:50:09 +0200
Message-ID: <CAFCwf10UPHaBKhc7p1MrhhNAwZ3Jh3J3we2OPkGxPbAj+eaMRQ@mail.gmail.com>
Subject: habanalabs user-space thunk library available in GitHub
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Cc:     Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Olof,
I wanted to let you know that I put the sources of our new userspace
thunk library in GitHub, as we discussed a few weeks ago during the
review of the driver.
The link is: https://github.com/HabanaAI/hl-thunk

As this library was written from scratch in the past month, it is
still quite small and provides only the minimal functionality over the
IOCTLs.
We did ported some of the userspace tests we have in our runtime to
this library (using CMocka framework) to demonstrate how to use the
IOCTLs.
The library is written in pure C. It is a stateless library (at least
for now) and I took the basic design from drm library.

Going forward, we plan to (in order of importance):
1. Integrate this in our S/W stack. In effect, remove the functionally
we expose in the thunk layer from the runtime and make the runtime
link with the thunk layer and call it instead of calling directly to
the IOCTLs. This will be done in the next week or two.
2. Add additional tests for Goya and for future ASICs. We plan to use
this library for doing bring-ups on Palladium and the real ASICs as it
provides us with easy platform for testing purposes.
3. Add more functionality to the library. I didn't yet decided how
much functionality I want to add to this layer though, because I want
to keep it thin.

Bottom line, this is definitely not some mockup library. This will be
an integral part of our S/W stack going forward.

I sincerely hope we can open source additional S/W parts in the
future. I'll try pushing to this goal as much as I can inside the
company.

Thanks,
Oded
