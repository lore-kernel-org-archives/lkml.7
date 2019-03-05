Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E87C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CFE20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="UZOwQjG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfCERcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:32:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38968 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCERcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:32:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id i20so6219761pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 09:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=1pE3ixqIqRqW61liQQd2t4mKkvPyJZJwGdgDqWNQ250=;
        b=UZOwQjG6/yA+Pb8jeiW+1GMqj9b0q0cM8FUlvvIK/K7n8eWcuWsETtDEMcPgq2cdo8
         0/RavltB3dKPkX0xMS/aC7OwdV16ytR1ZXRcBMAs0+Tftd/O2Rx/oX7T6dg1z+FIcYa/
         07aOCuhT2SEWzoasWThCRORD9V2Hgu9OoXwcbquMAZcse6XvDuICnY9Cq84z2HOjQ3gd
         3zrJynWoHIzvQ7jjApYZ1wWhns+yj+JQyvfagSZfwt3GYyLKqBAct0oE4nFNoIVw5wjG
         Fv4RwmMdQEgpl/VkdJcztdowLWWsQiNM155N/Xm0kpacjKOfRzuihaY2Fm1dFQU6OAaa
         4VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=1pE3ixqIqRqW61liQQd2t4mKkvPyJZJwGdgDqWNQ250=;
        b=WFXf5cwzBzdsYh+IfupJiigVPtLLNP3bUH4SoPgevOtjAa6HmEEb5lXmrNydLvf4az
         N3V0Pcew9bf0K10gGto452FWOMddkljAmFoXiAmRibCwiQKvn1aCdU8hx0VZ28ZzoPG9
         UQtiCy1yNQ+5SBzrh4BoTUocyVndPc7iYQIUrmLQF2uPmVD5Y+/vKJPf1qrkrtUeoQ92
         PWKtD6BDSuPUYC/y6Xf/mbM8XMMKrpPXldLhvDSHG9UxD0Wkrlgn1aY9RjFIir2h71df
         OXrFRnNn2xCjV+EMOZaG0l+16R2tNTg15TvzCWfm9l0J6EcfLHHOWrr7gVOIg+uKxFn/
         RgOA==
X-Gm-Message-State: APjAAAWUT5VGJReAHaBVk84MkUWld8lpLVQZ1ATrae8hAWmRuVlPg3h1
        JXOG9Dr2yRhzJEtdEOtDgzSmvA==
X-Google-Smtp-Source: APXvYqxaQz0DviF7Hqx/6ymdghJP7U+4nqCx07qqk6qqU3yK8wtQusWDHpm4/+SIKxiGASvbm0GqHw==
X-Received: by 2002:a17:902:b904:: with SMTP id bf4mr2286086plb.273.1551807166048;
        Tue, 05 Mar 2019 09:32:46 -0800 (PST)
Received: from cakuba.hsd1.ca.comcast.net ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id z189sm13855780pfb.146.2019.03.05.09.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 09:32:45 -0800 (PST)
Date:   Tue, 5 Mar 2019 09:32:40 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alban Crequy <alban.crequy@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io
Subject: Re: [PATCH bpf-next v1] tools/bpftool: create map of maps
Message-ID: <20190305093240.53095a37@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20190305163803.18915-1-alban@kinvolk.io>
References: <20190305163803.18915-1-alban@kinvolk.io>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Mar 2019 17:38:03 +0100, Alban Crequy wrote:
> From: Alban Crequy <alban@kinvolk.io>
> 
> Before this patch, there was no way to fill attr.inner_map_fd, necessary
> for array_of_maps or hash_of_maps.
> 
> This patch adds keyword 'innermap' to pass the innermap, either as an id
> or as a pinned map.
> 
> Example of commands:
> 
> $ sudo bpftool map create /sys/fs/bpf/innermap type hash \
>         key 8 value 8 entries 64 name innermap flags 1
> $ sudo bpftool map create /sys/fs/bpf/outermap type hash_of_maps \
>         innermap pinned /sys/fs/bpf/innermap key 64 value 4 \
>         entries 64 name myoutermap flags 1
> $ sudo bpftool map show pinned /sys/fs/bpf/outermap
> 47: hash_of_maps  name myoutermap  flags 0x1
> 	key 64B  value 4B  max_entries 64  memlock 12288B
> 
> Documentation and bash completion updated as well.
> 
> Signed-off-by: Alban Crequy <alban@kinvolk.io>

bpf-next is closed let's continue reviewing, but you'll probably have
to repost after the merge window :(

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index e0c650d91784..7d8ce903a471 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1151,6 +1151,9 @@ static int do_create(int argc, char **argv)
>  				return -1;
>  			}
>  			NEXT_ARG();
> +		} else if (is_prefix(*argv, "innermap")) {
> +			NEXT_ARG();
> +			attr.inner_map_fd = map_parse_fd(&argc, &argv);

You need to check if the return value is not -1, and also close this
file descriptor (a) when done, (b) when error happens.

>  		}
>  	}
>  
