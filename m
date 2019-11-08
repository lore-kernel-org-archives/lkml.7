Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FFCFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CD8214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2U5fy1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389009AbfKHUTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:19:09 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36823 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfKHUS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:18:58 -0500
Received: by mail-il1-f193.google.com with SMTP id s75so6255680ilc.3;
        Fri, 08 Nov 2019 12:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Buzlffd6qPZ251pCZD0B39C9+fvZzH1TSbcG09q8kOM=;
        b=E2U5fy1GS15GNw8LWY0zWj+xg+cFRiv3arN9dfOCfPpp8SeACKDuwjQx35uGwKkxJq
         rYXGLQh5316oaljNVZYrfIPN67Mdle/ZpOdqFDyVUD+ZVJc09VstOgZ0qwN4LtUAmybG
         dCYvqagCutIWKJ3fFcbprCjA+Jcwex90SoMOHUCDpdeOBw8N/h8uusTl11YBUC0km6wY
         YPmwAcCukRny/ZJfFYsw0QoUlAPkaGNh4szDNH7WAau7Dx1Tdbsj+j6a/fCRR0b1v6+Q
         0Gdbkv2bDEa6YyDZ4mXsw/FpLCzcj8clZZNituJYCWxY0/GkLfk8eBoUFnrXckDQb4WN
         5F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Buzlffd6qPZ251pCZD0B39C9+fvZzH1TSbcG09q8kOM=;
        b=HM8pX1HsaFmgXYnijs8yD+TV5TK81vne5r5MLMPN0JqD3RdYcp4vfAE5jmU+WkOhGD
         BI9VZt4Lgnqg30rfj0rEJDetTliG6x1xXHwB4bf2RYDzwCcekDOL+eWbc6JYNjPn5wvP
         cb705HEXk5nkB/VB78UEvI96q7YHXxVKQDZyqt2kkQFr98uH2KXQcE/r26FBeba3DrMW
         4wtvu9mYSYENKQt7Bhjw/YBFzfL90zfMzmJ0nDUAXJ/jQRCJyS+4xSUhpDL6sedES3rC
         T5Ijy6+4b35Q0RlJJrQKPlrGqJsRBMY+0JgZsNLJ7JYyXceOSYhy3tOUyU8BekpK8ZH8
         lZJg==
X-Gm-Message-State: APjAAAUChOsrwJOOlRHmFkvWUFRUfgKq420R1oCLh1krp2Ydxx6+is9m
        Ffc0Wmx0o7pPhxEOzAIPevWOlx5i47sLD/rwVv8=
X-Google-Smtp-Source: APXvYqwl51D2sksVNbNWnw3MblkRidAPR3sW4psWmp9RV0h3tFjpgG3mZY7AvHGAjxlVmCjySEmRNAp3bsgKVmyRfSQ=
X-Received: by 2002:a92:297:: with SMTP id 145mr14835935ilc.85.1573244336215;
 Fri, 08 Nov 2019 12:18:56 -0800 (PST)
MIME-Version: 1.0
References: <CAOesGMjVUCd9bN=pggS-ECjMR42b0SqXKewsp+NYFSVqRgSWrg@mail.gmail.com>
 <20191107211801.GA107543@google.com> <20191108110736.GA10708@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191108110736.GA10708@e121166-lin.cambridge.arm.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Fri, 8 Nov 2019 14:18:45 -0600
Message-ID: <CABhMZUV=757JyGEuMQsfbrpiHUhn8uDgiKTRvxQNFAmxfmX0TQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pci tree with the arm-soc tree
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 5:07 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Nov 07, 2019 at 03:18:01PM -0600, Bjorn Helgaas wrote:
> > On Thu, Nov 07, 2019 at 10:27:20AM -0800, Olof Johansson wrote:
> > > On Wed, Nov 6, 2019 at 2:46 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > Today's linux-next merge of the pci tree got a conflict in:
> > > >
> > > >   arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > >
> > > > between commit:
> > > >
> > > >   68e36a429ef5 ("arm64: dts: ls1028a: Move thermal-zone out of SoC")
> > > >
> > > > from the arm-soc tree and commit:
> > > >
> > > >   8d49ebe713ab ("arm64: dts: ls1028a: Add PCIe controller DT nodes")
> > >
> > > Bjorn, we ask that driver subsystem maintainers don't pick up DT
> > > changes since it causes conflicts like these.
> > >
> > > Is it easy for you to drop this patch, or are we stuck with it?
> > > Ideally it should never have been sent to you in the first place. :(
> >
> > Lorenzo, is it feasible for you to drop it from your pci/layerscape
> > branch and repush it?  If so, I can redo the merge into my "next"
> > branch.
>
> Done. ...

Thanks, I updated my "next" branch to incorporate this.
