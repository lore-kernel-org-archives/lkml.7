Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772CAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE2C207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="dOLryY6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfCJHzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 03:55:49 -0400
Received: from sonic304-23.consmr.mail.gq1.yahoo.com ([98.137.68.204]:41136
        "EHLO sonic304-23.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbfCJHzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 03:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1552204548; bh=r3y5YGbcvhx7dMMYpFJ7Wtyes0yak7/C4Yd5mRFlflw=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=dOLryY6JRniI1y9DCZQn+M9XibEYFsxt6RNbVvuSQ77hroaPoEOqTF65KW1jCVFMbtatt6V/9OTVzihDi8yilHCHPFNa8qMzkQmCJXtbsDM/mV40TrH5pjbi1RuyS/Dr1enLRKTOSwNQKixjnapsG+/IDkv6+3kRy4FUpCBKpwEGehyxMAlKpv+BQ8lS4y6go6WYRhdRxmFndEidUHd6PbzO1pPbTOBru77A/osVlte2mB3AhOiTBE26SyqGfRcUqTRq4MKS8jiDS+dAi7H4EbQ/PDWv+NjalTaBic4kkKj29uMXj/Xx+5BmG4YinFBeu87tb2lX4vuMwGH0h405Ew==
X-YMail-OSG: IKrslHsVM1n_QuRTRG31fZi9QbrS1vU8Fle1wy82v.S09WaMDlpLTACWYBU37lG
 F5XxxAJWqNq3KXUvoBJ5b1qZnbY991NVpoEENGOJDvShWe_IoIav4g9WDezBS5tLUvsNEpQJw6lR
 OyhW0i.DCeTvxY4XBW6Jb7tSXqqrKs.8qzHvlNlmnmUuYupjyqustH.tA1ODU3w1XazOjwBRD4CC
 eMJTpPOGls5bgb1I6KAD2EOQxMG.3hTQTtw0319CdW.AKszCaBwM5EAH8c9Zty__TLYUOWdLiJ4A
 uuQUlZiuHoF6GwChQ7Q6WN8fbENrTw.hhf6Ji2_dSClHFAMxAwlpOJ6FMQAJPuwSXAtiAIJvlY5a
 4EB7aVFIYjkwKui3cBDLVPwERWV7ICZfqAHYF9CF8re7nPIlNZqszmGO0d9W.xd2IoRBR2Q2Q9aT
 CwtVvp88Ezhy8f..aTNzYtPRWbbSb2gyzy8OrbnuYMwdXmYHVoH.1lk9hUdob7wQuh4jGMMtQtKZ
 6xlhpA_32jc.QxgY0OIZpSGPfziuHU4plt6r0xBmo3ik1v1xBjkQGlXXy6IrzS_gBr4KSkgUVlsF
 MMbrojM5ahYOgUO_VnkjJwQJOvHr9LzcS8EUw2w11kxVGAOHos5jkbrjZJP7FmPW4jz9x66twoiW
 pUQKlSIHd4oB1ET03mRH6vzYRgcZnEMiBtGtHqA7HSjFabHr9q3ZGRCKyuMBwWpE78nH7amA9_p2
 butaJBbOr_ev5GN5903YyNQ3OudhDNWg8IEBJw4ZQ9ETfCLnS3hv1Y84kSfuQrmvmmfFZPqqy.1q
 K3L1.ZYhT1.pTboXvRdFYkjSGWswfbzLKP7oe5iGVRCGY4XAoT3L6Fq.6bVxVTeKN5oo04cBY8vq
 J9X7WndQfLrcjCDaTJsJkIT2i.a9lZNDS.9NNMhCJ._Ld5_PCLOl4zY2bUhmYskjoKvZiXlXn0gT
 XmJDpXAZo9ielQUipWs1YAR7BAWF9eySg9kaHDbzpv0Bqiu39XHQWNs6wfI.x5w1F1C7lrzDEPSV
 _1gmAUjnnf7at3IzZa5LAoUVjk8A2CluD_SmLJON7o8d7w0wvvSw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sun, 10 Mar 2019 07:55:48 +0000
Received: from 36.24.171.113 (EHLO [10.1.1.220]) ([36.24.171.113])
          by smtp414.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 80a3bf10880533b37c396577833dc412;
          Sun, 10 Mar 2019 07:55:43 +0000 (UTC)
Subject: Re: [PATCH] staging: erofs: add a new line after variable declaration
To:     Julio Bianco <juliobianco@gmail.com>
References: <20190309170853.8297-1-juliobianco@gmail.com>
Cc:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        gregkh@linuxfoundation.org, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <cc0fd3b6-ef6d-e588-aa66-a93002fd589e@aol.com>
Date:   Sun, 10 Mar 2019 15:55:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190309170853.8297-1-juliobianco@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julio,

On 2019/3/10 1:08, Julio Bianco wrote:
> Add a new line after variable declaration
>
> Signed-off-by: Julio Bianco <juliobianco@gmail.com>

There is the only place in erofs for this issue?
Could you check and please fix them all if you have some time?

Thanks,
Gao Xiang

> ---
>  drivers/staging/erofs/inode.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index 924b8dfc7a8f..1cf1afe2d73a 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -270,6 +270,7 @@ struct inode *erofs_iget(struct super_block *sb,
>  	if (inode->i_state & I_NEW) {
>  		int err;
>  		struct erofs_vnode *vi = EROFS_V(inode);
> +
>  		vi->nid = nid;
>  
>  		err = fill_inode(inode, isdir);
