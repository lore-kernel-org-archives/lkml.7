Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36169C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0052A2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfCSPg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:36:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45612 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfCSPg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:36:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id v20so22601924qtv.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 08:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0ndwrXvr1fDw8YN1AwbvOJecbQBOdygmtIAM9cY7Lw=;
        b=GV82WmCLcS4bxmvYzvR17dhivD64pnH5joeBXDsAgvAKASvjL0stq4hLiqoqUIcRJC
         f+Kl6NbTfLZkjh1uwzZyIeaJza7IqxpSZApf98agKhPWhNsmsNbQJNxdLsCq1D9icFyr
         jRX36LkEzsCDwHefu1lPCow+sB/frzo9kWqbKkm0sEvGN7d2/v1Z1k0C3s/fPYTP7YVJ
         8ragu3mmAsvfNtXwuEkqCY/P6wWcN5QGx0JWZvh127jX8mf2AffMZ2YAIoVQla5ZCF8e
         KmMu2RYBepWR/lR+JdTILXCB4iK7qs8je70sVy7LWnEDLSoNEBfsFlJnBD9kaUKAlFTK
         oafg==
X-Gm-Message-State: APjAAAXB1Gk4Y3pHpYfiZV++krD1Axbyv2N6yrpnt5E7Oy52VCah8nJV
        0gMr9yhmjMGACOKpIVWvNPSPVgNjcnsEM60ImMOk6g==
X-Google-Smtp-Source: APXvYqyiOJWS6vaJLjs+bSJW9lQPUZ4xXdxAD3b0srtv043diui6B3alg2FDVNE8zE9xpTRonq5kPG1zLC1cUmie5wg=
X-Received: by 2002:ac8:2692:: with SMTP id 18mr459611qto.343.1553009787535;
 Tue, 19 Mar 2019 08:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
 <1552997064-432700-5-git-send-email-dragan.cvetic@xilinx.com>
 <CAK8P3a3uKOVW5HcQD9LLKfoeOkTnhE8M2rHsZuwjNUQv18=J_g@mail.gmail.com> <BL0PR02MB5681AEB47A24279266831D1BCB400@BL0PR02MB5681.namprd02.prod.outlook.com>
In-Reply-To: <BL0PR02MB5681AEB47A24279266831D1BCB400@BL0PR02MB5681.namprd02.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Mar 2019 16:36:08 +0100
Message-ID: <CAK8P3a115AM-iuGPgqEYfR7p9HMQL3fm9eL7370ogf3-DBrjbA@mail.gmail.com>
Subject: Re: [PATCH 04/12] misc: xilinx_sdfec: Add open, close and ioctl
To:     Dragan Cvetic <draganc@xilinx.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 3:59 PM Dragan Cvetic <draganc@xilinx.com> wrote:
> >
> > > +       /* Only one open per device at a time */
> > > +       if (!atomic_dec_and_test(&xsdfec->open_count)) {
> > > +               atomic_inc(&xsdfec->open_count);
> > > +               return -EBUSY;
> > > +       }
> >
> > What is that limitation for? Is it worse to open it twice than
> > to dup() or fork()?
> >
> The device can be opened only once.

What I mean here is that preventing the double open() is
a fairly weak protection: it means you cannot have multiple
'struct file' pointers attached to the same inode, but you
can still have the same 'struct file' being available to
multiple processes.

         Arnd
