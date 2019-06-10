Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2686EC4321B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0159B20820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zayqil/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389385AbfFJUT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:19:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40571 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfFJUTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:19:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so2641891pfp.7;
        Mon, 10 Jun 2019 13:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=03W6FmFaWOA/TRw2Cw9foNPgPUhYZqfikMgm3aoqsqw=;
        b=Zayqil/OVQgMEKpvIa3qi7YurE3ir3/GOQj63Tc2tiNhM6mMrG5gKb6qZG7VL6rc3F
         GQvtUl0zu878fRPj2/voYS70txbNm9LQxl0D5uM20gsyzj86SEDrK6AMnC9UgEaG5Sgy
         XXxE4OK6yyntHwA3KtXiryO5lvri3WYHEwsgXUIHmdtB+OW2B24mWZxlk1zfydTZbAL5
         AqBbpLu4AwJ7p2ZLfNGEu/GxBCc9rYP3zK5G6Wvce1VAH98SdNDL8P0BxwelaoH2567W
         Q7xC7S7BKCJr7s5DH9x/u8HV2xg39Zg/WCKSPmf/EGWszPqv/K5sohzo4bpm/uqDqdtJ
         hFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=03W6FmFaWOA/TRw2Cw9foNPgPUhYZqfikMgm3aoqsqw=;
        b=nzh/ZmUE78MrfnrNaCG3a3cm7+2mvXJz+aCn2qEc1TusEqcQPbLVs9u4e0z7JDDNXS
         tKXGxP/WO5v+g06m94GUOfUjud59nkaFfM5FmILCql5rfOHRhLuLJuLgi3UVgGGtwPV8
         HzmBvnyxOQUWiC09Ka1x8Jfyc1AhwVQ1EY29bkYpPN3fGhRh2oiGLfgGJ8189+dCF14J
         irDiwrPvZ9q14osz7G+GSzkG+q8Ee7Y9sxUvfGOVzyZC9pxACNeQG5K5sHdr/+Nyo5N/
         e/0r3Y4rn4/ZjEIExncFTlHLsp836weZgjl6nr7Zak9JI4NF/aZk9CZHQmgt11LJH1We
         7tng==
X-Gm-Message-State: APjAAAXVDFnWRNEv2u21bnI9iTeHcyB0dsdDuJQSGnSFujKvmhaJCJU2
        G1zqo/4GRzxnbmF6Lm3JL5k=
X-Google-Smtp-Source: APXvYqwezggIX1oeRyjxUbAw7ivczegK/PwSD0j5lFeS9Hvgs6GNvrhwwY60DrA/AVvp+Ton+2OD/Q==
X-Received: by 2002:a17:90a:9dc5:: with SMTP id x5mr22051562pjv.110.1560197995050;
        Mon, 10 Jun 2019 13:19:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b35sm312310pjc.15.2019.06.10.13.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 13:19:53 -0700 (PDT)
Date:   Mon, 10 Jun 2019 13:19:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, oakley.ding@advantech.com.tw,
        jia.sui@advantech.com.cn, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct7904) Add extra sysfs support for fan,
 voltage and temperature.
Message-ID: <20190610201952.GA13191@roeck-us.net>
References: <20190610080736.6593-1-Amy.Shih@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610080736.6593-1-Amy.Shih@advantech.com.tw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 08:07:35AM +0000, Amy.Shih@advantech.com.tw wrote:
> From: "amy.shih" <amy.shih@advantech.com.tw>
> 
> This patch do 2 jobs as described in below:
> 
> 1. NCT-7904D also supports reading of channel limitation registers
> and SMI status registers for fan, voltage and temperature monitoring,
> add below sysfs nodes:
> 
> -fan[1-*]_min
> -fan[1-*]_alarm
> -in[0-*]_min
> -in[0-*]_max
> -in[0-*]_alarm

Not really. Voltage attributes still start with 1.

> -temp[1-*]_max
> -temp[1-*]_max_hyst
> -temp[1-*]_emergency
> -temp[1-*]_emergency_hyst

Why emergency and not crit ? The registers are labeled "critical",
and there is no mention of "emergency" in the datasheet.

> -temp[1-*]_alarm
> 
> 2. Add the temp[1-*]_type sysfs to show type of temperature sensor is
> thermal diode, thermistor, AMD SB-TSI or Intel PECI.
> 
> Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
> ---

This is where the changelog should go. Also, patches should be versioned.

More detailed review will follow.

Thanks,
Guenter
