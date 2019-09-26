Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21C2C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CD321D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+pwT6b5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfIZRxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:53:16 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40872 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfIZRxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:53:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id y39so2780548ota.7;
        Thu, 26 Sep 2019 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l4hVPvXuA1yUfCTMAa2qM1WXIm4IGNEgGvOx69kn5iQ=;
        b=R+pwT6b5a5j4MI1LUBnBz+75gDMAVK7FAbaw4LQgbnbk3qbI8f7fNZYdiX8kaiXozr
         APqQI9wPwrOWmh5TBuBPtQiyZQSh8/w8k00TrD/+uEhJIhyZxrsWB1BkTN42hrKMEQqS
         V07EM/H827soR7Evyna+E7IwEg6lc80tPOe7ds0CLNk9PTaBR34vzkHGNgRAWoWIGopN
         oFVyZoyByZL2y3yGqMUTcKkc+iozoEQl1ynqgKJwQhZ1isuHVT3MvlzjCNtV40VPFfo2
         n52tH3k47fv8tR7u5grfe1yrgoIgtRe5VW7Y4wxpc/KEOmyyhdk16wIZTaR8vBxgRNHl
         j4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l4hVPvXuA1yUfCTMAa2qM1WXIm4IGNEgGvOx69kn5iQ=;
        b=Vyv/L7CsQIDOCaYKNXR/dfXdvG9qojog2218JMeSWGmE45cwOGv/1vGDlaQZwQVL+J
         GnLfdc3tZT20zc3seHac8M61rNTr+i4/p9C/PahJCT8P3Diny+5MywBLfoMklZdaY95N
         AF7elvxz9fQgR6JAeFWEBozzVVjRR9t+s9fCItoF13aO54y/j+wdgKBMaKnRioP+nDm3
         osFHcYDe0qC6eidv06IeHPzmJAcizBp8/o/omdeVAAoSv6nsHricrrVaSImTFAMIqt/y
         PFY4qmD+RyFkLQ6PICIZ2aC5unxxWPfNvy36bInz+iUaA/okivf1HV+8xc9O2vnHGVMT
         qUkQ==
X-Gm-Message-State: APjAAAVFWhOqg+wVxYKEoL1q74cieKfOsaDkVa9aOIA8aFofi1l46UdH
        //nCdTdDogwXw1gfpA2V2B0oLS8G
X-Google-Smtp-Source: APXvYqyGGz+8L/6FHfyVFOKmPZvgQvzYKIeL1mfG62VHuz4RAlTKBD+Sm4duhnF/eEGxdihGtHTNUQ==
X-Received: by 2002:a05:6830:1c5:: with SMTP id r5mr3603353ota.325.1569520394453;
        Thu, 26 Sep 2019 10:53:14 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x6sm891889ote.69.2019.09.26.10.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 10:53:14 -0700 (PDT)
Subject: Re: [PATCH v2] staging: rtl8188eu: remove dead code/vestigial
 do..while loop
