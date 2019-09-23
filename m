Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D31DC64998
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC3C20673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJv03hsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbfIWUin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:38:43 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46264 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387586AbfIWUin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:38:43 -0400
Received: by mail-ot1-f65.google.com with SMTP id f21so13335147otl.13;
        Mon, 23 Sep 2019 13:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sweUxZxJQosgkHBCYd8BKEHHN75LnY+P6m8uRQ6mgPE=;
        b=LJv03hsqxE7HeQxEDwFpfAn/DjAJR3E9WORr/bIi5FIQGwRrHSRpvlNmA1OyrIT0/5
         m7p7Rj+VSyMoqAmoXxt6PZtc4ffTgJDZUyw5z+i401rzSy9ZWvQ/FsQnaH5IzUSFZhH9
         p/qEosXDAiQWmcyJFhNAZ+Cyd+VY+A8DsLr4bv6BoNv27QdFlV/DK+xqjwvvzrVEjrhc
         e32nisHV2HUkkZ90zh40XBB96WGpkKtuvPPPM8TcZllI9BuhgS40JE0jD+BPxDXQGOjd
         audrENWHDcGzQei1boeFz6THkaawWLHeQp79muBhkMlYe9eahigwz9diIcH3n8hHFCSb
         MU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sweUxZxJQosgkHBCYd8BKEHHN75LnY+P6m8uRQ6mgPE=;
        b=Zr9kr8z+AWTewoZ5kEJ8sEFpIyVcMS05qnDxXwobDwfiLdKS+TH15oE30GW8ALafCe
         5IrEwmEPEWTv9N7dflJEjhfDEoiC/RAHNnmxVjrG5shJ3/9a4HJ5dRg7+kq99TLg/NPP
         un5C1sDDUJEUyT9spKQkG1c3uFOlmQ10XU4quUrrGgHGYnZrFvv0FCA8vq6fLS0ErIDl
         N7XPDblBL9PyF2CJ71bgQXFbSSz5XXxBUi5hEyRCtlA5+59IifnfWfiaBlh8Rt6vSg4U
         M86uiNSnyoJyVwdiTVJtXaUmv79XxHC6zNEiLyJkvvcxKTpqBnK7kqOc2ChSJN3tMkt6
         CA8Q==
X-Gm-Message-State: APjAAAWbve0tXnIWfqy/YtbpiJO01YVNagvEyALBEtrSCHxa2bSy3Br/
        WGZHfdacnES90mZ+8r/7bbaaLEnh
X-Google-Smtp-Source: APXvYqxVGuW3Yqgnxvh8w8QHADv1Q7TKMCTm0SavQ/Xl+LXxhXcGKhfZQ7iNGJHU34SMXI9bp2Lhtg==
X-Received: by 2002:a9d:744d:: with SMTP id p13mr143941otk.76.1569271122026;
        Mon, 23 Sep 2019 13:38:42 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id d9sm3881232ote.11.2019.09.23.13.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 13:38:40 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8188eu: remove dead code in do-while
 conditional step
To:     Connor Kuehl <connor.kuehl@canonical.com>,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190923194806.25347-1-connor.kuehl@canonical.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <c2ce3fb0-6407-982a-a3f2-172cef17f2a6@lwfinger.net>
Date:   Mon, 23 Sep 2019 15:38:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190923194806.25347-1-connor.kuehl@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/19 2:48 PM, Connor Kuehl wrote:
> The local variable 'bcmd_down' is always set to true almost immediately
> before the do-while's condition is checked. As a result, !bcmd_down
> evaluates to false which short circuits the logical AND operator meaning
> that the second operand is never reached and is therefore dead code.
> 
> Addresses-Coverity: ("Logically dead code")
> 
> Signed-off-by: Connor Kuehl <connor.kuehl@canonical.com>
> ---
>   drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
> index 47352f210c0b..a4b317937b23 100644
> --- a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
> +++ b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
> @@ -48,7 +48,6 @@ static u8 _is_fw_read_cmd_down(struct adapter *adapt, u8 msgbox_num)
>   static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *pCmdBuffer)
>   {
>   	u8 bcmd_down = false;
> -	s32 retry_cnts = 100;
>   	u8 h2c_box_num;
>   	u32 msgbox_addr;
>   	u32 msgbox_ex_addr;
> @@ -103,7 +102,7 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
>   		adapt->HalData->LastHMEBoxNum =
>   			(h2c_box_num+1) % RTL88E_MAX_H2C_BOX_NUMS;
>   
> -	} while ((!bcmd_down) && (retry_cnts--));
> +	} while (!bcmd_down);
>   
>   	ret = _SUCCESS;

This patch is correct; however, the do..while loop will always be executed once, 
thus you could remove the loop and the loop variable bcmd_down.

@greg: If you would prefer a two-step process, then this one is OK.

Larry

