Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B91FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF28218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btQbUpLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfCVOxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:53:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41762 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbfCVOxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:53:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id a25so1917768edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HRRg/zLFw/rJ1vqC/Ipe+1CgzWz4ssH3PHYkk0/OIFY=;
        b=btQbUpLIaWHN+Vzz+IlSbR3GLLuRygdLuJq9qv0MbJ/hhhGSmXQEsLN+dbf4VciIXK
         Nt6R3QkhGFv5CExf0Re9Xx4mrjwG+oK/e7HQusY40h5YTD2ItnKfz2pef5Jy6Zt85LPp
         +56GaDxgGgOwWQoE5GsbihLy8ws0816+I7up0coDuhuJWRhYNrX1vXMjf1SdCw27jW+y
         EwpeZwZCdRWVltwS8PyTvSbFQ8TG6I6ibtanUFGqIbURzkAm7CIAkoj3h7Mzerf64eu7
         ZvXOyDkkj5jNJxFf4kJvH1w7foqjBX2tz+Vj0I3IVAMe19948RPS6lXvyT5fAE7YKExf
         MkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HRRg/zLFw/rJ1vqC/Ipe+1CgzWz4ssH3PHYkk0/OIFY=;
        b=LcbOTmJYqi3CPj0hXlDUFKgv7Iq0hwIuJU9seGWbn2/FzJG9zVTKRkI8VIXx+TdBPd
         l66gyna/HZZZZ0f3eYnr+lmW67HjH+q3mLmkijev/PUJ5iGJaGS4Gr6wx8tXPPgEsgfE
         9np3eFwQ5pw+xV8f6rIlMwLLWCjuDExDm97BVDXbKg56TqK+7wXVhAyx0ujXcTs9D6gk
         fXDLEchcU1gjZzXf+Z3bLvXUKn4uOI5kWHoxh/u7/qhf8JGAraCudMmjJ0SxZo9XPXdb
         iHalu+sz9X2wg11klE8IdZco3asXSdwgistc8UV4mpZCmcEENGRGaUroZNPK6ueLJ6UU
         5ZgQ==
X-Gm-Message-State: APjAAAXawp6703oR0frgGB7d2OyWWzJaNo88A+XBs4nfzXJLJ+6jmj4T
        UAoDQ+u3Rp6ev03cjZyKaqNig92asbo=
X-Google-Smtp-Source: APXvYqw/j4fEzADUEV3bmJSKKB5ExR1KPHuhsQp30x5ChaqYE1OWamnLabqJqC++l1dj3AP4BV6AgQ==
X-Received: by 2002:a17:906:a01:: with SMTP id w1mr5880358ejf.21.1553266398709;
        Fri, 22 Mar 2019 07:53:18 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id h50sm2556380edh.47.2019.03.22.07.53.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 07:53:17 -0700 (PDT)
Date:   Fri, 22 Mar 2019 07:53:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Takashi Iwai <tiwai@suse.com>,
        Connor McAdams <conmanx360@gmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/ca0132: work around clang -Wuninitialized
 warning
Message-ID: <20190322145315.GA6521@archlinux-ryzen>
References: <20190322140649.197027-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322140649.197027-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 03:06:28PM +0100, Arnd Bergmann wrote:
> When CONFIG_PCI is disabled, clang gets confused about the
> control flow of the switch() statement always ending up
> in the default case, and warns:
> 
> sound/pci/hda/patch_ca0132.c:7558:6: error: variable 'fw_entry' is used uninitialized whenever 'if' condition is false
>       [-Werror,-Wsometimes-uninitialized]
>         if (!spec->alt_firmware_present) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/pci/hda/patch_ca0132.c:7565:42: note: uninitialized use occurs here
>         dsp_os_image = (struct dsp_image_seg *)(fw_entry->data);
>                                                 ^~~~~~~~
> sound/pci/hda/patch_ca0132.c:7558:2: note: remove the 'if' if its condition is always true
>         if (!spec->alt_firmware_present) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/pci/hda/patch_ca0132.c:7521:33: note: initialize the variable 'fw_entry' to silence this warning
>         const struct firmware *fw_entry;
>                                        ^
>                                         = NULL
> 
> Adding an explicit check for CONFIG_PCI avoids the issue.
> Unfortunately this is not very intuitive here.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=41197#c1
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> Any suggestions for other workarounds appreciated. If you can think
> of a better fix, please treat this as a reported-by:
> ---
>  sound/pci/hda/patch_ca0132.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> index 29882bda7632..415b16b7db70 100644
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> @@ -7555,7 +7555,7 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
>  	 * Use default ctefx.bin if no alt firmware is detected, or if none
>  	 * exists for your particular codec.
>  	 */
> -	if (!spec->alt_firmware_present) {
> +	if (!IS_ENABLED(CONFIG_PCI) || !spec->alt_firmware_present) {
>  		codec_dbg(codec, "Default firmware selected.");
>  		if (request_firmware(&fw_entry, EFX_FILE,
>  					codec->card->dev) != 0)
> -- 
> 2.20.0
> 
