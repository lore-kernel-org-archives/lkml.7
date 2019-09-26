Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E1EC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A0B206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmBs2pc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbfIZAFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:05:43 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39224 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387449AbfIZAFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:05:43 -0400
Received: by mail-ot1-f65.google.com with SMTP id s22so409792otr.6;
        Wed, 25 Sep 2019 17:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cLDBlYUmNrPQrO4eVaMtvr6RX8X34auEyuZMhH4LAik=;
        b=UmBs2pc/Zvu6RyHaZ3E3Zph8I97+mpbFMmp0wAhC4XuCt4lrQ4CMSlnMa6oz/VbC0w
         808hdIHq6Qsn3oszdBYWWUIfr8yRYW35NT3/jAFdJKdtx2SDDuB2SGwltamMntDJaqgT
         lUkScSAQYQ+UsLYh8jaFzomkjdgDsKSWWYwlumew6E6ewzbOY1hnBAkKLEBVz/zPMNwI
         anizYEtGwTNmWvPPi8bPqhrtY8Xqup607P5kgu3SeWpl3G/blyzHnQAAbrBhk0+dYqGt
         oAI09pf7ovdOf2mjr6Uevr3SuEY2sVfi1dyefPoERqKTkxBJGTmAKLAWxk821fz7MQdl
         FsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cLDBlYUmNrPQrO4eVaMtvr6RX8X34auEyuZMhH4LAik=;
        b=gdmwII3o28y+4mDuVrtJh6BY6C2/b4u7b3AjdttE7mP0eun8E+9tJMitKeg/r5YEPf
         AP20AQBFzR7tmwfV/cBPfDXS70Wpo/c+xk0Aue7/pCha+N3XuBQnuDD99n6675jG74aW
         pQNAL79WjKeHogZX9nvY8BWTtZW/N9cJvTzfnq+aZkE7/sQcOJk4k9ol5Dd47y4riImF
         c5iM8xhIlrRE+MGqUE9TQAtVWldak8DrkjbPJ2FS3E+cd3qHN1gmzgweuJMGjpQo59ls
         7M8SB/n4IsZgeGudQAz7JM9sd1TLBF0/5ocmf9pBEy0f4uJgS27RBSsZZhNMFP0wADR4
         pdnQ==
X-Gm-Message-State: APjAAAWyD4BQY6JVslOMC1U8Msn+AUcpIu4ZXGj1NRyPp9bGjX+cgxJF
        OmdJvr6Yp+E7W2Mxob/s3x68sI1X
X-Google-Smtp-Source: APXvYqzKvmb5CmGQHuVV4hwjbageKrnNRU1k6G4PjsXBsHySHIWs6PSbzG/elNsMEYgii2B8aTgxQg==
X-Received: by 2002:a05:6830:4a5:: with SMTP id l5mr553245otd.150.1569456342282;
        Wed, 25 Sep 2019 17:05:42 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id k34sm108144otk.51.2019.09.25.17.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 17:05:41 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8188eu: fix possible null dereference
To:     Connor Kuehl <connor.kuehl@canonical.com>,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190925213215.25082-1-connor.kuehl@canonical.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <b725820f-525c-519b-4474-476abf004985@lwfinger.net>
Date:   Wed, 25 Sep 2019 19:05:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925213215.25082-1-connor.kuehl@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/19 4:32 PM, Connor Kuehl wrote:
> Inside a nested 'else' block at the beginning of this function is a
> call that assigns 'psta' to the return value of 'rtw_get_stainfo()'.
> If 'rtw_get_stainfo()' returns NULL and the flow of control reaches
> the 'else if' where 'psta' is dereferenced, then we will dereference
> a NULL pointer.
> 
> Fix this by checking if 'psta' is not NULL before reading its
> 'psta->qos_option' data member.
> 
> Addresses-Coverity: ("Dereference null return value")
> 
> Signed-off-by: Connor Kuehl <connor.kuehl@canonical.com>
> ---
>   drivers/staging/rtl8188eu/core/rtw_xmit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> index 952f2ab51347..bf8877cbe9b6 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> @@ -784,7 +784,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
>   			memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
>   			memcpy(pwlanhdr->addr3, get_bssid(pmlmepriv), ETH_ALEN);
>   
> -			if (psta->qos_option)
> +			if (psta && psta->qos_option)
>   				qos_option = true;
>   		} else {
>   			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("fw_state:%x is not allowed to xmit frame\n", get_fwstate(pmlmepriv)));
> 

This change is a good one, but why not get the same fix at line 779?

Larry

