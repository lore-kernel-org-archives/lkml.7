Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE0FC17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C298821655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBSNhKIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKKPTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:19:16 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38307 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfKKPTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:19:16 -0500
Received: by mail-oi1-f193.google.com with SMTP id a14so11789709oid.5;
        Mon, 11 Nov 2019 07:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oj77XRuIrZ+nhWL6BBEQMxJ0gbQ2ADE6qolk4AXWkzA=;
        b=MBSNhKIAv95LtaZvlBH6VARu3dh7z+L05kADCNgCQQ2W1L+YEJ/Fh5KbVdrN2ukKTW
         yye7KJf0Mxhe/0Qlz/cca8Nh3qnNE7kVPRvFwgCA+sWCozRAuhez99jCi8oKLRtEyOLz
         YDMo/IafADp0jPq+iZTQnrrQEmEARhTi9OOwYntNdsUQ0+uySatCE4nETmvlVIMpzjTu
         Fbkni5LtKIrwqZHTwYwFYCeoAL6O8zyxnqtRyRDacZWI3rRATBHF0zyb7cVYqnfD76+Q
         UrctDS3U/OVVkj0MDFo8fXnjTphJGEHakhq/62iffw7rom5hMV5ZYaE+20oo/Gcx85u+
         zBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oj77XRuIrZ+nhWL6BBEQMxJ0gbQ2ADE6qolk4AXWkzA=;
        b=h2aC4W1qSlMewAnzTnmvRdXvNUtL1FGNqQrMxVezYfgVxRjL4BH6Y2pM9Nu7L1TTvz
         EclsK0Zo3j7aOHVD/Qq++aA7r8DAA8JPhMmgZGg5EXZyhUhTWSe9+J6t4AI9U2wAmwwv
         99i+LVHnGtqq0OlCkBqJvw1JSP7T4uYeh8QCAZGOP3U5nGclzv2MmeqAsJviX8nVcrPV
         sA57eQAoXqML8v0YsZR6zd5n6ZCMXvTSdNurSCwd+pyM7ucAfT6/HNYWsPchAJfhDTU6
         gFY4ifZrhRiHT/zcEJ0AN7miU0CHc6K+75nktlVqbUFqdhdpHoIGVDf9nHwOnvsHmkin
         HbnA==
X-Gm-Message-State: APjAAAU9TCQ+JNx7C4pfRHqriudfapFXXZqRf27dGqIL0h7gOi56buE6
        9bFseCVMDLn34fR4Ww2qEVmw5GX/PhKBLB+y6fk=
X-Google-Smtp-Source: APXvYqw9rbbJ6ZcvEghaKJ5gEsvMxtbSqyhIaGnVT2nY29rpxvM6DopCJ1x8v1olm7Q1QpHPOIBOY+lnBec1fmFd1yA=
X-Received: by 2002:aca:2803:: with SMTP id 3mr1017346oix.113.1573485555030;
 Mon, 11 Nov 2019 07:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20191018194707.27188-1-sudipm.mukherjee@gmail.com> <20191104164351.GA2269025@kroah.com>
In-Reply-To: <20191104164351.GA2269025@kroah.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 11 Nov 2019 15:18:38 +0000
Message-ID: <CADVatmMzZ9AByeUBtqdrfE_apK58oMYLxSuBrDdLh2XTQzKE9A@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: samsung: rename to fix build warning
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Nov 4, 2019 at 4:43 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 18, 2019 at 08:47:07PM +0100, Sudip Mukherjee wrote:
> > The build of arm allmodconfig gives a warning:
> >
> > warning: same module names found:
> >   drivers/tty/serial/samsung.ko
> >   drivers/mtd/nand/onenand/samsung.ko
> >
> > Rename drivers/tty/serial/samsung.c to drivers/tty/serial/samsung_tty.c
> > to fix the warning.
> >
<snip>
>
>
> What are you going to break if you rename this module?

hopefully nothing.

>
> What configs enable both of these other than allmodconfig?  Why rename
> the tty driver and not the mtd driver?  Why not both?

But, there is no other config defined which has both enabled. Though I can
make one, but since it is not defined and no one else has reported this, I think
its better if you discard this. ( I think you already have :) )  or if
you want I can
send a v2 renaming both.


-- 
Regards
Sudip
