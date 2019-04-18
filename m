Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CC9C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB97920675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU3ubNnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbfDROPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:15:46 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38506 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388097AbfDROPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:15:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id e80so1837702ote.5;
        Thu, 18 Apr 2019 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9bYJ3AThrbOUJKHn803L2pSv2Dsj0A707jKHfwdN1JQ=;
        b=YU3ubNnEFeb4c5wqqbTR4PB7+UFA9GtFLGWfkpogvCPKp4y7uFW0D2Lv6Jnoq7/t4r
         A/L4CwqhjIHoZfT+MReePeQjtowsJrq8EpxDSmRqMAnPy1koAmGHfUjVtzANSPWfQG9m
         qBRUW1IHpEX/eu9kvMITD8uH/9lhIcM4tutN0IMevBsmYqJjDUJHMINMTw58EdxtcwmK
         AAydKDNF81agOoC+2yWuoIi1MujCD93ajTaF+Pa2IuDl97BzeIEvxp5Cf8vcfUYavK8A
         UvcRwAzKz7dxol6+5+T6iqFM0AAZHUxcMfI5wYudCrpWf3ruUutWdCd9kzODSmx9pzZv
         FWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=9bYJ3AThrbOUJKHn803L2pSv2Dsj0A707jKHfwdN1JQ=;
        b=j0xjocSuZgQAs7CvM5AFsMB401v4VaRS+51ZFNSsrHmUGPP+OL1tg4btrMip80M1MS
         P8Mfvwm2/uDZxcyvYVQz4j8qMXm+H3UMPgX/9BCgHtblsF1X1D72O//zxvBdhRr31Iaw
         IYEqp3xha4xvLPHQrMJu1oZhRpzIOg85wFoArtgY5Pok4wjEd6TCcrfZowK28q3M8sNk
         LqdfGPOon3quAOUIgHqqIo8l8Y2XcR+bS5SqwE5+JDsBdTZE+lSXR0vWav8Qxduv8aa8
         DlD4tEng9gdr/5x+nJhfe2fbWd6jqNc/GnwjQhLBPpO1TqUIqRzeEBhWcxccCathQ6bB
         60Ew==
X-Gm-Message-State: APjAAAWAvg43ecJhZqUMsVVzgccPw4aINa5xLlWvaG/KQRXFtFh888r4
        Uae2vm4mRou10XgyFiuuSg==
X-Google-Smtp-Source: APXvYqyOc0sBlXXJlXvy/JZHmA+tO/joH2Mv7I5mKkOHXy6WPkt0cJZuZtL9SLqnf00ye7kFnNRCQQ==
X-Received: by 2002:a05:6830:1345:: with SMTP id r5mr5020010otq.256.1555596945179;
        Thu, 18 Apr 2019 07:15:45 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id v24sm845900oic.32.2019.04.18.07.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 07:15:44 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
        by serve.minyard.net (Postfix) with ESMTPSA id 7426A1800CB;
        Thu, 18 Apr 2019 14:15:43 +0000 (UTC)
Date:   Thu, 18 Apr 2019 09:15:42 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Aishwarya Pant <aishpant@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char/ipmi: fix spelling mistake "receieved_messages" ->
 "received_messages"
Message-ID: <20190418141542.GH2479@minyard.net>
Reply-To: minyard@acm.org
References: <20190418101502.9748-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418101502.9748-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 11:15:02AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the documentation. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, queued for 5.2

-corey

> ---
>  Documentation/ABI/testing/sysfs-devices-platform-ipmi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-ipmi b/Documentation/ABI/testing/sysfs-devices-platform-ipmi
> index 2a781e7513b7..afb5db856e1c 100644
> --- a/Documentation/ABI/testing/sysfs-devices-platform-ipmi
> +++ b/Documentation/ABI/testing/sysfs-devices-platform-ipmi
> @@ -212,7 +212,7 @@ Description:
>  					Messages may be broken into parts if
>  					they are long.
>  
> -		receieved_messages:	(RO) Number of message responses
> +		received_messages:	(RO) Number of message responses
>  					received.
>  
>  		received_message_parts: (RO) Number of message fragments
> -- 
> 2.20.1
> 
