Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FAFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1704720B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMcWdO51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfJULqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:46:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45458 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfJULqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:46:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id q13so8616879wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=r99SrmIAWCZFhQdc6QFpd7cI3BE/OyLzeiOHzb6k9dA=;
        b=AMcWdO51d/gm6zTYZOvF3fnk145odN8cyZWo76JC0ghHEXavyH8vzyGV/wfxZXgYVU
         8XO0R/dE8lsMsAr6TglgjDyz9nMN8Rv53iwvQmDiBbuFFbYDR+bFA3CdxPki/htNdtJi
         QtRQdRNKibX7XrlX7Kwn4lBr3sSZS8Q+I2Tvj/DKaGAONzsjEY09lf0Ms8j/jAKmUqPg
         +WAhJE/Az06Wvtg/NyhKSkvQkniMvQHTVTwGAoWgwvCAsdavTxiHULlfspg416S324mc
         LI6mi/Apx61FqeJytQo2Qtjfmal0sQ8ujYiBBnVLvOimamhx1Sil//g2hH7ByN6Ib5UB
         8hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r99SrmIAWCZFhQdc6QFpd7cI3BE/OyLzeiOHzb6k9dA=;
        b=e4tcYHETS18oDzr4CApXhUS0PyyWfQjb+NWCO9aXuJgOO+jl308BByM1+6OiTPp2xL
         B1R7VczpAgo9i1lPi0CH/TkgvcyAX7uThwErLKEU7KRvbvtIbEjRVjOuqmz1kRCqlANG
         R2kfSaA3l9LhaZRoXFRcuqIi0q4y0zbF2jGjRKp3CeFteGcwTjHv4aQ8kDvkD/qQEgNh
         ghC0wJC4wQQzF8rUdGOdoaxr4uVkeKna8EaMsvQ7kheFx6AuT+fmS/HT4O+WSPVZJhNo
         Wdi+6n/VsNdAMd6bbZJEE3E0QrELWHomfiIDltlqyvXo/0WeaiSA/9eLHlUbPb1uJWK3
         eDiw==
X-Gm-Message-State: APjAAAWgvRA7bCVuoc8X/SPgkQU+NyLI2H/ekXt6UbEMNST6GpxjJYZ1
        /GmCj0MuLwZIB52dXKfdUksB7w==
X-Google-Smtp-Source: APXvYqz5RaYEnHFOjq+WSQPnFuuDBupuZAPhnGNk9cAwiBNB0sPg6VYeOLxAVLwf8rQBz7C98J8PXQ==
X-Received: by 2002:a5d:66c6:: with SMTP id k6mr12067264wrw.152.1571658389329;
        Mon, 21 Oct 2019 04:46:29 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id q3sm14546759wru.33.2019.10.21.04.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 04:46:28 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:46:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 2/9] mfd: cs5535-mfd: Remove mfd_cell->id hack
Message-ID: <20191021114627.GE4365@dell>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <20191021105822.20271-3-lee.jones@linaro.org>
 <20191021111137.ey6cbrrb2af3wj5i@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021111137.ey6cbrrb2af3wj5i@holly.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Daniel Thompson wrote:

> On Mon, Oct 21, 2019 at 11:58:15AM +0100, Lee Jones wrote:
> > The current implementation abuses the platform 'id' mfd_cell member
> > to index into the correct resources entry.  If we place all cells
> > into their numbered slots, we can cycle through all the cell entries
> > and only process the populated ones which avoids this behaviour.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/cs5535-mfd.c | 31 +++++++++++++------------------
> >  1 file changed, 13 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
> > index 2c47afc22d24..9ce6bbcdbda1 100644
> > --- a/drivers/mfd/cs5535-mfd.c
> > +++ b/drivers/mfd/cs5535-mfd.c
> > @@ -62,26 +62,22 @@ static int cs5535_mfd_res_disable(struct platform_device *pdev)
> >  static struct resource cs5535_mfd_resources[NR_BARS];
> >  
> >  static struct mfd_cell cs5535_mfd_cells[] = {
> 
> This array is sized from the initializer...
> 
> > -	{
> > -		.id = SMB_BAR,
> > +	[SMB_BAR] = {
> >  		.name = "cs5535-smb",
> >  		.num_resources = 1,
> >  		.resources = &cs5535_mfd_resources[SMB_BAR],
> >  	},
> > -	{
> > -		.id = GPIO_BAR,
> > +	[GPIO_BAR] = {
> >  		.name = "cs5535-gpio",
> >  		.num_resources = 1,
> >  		.resources = &cs5535_mfd_resources[GPIO_BAR],
> >  	},
> > -	{
> > -		.id = MFGPT_BAR,
> > +	[MFGPT_BAR] = {
> >  		.name = "cs5535-mfgpt",
> >  		.num_resources = 1,
> >  		.resources = &cs5535_mfd_resources[MFGPT_BAR],
> >  	},
> > -	{
> > -		.id = PMS_BAR,
> > +	[PMS_BAR] = {
> >  		.name = "cs5535-pms",
> >  		.num_resources = 1,
> >  		.resources = &cs5535_mfd_resources[PMS_BAR],
> > @@ -89,8 +85,7 @@ static struct mfd_cell cs5535_mfd_cells[] = {
> >  		.enable = cs5535_mfd_res_enable,
> >  		.disable = cs5535_mfd_res_disable,
> >  	},
> > -	{
> > -		.id = ACPI_BAR,
> > +	[ACPI_BAR] = {
> >  		.name = "cs5535-acpi",
> >  		.num_resources = 1,
> >  		.resources = &cs5535_mfd_resources[ACPI_BAR],
> > @@ -115,16 +110,16 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
> >  		return err;
> >  
> >  	/* fill in IO range for each cell; subdrivers handle the region */
> > -	for (i = 0; i < ARRAY_SIZE(cs5535_mfd_cells); i++) {
> > -		int bar = cs5535_mfd_cells[i].id;
> > -		struct resource *r = &cs5535_mfd_resources[bar];
> > +	for (i = 0; i < NR_BARS; i++) {
> 
> ... which means this translation from ARRAY_SIZE() to NR_BARS
> is rather odd.
> 
> I don't care whether the array is sized using NR_BARS or the loop
> uses ARRAY_SIZE() but IMHO the loop boundary condition must match
> the array declaration.

Sounds reasonable.

> With that fixed free to throw the following onto the next rev:
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Ta.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
