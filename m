Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EED6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F162190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="WsI01r0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfGXWwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:52:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38655 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfGXWwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:52:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id v186so36242060oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NS4u+eBseg0DbQA0MU2dSuty1nFLg/yD2ulnxgZWxpw=;
        b=WsI01r0+8S0qHaiUGli9O6VA8G5EbT8wESR+QHOUxt+/JeNKOPhQaHmPMTMh8KeJhi
         knfyeHmKxGpmpur/ltSGLunAHSSg6BCDIPy3rFyWNIOzGn6KeOBjFf0EWl/VovTwjw2Z
         ZF8lTd/ZFvMgkJB+p8yHYfJm6eUvMH5ebX5U6dNhiA2NEsSOM47/uSHe0/CI8vqIrIy5
         nzEgeRtmzAJl4ArzmC9enkYIQ7bvu4mXazcyXaOupfOvh1MFtfCZ8BS9ALKmFxbZDY2/
         mtnlrYGHU8qf5gw0Pziar4dwHIBm8siMjy/LtAfsWqykl6JFTDPIFrc6TJvZvHVV6sf/
         /5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NS4u+eBseg0DbQA0MU2dSuty1nFLg/yD2ulnxgZWxpw=;
        b=GORrCGpsGLVCNa9qUBBL6m1ApgDLPlW8HAMR6n3FkPLJ9cfrFzQbthe+UXrET64+lb
         KJjjwu+euraXO8pEe6hDWJVgJktBzmixaQ7baTs39dF5M7tQWllJFBoUD+jVv2a108sk
         7OWmsuqAOXf2c7JtD5EtgwlpBPGrU2RI7JzBY410XTC5drMYuh76VADzWqeu5rsV2CYu
         Q+vc2uCfahWBD3oT2SayJHPFoa3Ln9NCZrCJJ0PpiZEQjqgXWmJN46fIkSIeX3O20SXs
         kIcRo+4VBpufwYIdJXCNNGTK3EHKezEaJg51RLXx2UqbGC8ozP0ysKWwNN5DpQeFxJNY
         Ij/Q==
X-Gm-Message-State: APjAAAVEcaVUyW3ySLWnEV0ODYBkcugp2AlyjBnpmWx1D/2Dy832YaAT
        lKD36fmuJBgK0MjhPZtuWdpMHE5FESEIj6mWD47Bpw==
X-Google-Smtp-Source: APXvYqzSZInaKhuMFiPlmjU3dlvlT2OJR7ptIKglkJzXRv3bZsRsA+zEBuvwUDFgRbzKWlufzZxuvok65bNWe4q/BNE=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr40944549oii.0.1564008761619;
 Wed, 24 Jul 2019 15:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <1564007603-9655-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1564007603-9655-1-git-send-email-jane.chu@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Jul 2019 15:52:30 -0700
Message-ID: <CAPcyv4iqdbL+=boCciMTgUEn-GU1RQQmBJtNU9RHoV84XNMS+g@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS issue
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 3:35 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> Changes in v2:
>  - move 'tk' allocations internal to add_to_kill(), suggested by Dan;

Oh, sorry if it wasn't clear, this should move to its own patch that
only does the cleanup, and then the follow on fix patch becomes
smaller and more straightforward.
