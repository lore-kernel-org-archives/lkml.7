Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86702C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281D320821
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQwYJghn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfEVUoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:44:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45303 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbfEVUoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:44:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so3747530wrq.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=esU+3qm17qrDuexe7jxN3EvAQX5MaY6ZoatueVdr3qQ=;
        b=LQwYJghnsjhn591pkI1Li/RiGNLgcSIn+RKzEdMKdpMhy1XZToSM64anUNI9+saxK3
         ODHzCEFRE5XfoiS1p/TWCDYIthlUJIhYCafNd+cdkCt2FHwqrVkiDp1/srtU/+1359CV
         txZ5+WP6U+hiEJJHvBwIkHWRUKq/irVsr5+R2jyPac2VWFSABPEyi5GqcVp9/rAyKqud
         ivB+KBcPmscp8HxxBctoQj2bYm+rDsp9FShbnqUrka9POWYktrtNnuaqc+BEt9Mv5EM0
         CAGc29oBeJM56ZBnDgN2BCx4SrVkMck8aau30uIDwDZj6xI93LaWCiQSkJ4iIVp7cDgu
         c60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esU+3qm17qrDuexe7jxN3EvAQX5MaY6ZoatueVdr3qQ=;
        b=MT0MqaR6eoq+HDy2K3WOMTlZZk8JZ51HHX8KJT+QiDuW0aWmW3iNwPUY1Y9k5g6oNv
         BS+jTscHId97Z4kKgq7ANy3myKhQimS0dIjvGSGyzX9q+yJcAlBncvUUud1oTXIKbejc
         nxc41lGIEwuOol1/dZK12rv6M+GvCPG6oofRTcNgTiAvNPT2JwK91/6cS5awOEkFRrl0
         74lweYoPMPCS6cZ4H9UbBX1/C2cW0mdVA6nH8b+L9QAxO36Y4MSQsd40KZRMiF55LE3u
         V2YVnYtGcCzGWL//WIzh0amUnsMLjm77XdgwKzICZkWRp8eSoFDazVbEL5Az8u1kzGgK
         kWTw==
X-Gm-Message-State: APjAAAXDcpTkdXUiDP9CplF85anmmGqPP7sUVdTtKmP0W8QrncPlMTZO
        LMDRczA7BzjCULxXyIerB52VjLTYGcqT6cYHGjI=
X-Google-Smtp-Source: APXvYqxc45ky2GHi1FeZ+BIf3VnaFuT1mLCFliU3lSSeZiCzoTlqseE8pdpvOSSzz5iK6QZMeV6uMntQG00gwpjmjHI=
X-Received: by 2002:a5d:4e09:: with SMTP id p9mr11738017wrt.218.1558557859722;
 Wed, 22 May 2019 13:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190522000753.13300-1-chris.packham@alliedtelesis.co.nz> <20190522000753.13300-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20190522000753.13300-2-chris.packham@alliedtelesis.co.nz>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 22 May 2019 22:44:08 +0200
Message-ID: <CAFLxGvy2c9KV1CyoFaD76jvThfPiotqfoeNchqjGcDp+uHie7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: concat: implement _is_locked mtd operation
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 2:08 AM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Add an implementation of the _is_locked operation for concatenated mtd
> devices. As with concat_lock/concat_unlock this can simply use the
> common helper and pass mtd_is_locked as the operation.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  drivers/mtd/mtdconcat.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
> index 9514cd2db63c..0e919f3423af 100644
> --- a/drivers/mtd/mtdconcat.c
> +++ b/drivers/mtd/mtdconcat.c
> @@ -496,6 +496,11 @@ static int concat_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>         return __concat_xxlock(mtd, ofs, len, mtd_unlock);
>  }
>
> +static int concat_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> +{
> +       return __concat_xxlock(mtd, ofs, len, mtd_is_locked);
> +}

Hmm, here you start abusing your own new API. :(

Did you verify that the unlock/lock-functions deal correctly with all
semantics from mtd_is_locked?
i.e. mtd_is_locked() with len = 0 returns 1 for spi-nor.
