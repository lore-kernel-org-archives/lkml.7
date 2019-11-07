Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B09FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF642166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vdorst.com header.i=@vdorst.com header.b="DErSWDeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbfKGJUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:20:55 -0500
Received: from mx.0dd.nl ([5.2.79.48]:40884 "EHLO mx.0dd.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfKGJUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:20:55 -0500
Received: from mail.vdorst.com (mail.vdorst.com [IPv6:fd01::250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.0dd.nl (Postfix) with ESMTPS id BDAB85FBCA;
        Thu,  7 Nov 2019 10:20:53 +0100 (CET)
Authentication-Results: mx.0dd.nl;
        dkim=pass (2048-bit key; secure) header.d=vdorst.com header.i=@vdorst.com header.b="DErSWDeC";
        dkim-atps=neutral
Received: from www (www.vdorst.com [192.168.2.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.vdorst.com (Postfix) with ESMTPSA id 70F7860E15;
        Thu,  7 Nov 2019 10:20:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.vdorst.com 70F7860E15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vdorst.com;
        s=default; t=1573118453;
        bh=VNI6ueMuAqg9JykHs42KWFyCu+oSfzrckVrJN6RHl1U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DErSWDeCJGOpQRn/9IeUDgudR8wiBsZK/52Ly5Hj8qYOKx+kIISU/EDojjPAFMf7V
         1zeb2cvB6HtA/xtvbomGdctF0jRFYQU9IVwzqbYFiFmsReIXrlLMrRiIAELkhFFLyG
         B91UMdHXknKgc//LIaMXx/GqSwcHFeVPcU2PZskl7dRY6plX7q/TAqtdoMCZFb+4EI
         /uh6oQw209TxyItkPHW48wPRevFclqyUKUc3CdwgDDmpUCHxo62eij9bBO7dWk2QAg
         JyN/nBxqYW+29pPCkLLDnZITfxNPB1XGKWRR/lGloR7jFyWsntIS8dzndVjlaWdHjA
         aJN4eY5F4PpEw==
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1]) by
 www.vdorst.com (Horde Framework) with HTTPS; Thu, 07 Nov 2019 09:20:53 +0000
Date:   Thu, 07 Nov 2019 09:20:53 +0000
Message-ID: <20191107092053.Horde.i3MVcW9RqZDOQBMADZX9fuc@www.vdorst.com>
From:   =?utf-8?b?UmVuw6k=?= van Dorst <opensource@vdorst.com>
To:     gerg@kernel.org
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, neil@brown.name, blogic@openwrt.org,
        DENG Qingfang <dengqf6@mail2.sysu.edu.cn>,
        Chuanhong Guo <gch981213@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: driver for Mediatek MT7621 SoC NAND flash
 controller
In-Reply-To: <20191107073521.11413-1-gerg@kernel.org>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gerg@kernel.org:

> From: Greg Ungerer <gerg@kernel.org>
>
> Add a driver to support the NAND flash controller of the MediaTek MT7621
> System-on-Chip device. (This one is the MIPS based parts from Mediatek).
>
> This code is a re-working of the earlier patches for this hardware that
> have been floating around the internet for years:
>
> https://github.com/ReclaimYourPrivacy/cloak/blob/master/target/linux/ramips/patches-3.18/0045-mtd-add-mt7621-nand-support.patch
>
> This is a much cleaned up version, put in staging to start with.
> It does still have some problems, mainly that it still uses a lot of the
> mtd raw nand legacy support.
>
> The driver not only compiles, but it works well on the small range of
> hardware platforms that it has been used on so far. I have been using
> for quite a while now, cleaning up as I get time.
>
> So... I am looking for comments on the best approach forward with this.
> At least in staging it can get some more eyeballs going over it.
>
> There is a mediatek nand driver already, mtk_nand.c, for their ARM based
> System-on-Chip devices. That hardware module looks to have some hardware
> similarities with this one. At this point I don't know if that can be
> used on the 7621 based devices. (I tried a quick and dirty setup and had
> no success using it on the 7621).
>
> Thoughts?

+CC DENG Qingfang, Chuanhong Guo, Weijie Gao to the list.

Hi Greg,

Thanks for posting this driver.

But I would like to mention that the openwrt community is currently  
working on a
new version which is based a newer version of the MediaTek vendor driver.
That version is currently targeted for the openwrt 4.19 kernel.
See full pull request [1] and NAND driver patch [2]

It would be a shame if duplicate work has been done.

Greats,

René

[1]: https://github.com/openwrt/openwrt/pull/2385
[2]:  
https://github.com/openwrt/openwrt/pull/2385/commits/b2569c0a5943fe8f94ba07c9540ecd14006d729a

<snip>

