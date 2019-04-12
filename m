Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238DDC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E628F2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfDLHPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:15:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35409 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfDLHPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:15:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id s39so7425654edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 00:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=13wQ/vIEQV4DmOqwYRy34cBX+EyJikzd0euuned94A0=;
        b=R7gyZpKSNjn0LL/Qv7W60LkGVIeokTn3yTtTBsSxT4/8u4jxMdsxdSXidCIU/1ywFy
         ivq8ef+LcMtC4BIGS5oFAv+4nJEhf76A4OliS5Jxw4tNVKjhpDBRnoJYHv9NYQRazwYV
         +QBLoxkMuHcbH6ZWVGABw1wLlLS+b1fgMRjKrBdwvdrKviTZbdmpWkMM9/om9wKedAgk
         EWSUrWQIMqzfnliOSYmp+7bKY0tH3ou5vP7oHQnLEXJszcDjubVmb2uHuAduo9moNqRc
         ozvi4ksVmvhvFyBtk3S/0xFvolijRG/YVglt4WStBbzsgspm/z+LpWhmTTmveurEPGUf
         yAKg==
X-Gm-Message-State: APjAAAWlpmG0WIqcNGvTRrQLrkDffIq+5Xc8ebLzTjaCb4V9Scut5VTF
        e3nLXPS70DnB+GEisNpK9nvltQ==
X-Google-Smtp-Source: APXvYqzK/6fuXxE6062s4/zCLdjxlM/5d+nmRe3+teiJn9SHzjGZIeRDGp7rsK/mthyg0CEJe7SFRA==
X-Received: by 2002:a17:906:b202:: with SMTP id p2mr30002206ejz.266.1555053341419;
        Fri, 12 Apr 2019 00:15:41 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id g6sm11725674edp.4.2019.04.12.00.15.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 00:15:40 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: pmc_atom: Drop __initconst on dmi table
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     kbuild-all@01.org, kbuild test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        =?UTF-8?Q?David_M=c3=bcller?= <dave.mueller@gmx.ch>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <201904111738.Ncw2Vf01%lkp@intel.com>
 <20190411172807.57796-1-sboyd@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4c95e469-c5fc-f043-8d54-f85ac812493b@redhat.com>
Date:   Fri, 12 Apr 2019 09:15:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411172807.57796-1-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 11-04-19 19:28, Stephen Boyd wrote:
> It's used by probe and that isn't an init function. Drop this so that we
> don't get a section mismatch.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: David Müller <dave.mueller@gmx.ch>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Fixes: 7c2e07130090 ("clk: x86: Add system specific quirk to mark clocks as critical")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Thank you for fixing this, I agree that this is the correct fix:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/platform/x86/pmc_atom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
> index eaec2d306481..c7039f52ad51 100644
> --- a/drivers/platform/x86/pmc_atom.c
> +++ b/drivers/platform/x86/pmc_atom.c
> @@ -396,7 +396,7 @@ static int pmc_dbgfs_register(struct pmc_dev *pmc)
>    * Some systems need one or more of their pmc_plt_clks to be
>    * marked as critical.
>    */
> -static const struct dmi_system_id critclk_systems[] __initconst = {
> +static const struct dmi_system_id critclk_systems[] = {
>   	{
>   		.ident = "MPL CEC1x",
>   		.matches = {
> 
