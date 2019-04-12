Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12430C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61FC2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="lADMS5s4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfDLNUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:20:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36635 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfDLNUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:20:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so11962979wrd.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RD5e3nY4gSGKvY1dPERdEJF3Duo6Im/qEyST4NxZfjk=;
        b=lADMS5s4NQBE+2YJwhMzPXbp57vD/aJJRK4khgoEdAMfrGPZ/T5LNmO38/dpLX4Wb8
         TYbp5rUzNGLEwXb8k6bzsIWByMzGM0ZtEMGAf41oPifQY17lise8NjwKLlfHIsKAGiK5
         9h3Hiudmr9YPlkYn8KzR/XGfbp/G4JNhYFtS4QRMGGzUQ/ykF2QSChcXSmTH+x8hSHmh
         khpdJThC+gdcoUKh3w3mCB8KQPH3TV0gsbwNwmnWnfXtriMXL3UWI6qP0bV7uL9g1MUH
         5uIEeuvntDToS03YT1Yq9HTxxAm8dD4Ip3sTgPuN87IpzHq6B3WhxSpQBCUU/Ukxk/u3
         LJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RD5e3nY4gSGKvY1dPERdEJF3Duo6Im/qEyST4NxZfjk=;
        b=krQzzrwqq0FidD4A1FVNZ9CBuiJ3Ye05v/A6wWLq/NmKzcvuTsBEbfhrZrAXzP87wj
         nvDnbxvtSonyw/pJLJTuL4jObiah2580Vk2H799FrQU8PTCF79mX/JA/kKeXBms/y5lA
         r5+6MqIM8k4BOUtIybDb02yHBXj8y9oGM5EkJxlNw5xg2jYdku8ibEt6Gy52xgEmB49w
         R4xRIB3NWDCno8f0uR9X6slVsnTqnih6fHcJCzkXrlmxzdJVScbb0Y7U3UQG/RAA37ej
         CIlgo+pcIvqWQprtK2w1iloSAENT5ejm2elVjZkGnMcaGB9axv7+WRS2pBL6CsWr1E8x
         VZng==
X-Gm-Message-State: APjAAAVeZS6DJgIaV1zLMpqavj72QeAlDR5HMdYGQDM+wC2goOjWUFpD
        WBtiVRrnaK3gleTkqnMxTy7rAQ==
X-Google-Smtp-Source: APXvYqwglRDtPCIJqP4n6Ram6jkt9NTn1qATEQw1wmoVddpNIOAjDnh11N/UTfIUh0RGPiQTXBTsZg==
X-Received: by 2002:adf:eb84:: with SMTP id t4mr8579724wrn.43.1555075249195;
        Fri, 12 Apr 2019 06:20:49 -0700 (PDT)
Received: from [172.20.1.104] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id w130sm11051415wma.36.2019.04.12.06.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:20:48 -0700 (PDT)
Subject: Re: [PATCH bpf v2] tools: bpftool: fix infinite loop in map create
To:     Alban Crequy <alban.crequy@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io
References: <20190412124050.32120-1-alban@kinvolk.io>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Message-ID: <8fb1d2e0-f8c0-4e01-ddf8-158c9e80558c@netronome.com>
Date:   Fri, 12 Apr 2019 14:20:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412124050.32120-1-alban@kinvolk.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-04-12 14:40 UTC+0200 ~ Alban Crequy <alban.crequy@gmail.com>
> From: Alban Crequy <alban@kinvolk.io>
> 
> "bpftool map create" has an infinite loop on "while (argc)". The error
> case is missing.
> 
> Symptoms: when forgetting to type the keyword 'type' in front of 'hash':
> $ sudo bpftool map create /sys/fs/bpf/dir/foobar hash key 8 value 8 entries 128
> (infinite loop, taking all the CPU)
> ^C
> 
> After the patch:
> $ sudo bpftool map create /sys/fs/bpf/dir/foobar hash key 8 value 8 entries 128
> Error: unknown arg hash
> 
> Fixes: 0b592b5a01be ("tools: bpftool: add map create command")
> Signed-off-by: Alban Crequy <alban@kinvolk.io>
> 
> ---
> 
> Changes in v2:
> - Explain the cause of the bug in commitmsg
> - Add the "fixes" line in the commitmsg (Jakub's review)
> - Rebase on the bpf tree
> 
> v1 was initially based on bpf-next and submitted on
> https://marc.info/?l=linux-kernel&m=155310327709613&w=2
> ---
>  tools/bpf/bpftool/map.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 05b029b934a6..1ccc38718458 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1151,6 +1151,9 @@ static int do_create(int argc, char **argv)
>  				return -1;
>  			}
>  			NEXT_ARG();
> +		} else {
> +			p_err("unknown arg %s", *argv);
> +			return -1;
>  		}
>  	}
>  
> 

Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>

Thanks Alban!
