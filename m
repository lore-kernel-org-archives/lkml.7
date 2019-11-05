Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82A8C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA12217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="hLBHSDw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389952AbfKEPrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:47:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35202 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389399AbfKEPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:47:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id 8so13681091wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 07:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/3v/iFLkEBuwQFFCYnjZhKit30wFqd9RVcimAk+a9Vg=;
        b=hLBHSDw2JMN1+e779q/nRjHLfQRZaAmvjg+ByHa5eAd0LRxl9pklZ2nJKbWbdHwEGp
         tjVEt+F37m33S0/FsbY/J5CgNlfZFJOVQloxykjLXTeIps/L9FUI3JvpmHX1DJsID5Q5
         slzRQ0e+sTO8M1nOrMVRuvxDeqxWnR8BHG6I5+Tmi1KAVbSi+rCnrFhEZZFMjZZQrhUx
         7zeNvah37WNj1n9gUQ6MnWUqWYNtRyNYr6I7Y+NDyP9rTrJLcqXU4IK3Sc/isvfmwxpv
         T/UVFVdImJYhfkD83mqE4aaXt4ohZU9ugQ8HasYkuggFf0O+7SV/L9Zy8Q5tEYKtb4es
         94wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/3v/iFLkEBuwQFFCYnjZhKit30wFqd9RVcimAk+a9Vg=;
        b=a0Y7rbW1STVBPMeQp4XDlg70Yr6M9i9nYfmhBJMK9iCsXgRtm4WsT8tqyvkLYoy8eG
         71ttgdx30FqjcXeZxYQi/dkco2W1L8t7/lo30KZmwBL9ztnpf1R4GBgzOKHzYJ6piqsI
         bnRcfWjdIqL/JNmx8BmLooswv7+fb2wL83RQxCsoFWw2kqAsWoVUlzjRFjtj79ABB9vU
         NTuEOYc0Qa8vDV9372sb8IUmZzuRqc5Izv4apK5sMqb4hjoh6fRzLw54/iXUFGON9skj
         vgrsh5GUFmLsgjwbMe9mWRG7KTEUNz78Gx5avAkTZLjLvl3hWbXTuBZqL73jwtTeOWPX
         oE7w==
X-Gm-Message-State: APjAAAUodAHbSeo4bFcjGrESGUhsjUDZpTGWP6lHhE/T2g/paJmF9UXU
        bJY04f+0p/lbkTKVy5MBZTeG4A==
X-Google-Smtp-Source: APXvYqzpZIvSnvOKpkPrQvcBy16uYI1kRaMQObz1LcUtV0SuT3gm5wk6Yk0MBbSbo3owHMcqxqsERQ==
X-Received: by 2002:a7b:c1ca:: with SMTP id a10mr444576wmj.161.1572968866212;
        Tue, 05 Nov 2019 07:47:46 -0800 (PST)
Received: from ?IPv6:2a01:e35:8b63:dc30:f096:9925:304a:fd2a? ([2a01:e35:8b63:dc30:f096:9925:304a:fd2a])
        by smtp.gmail.com with ESMTPSA id 16sm238178wmf.0.2019.11.05.07.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:47:45 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH 4/5] net: ipv4: allow setting address on interface outside
 current namespace
To:     Jonas Bonn <jonas@norrbonn.se>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net
References: <20191105081112.16656-1-jonas@norrbonn.se>
 <20191105081112.16656-5-jonas@norrbonn.se>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <ae1d28b3-f62f-c58e-d478-980f47fe4fea@6wind.com>
Date:   Tue, 5 Nov 2019 16:47:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105081112.16656-5-jonas@norrbonn.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 05/11/2019 à 09:11, Jonas Bonn a écrit :
> This patch allows an interface outside of the current namespace to be
> selected when setting a new IPv4 address for a device.  This uses the
> IFA_TARGET_NETNSID attribute to select the namespace in which to search
> for the interface to act upon.
> 
> Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
> ---
[snip]
> @@ -945,10 +961,11 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
>  
>  			if (ret < 0) {
>  				inet_free_ifa(ifa);
> -				return ret;
> +				err = ret;
> +				goto out;
>  			}
>  		}
> -		return __inet_insert_ifa(ifa, nlh, NETLINK_CB(skb).portid,
> +		err = __inet_insert_ifa(ifa, nlh, NETLINK_CB(skb).portid,
>  					 extack);
if (err < 0)
	goto out;
?
else err is set to 0 later.

>  	} else {
>  		u32 new_metric = ifa->ifa_rt_priority;
> @@ -956,8 +973,10 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		inet_free_ifa(ifa);
>  
>  		if (nlh->nlmsg_flags & NLM_F_EXCL ||
> -		    !(nlh->nlmsg_flags & NLM_F_REPLACE))
> -			return -EEXIST;
> +		    !(nlh->nlmsg_flags & NLM_F_REPLACE)) {
> +			err = -EEXIST;
> +			goto out;
> +		}
>  		ifa = ifa_existing;
>  
>  		if (ifa->ifa_rt_priority != new_metric) {
> @@ -971,7 +990,14 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
>  				&check_lifetime_work, 0);
>  		rtmsg_ifa(RTM_NEWADDR, ifa, nlh, NETLINK_CB(skb).portid);
>  	}
> -	return 0;
> +
> +	err = 0;
here.


Regards,
Nicolas
