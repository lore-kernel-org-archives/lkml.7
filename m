Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D1EC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 12:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53A820693
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 12:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="bDMcOZIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfFHMLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 08:11:47 -0400
Received: from sonic303-20.consmr.mail.ir2.yahoo.com ([77.238.178.201]:45749
        "EHLO sonic303-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727191AbfFHMLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 08:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1559995904; bh=KvReJB3bNC8VOtsMTPigIMkLct1KV+hCCuAue4hnO8c=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=bDMcOZIrahj+HBbU0JUUVnjtQSXN2ZHGV8PEzvyrcG49h/sOSRSMMdAFdrZYajF3hu1m39an1Va/bXXT/6hZwAw3X2ZVyyaFzdokvoG1klhiRAuxU7wFPB+nGlIbq5vUOVrrfLCzlxt2t4tFb8yhoomRaKOAq7IcnZmEg8EH/lO8hW5QVa8vBgbdz/yfk1h7Lx745OF5//F1rfCwwCWuMf9CNC9agw60HYGvaMIPth/IZYCc3QXiHsCpZ/pEo5YCwbE8aO4iy9L3Gu7DBjsQ7acKsuQysqzoG0xiwrCXood5cRwGCfsTE2MVe0XTdnSf6Wf/D94fMq1rfXS2+aBD0Q==
X-YMail-OSG: X0VcEgsVM1kj6QP.grn7pZmdoJ9yh4I39ENaddveK7euHDhzLkOly_LHcHUH_Bu
 52FySkfH1EhebGY_fu3o2vZUicdi99eDTrlieNDSJ4QQ6a2MZj33HaDsHzUabrD2lW1HPQR9JMa9
 FIZrwfkIJYtO5Qua5foxAHWxORV3bTCy6VKPdwVupw8UEJceEwomL59H70XyT6fRa81cEJ88plFY
 E2zT1CqyPYPY_Drc_h9LU2CnSZ64ruZ8tN5Fa4_hYhgpF_kusTOXIkCd.no05OckYdEWkjpC5CpU
 .w0HEuh_JP2djKtpz6fF2DGOnYhNtr_mMdBlDJ2RUH7maT7IrtWLYtGzZTf7CNj3s7aSq7RQedty
 z2xKwnUdQmZxkUFFy1KCBO1TB9fm6zeKnCATD7kJN5N7Ergt19T5Bl25A_UW0S5v2E6E1OG35Iad
 GnsaW_H.XDiZIXakBVIkYp6bNkE2lI0Rs1jEE9_iTlFVfn1bQvfQwU5JnYxSlexI_ZGVNx2R1FS2
 I3PTtnchEF0FOforb9HaqbWxafCdfL2.wernSWenqkk3NTH.I.WhrQqgOkZvKL8bXpr6fG_H8WMP
 l62dypNbqGqAEQaUOAidvLi4n.sJ3vhhYrwCfTXL0AIQJOqVN.GwS._c9v7zJ9Kz_8NTiYa90Lcp
 hYexQfy3qfgtzmbnrx87ohdP9wouoLypdY7G_Hs_smBU3tyUH6noIJkD2zoScHGCY8MAYJaX7jnW
 oCueO3DxAtdG00QJ8yHYTLFt7FQl_ttSrlRCWo5kwE3Jxa8bJeZlUnxNwoJ7HWLtVNSAUTdI234K
 QkbM.1JvSGNJfUlfGzTUdGz7_.J5k4PLz_QyRqQSncIUqHPn4rEpJkyf9Nzv9zoWiBDe8H5Jx3KT
 S41z3H7zoR8Js.zfLC.IspsGDq_4xruXJ_jf3b4o.1g0zgLvr7y55hS56P2pgT7_WXDE3JysYLfk
 SOdspW1bbAVL0p0NMIUhGZZ5ng9U8tz3zYjFpQYaPpAjhL4k4daPWqA2c5TyytXSRmyugsSpgLBZ
 VOePAQT1e2f3UBTw99XA6iWc0utDP.HAx3T05MUPKNSEUoopZHR63YIGswu6HOGiNjaMYMQp9rMK
 qGChP3eu.JVbr.ETsA5nGLIeQmVe0nkSm7_wnSRVOZHSFmA3w5GY8_RuS0gp24ejJZOJFsgZ7Rly
 Wa709w3kvUplTPyc.5MffCn20x4I4Vb6OMfTEeSE4F6A-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Sat, 8 Jun 2019 12:11:44 +0000
Received: from 125.120.226.196 (EHLO [192.168.0.101]) ([125.120.226.196])
          by smtp415.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID aaa314d510ea14c03aa85b21185d2f79;
          Sat, 08 Jun 2019 12:11:43 +0000 (UTC)
Subject: Re: [PATCH] staging: erofs: make use of DBG_BUGON
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
References: <20190608094918.GA11605@hari-Inspiron-1545>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <0b6db3cd-25ec-49b2-93e0-31d0677507c1@aol.com>
Date:   Sat, 8 Jun 2019 20:11:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190608094918.GA11605@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/8 ??????5:49, Hariprasad Kelam wrote:
> DBG_BUGON is introduced and it could only crash when EROFS_FS_DEBUG
> (EROFS developping feature) is on.
> replace BUG_ON with DBG_BUGON.
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

> ---
>  drivers/staging/erofs/unzip_vle.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
> index 517e5ce..902e67d 100644
> --- a/drivers/staging/erofs/unzip_vle.h
> +++ b/drivers/staging/erofs/unzip_vle.h
> @@ -147,7 +147,7 @@ static inline unsigned z_erofs_onlinepage_index(struct page *page)
>  {
>  	union z_erofs_onlinepage_converter u;
>  
> -	BUG_ON(!PagePrivate(page));
> +	DBG_BUGON(!PagePrivate(page));
>  	u.v = &page_private(page);
>  
>  	return atomic_read(u.o) >> Z_EROFS_ONLINEPAGE_INDEX_SHIFT;
> @@ -179,7 +179,7 @@ static inline void z_erofs_onlinepage_fixup(struct page *page,
>  		if (!index)
>  			return;
>  
> -		BUG_ON(id != index);
> +		DBG_BUGON(id != index);
>  	}
>  
>  	v = (index << Z_EROFS_ONLINEPAGE_INDEX_SHIFT) |
> @@ -193,7 +193,7 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
>  	union z_erofs_onlinepage_converter u;
>  	unsigned v;
>  
> -	BUG_ON(!PagePrivate(page));
> +	DBG_BUGON(!PagePrivate(page));
>  	u.v = &page_private(page);
>  
>  	v = atomic_dec_return(u.o);
> 
