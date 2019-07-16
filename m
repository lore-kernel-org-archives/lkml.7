Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9136CC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4D32064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCFXNf5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388511AbfGPTYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:24:53 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:40514 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPTYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:24:52 -0400
Received: by mail-pl1-f170.google.com with SMTP id a93so10603524pla.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bU1/CVF/ZWtJJhgU959pS7VfovwURoEItAnWPdtOSts=;
        b=oCFXNf5JX+/4eeBdZQKCCO/JQDetWltLy3dTw617Qm/vZ1HChXg+PtrrydydFpaB5/
         sdmTE9FNdSteLEc5TKtxMPHwmcBs4oY/XYuq7+hd2F62ozCcQKNxw+7rL91Tir7Fq9x1
         7iKJkJQkJ88EdyuohYECAvuAf8VaHoTS0JK8VbTQBGLErp/lMn9aYxUmL26zA7VN/U5+
         sJog0zbYuR/21TlduGydTJtTNEBNOIuQZbTn+aLMAf5MZc4xXk1sQe70WvIcgxFdf646
         rvNRFUo0C3to57R60BLDyeiUDxo6xr7unWQb+oQo5Hj0uw/AuIMTOI3KspPRm6DMaWFa
         Dx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bU1/CVF/ZWtJJhgU959pS7VfovwURoEItAnWPdtOSts=;
        b=DN1SwHJEosE1BCJpEgJiyKlP7EMSi5tdpyWEgVvWo0aiLaW0LzzwcVy5zay8SOg5O7
         dJilG+mshL/4uWVVMPmi1x0mi6E8PVT/QijNIrSRXxtTmuuJjRrkaiROy7H2iElyo9Pr
         H7bKbePm1zLJfMuoC2BafPV/8XZwHihCRXSVCErW8d1W7qeH/m5V/6mV4Ltu4VDPAH2D
         yqAlQ9RwEsI014G4y+qnqFltI4mxgjbkYICZqIpohywEP+5X5Ze4CrvNAbLhIyOfyWOn
         nHhWS9d5Io2UjV91NUj6rnyq46ksHaGoBqcoUBZ//YXOwiPGv0nuKwhg5a04ea3FP95S
         6DDA==
X-Gm-Message-State: APjAAAXiI5FWq4U6VNB8kmI+AJg3J+YCVQzThSHDKWum+B7mX/Wok5BX
        tfNdo+3mrqq8SVOTo5zPtqDLMVcs3ZZ4s4xJ2xY=
X-Google-Smtp-Source: APXvYqwoULbW6I3/j6jqUYqjRam15nTQYm+zSYTYfp7uzk0akd/O6vFwERYHBtmiebhw+uYwA71+a+3RsGMb7ErJbmY=
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr36176148plb.316.1563305092158;
 Tue, 16 Jul 2019 12:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190517221039.8975-1-xiyou.wangcong@gmail.com>
 <20190520065906.GC8068@krava> <CAM_iQpXoD3YzkUzyLSF9qKLpbGxXVeOdFccLbv-mCTVfshx-2w@mail.gmail.com>
 <20190528191102.GD13830@kernel.org>
In-Reply-To: <20190528191102.GD13830@kernel.org>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 16 Jul 2019 12:24:41 -0700
Message-ID: <CAM_iQpWxAYqUsC8TEOfhp12d8gbLmJ+xpLmcE_DwTV7gKm6_ww@mail.gmail.com>
Subject: Re: [Patch] perf stat: always separate stalled cycles per insn
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Arnaldo

On Tue, May 28, 2019 at 12:11 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, May 28, 2019 at 11:21:38AM -0700, Cong Wang escreveu:
> > Thanks for reviewing it. Is there anyone takes this patch?
>
> Enough time, acked already, picking it.

Where is this patch landed? I don't see it in Linus tree. I guess you
are still holding it somewhere?

Thanks.
