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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD71C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 12:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F54E216C4
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 12:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="r9GHNBdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfFHMGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 08:06:20 -0400
Received: from sonic314-19.consmr.mail.gq1.yahoo.com ([98.137.69.82]:33370
        "EHLO sonic314-19.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727865AbfFHMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 08:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1559995574; bh=9E7MyQwq36DvghPQy6gbYSm5lbo+i9g9K12tGggIgLM=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=r9GHNBdfTrGLdNxj56yG+fGQud77WJx4xUHXbzfggSV9sJlANrSYsCvTs/W43HtH2U3g+8f3x7gVgJtWKBlPGw8qU8T1UH472yeVrC5//sr2y9t0f7h66BFAVXJXVwjSHAeeuTXnkAGCC2apX8Y8aZmuH4iBwwhfra9aFxMJfukDgL6vJWTtItwGSheBLV+g8aPgH527HONbu+AZD8ssjTYZntFkuRZvA7XTSlsC5srEvhThHuVgBYpjhCXCc6I00hguMBoIvRQvCOoKOR2WURnTvBorRSYmnqGvqJBforNoklFu9bV8hjxc2zA2A5NJSk2i9OuKo/tYyeI5u3byVw==
X-YMail-OSG: _4r6oOMVM1kH7YRduJ1JYn5fyb2KOPttvNkglhqqCq6jnBgKu8OubVI_xEvmyEo
 XawmcGsu7eaISjVB7govGwor3Lv3LjdyQzP1F2nVX_3BFjPWG4S9Rn4bUeo68fhf58GZhYKHMDwa
 vBu4.Gh4cYYJ4a.3km5VA_iC7izhpPeuzc5I7a_L.6ie_1i6TWY4qJM.GT4lniFw49cmwcL_uvra
 qEZhZN8WnlBESdUPDSd1aMc9JJCTyEJPROTq7VjMBkIYc075A8R8iBPfiWN1F7I6GMHMkIYyRIkU
 M7YwVuuPEi4ZY9wkeVlXB_qS3Pf.r9vnb9PGg9w8kX89L6E7gQgk6UiIGa4kdbxkdY7hAu7HmlVU
 uqMz.oeVKVkMr9v2xjFwBnUAn.sQsPC3LwpghbB4v87W_9T_U9pGFtpecbGGA04xYggw46yqeoom
 koMV.V70oC5pChfdevkqi6QucSKqbXIom84RRsNr5oob7uiWOYTlIcAMK3MO8bz_TT0b.WRI3aAv
 Nz4oud87s0Aw9GwilkltRCGoRkg2UstH8k_XS0BE8AkCSKoxnwwJ9bHObofuY4lzDAPYDUjltf1m
 p4G0V.m6SFvHn3RQhDifz2xNDnW_74fQyC4T1FT7rtb.SV5Pt9uDoAK84Ihs4h3CoQlzkr89OLNR
 HVc1pLxbHIKgFZKUU8YQHlCTpl9_iuLrZqxnJ3tNveN7f0rmI8HD8cjpkG._8YjhZuoYRraruJ4l
 d8vik1f8BN9csyA6mP7WBM6nCFFWcmM05PZxWDqKHRtec4I4tTaqTUc2PPT6g5E8OOaYC1wJjwMh
 pGXepoSCH_TYM2YJvfqjcSd5yi2m4ilkHraILk11887h4qETnNuFZ2XQZ.ECn39bjW.uG_9RrITU
 9gbxuwV6wuQbEw3lBjOlLZO7R70K_wBzFY_OWda0F0FCuTTRqvmG3ribTSSF9WGn182KfwNoy2xw
 UNSaLSTvhTcLoAlcQBW7.t.tFzWysiK8XGjc7CCbTos2gkCNH7srHDvQ9onVEbmcdK69Y0szV8aN
 .gOm7womykJxf31YPQAFlToQw6oUgKcfVU3uzPbtq9xLdChzG6Bwz41aNkRuPkP5VcH3hhiP9KQh
 8m_hF83O6PgwaATFlJbwyw5UwKoE6HcO2YeXxzeyZD1IhpIU2aMZvpvUljMpxLvKtT4cNJWiuV6M
 MfDElje1ByvLUIz_RdAg5bBG.4_HUNJux62uVfpgM2g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Sat, 8 Jun 2019 12:06:14 +0000
Received: from 125.120.226.196 (EHLO [192.168.0.101]) ([125.120.226.196])
          by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3dfb8dff750982ce7b5096f4cd30efc9;
          Sat, 08 Jun 2019 12:06:14 +0000 (UTC)
Subject: Re: [PATCH] staging: erofs: fix warning Comparison to bool
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
References: <20190608093937.GA10461@hari-Inspiron-1545>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <8aa1fe39-27f3-e74b-5985-c67e04be2f31@aol.com>
Date:   Sat, 8 Jun 2019 20:06:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190608093937.GA10461@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/8 ??????5:39, Hariprasad Kelam wrote:
> fix below warnings reported by coccicheck
> 
> drivers/staging/erofs/unzip_vle.c:332:11-18: WARNING: Comparison to bool
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

> ---
>  drivers/staging/erofs/unzip_vle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> index 9ecaa87..f3d0d2c 100644
> --- a/drivers/staging/erofs/unzip_vle.c
> +++ b/drivers/staging/erofs/unzip_vle.c
> @@ -329,7 +329,7 @@ try_to_claim_workgroup(struct z_erofs_vle_workgroup *grp,
>  		       z_erofs_vle_owned_workgrp_t *owned_head,
>  		       bool *hosted)
>  {
> -	DBG_BUGON(*hosted == true);
> +	DBG_BUGON(*hosted);
>  
>  	/* let's claim these following types of workgroup */
>  retry:
> 
