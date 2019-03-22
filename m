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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530BAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC0D2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nymKydGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfCVPN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:13:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32892 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfCVPN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:13:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id q3so2004080edg.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WNf6yB4kQs6L5gnAHkI7cnWIeAdYYRDcWm8lwu4UJZo=;
        b=nymKydGkjHf/MUMPZeuWZb0mHhMYFVwnEYOMMYQ1q3E/ZIi9ooH1i/wNXbwyrVRBXE
         9Uh2udfps/VklihPw/VV1ythvXF0L45rDNy6gAHwL2Rinop8lB44fh219A+7KHl3q+uU
         f8xtXpo91wPY3S0EGCv70/trSm20CT1kQMdjRr3um3YMLiQuKsPgo0khAhPCfA3P4Hq7
         axfO2oSwitCGykQWlooTKpGeEEGOTNtg8FMD6cGHDN91eNt2pW6jPkQsorkuhThikUam
         lm91f9zeKAEpzn8j2aDg0phKxx1X9vfoTHthqEduwpOkTF887XZq2MRAuHmy8Y3xkDGa
         oibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WNf6yB4kQs6L5gnAHkI7cnWIeAdYYRDcWm8lwu4UJZo=;
        b=CystmdjSZLfD7WQQaSb/o2Ol4/YRXXFW7fOwFMj5zcm1REA7l8wIVz7XIcWBBZ42HF
         JUo5wEtis83bLCFOSIKBJ25SR7EpocuNYSMOexTYQ+JqSETGxkDEsn37KEnS6EeFJQpH
         /fNRa76/mwJtzTdRwCFTYhxAz3D6TB6Ku+kzvBfnSy0PfZdQvb1WQzzJt0N/0jL1xJRc
         qDll+jm60JsA/PnIZ08Xz56jF01JKDG5gKGHD4Mxk9jOUtw20P3qFdKs6HZEu7/v7Egi
         /XCLXdMXNXLbhePEXU/qWFOyB22MrbnJGu2OL4hExVs5dT+60sEv+Y6rIPCV2FD3pbJU
         hmxA==
X-Gm-Message-State: APjAAAVTys1GMM5PRqwDycJ5T+ZTSVdpTFhD1Et/cOWc2XHlz0E6nx1A
        GSgRNmF6c7fHLIZlK3+EwvM=
X-Google-Smtp-Source: APXvYqxPzNZeK585JhepT+/waw0xIFDpFrME48T83O7if2yboUXumdujEuwjPG55fLmarcYFavfuSw==
X-Received: by 2002:a17:906:4c92:: with SMTP id q18mr5987925eju.16.1553267604197;
        Fri, 22 Mar 2019 08:13:24 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id a18sm2558555edt.2.2019.03.22.08.13.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 08:13:23 -0700 (PDT)
Date:   Fri, 22 Mar 2019 08:13:21 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Connor McAdams <conmanx360@gmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/ca0132: work around clang -Wuninitialized
 warning
Message-ID: <20190322151321.GA13220@archlinux-ryzen>
References: <20190322140649.197027-1-arnd@arndb.de>
 <s5hr2az9cos.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hr2az9cos.wl-tiwai@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:00:19PM +0100, Takashi Iwai wrote:
> On Fri, 22 Mar 2019 15:06:28 +0100,
> Arnd Bergmann wrote:
> > 
> > When CONFIG_PCI is disabled, clang gets confused about the
> > control flow of the switch() statement always ending up
> > in the default case, and warns:
> > 
> > sound/pci/hda/patch_ca0132.c:7558:6: error: variable 'fw_entry' is used uninitialized whenever 'if' condition is false
> >       [-Werror,-Wsometimes-uninitialized]
> >         if (!spec->alt_firmware_present) {
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > sound/pci/hda/patch_ca0132.c:7565:42: note: uninitialized use occurs here
> >         dsp_os_image = (struct dsp_image_seg *)(fw_entry->data);
> >                                                 ^~~~~~~~
> > sound/pci/hda/patch_ca0132.c:7558:2: note: remove the 'if' if its condition is always true
> >         if (!spec->alt_firmware_present) {
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > sound/pci/hda/patch_ca0132.c:7521:33: note: initialize the variable 'fw_entry' to silence this warning
> >         const struct firmware *fw_entry;
> >                                        ^
> >                                         = NULL
> > 
> > Adding an explicit check for CONFIG_PCI avoids the issue.
> > Unfortunately this is not very intuitive here.
> > 
> > Link: https://bugs.llvm.org/show_bug.cgi?id=41197#c1
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Any suggestions for other workarounds appreciated. If you can think
> > of a better fix, please treat this as a reported-by:
> 
> Can it be addressed by the code simplification like below, instead?
> 

Yes, the warning is fixed with that diff and makes the code easier to
follow I think.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> 
> thanks,
> 
> Takashi
> 
> ---
>  sound/pci/hda/patch_ca0132.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> index 29882bda7632..e1ebc6d5f382 100644
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> @@ -1005,7 +1005,6 @@ struct ca0132_spec {
>  	unsigned int scp_resp_header;
>  	unsigned int scp_resp_data[4];
>  	unsigned int scp_resp_count;
> -	bool alt_firmware_present;
>  	bool startup_check_entered;
>  	bool dsp_reload;
>  
> @@ -7518,7 +7517,7 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
>  	bool dsp_loaded = false;
>  	struct ca0132_spec *spec = codec->spec;
>  	const struct dsp_image_seg *dsp_os_image;
> -	const struct firmware *fw_entry;
> +	const struct firmware *fw_entry = NULL;
>  	/*
>  	 * Alternate firmwares for different variants. The Recon3Di apparently
>  	 * can use the default firmware, but I'll leave the option in case
> @@ -7529,33 +7528,26 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
>  	case QUIRK_R3D:
>  	case QUIRK_AE5:
>  		if (request_firmware(&fw_entry, DESKTOP_EFX_FILE,
> -					codec->card->dev) != 0) {
> +					codec->card->dev) != 0)
>  			codec_dbg(codec, "Desktop firmware not found.");
> -			spec->alt_firmware_present = false;
> -		} else {
> +		else
>  			codec_dbg(codec, "Desktop firmware selected.");
> -			spec->alt_firmware_present = true;
> -		}
>  		break;
>  	case QUIRK_R3DI:
>  		if (request_firmware(&fw_entry, R3DI_EFX_FILE,
> -					codec->card->dev) != 0) {
> +					codec->card->dev) != 0)
>  			codec_dbg(codec, "Recon3Di alt firmware not detected.");
> -			spec->alt_firmware_present = false;
> -		} else {
> +		else
>  			codec_dbg(codec, "Recon3Di firmware selected.");
> -			spec->alt_firmware_present = true;
> -		}
>  		break;
>  	default:
> -		spec->alt_firmware_present = false;
>  		break;
>  	}
>  	/*
>  	 * Use default ctefx.bin if no alt firmware is detected, or if none
>  	 * exists for your particular codec.
>  	 */
> -	if (!spec->alt_firmware_present) {
> +	if (!fw_entry) {
>  		codec_dbg(codec, "Default firmware selected.");
>  		if (request_firmware(&fw_entry, EFX_FILE,
>  					codec->card->dev) != 0)
> -- 
> 2.16.4
> 
