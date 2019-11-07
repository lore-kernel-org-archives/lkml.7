Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4B2C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA8820869
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573161488;
	bh=+J4FAIKTXaaTMUjiB9JwExcwXekKFRbj/8/L2DEZGfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=BnBnZ6XVxtvuDpdmy97eGjF7Rl5YwaV22VVshi5MXvxcj/LyGtXe8qjE3oTaqiZAn
	 PTnVNaP47sxMr2bfhGUvwyOMpIUuUsiw7cUjx7T0iBj6qB7FpYWAT5tI10JCZQH70V
	 dgvIgWFtoL+xwBuduqG3odMGUsHBPRns7hvluH70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfKGVSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:18:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfKGVSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:18:07 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA5DC2077C;
        Thu,  7 Nov 2019 21:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573161486;
        bh=+J4FAIKTXaaTMUjiB9JwExcwXekKFRbj/8/L2DEZGfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gDEqAWSa5ZZIbcdBqNLxXP5Bq9FiF+tJfk5J7VKwv0fHvTOnAkwdeMMxvwyMmrE1u
         M1soAbjwF54DNbKn+WpoBNaHdPDxHjCz7Zfmdng1PWtQW/HA03X/dNziBxwPOkPXG+
         jxicxYHMDkodzwlwUgPlwUTwRQhvsAdsHL37JoII=
Date:   Thu, 7 Nov 2019 15:18:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Olof Johansson <olof@lixom.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: linux-next: manual merge of the pci tree with the arm-soc tree
Message-ID: <20191107211801.GA107543@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMjVUCd9bN=pggS-ECjMR42b0SqXKewsp+NYFSVqRgSWrg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:27:20AM -0800, Olof Johansson wrote:
> On Wed, Nov 6, 2019 at 2:46 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > Today's linux-next merge of the pci tree got a conflict in:
> >
> >   arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >
> > between commit:
> >
> >   68e36a429ef5 ("arm64: dts: ls1028a: Move thermal-zone out of SoC")
> >
> > from the arm-soc tree and commit:
> >
> >   8d49ebe713ab ("arm64: dts: ls1028a: Add PCIe controller DT nodes")
> 
> Bjorn, we ask that driver subsystem maintainers don't pick up DT
> changes since it causes conflicts like these.
> 
> Is it easy for you to drop this patch, or are we stuck with it?
> Ideally it should never have been sent to you in the first place. :(

Lorenzo, is it feasible for you to drop it from your pci/layerscape
branch and repush it?  If so, I can redo the merge into my "next"
branch.

Bjorn