To:     Connor Kuehl <connor.kuehl@canonical.com>,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        devel@driverdev.osuosl.org, dan.carpenter@oracle.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190924142819.5243-1-connor.kuehl@canonical.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <2f275661-5945-9e27-95a4-a82584756f2e@lwfinger.net>
Date:   Thu, 26 Sep 2019 12:53:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190924142819.5243-1-connor.kuehl@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/19 9:28 AM, Connor Kuehl wrote:
> The local variable 'bcmd_down' is always set to true almost immediately
> before the do-while's condition is checked. As a result, !bcmd_down
> evaluates to false which short circuits the logical AND operator meaning
> that the second operand is never reached and is therefore dead code.
> 
> Furthermore, the do..while loop may be removed since it will always only
> execute once because 'bcmd_down' is always set to true, so the
> !bcmd_down evaluates to false and the loop exits immediately after the
> first pass.
> 
> Fix this by removing the loop and its condition variables 'bcmd_down'
> and 'retry_cnts'
> 
> While we're in there, also fix some checkpatch.pl suggestions regarding
> spaces around arithmetic operators like '+'
> 
> Addresses-Coverity: ("Logically dead code")
> 
> Signed-off-by: Connor Kuehl <connor.kuehl@canonical.com>
> ---
> v1 -> v2:
>   - remove the loop and its condition variable bcmd_down
>   - address some non-invasive checkpatch.pl suggestions as a result of
>     deleting the loop
> 
>   drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c | 55 +++++++++-----------
>   1 file changed, 24 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
> index 47352f210c0b..7646167a0b36 100644
> --- a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
> +++ b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
> @@ -47,8 +47,6 @@ static u8 _is_fw_read_cmd_down(struct adapter *adapt, u8 msgbox_num)
>   ******************************************/
>   static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *pCmdBuffer)
>   {
> -	u8 bcmd_down = false;
> -	s32 retry_cnts = 100;
>   	u8 h2c_box_num;
>   	u32 msgbox_addr;
>   	u32 msgbox_ex_addr;
> @@ -71,39 +69,34 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
>   		goto exit;
>   
>   	/* pay attention to if  race condition happened in  H2C cmd setting. */
> -	do {
> -		h2c_box_num = adapt->HalData->LastHMEBoxNum;
> -
> -		if (!_is_fw_read_cmd_down(adapt, h2c_box_num)) {
> -			DBG_88E(" fw read cmd failed...\n");
> -			goto exit;
> -		}
> -
> -		*(u8 *)(&h2c_cmd) = ElementID;
> -
> -		if (CmdLen <= 3) {
> -			memcpy((u8 *)(&h2c_cmd)+1, pCmdBuffer, CmdLen);
> -		} else {
> -			memcpy((u8 *)(&h2c_cmd)+1, pCmdBuffer, 3);
> -			ext_cmd_len = CmdLen-3;
> -			memcpy((u8 *)(&h2c_cmd_ex), pCmdBuffer+3, ext_cmd_len);
> +	h2c_box_num = adapt->HalData->LastHMEBoxNum;
>   
> -			/* Write Ext command */
> -			msgbox_ex_addr = REG_HMEBOX_EXT_0 + (h2c_box_num * RTL88E_EX_MESSAGE_BOX_SIZE);
> -			for (cmd_idx = 0; cmd_idx < ext_cmd_len; cmd_idx++)
> -				usb_write8(adapt, msgbox_ex_addr+cmd_idx, *((u8 *)(&h2c_cmd_ex)+cmd_idx));
> -		}
> -		/*  Write command */
> -		msgbox_addr = REG_HMEBOX_0 + (h2c_box_num * RTL88E_MESSAGE_BOX_SIZE);
> -		for (cmd_idx = 0; cmd_idx < RTL88E_MESSAGE_BOX_SIZE; cmd_idx++)
> -			usb_write8(adapt, msgbox_addr+cmd_idx, *((u8 *)(&h2c_cmd)+cmd_idx));
> +	if (!_is_fw_read_cmd_down(adapt, h2c_box_num)) {
> +		DBG_88E(" fw read cmd failed...\n");
> +		goto exit;
> +	}
>   
> -		bcmd_down = true;
> +	*(u8 *)(&h2c_cmd) = ElementID;
>   
> -		adapt->HalData->LastHMEBoxNum =
> -			(h2c_box_num+1) % RTL88E_MAX_H2C_BOX_NUMS;
> +	if (CmdLen <= 3) {
> +		memcpy((u8 *)(&h2c_cmd) + 1, pCmdBuffer, CmdLen);
> +	} else {
> +		memcpy((u8 *)(&h2c_cmd) + 1, pCmdBuffer, 3);
> +		ext_cmd_len = CmdLen - 3;
> +		memcpy((u8 *)(&h2c_cmd_ex), pCmdBuffer + 3, ext_cmd_len);
> +
> +		/* Write Ext command */
> +		msgbox_ex_addr = REG_HMEBOX_EXT_0 + (h2c_box_num * RTL88E_EX_MESSAGE_BOX_SIZE);
> +		for (cmd_idx = 0; cmd_idx < ext_cmd_len; cmd_idx++)
> +			usb_write8(adapt, msgbox_ex_addr + cmd_idx, *((u8 *)(&h2c_cmd_ex) + cmd_idx));
> +	}
> +	/*  Write command */
> +	msgbox_addr = REG_HMEBOX_0 + (h2c_box_num * RTL88E_MESSAGE_BOX_SIZE);
> +	for (cmd_idx = 0; cmd_idx < RTL88E_MESSAGE_BOX_SIZE; cmd_idx++)
> +		usb_write8(adapt, msgbox_addr + cmd_idx, *((u8 *)(&h2c_cmd) + cmd_idx));
>   
> -	} while ((!bcmd_down) && (retry_cnts--));
> +	adapt->HalData->LastHMEBoxNum =
> +		(h2c_box_num + 1) % RTL88E_MAX_H2C_BOX_NUMS;
>   
>   	ret = _SUCCESS;

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry

