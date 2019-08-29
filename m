Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C9EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC8623405
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n3UVmRw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH2Tyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:54:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfH2Tyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=55avPHCB4kgSPVu+7a0pbbDNIW2N286oF9ZXSEbhdNU=; b=n3UVmRw89l02Nb/TRMTXOwgxt
        it/ol8/ca2qtY1iKiuoug5dTVmJlZ+7QB+Zz26KrgxKj34kjUnS5Y7pFDXfTTSYhcPLZ+2ljpU2Lt
        TwirMGLPpsifQ2aCbndYOJdDJHDxK6uGat++9JdfwjVfp6NZj6Fd9RRiSPYj2BkME3OmS1Ul5gJSS
        P9Gtt31aQIn971104XObqNl5GvG/SL8dvE6c/mF3owKDmSEKAPAu8W6CWAsNNkDozDbS87XCskr6T
        2S5henQWrhFYMb5SEkPHzvKUMGnWyQJsDxiX7xDeuXbiV6E1jtaySqDcSZUQ3xpa01S8n2o2iJMvL
        rMxlCe5Mg==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3QV5-0000G1-M4; Thu, 29 Aug 2019 19:54:31 +0000
Subject: Re: linux-next: Tree for Aug 29 (mlx5)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
References: <20190829210845.41a9e193@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3cbf3e88-53b5-0eb3-9863-c4031b9aed9f@infradead.org>
Date:   Thu, 29 Aug 2019 12:54:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829210845.41a9e193@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/19 4:08 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190828:
> 


on x86_64:
when CONFIG_PCI_HYPERV=m
and mxlx5 is builtin (=y).

ld: drivers/net/ethernet/mellanox/mlx5/core/main.o: in function `mlx5_unload':
main.c:(.text+0x5d): undefined reference to `mlx5_hv_vhca_cleanup'
ld: drivers/net/ethernet/mellanox/mlx5/core/main.o: in function `mlx5_cleanup_once':
main.c:(.text+0x158): undefined reference to `mlx5_hv_vhca_destroy'
ld: drivers/net/ethernet/mellanox/mlx5/core/main.o: in function `mlx5_load_one':
main.c:(.text+0x4191): undefined reference to `mlx5_hv_vhca_create'
ld: main.c:(.text+0x4772): undefined reference to `mlx5_hv_vhca_init'
ld: main.c:(.text+0x4b07): undefined reference to `mlx5_hv_vhca_cleanup'


-- 
~Randy
