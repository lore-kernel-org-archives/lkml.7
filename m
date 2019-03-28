Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3909C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B1E2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoT19zZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfC1CZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:25:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42423 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfC1CZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:25:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id r15so10595180pfn.9;
        Wed, 27 Mar 2019 19:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mql8WNuG6cqKIJjVHvfQWww23ugEg3tBK1/HZguncgs=;
        b=SoT19zZZlL9V9J5j3QBBDXEOu+CJhoteOgk7P1R6oe0HrEHyZYKK6sFFtZqd+jpnUd
         LkF9x69cQv/2aPWrf8XIeDHhihyhdeXTFoFn0nBF6S6Ja5eLLXUuRNlwhjMk0+1jO87j
         RzxHCYOxDsNjFe2m4d/9XNXpB3jBkl70caT5zzsOzlo8E8s+Sp+AuTY64YhDADGoL0yB
         5ivz930HH77U0JH4kr+khNWAZC7m1WnqVj0zCvavRDFjdWRawN75eIBa+JPYh4k2UiDH
         uEjSMUMA/BunS8dI1eWaW+WZ62HcC2gs9ymlb5F/mi7eGc5wUqUahHDldoRi0ZiTFt1k
         mzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mql8WNuG6cqKIJjVHvfQWww23ugEg3tBK1/HZguncgs=;
        b=YWUE1rrjs114UeDcGamqRnBUSZB9TIdWNHlkqq6Podspj3EcuZumE3fXBolW7uUE/5
         LOvemXGWtF4j0J8Actw/8OCHZZxK35WL++T2GNvlrWpdBJ1Zse/9U5xfS+OLDm8Qm0R1
         CiW/fSHtkDUsp31WZw0SzQTAqsh3HIaa/MLoMlLbgAUQRfU5m13nahm1n22TCW/Q+Etf
         cqPvqbePJVIXRdJFozFvI1rhfK5aMn+EkmFcPhj/Mqe7p5ucAlzHffF5ymnGDji3oJm9
         APb1xkPIcmM/GdtIx8PmgkYIkgp6l+1jO//JTuy4BiJ94ovfSloBZsWCBBnjyL2v+pE6
         J3Fg==
X-Gm-Message-State: APjAAAVWG4MbdqSBPdVhKvPm969lissC97Ji6SopkB/taRSwTY2HtsqC
        rzf/JILdfiAWCZabigJTnPCWbSSU
X-Google-Smtp-Source: APXvYqynwtVKhwXX2zl6uNNw7qdbD/UIUdvXXIdYWg6daR0KTCq7CFcCrKMVDRQNQHjNOe8JNH895w==
X-Received: by 2002:a65:6098:: with SMTP id t24mr38115597pgu.57.1553739952953;
        Wed, 27 Mar 2019 19:25:52 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id l63sm34447008pfc.89.2019.03.27.19.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 19:25:52 -0700 (PDT)
Subject: Re: [PATCH net-next v5 12/22] ethtool: provide string sets with
 GET_STRSET request
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <f5af581e33b4976b84eae7c7788e3fde9adfa83c.1553532199.git.mkubecek@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <2c29310b-a2a0-3867-a09f-51f2dc47ecd3@gmail.com>
Date:   Wed, 27 Mar 2019 19:25:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f5af581e33b4976b84eae7c7788e3fde9adfa83c.1553532199.git.mkubecek@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 10:08 AM, Michal Kubecek wrote:
> Requests a contents of one or more string sets, i.e. indexed arrays of
> strings; this information is provided by ETHTOOL_GSSET_INFO and
> ETHTOOL_GSTRINGS commands of ioctl interface. There are three types of
> requests:
> 
>   - no NLM_F_DUMP, no device: get "global" stringsets
>   - no NLM_F_DUMP, with device: get string sets related to the device
>   - NLM_F_DUMP, no device: get device related string sets for all devices
> 
> It's possible to request all string sets of given type or only specific
> sets. With ETHA_STRSET_COUNTS flag, only set sizes (number of strings) are
> returned.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---

[snip]

> diff --git a/Documentation/networking/ethtool-netlink.txt b/Documentation/networking/ethtool-netlink.txt
> index 5e5d785fe215..1508c16a236e 100644
> --- a/Documentation/networking/ethtool-netlink.txt
> +++ b/Documentation/networking/ethtool-netlink.txt
> @@ -127,6 +127,8 @@ List of message types
>  ---------------------
>  
>      ETHNL_CMD_EVENT			notification only
> +    ETHNL_CMD_GET_STRSET
> +    ETHNL_CMD_SET_STRSET		response only
>  
>  All constants use ETHNL_CMD_ prefix, usually followed by "GET", "SET" or "ACT"
>  to indicate the type.
> @@ -167,6 +169,46 @@ and also multiple events of the same type (e.g. two or more newly registered
>  devices).
>  
>  
> +GET_STRSET
> +----------
> +
> +Requests contents of a string set as provided by ioctl commands
> +ETHTOOL_GSSET_INFO and ETHTOOL_GSTRINGS. String sets are not user writeable so
> +that the corresponding SET_STRSET message is only used in kernel replies.
> +There are two types of string sets: global (independent of a device, e.g.
> +device feature names) and device specific (e.g. device private flags).
> +
> +Request contents:
> +
> +    ETHA_STRSET_DEV		(nested)	device identification
> +    ETHA_STRSET_COUNTS		(flag)		request only string counts

Should not that be part of the nested attribute under
ETHA_STRSET_STRINGSET. We should probably think about adding another
flag which indicates that we want to get the stringset associated data,
see below why.

> +    ETHA_STRSET_STRINGSET	(nested)	string set to request
> +        ETHA_STRINGSET_ID		(u32)		set id
> +
> +Kernel response contents:
> +
> +    ETHA_STRSET_DEV		(nested)	device identification
> +    ETHA_STRSET_STRINGSET	(nested)	string set to request

string set requested?

> +        ETHA_STRINGSET_ID		(u32)		set id
> +        ETHA_STRINGSET_COUNT		(u32)		number of strings
> +        ETHA_STRINGSET_STRINGS		(nested)	array of strings
> +            ETHA_STRING_INDEX			(u32)		string index
> +            ETHA_STRING_VALUE			(string)	string value

This is one of the areas where the legacy ethtool ioctl() is painful
because we need to request a string set to know how many of those exist
to allocate space for those in both kernel and user space.

If we could find a way to have a single command that allows us to dump
stringset (count, values) and associated data, then we save ourselves a
context switch and having to pre-allocate memory accordingly.
-- 
Florian
