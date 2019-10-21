Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF3DCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FC62089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfJUGAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:00:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35763 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfJUGAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:00:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10so11903983wrb.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 22:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4pVRsWxXoNBJ8DZ4LnU+6HuXrrAG6ENHjv7dXMaiaIQ=;
        b=dzzq3L4diiBrSL0UmnYahBeFLuClAJt7bggnP7TCnHM8RW4M5cBlxbBBrlhwA/3Gxw
         xnbzIq5vllsTYy0jrQTq4vTH4ckZ3Xk4i2X5z3NQtnRlVr0N5A6vyoHN6hWuxruw7xnM
         SNZAkdyY9OKgJ9U/Unzhu3JWtabk2BDG9wTgfh+pCCT/vMe6VS6sef7VTr0uvUPrpq2a
         grLh+tw5MKSMDzX9dyyGxx1R06NmknOF4TaADuiElS8RSb4OOudmI6OGbUD3tGeCClVk
         EOX7A+X3bfli9kcxQTo2CwXOShcO3S5gsVnkdx4e2Cg/Gh00q3U5tWsJdz6D3kcl6wO+
         y4Wg==
X-Gm-Message-State: APjAAAXFF+yXsZTaRw6QikF+MhQl/n2e4f4UITrVF03c4gBBXbgMuB8W
        psWgDs9G8EdflgJcf4klL9VZuc3wNEk=
X-Google-Smtp-Source: APXvYqw4PiIMxm4FgE+4e4u3WrZC72h/A3HtDa+izxGkPDXSn/ZJ2OYArtymKSlme9+bP8Q0oha28w==
X-Received: by 2002:adf:f087:: with SMTP id n7mr4063528wro.1.1571637597517;
        Sun, 20 Oct 2019 22:59:57 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id y13sm21139607wrg.8.2019.10.20.22.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 22:59:56 -0700 (PDT)
Subject: Re: [PATCH v2] tty: rocket: reduce stack usage
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20191018161712.27807-1-sudipm.mukherjee@gmail.com>
From:   Jiri Slaby <jslaby@suse.com>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <afe485c6-7816-96dd-f301-1c0797e8b7ce@suse.com>
Date:   Mon, 21 Oct 2019 07:59:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018161712.27807-1-sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 10. 19, 18:17, Sudip Mukherjee wrote:
> The build of xtensa allmodconfig gives warning of:
> In function 'get_ports.isra.0':
> warning: the frame size of 1040 bytes is larger than 1024 bytes
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Acked-by: Jiri Slaby <jslaby@suse.cz>

Thanks.

> v2: check faliure of kzalloc
> 
>  drivers/tty/rocket.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
> index 5ba6816ebf81..fbaa4ec85560 100644
> --- a/drivers/tty/rocket.c
> +++ b/drivers/tty/rocket.c
> @@ -1222,22 +1222,28 @@ static int set_config(struct tty_struct *tty, struct r_port *info,
>   */
>  static int get_ports(struct r_port *info, struct rocket_ports __user *retports)
>  {
> -	struct rocket_ports tmp;
> -	int board;
> +	struct rocket_ports *tmp;
> +	int board, ret = 0;
>  
> -	memset(&tmp, 0, sizeof (tmp));
> -	tmp.tty_major = rocket_driver->major;
> +	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	tmp->tty_major = rocket_driver->major;
>  
>  	for (board = 0; board < 4; board++) {
> -		tmp.rocketModel[board].model = rocketModel[board].model;
> -		strcpy(tmp.rocketModel[board].modelString, rocketModel[board].modelString);
> -		tmp.rocketModel[board].numPorts = rocketModel[board].numPorts;
> -		tmp.rocketModel[board].loadrm2 = rocketModel[board].loadrm2;
> -		tmp.rocketModel[board].startingPortNumber = rocketModel[board].startingPortNumber;
> -	}
> -	if (copy_to_user(retports, &tmp, sizeof (*retports)))
> -		return -EFAULT;
> -	return 0;
> +		tmp->rocketModel[board].model = rocketModel[board].model;
> +		strcpy(tmp->rocketModel[board].modelString,
> +		       rocketModel[board].modelString);
> +		tmp->rocketModel[board].numPorts = rocketModel[board].numPorts;
> +		tmp->rocketModel[board].loadrm2 = rocketModel[board].loadrm2;
> +		tmp->rocketModel[board].startingPortNumber =
> +			rocketModel[board].startingPortNumber;
> +	}
> +	if (copy_to_user(retports, tmp, sizeof(*retports)))
> +		ret = -EFAULT;
> +	kfree(tmp);
> +	return ret;
>  }
>  
>  static int reset_rm2(struct r_port *info, void __user *arg)
> 


-- 
js
suse labs
