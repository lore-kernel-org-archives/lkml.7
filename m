Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6797EC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A022084B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560849247;
	bh=G5n7tQEA4D7IaVaj+n+intnIJiU7vvwx1xThRaNy7Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VyVc44CVdbm58mbCo3n/lDs9koxEf+bOijjTuYdHdTIPcUqtFqI5UpcIFfgodp7LH
	 L4GwyTgX2vEs0c1pIjaITKFoTUdrLD8TjGNOeaIOXOQkJ/Ng8CYhWAd4oOjnrI+0EH
	 LomNwU5HPt/nXpwncGjpuHI+6P8cMlIla+hnnTX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfFRJOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbfFRJOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:14:05 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BB13206BA;
        Tue, 18 Jun 2019 09:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560849244;
        bh=G5n7tQEA4D7IaVaj+n+intnIJiU7vvwx1xThRaNy7Nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1AE0dKeXOphrd0NEoeC0kvijNE5Z3yzzZaSZ+0GwZF/SIAzx9uT2NX9XnsXG3ogcj
         fzvhWN9nY3ncNjYjwlBe42xt7Ro2jBIaXnuq2wX6uSretwiO9qwiZvVSRD/RhgOnNT
         B0GLmfhS0LDLFiXbe1ARbwhGxQnwLiPB/9vzspXw=
Date:   Tue, 18 Jun 2019 17:13:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, viresh.kumar@linaro.org,
        abel.vesa@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/2] soc: imx8: Fix potential kernel dump in error path
Message-ID: <20190618091309.GL29881@dragon>
References: <20190614080748.32997-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614080748.32997-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:07:47PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> When SoC's revision value is 0, SoC driver will print out
> "unknown" in sysfs's revision node, this "unknown" is a
> static string which can NOT be freed, this will caused below
> kernel dump in later error path which calls kfree:
> 
> kernel BUG at mm/slub.c:3942!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc4-next-20190611-00023-g705146c-dirty #2197
> Hardware name: NXP i.MX8MQ EVK (DT)
> pstate: 60000005 (nZCv daif -PAN -UAO)
> pc : kfree+0x170/0x1b0
> lr : imx8_soc_init+0xc0/0xe4
> sp : ffff00001003bd10
> x29: ffff00001003bd10 x28: ffff00001121e0a0
> x27: ffff000011482000 x26: ffff00001117068c
> x25: ffff00001121e100 x24: ffff000011482000
> x23: ffff000010fe2b58 x22: ffff0000111b9ab0
> x21: ffff8000bd9dfba0 x20: ffff0000111b9b70
> x19: ffff7e000043f880 x18: 0000000000001000
> x17: ffff000010d05fa0 x16: ffff0000122e0000
> x15: 0140000000000000 x14: 0000000030360000
> x13: ffff8000b94b5bb0 x12: 0000000000000038
> x11: ffffffffffffffff x10: ffffffffffffffff
> x9 : 0000000000000003 x8 : ffff8000b9488147
> x7 : ffff00001003bc00 x6 : 0000000000000000
> x5 : 0000000000000003 x4 : 0000000000000003
> x3 : 0000000000000003 x2 : b8793acd604edf00
> x1 : ffff7e000043f880 x0 : ffff7e000043f888
> Call trace:
>  kfree+0x170/0x1b0
>  imx8_soc_init+0xc0/0xe4
>  do_one_initcall+0x58/0x1b8
>  kernel_init_freeable+0x1cc/0x288
>  kernel_init+0x10/0x100
>  ret_from_fork+0x10/0x18
> 
> This patch fixes this potential kernel dump when a chip's
> revision is "unknown", it is done by checking whether the
> revision space can be freed.
> 
> Fixes: a7e26f356ca1 ("soc: imx: Add generic i.MX8 SoC driver")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
