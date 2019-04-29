Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42228C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DDA2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuTnIbE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfD2UJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:09:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34244 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2UJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:09:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id b67so707969wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MvdFa5U3+5xI+n7BnR9vncycYNJ5YsEVOp/2MMs/RVM=;
        b=BuTnIbE/5X9q4mxEOiBag5fyPi2rnHanlZN0p7kPbZG9UotvYf93pZvWrfRxStaYVJ
         /GdMDmTZmyhQG4Hy8S73PFiykd/3xLz5uxkOlR1T2d+ZYUv3bH1nIvRqSj9TghaMH8e9
         h3E7U3EsYofgiT5ZkKI+1mBkQdhp4qVEItwbaVaZiJIbK8xau1AjSVBRICUOm6h7Aakn
         Lw2n4C1QWRRUPfTk3aM/E0ArH7yQj5h/EqjaiZq3PblxIFSFj0c2riOZT4XPLwvzKElR
         QNh/o96SuIgP8b1IUBnMZVOJ/BcIXhX8iULCLXLMOueeICaz+P66G7gaXAr4/wbq9wUL
         XJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MvdFa5U3+5xI+n7BnR9vncycYNJ5YsEVOp/2MMs/RVM=;
        b=J34IBx2eU1QirYtrNAf6L3jMa8xmVkcl+qXmNrpelpzuCpevJ88S9spQj8HxtyFok8
         dvBZw+mlbK2UGhBYrMD2IEqfygu57nvzVibSbfFcyYA7ocC3cOnDtqLcis0Qe8psmnfu
         Ba0CETfxEeqxxnlWTsO4yGcq+52s+ih3fHpp39IIxLkVBJ7Uey8uie9IRb6exX3ylvan
         HHzbuJZbpTJ6mhe/MnFyLerC40F4Vvj6+WZYlzUGqtmucZi3OoTX2/zPFyVNO6KlcMNf
         e49nhOCecAfD9S3W1y/2DhamDO01rY2bHKBXW91pnsejsUVGndb9BFzkO5lYiKDvE8U9
         xmcw==
X-Gm-Message-State: APjAAAX3dmJv1HPwlPZGQLgWIw5XGIpIO315nkg7orxBDbrHS5j6MiE1
        3XSWewFZ018QQdrkE0aWoWQVeBMqCup9D9YoxecH
X-Google-Smtp-Source: APXvYqzinbFB8LtmNFQ+ucaSuOAAMRFBDlIxFr9bPj35ybI9+jbSy361WcbSMCVMAUkixylis7DlTkYjGroaxKsnD+Y=
X-Received: by 2002:a7b:c25a:: with SMTP id b26mr496762wmj.123.1556568595400;
 Mon, 29 Apr 2019 13:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <s5hy33siofw.wl-tiwai@suse.de> <20190429195459.GU2583@lahna.fi.intel.com>
In-Reply-To: <20190429195459.GU2583@lahna.fi.intel.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 29 Apr 2019 15:09:43 -0500
Message-ID: <CAErSpo4awEXF3evh7=ZGi39y1dpMx9bdhXw8zt7s+1sDaH6nng@mail.gmail.com>
Subject: Re: [REGRESSION 5.0.8] Dell thunderbolt dock broken (xhci_hcd and thunderbolt)
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, Jiri Slaby <jslaby@suse.cz>,
        Michael Hirmke <opensuse@mike.franken.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc linux-pci]

On Mon, Apr 29, 2019 at 2:55 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Apr 29, 2019 at 09:47:15PM +0200, Takashi Iwai wrote:
> > Hi,
>
> Hi,
>
> > we've got a regression report wrt xhci_hcd and thunderbolt on a Dell
> > machine.  5.0.7 is confirmed to work, so it must be a regression
> > introduced by 5.0.8.
> >
> > The details are found in openSUSE Bugzilla entry:
> >   https://bugzilla.opensuse.org/show_bug.cgi?id=1132943
> >
> > The probe of xhci_hcd on the dock fails like:
> > [    6.269062] pcieport 0000:3a:00.0: enabling device (0006 -> 0007)
> > [    6.270027] pcieport 0000:3b:03.0: enabling device (0006 -> 0007)
> > [    6.270758] xhci_hcd 0000:3c:00.0: init 0000:3c:00.0 fail, -16
> > [    6.270764] xhci_hcd: probe of 0000:3c:00.0 failed with error -16
> > [    6.271002] xhci_hcd 0000:3d:00.0: init 0000:3d:00.0 fail, -16
> >
> > and later on, thunderbolt gives warnings:
> > [   30.232676] thunderbolt 0000:05:00.0: unexpected hop count: 1023
> > [   30.232957] ------------[ cut here ]------------
> > [   30.232958] thunderbolt 0000:05:00.0: interrupt for TX ring 0 is already enabled
> > [   30.232974] WARNING: CPU: 3 PID: 1009 at drivers/thunderbolt/nhi.c:107 ring_interrupt_active+0x1ea/0x230 [thunderbolt]
> >
> >
> > I blindly suspected the commit 3943af9d01e9 and asked for a reverted
> > kernel, but in vain.  And now it was confirmed that the problem is
> > present with the latest 5.1-rc, too.
> >
> > I put some people who might have interest and the reporter (Michael)
> > to Cc.  If anyone has an idea, feel free to join to the Bugzilla, or
> > let me know if any help needed from the distro side.
>
> Since it exists in 5.1-rcX also it would be good if someone
> who see the problem (Michael?) could bisect it.
