Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9577FC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6744F205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1wAnDEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfEHOkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:40:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34016 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfEHOkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:40:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id n19so2060219pfa.1;
        Wed, 08 May 2019 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qU+b830HjTDROUNUT/+w1uv0y2kFrc/lnnYO3ZmFuyQ=;
        b=n1wAnDEoWZeIZveeMXxtGy1V2bRZ4r92eFhDUCyLpO2y4n2tZdYl1zOSrUDeVDVwPT
         FIlxCREmkh0hDpQn+0AH9X4/g0xloD3hCY0JQwQAa6LqRb+XMB9sKbcjg+HQxOaS1p4N
         KcooeenPbGttAMpVjWaN47R8FmUIFv3ckNBHn2+bCaCYXbpCpPE0O1e0qChY5eqvWVPJ
         bI3dfe7UV1QesyxqSFRWDWdgdqlQ5U18hnq6nJIh5/gd07qzwlbEpyUasfpDOKy1iyDH
         SRo2TN8jyPNN5yZXUZx/KSttbSQv6qwda7NUD7RkvDktdG7WOLXhiaC/UEmUaLcLs7D6
         61MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qU+b830HjTDROUNUT/+w1uv0y2kFrc/lnnYO3ZmFuyQ=;
        b=ocwr6Y21+wu4BdverycZZTrSlUWL5NM3WsEFINA0GBdc7c6KQpblOCc39mNdfKo183
         ALz+Ysn1Jcn0emYZoKpVBgJxNhKeJ2M/SVhakc/Y5Iij1UWlkO2NEXc5ucoo2JC6izFp
         9GWCm2HdzLvB8rskCiVzzLUByq8qDgSnW/S3DLDRwdkNllVvISKDRM4hHUoq2M/c8AzG
         9Ae9GdAqXVInW4U6DZ2xPaYpzHjJ7fxE4FXDjt7Rfxm2l07Hs/r+X660hBOePWRx2iX6
         EvkYp/6uJGe/GAJQZdfBgFUmDbaF8hul4YEMY8Wt7ikyX1IXg/SpnWacL/lpt0nLdW5I
         guWg==
X-Gm-Message-State: APjAAAV3b2PChhnC8M7Ia7T+xUOm3E5nv3AX6Pj0ma7tx6wP1UhZRGxi
        92EeQu+YZdoGuQADETJ4M6t4/12dstA=
X-Google-Smtp-Source: APXvYqyP65HG3rORTR+4E+EuA4ikj7IagPu+Hf+70+EumxbD21ROxTl1cat427U0GyTRpgH1XjK5kA==
X-Received: by 2002:a63:10c:: with SMTP id 12mr48465705pgb.276.1557326423339;
        Wed, 08 May 2019 07:40:23 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id o73sm7255366pfi.137.2019.05.08.07.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 07:40:22 -0700 (PDT)
Date:   Wed, 8 May 2019 23:40:18 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] usb: host: xhci: Support running urb giveback in
 tasklet context
Message-ID: <20190508144016.GA2569@localhost.localdomain>
References: <20190401141611.10087-1-suwan.kim027@gmail.com>
 <20190507160219.GB2427@localhost.localdomain>
 <0529be1d-57d6-18b8-6f62-49f4b3931e1a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0529be1d-57d6-18b8-6f62-49f4b3931e1a@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 03:04:33PM +0300, Mathias Nyman wrote:
> On 7.5.2019 19.02, Suwan Kim wrote:
> > On Mon, Apr 01, 2019 at 11:16:11PM +0900, Suwan Kim wrote:
> > > Patch "USB: HCD: support giveback of URB in tasklet context"[1]
> > > introduced giveback of urb in tasklet context. [1] This patch was
> > > applied to ehci but not xhci. [2] This patch significantly reduces
> > > the hard irq time of xhci. Especially for uvc driver, the hard irq
> > > including the uvc completion function runs quite long but applying
> > > this patch reduces the hard irq time of xhci.
> > > 
> > 
> > I sent this patch a month ago but got no answer.
> > Is there any feedback for this?
> > Please let me know if there are any faults or it needs more tests.
> > 
> 
> I'll add this to a internal tree first, and let it sit there for a few
> weeks, trying to catch possible bugs this change could expose.

Thank you for spending your time for it! I also have been testing it
in my daily desktop and until now, there are no special issues.
If some bugs occur, i will report it to the mailing list.

Regards

Suwan Kim
