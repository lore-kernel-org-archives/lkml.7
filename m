Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DC4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A19021929
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMYWbfHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfJUC6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 22:58:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34883 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfJUC6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 22:58:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so7459862pfw.2;
        Sun, 20 Oct 2019 19:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5viSdignwBd+hP0QdUGF2BJiCA6pTj2uN3VG3vY6NRA=;
        b=oMYWbfHr1Pn9wB5dKoGj67iZ4euP7QNCOCByzvS0/V4quzp8hXHCuz1OoqVlI0DsRd
         dUU7qWXdqHXK56E4YeVoFrG81Q3KFoHT64HOia3IuA4h1sSR8rgmXuXIuScmLZPWTPZw
         GZobFSfyJTqAfkX+jZeNT/zY+zwOR44kns2z0cfIN8a2R6C5JoaxpBTR48XprrTyOQsv
         hCC1pbpWtPUUxz+aCxpUa3I+/fXvta/iiZq8aOCKP8IP8MI9dVHRsdE3fmi1K3NgA7uX
         I8XtUpS7SzO0kyYwe49n5osG5jbXH/44XllFwGkhD1p5tMHV6ldpKpyAn05waOLQkwpD
         KcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5viSdignwBd+hP0QdUGF2BJiCA6pTj2uN3VG3vY6NRA=;
        b=UjKlUzvUr2JWJbDW8KFoTPPe88hvlgDCuJA+p7A78ERTV2XZ5AZbB/bEcoDGdUjzCm
         iFhfkcffuJOKe6o00TFtLw7z799BnRDyJI8zMLmMGKm8M5jQzNRUJPXUoercgaHdTZ46
         S8obZ8ZzwN+NHWaZXVo1OMSL3Tx4A9Wvl1+qBw0xqc0r84NBCoS1Ezc9ioRwpJ8KFlIe
         38xNTw7d0797vVRHnCxfQluEcriJ5FJmjSgC4ASmtrXf+fUBWEkNF5ORs6WC7844tAv9
         8/YbfvARnAUtOG0l3fwH/h8RNlxk0PH77zleM2znWpYcwZ4ztm5NFPjjjQVxCEH9UlE4
         dYfg==
X-Gm-Message-State: APjAAAUZwXvAbzba4gnLC3p0lAbWZx42l1LFU8RZsW3vWwBH87n6JDc4
        mREcNoyp2X2XdSBQAXA1epGlFdjP
X-Google-Smtp-Source: APXvYqxdhxT7zwTYgmbbBWoCbb1kt15S2Si4vdvQ5rU3y5dmhBrOfH0O+oE6bUgeo/tqIunPXIfJBA==
X-Received: by 2002:a62:ac02:: with SMTP id v2mr10973737pfe.26.1571626716163;
        Sun, 20 Oct 2019 19:58:36 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id h4sm14524838pfg.159.2019.10.20.19.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 19:58:35 -0700 (PDT)
Subject: Re: [PATCH net-next 02/16] net: dsa: add ports list in the switch
 fabric
To:     Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org
References: <20191020031941.3805884-1-vivien.didelot@gmail.com>
 <20191020031941.3805884-3-vivien.didelot@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d1b9e4c7-9641-39bb-f559-a64014e7d5ba@gmail.com>
Date:   Sun, 20 Oct 2019 19:58:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191020031941.3805884-3-vivien.didelot@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2019 8:19 PM, Vivien Didelot wrote:
> Add a list of switch ports within the switch fabric. This will help the
> lookup of a port inside the whole fabric, and it is the first step
> towards supporting multiple CPU ports, before deprecating the usage of
> the unique dst->cpu_dp pointer.
> 
> In preparation for a future allocation of the dsa_port structures,
> return -ENOMEM in case no structure is returned, even though this
> error cannot be reached yet.

BTW, this patch had a small hunk while applying which forced git am to
ask for manual resolution, my net-next tree was based off
v5.4-rc1-582-gebcd670d05d5.
-- 
Florian
