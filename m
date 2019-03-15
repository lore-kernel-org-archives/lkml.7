Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67646C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5AE217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="UGptGFx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfCOI7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:59:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42415 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfCOI7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:59:05 -0400
Received: by mail-lf1-f67.google.com with SMTP id p1so6257508lfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EMNHFuyeYx0aGdLZZBXVol/A9ho56AwJaCkjKbZhx3Y=;
        b=UGptGFx0OUPqvWR71K9CwB1T4/968zWKNpSeekoM2LPhVVyV02r8N2zGSagxBNZpNn
         AzohkpfDvaHxe1liGg67s6jkNZtAozl8UaZwh1UbXfilhBmfkRyD5M38hWAIjsph9Pvh
         iXi3UsWamCM6x0i6xMbQggASUEsP7t7HR+fPd2g+7FRpvJwJy+qQsNCLqwhAn7aHFvGv
         GYrEGkp6m4FOZgiaptsbXBe+sQRJZ6iKudEn8UzYIGlS0ayhOX9omX2hhqqOxGtKx8zP
         Uc6Z3YOP2YcjH5pim7gOdJ8CEP0SR+Gr2gF0VR7rcVBUL5Jyi6DDd6LMkNQT5hgRRxFo
         JVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EMNHFuyeYx0aGdLZZBXVol/A9ho56AwJaCkjKbZhx3Y=;
        b=nglMRE9yQtDThEb0iJdaY+vaE8GzuxOqx2qQ0ThJ/GrYtbljcgfz/uZT1ElIvUCWhD
         5TIWpuU8QCNc+UDyrpbAzLACVusCaBSjmcfAZ/oQxol1+hmp5/0Eln5Xjh811cckxv+3
         rW/BSpjND7cZRzyrLsVpjiE22aR3Le0BJUZZdWBUqRpozwC1AvuNbIqgQpYkWyoe3Ly1
         04TwD/6GplPydPEJPNLUyMxn/grcK1b8WZRKU6VgcRsB5uHd3qHX7EH70uEMSevMhoMU
         EwELQesjyryPbCpkVQ0laODiopTQWYxv3AOGF/icboGizCZSQMxP2cq8/9RAOQlv+1ge
         D+gQ==
X-Gm-Message-State: APjAAAXuB+sAcelVhDRWKLPRoGbksTHjF4Qr1jFPIFMYVDDGB+jMDoKE
        y95JDKAXVjlOgexCanC5jST7vGhfVP4=
X-Google-Smtp-Source: APXvYqz/Gi3sqP1+RWgAjs4/KQiY6DKXMAZpOrp0vlYfToFG1DPAvnmBb1XqSlxuzmU47Ker29sNMg==
X-Received: by 2002:a19:598f:: with SMTP id n137mr1587576lfb.140.1552640343148;
        Fri, 15 Mar 2019 01:59:03 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.80.66])
        by smtp.gmail.com with ESMTPSA id d5sm310297lfi.95.2019.03.15.01.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 01:59:02 -0700 (PDT)
Subject: Re: [PATCH] net: tipc: fix a missing check of nla_nest_start
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20190315060740.13920-1-kjlu@umn.edu>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <1d97622a-6404-6600-c06b-9450b225742b@cogentembedded.com>
Date:   Fri, 15 Mar 2019 11:58:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190315060740.13920-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 15.03.2019 9:07, Kangjie Lu wrote:

> nla_nest_start could fail and requires a check. The fix returns
> -EMSGSIZE if it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   net/tipc/group.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/tipc/group.c b/net/tipc/group.c
> index 06fee142f09f..117867e480ba 100644
> --- a/net/tipc/group.c
> +++ b/net/tipc/group.c
> @@ -918,6 +918,8 @@ void tipc_group_member_evt(struct tipc_group *grp,
>   int tipc_group_fill_sock_diag(struct tipc_group *grp, struct sk_buff *skb)
>   {
>   	struct nlattr *group = nla_nest_start(skb, TIPC_NLA_SOCK_GROUP);

    Please keep the empty line after the declarations.

> +	if (!group)
> +		return -EMSGSIZE;
>   
>   	if (nla_put_u32(skb, TIPC_NLA_SOCK_GROUP_ID,
>   			grp->type) ||

MBR, Sergei
