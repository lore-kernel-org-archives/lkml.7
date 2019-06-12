Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8260EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F7B2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9hscLxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfFLGfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 02:35:34 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:56021 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFLGfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 02:35:34 -0400
Received: by mail-it1-f193.google.com with SMTP id i21so9000117ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 23:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHcvYWRnrXWxsWWs0BejJhNYWntQgPzwqsTyK3JVcEE=;
        b=S9hscLxT9U0oYcldK6EV5J/lbYqp/LZmLHawIS7nzJVR0hsF1YqVy150zNpRA9eZtS
         04C0Hbr1JbzSiOoaoXFWJijWoXICJeBvkpEM2EMr+QojWFDJ8UlLUaUSBOpD2z9Nlfgc
         F6zwaVjxQlFzllxXNlNlaICFHIf4OAVLxZbKKCgBXFSFsBKTRA1B1KYpGaN4woeCH091
         GNSM6lSXYFA+slAMAiohXpmR69HFHKhg/lxP3dP1h954Fc/oEsyat+AX0WldkvkU2u94
         81Otxa9+L7GosJ3ZF8B3x8fOUMRgxm3yuiWt+QNnp/cOpbigVendTpVFvhXldkxI+/D3
         x2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHcvYWRnrXWxsWWs0BejJhNYWntQgPzwqsTyK3JVcEE=;
        b=K+VzZmUlN9j24946oOjFNyAE6igtFwtkMu9V9SCEfD9LbLqHj7TeD6BFzCcCwxcr6g
         5BA/JPXTdM9rj3YKYIrTiU7xsXd+FgH3tQxrrRx60OY2KuYJFyz9ysfF+zwGanhXb9Zt
         VOdJ7Ig0/6yVkpcn7iRIU5vm7A92pb2NYpg18H4uYi4TSxkmqAmDTEHHEwzVZ8y2bARr
         bFZqcmOh+SCroVUEU/9JCyXpFqmeq/rrVkBdWT8cDOSSDWyE7RsI7Ziz7poifAmWos2v
         ccSLtyNCWAFy034P5IYTlCztYJac9+d/08yQ6CEv1uiKnAD0tEQh/pNCyeFRUW1qCfJW
         bRoQ==
X-Gm-Message-State: APjAAAVEovKXNzWR2lLPjbMvlSk26U55XirmlaR0I9Bz32kP69Fha1IT
        XRRMpPAUXE7ltnO3iUhItBaWH0ufFb4TlnCMBUcQFE/t
X-Google-Smtp-Source: APXvYqx16rAJnIPnPFPqqoZ7lmzh1vpi/yzIxiE9JzX1lPl2u7spnY33oJUFEHnBbB8dL05qV9YE/DbB9OoGggJpIo4=
X-Received: by 2002:a24:d145:: with SMTP id w66mr20513709itg.71.1560321333285;
 Tue, 11 Jun 2019 23:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190611092144.11194-1-oded.gabbay@gmail.com> <20190611095857.GB24058@kroah.com>
 <20190611151753.GA11404@infradead.org> <20190611152655.GA3972@kroah.com>
 <CAFCwf13A73AxKzaa7Dk3tU-1NDgTFs4+xCO2os7SuSyUHZ9Z3Q@mail.gmail.com> <CAFCwf134nTD4FM_9Q+THQ7ZAZzGxhs15O6EheaRJMqM5wxi+aA@mail.gmail.com>
In-Reply-To: <CAFCwf134nTD4FM_9Q+THQ7ZAZzGxhs15O6EheaRJMqM5wxi+aA@mail.gmail.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 12 Jun 2019 16:35:22 +1000
Message-ID: <CAOSf1CE82uVVni638jkJJpQ7XLXX+HdD7xuB7Wv-f8mn=SBMeg@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@ozlabs.org,
        Christoph Hellwig <hch@infradead.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 3:25 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Tue, Jun 11, 2019 at 8:03 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > On Tue, Jun 11, 2019 at 6:26 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > *snip*
> >
> > Now, when I tried to integrate Goya into a POWER9 machine, I got a
> > reject from the call to pci_set_dma_mask(pdev, 48). The standard code,
> > as I wrote above, is to call the same function with 32-bits. That
> > works BUT it is not practical, as our applications require much more
> > memory mapped then 32-bits.

Setting a 48 bit DMA mask doesn't work today because we only allocate
IOMMU tables to cover the 0..2GB range of PCI bus addresses. Alexey
has some patches to expand that range so we can support devices that
can't hit the 64 bit bypass window. You need:

This fix: http://patchwork.ozlabs.org/patch/1113506/
This series: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=110810

Give that a try and see if the IOMMU overhead is tolerable.

> >In addition, once you add more cards which
> > are all mapped to the same range, it is simply not usable at all.

Each IOMMU group should have a separate bus address space and seperate
cards shouldn't be in the same IOMMU group. If they are then there's
something up.

Oliver
