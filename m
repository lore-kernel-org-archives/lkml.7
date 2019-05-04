Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AA7C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772E12084A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNs6zsS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfEDKEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 06:04:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41630 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfEDKEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:04:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so4165837pfd.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 03:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gfIdtbvl+cU5+4oOsDFHcXYeeYkozHfEYXRLh0N3BKE=;
        b=FNs6zsS4m6E3vHqa1w/FdmSh4GwdllDL2fGoTv0cPqrTDLX6MBdGVxqyIk5Ip7PRrE
         /VMTkhZyCJQXSgl1ixaH9D5HvMCQb4dSOb84ItgH5it4MsNzRt80LGlF1/Bt8/gzaF5g
         EIH1Ux2Cf5I2eyZgYAum6NkY/MF/YiPi/90CyyP8aNCCnPHOMKO7CZdbKRZbDgSnzxZ0
         W0TrMa9it4HOZ9euUN5L4WrwLRWWGTmQwGGYfgWaTEuSJOFmmhc2j8qgezlywCQf4FY4
         wq5w3p/zwgz5WT5tj5MEZqZ6nkL3l5WKtSLOuows1V7Y9vFBU76a3wBic5ASGxcyHwMY
         taDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gfIdtbvl+cU5+4oOsDFHcXYeeYkozHfEYXRLh0N3BKE=;
        b=P3F8MqIwavpHorq3gUhFuumIrxRrsQPrT3ELqTP/jgJB2YtLZOaRwywjlHDVajhtfl
         XCspQSnwLuvoH5CV9K/P+iH4JdjW9nXbXDG1hpl0Mn6Yp64i33+cJxQX/WFhLRA9wdut
         lH0GVUZZ9Bxajjl8I9QLllarjgOyTEd0/9PI/KzQLL3FV6rgacXaSVnlSyK3u9vl7dbt
         hIdKnYXGBhSWwiue+W9wqvEzQCzM8mEQiuKXDoVxT+DDnCznUjFAk3mrfXNEAz+qwzXf
         b09TtKc8sWrOil+F+3S4Vp+wZd5v1XiGTnZzpRq672p6lMzFryHp7n4WbW4+q5KoJFop
         +HtA==
X-Gm-Message-State: APjAAAUNhyKKCLEZF0vUVUBMMKIIx2VDCXQ8dmYaNzfxvoRjnkB6iyMo
        bDZGFa6HOWsokE6d+bV+JOU=
X-Google-Smtp-Source: APXvYqxh9+Xd48+1ehg/SIwAK+M/lJBxN7I/+Apl6JWEq7lsZXZpJdT4c6hP/DhHWMkSAInRYLIzYA==
X-Received: by 2002:a63:e004:: with SMTP id e4mr17677804pgh.344.1556964291118;
        Sat, 04 May 2019 03:04:51 -0700 (PDT)
Received: from [192.168.0.6] ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id k7sm5519422pfk.93.2019.05.04.03.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 03:04:50 -0700 (PDT)
Subject: Re: [PATCH 3/4] nvme-pci: add device coredump support
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <1556787561-5113-4-git-send-email-akinobu.mita@gmail.com>
From:   Minwoo Im <minwoo.im.dev@gmail.com>
Message-ID: <66a5d068-47b1-341f-988f-c890d7f01720@gmail.com>
Date:   Sat, 4 May 2019 19:04:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556787561-5113-4-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Akinobu,

Regardless to reply of the cover, few nits here.

On 5/2/19 5:59 PM, Akinobu Mita wrote:
> +
> +static const struct nvme_reg nvme_regs[] = {
> +	{ NVME_REG_CAP,		"cap",		64 },
> +	{ NVME_REG_VS,		"version",	32 },

Why don't we just go with "vs" instead of full name of it just like
the others.

> +	{ NVME_REG_INTMS,	"intms",	32 },
> +	{ NVME_REG_INTMC,	"intmc",	32 },
> +	{ NVME_REG_CC,		"cc",		32 },
> +	{ NVME_REG_CSTS,	"csts",		32 },
> +	{ NVME_REG_NSSR,	"nssr",		32 },
> +	{ NVME_REG_AQA,		"aqa",		32 },
> +	{ NVME_REG_ASQ,		"asq",		64 },
> +	{ NVME_REG_ACQ,		"acq",		64 },
> +	{ NVME_REG_CMBLOC,	"cmbloc",	32 },
> +	{ NVME_REG_CMBSZ,	"cmbsz",	32 },

If it's going to support optional registers also, then we can have
BP-related things (BPINFO, BPRSEL, BPMBL) here also.

Thanks,
