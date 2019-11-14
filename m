Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C36C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B083206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573710658;
	bh=4A75EbHYfhyoJ0lhDbgLRn70lmtQcL0MNpem0+VHKtk=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=dWVsLR8+2UlkQGdQ26j2zjnosAAVdTbZFSo1psuy8SDV5xeOlZhdl8KcNCGkDv/m7
	 4hrpBKMXGy6zXt53w6fpmud0khKLbADe06oi1nopccWRYtNDkzYaovqUgwdoHTiO44
	 M1mQmAyJT0CaPLWgM3SFXXMxEvpIeJR8Musr8qvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfKNFu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 00:50:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfKNFuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 00:50:55 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C280F206DA;
        Thu, 14 Nov 2019 05:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573710654;
        bh=4A75EbHYfhyoJ0lhDbgLRn70lmtQcL0MNpem0+VHKtk=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=1n08guEVhPb8UK6CAVnBSbKcdr1bhzFAIYzVKmdZyTwg3cLFLt/y/po33Fzs3Z23j
         yU5A9GSYX5vYnxlWu6QZ9iRnSMh+HDgucz/akSpMXc4HslM/XwnjgTN5+GeY37Hl5d
         db1fLr78Pu6s7rG92jverAQAFSl9D1Y5Dz/cIgDU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191114053404.GA8459@mani>
References: <20191026110253.18426-1-manivannan.sadhasivam@linaro.org> <20191113222116.E5E9B206E3@mail.kernel.org> <20191114053404.GA8459@mani>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6 0/7] Add Bitmain BM1880 clock driver
User-Agent: alot/0.8.1
Date:   Wed, 13 Nov 2019 21:50:53 -0800
Message-Id: <20191114055054.C280F206DA@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-11-13 21:34:04)
> On Wed, Nov 13, 2019 at 02:21:15PM -0800, Stephen Boyd wrote:
> > Quoting Manivannan Sadhasivam (2019-10-26 04:02:46)
> > > Hello,
> > >=20
> > > This patchset adds common clock driver for Bitmain BM1880 SoC clock
> > > controller. The clock controller consists of gate, divider, mux
> > > and pll clocks with different compositions. Hence, the driver uses
> > > composite clock structure in place where multiple clocking units are
> > > combined together.
> > >=20
> > > This patchset also removes UART fixed clock and sources clocks from c=
lock
> > > controller for Sophon Edge board where the driver has been validated.
> > >=20
> >=20
> > Are you waiting for review here? I see some kbuild reports so I assumed
> > you would fix and resend.
>=20
> I'll fix it but I was expecting some review from you so that I can send t=
he
> next revision incorporating all comments.
>=20

Ok. I'm glad I broke the silence then.

Can you please resend without any dts changes? Those don't go through
clk tree. I think otherwise the patches look OK, although I was hoping
you could register clks by using the new way of specifying parents. Is
that possible?

