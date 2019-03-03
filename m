Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49DBC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 23:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97DC20830
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 23:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="ImD1quPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfCCXU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 18:20:28 -0500
Received: from sonic305-21.consmr.mail.ir2.yahoo.com ([77.238.177.83]:44083
        "EHLO sonic305-21.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbfCCXU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 18:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1551655225; bh=hJJs89gLO3zR8QQLuElz8/Yqbfde/GI2GHShr2zQm20=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ImD1quPIstA/ltgesQ5Kle203d50x7IdL9aaWmJmolZ8z9MdvRSnwwk7samUZTZ9k/kZgoAMFjepnpRXK+8hWZhwiawo9FqpJ5mETBztRg58WkPJx8UQYTY15xzquOepd5iF63bcFZn/6lHjb+f+ewbi3gMgj0ef0gb16bD1tfu/2KJ3JZ9MJdjqICWmUJ0D1trSPTu+YKvLlFbGYrikIk3KBQSWzSTN2zCYvy/xTjbGnEFm10cB7MK30BLgtgPDNWRVrqnMS4Z2bw0C03oihk6dnibpsZE1E1xth6yDSVw0cH0mThKOYdv2f6IOGTr37JSjbfjXOCdWylp45fWdzg==
X-YMail-OSG: WNqoP6MVM1nwpz3m2S8zh6Mh7W8eZUlUa2.fwkA.DoCz9453IdKt_Kh5mbZQCea
 ayj1tMMC8gXB3Iu9eTon1ZWOl2Dt8cvc1nt18Cli4G3VzhQfGXv3EQnzez380PyN104OZkdQn50A
 vuZZS1Q8K8V7ITG_VIJ1gQpKSasem55o5g.B2B2ACp80kIuOyeARJRuZZ_8mxz6EXs9qER7RGAJY
 wDbGwHZA39CG3cVyfJYeSrwPrOX.XD7I4QZXbujmrzzkS9M9yDlwN54CCl_7Wjyp7_MDB6t238.j
 LG5tMtban9gTA3JhzAUiIO2W6g34YQYQf7QlUKkVa3YLggPmiMOuLvbL8MeS.Wp8noIkOCmVqpZM
 e3yTVVn.NRWxJwIVC6Vfg_yRDL6KmEy0.f3bEre1hm1X7EH.pCti6WltjUU80W0ED9nCHW1k3mJ6
 C8VvuQQN3ijVYxcMLxGsw_TuvqNKwMMKhHKodZn2J5getkmEr7sANnMZLwAV.E3T.zOaDOPHA.B8
 z.MzVFdQi1waseEH9KB8jR_gTVzxsY75c.iaJtoQtlVlA9LM83JdnmTGHW.Wnsmt_EcMhn6tdxfs
 1QZGD6tnnsYz7IeokrQrvhfflUbhRUJ3.GUAwh1pf.LhUM4BcBVG9541ZA9AQE.L7GzG2LxL6NRY
 sgvAub_vpU0f6kgFg7kzLoBv7rJqyHFpk5rxaJiE._LabSf3OOG8jFbk0gBTDNC1JpEJvasMmUBY
 u3hIkTVaER7viFV8tkFNBqgKf9tmY435m1MLfxQIUdQ54alne3WoeOLbwDWVEWegv2IMWcCTpKR5
 3CQBthnu8.0nnETwDuyII2.CHFc8U4fDjYPeMOdnrEowjdO014o3g4XKTyyEdctZ.aiwWPswoUzS
 5XJ7UyONbLHBKURWBIeeVuZEn7.6W.dq2TeQo0OB7DImyZPGQ8r_dizt2qpuMFr.dB1dv.8DUqMp
 5Ij1UA3v6mC3.lCqOHE7nqc0jhO7FBtBty_GF_lw93KJ.55Km3ylSDNpK4sxxuC4CopkoxMq8E5j
 Uo8WmnpmlLhFmyAkOpj4G3Yywk7_jLRY34utfrcsL7beHTuUNEK5r
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Sun, 3 Mar 2019 23:20:25 +0000
Received: from 125.120.226.215 (EHLO [10.1.1.220]) ([125.120.226.215])
          by smtp412.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cffb140c901cd21086c4a78b37c17fea;
          Sun, 03 Mar 2019 23:20:22 +0000 (UTC)
Subject: Re: [PATCH] staging: erofs: dir.c fix "alignment should match open
 parenthesis" issues
To:     Dominik Adamski <adamski.dominik@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
References: <20190303223718.31937-1-adamski.dominik@gmail.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <2224517f-f4cd-538f-0f7c-7a5b64ea536a@aol.com>
Date:   Mon, 4 Mar 2019 07:20:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190303223718.31937-1-adamski.dominik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/4 6:37, Dominik Adamski wrote:
> Fix checkpatch issues: "CHECK: Alignment should match open parenthesis"
> 
> Signed-off-by: Dominik Adamski <adamski.dominik@gmail.com>
> ---
>  drivers/staging/erofs/dir.c | 8 ++++----

duplicated commit...
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/drivers/staging/erofs/dir.c?h=staging-next&id=cbebe5d05dd7fe2fdd13cff7c4a62f22109f1f95

Thanks,
Gao Xiang

>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/erofs/dir.c b/drivers/staging/erofs/dir.c
> index 833f052f79d0..e1955703ab8f 100644
> --- a/drivers/staging/erofs/dir.c
> +++ b/drivers/staging/erofs/dir.c
> @@ -24,8 +24,8 @@ static const unsigned char erofs_filetype_table[EROFS_FT_MAX] = {
>  };
>  
>  static int erofs_fill_dentries(struct dir_context *ctx,
> -	void *dentry_blk, unsigned int *ofs,
> -	unsigned int nameoff, unsigned int maxsize)
> +			       void *dentry_blk, unsigned int *ofs,
> +			       unsigned int nameoff, unsigned int maxsize)
>  {
>  	struct erofs_dirent *de = dentry_blk;
>  	const struct erofs_dirent *end = dentry_blk + nameoff;
> @@ -104,9 +104,9 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>  		nameoff = le16_to_cpu(de->nameoff);
>  
>  		if (unlikely(nameoff < sizeof(struct erofs_dirent) ||
> -			nameoff >= PAGE_SIZE)) {
> +			     nameoff >= PAGE_SIZE)) {
>  			errln("%s, invalid de[0].nameoff %u",
> -				__func__, nameoff);
> +			      __func__, nameoff);
>  
>  			err = -EIO;
>  			goto skip_this;
> 
