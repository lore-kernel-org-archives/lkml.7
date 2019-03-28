Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECAFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D80B20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0gJp+an"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfC1GJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:09:40 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38160 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfC1GJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:09:40 -0400
Received: by mail-vs1-f66.google.com with SMTP id s2so10118910vsi.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 23:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zN01lDppeJelvKU+xd6s8fuPB+NjVE6Txp2mdsUKQwU=;
        b=Y0gJp+anuQFeV5y5+hUD/YRsN5pTtlIC6MVzogbRgkU1sm8dDPnDLcLgA6UuSC1h6M
         aKrPtKzT/nwBBJw+89hNNlkIfbFk9pQn3VsG4nV3oqinn2TE/tUPzTIJ4MNkI8C1YdbA
         1agfJ3aD9IHk9RbW4A8WY7IoJFG70BykZluS4srHafEiR1OxBtj7i/A1PZiUJTQvsdLz
         MvfQewBp8yAzuycCBODf+Xxez9dsMOxyeBXt889ldEd63OVDddGM19T8OQWZOLqox0FU
         bkOwa7X+pcewFMs5LJwBfbdQsKECC8/EYpqIMPt8Fmwj/HrkB9efKOPPH1rejfHUC/Rv
         CAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zN01lDppeJelvKU+xd6s8fuPB+NjVE6Txp2mdsUKQwU=;
        b=N/UmF1/T/BNXPQ5vj9gVTiSiKnyZfI3luYank6JHvXvk4xMF1wGEk6ci7qJ6jB14WU
         aNMLJrCBLpCJaibiTlBa7P/nAfX7kajjw+0dRI5O+uqnE6EhKJmGROORY9agMh+nTllw
         qu3sjb6Q8SGLNKNLPqFX+m/x4CaAnbOScgIoFD69kGOKENi/05a/iFZpYQbp5ARQNMHb
         8Mhi2l8o5wB/V4Am4guyuTfXVlvYb527qYU7CvHffS5Jv3C4MS5QuNtnWO7oq4ePT2X9
         WEznM3/9uihGlydqNPwTTH5JvXvM169cbQ9zq0DdFihuvLk2NBhILQtsuPRlVKTyvGS9
         RoiA==
X-Gm-Message-State: APjAAAUJ6aniIuX37TEeQbVDXyJZpX4d4J7YqiHdHsA02P4pUUJFwBFd
        xyd57JPBHqEjMWobwet7oh9AXTCsVCVAuywqyv0=
X-Google-Smtp-Source: APXvYqxCvkXdpD2ECHlNyGQtzqHav6VS3b7Ya5rp82QEPUevd8H+fyyq7SltxyzeKdTYsiwpKPeVy9EiDpMz5q/UTJM=
X-Received: by 2002:a67:ea18:: with SMTP id g24mr4484901vso.228.1553753379224;
 Wed, 27 Mar 2019 23:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190326081335.GA4175@ogabbay-VM> <20190327010901.GA30198@kroah.com>
In-Reply-To: <20190327010901.GA30198@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 28 Mar 2019 08:09:13 +0200
Message-ID: <CAFCwf135COOzZmtJEGUFhJaOdBpETLB6VnSmXRabBtyLs3f6Kg@mail.gmail.com>
Subject: Re: [git pull v2] habanalabs fixes for 5.1-rc3
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 3:09 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 26, 2019 at 10:13:35AM +0200, Oded Gabbay wrote:
> > Hi Greg,
> >
> > A couple of important fixes for habanalabs driver:
> >
> > - Fix host crash upon resume after suspend
> > - Fix MMU related bugs which result in user's jobs getting stuck
> > - Fix race between user context cleanup and hard-reset which results in
> >   host crash
> > - Fix sparse warning
>
> Much better, thanks, now pulled and pushed out.
>
> greg k-h

Hi Greg,
In which branch do I see that ? I tried to find it in your char-misc
repo but couldn't find it.

Thanks,
Oded
