Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908FFC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011C0216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="c14Pz61K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbfG2ONj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:13:39 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:16415 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfG2ONj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1564409614;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=bJHqTONXYp006eOkJA1v0tEzHaPsPs7ladTfwDG0Q4E=;
        b=c14Pz61KroUKVe7ym0p9ZukvBXY7K2Dq1zI2caPm34+bpZR1J7cnXiEg7zSzrSxSvY
        3t9zDwEY9g3zqFVxY3jaWl8Z8jAPho4VjNKcRtPtIMXBO1o8QCI2rNsdvppC+PhRf4vl
        YMU83QOyzlFCQuoWfISJ0WZ58PbXyG4l6bhbg68tznxbhRVLx4yrTfyQKO4i4aUTFJzZ
        KVF3DJz+/e2FtqUW1BWIj3pmxe3Tz2pC+MoqD5qWbi3anR1P/DwaAd7oWq1G/gXs0yYf
        qnWxCXfmBFVm3O2+JSpXfnTInvmbuU00K0ZdIXVJIElJSlkBG7UsWHSXNGuMyVWFE86L
        8KMg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJUsh5k0mJ"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv6TEDNuAl
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 29 Jul 2019 16:13:23 +0200 (CEST)
Subject: Re: [can] 60649d4e0a: ltp.can_rcv_own_msgs.fail
To:     kernel test robot <rong.a.chen@intel.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        ltp@lists.linux.it
References: <20190729094112.GM22106@shao2-debian>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <786568d6-bd24-327a-8367-319efbe2cccb@hartkopp.net>
Date:   Mon, 29 Jul 2019 16:13:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729094112.GM22106@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

On 29/07/2019 11.41, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 60649d4e0af6c26b6c423dea9c57f39e823fc0c5 ("can: remove obsolete empty ioctl() handler")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git master

the kernel test robot is right.

The patch ("can: remove obsolete empty ioctl() handler") leads to a 
return value of -EOPNOTSUPP instead of the former -ENOIOCTLCMD.

As we can see in socket.c ...

https://elixir.bootlin.com/linux/v5.3-rc2/source/net/socket.c#L1041

         /*
          * If this ioctl is unknown try to hand it down
          * to the NIC driver.
          */
         if (err != -ENOIOCTLCMD)
                 return err;

... we need to return -ENOIOCTLCMD to pass the SIOCGIFINDEX ioctl to the 
NIC layer.

Therefore the entire commit needs to be *reverted* to restore the 
required functionality.

> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>

Many thanks,
Oliver
