Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207B3C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E790520861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcy3N/5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfGHLFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:05:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41526 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfGHLFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:05:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id q4so7494743pgj.8;
        Mon, 08 Jul 2019 04:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NtX1NBWaGDXHcz/9wV69LDs12vFDWpigTQpyWgIp7WY=;
        b=kcy3N/5wF2is7bKFphDTb3o32usun1qqyS+cw4mgA4BdBFYSHjAMF1zj1hxBN3uGPb
         3CxCaL/F37D+IKkM/HjMb8/gK4miXo3WDG7DQyf6UEN5UW5ocleFGf0OS9jPX3a9zOHE
         ThjMeTaV3tLmzBSadH3yqz9eh68IVYPZbg2zgXoj4ptcPRJ7S1l3qnYXW+6pwMoQcZ4L
         TjLFVg4qA5pMMlC94TVV+qPzlRIWNdCdXYkZDJcFQAFCHKYJrIL3P9UVi2Ry0aNEgKlp
         ItigGhFsqHWNdlvd+K9VFlv+k+xoMNvAj6eJtLOmCo3ue4amOLdZE0qNLsCbnV2MaFdf
         d0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NtX1NBWaGDXHcz/9wV69LDs12vFDWpigTQpyWgIp7WY=;
        b=jloCaq5DEfZ1wrztgL3Gh4Uc7+bjHrExQWoFpPK/B2uTcb+ERsOobvNjGKjM0YSRL+
         VaE7MWnrtdOQFWzR8tQRoJ+jTEvNoh8Nrk6nPHOSl5k6foVhe4uEeeM84hkSngRx8kls
         cPqSh1kiBb3McFH0dIgvR/mlomL67CE5ghDNNSdSotSpwmkx7Tgs9nqLP7H83t8a1VpN
         cW1JbsiA5xXsPuvPiYPCNT+Nid5ZV4ONmMOwTJmvvYzE8FcvcE/30k7X1psyB4FAdin+
         SbjNYN38ZvHrCN7e9Pnv0d+K5skk4uRy2o8sXz3/A40vpzBU+hbfp6U1TojQGANgcHsy
         Sm9g==
X-Gm-Message-State: APjAAAX9e+3tzXV5VMGWy4bxI2VeRvmrXR2ZTRdKrDq2f9wUua0OtzFw
        sY8venQ+twhpmeoYlG/j81E=
X-Google-Smtp-Source: APXvYqx3p0GV+7LFLkdB/dvR0QAleb83mTbmvQxj6v1xCAHyHZb7nvdMjfJUdSoK0o17VhSBXXpLcA==
X-Received: by 2002:a17:90a:9903:: with SMTP id b3mr24440118pjp.80.1562583942288;
        Mon, 08 Jul 2019 04:05:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b126sm20811787pfa.126.2019.07.08.04.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 04:05:41 -0700 (PDT)
Subject: Re: [PATCH 3.16 000/129] 3.16.70-rc1 review
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        Denis Kirjanov <kda@linux-powerpc.org>
References: <lsq.1562518456.876074874@decadent.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <89ecc914-674d-6626-6741-2076ba974d46@roeck-us.net>
Date:   Mon, 8 Jul 2019 04:05:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <lsq.1562518456.876074874@decadent.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/19 9:54 AM, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.16.70 release.
> There are 129 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Jul 09 20:00:00 UTC 2019.
> Anything received after that time might be too late.
> 

drivers/mtd/devices/docg3.c:1836:15: error: implicit declaration of function 'devm_kasprintf'

Seen in various builds.

Guenter
