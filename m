Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13749C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC904214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2z0f4LO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfJJWT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 18:19:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44673 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfJJWT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 18:19:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so4778060pfn.11;
        Thu, 10 Oct 2019 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u/5ZAJi0CkaRF5CIqKAmErm1uNaTzftysAnpXOCQ4TE=;
        b=A2z0f4LOwBhmMX4jddgyhcUB/VZUTbh8H+nGIfVACuLYL+Eq+xeITL+KE+rEh/gOia
         4tX3ATOjWcCyGTUQSUJGKdjCkQcQx9d47JFIAGG2biK9f3Ltc7oX0VED5LQDgp6xDurl
         p9n7lKf7BAl05bekR1Cq+tRIYaFY8o9jZUae7yl95tsapcKhcWkmoCCN/aqZKpEWD9dt
         PoBPBJlMGEyr4hQJy5Q6j/m9EqFNQp3PjMC0hU6L9g50zJPkOQHLfFJZCFohU3PwPpgt
         HAogy+0wZiAfPIoSSlUeGTREkv9qpkXJ+mdwTTVCkDOOW5wju8YP7YmyPZXPaloJx+cW
         Wq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u/5ZAJi0CkaRF5CIqKAmErm1uNaTzftysAnpXOCQ4TE=;
        b=YQvDzm899m5EsHQFQheLxUnqZYEz8GiVeZ5rdTDasOP32GatTGna7bO/HKqiPhdpIt
         r9QWorMJSso2GiC0Q5Uo0Cl50WfBGra4xbhyi12/tICCpVRdeajvP2A460e2ORQqbB1V
         q0VMVpekYy3fkBwgJQn7uaArEm7nGKpU0pGndbAVZuXNwWy55jRBBY1NdQfCtNzJ+c/d
         CrGhJHJDyqqT1zNiudW/WaDvKBXBJ9sxpnDcA1IUgUJn+SeKNOdtctVPMFz3G7YSHMoJ
         pl1HzY8teXZ/48bCEoU4Aqpb2rvZtw9DZ6i7Jy7Yo7oraNv+bCkIAP+fbwntfWpmEduq
         ZugA==
X-Gm-Message-State: APjAAAXztPQUTmHQCEsaXkN+2Uf/L7DbBt2+Kn+lzZFAS8hfoCiSb8+5
        wt4eexF1XeI/dO6w+7jufv7akzED
X-Google-Smtp-Source: APXvYqxeHjtcq4foYX5DcFATVwXRg6fe0+qh5TltNfiFa9simogficKStnIOe3se0YRFvmQwqDEjVA==
X-Received: by 2002:a62:b616:: with SMTP id j22mr12829747pff.55.1570745996365;
        Thu, 10 Oct 2019 15:19:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 127sm8329205pfw.6.2019.10.10.15.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 15:19:55 -0700 (PDT)
Subject: Re: [PATCH 5.3 000/148] 5.3.6-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20191010083609.660878383@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e72a6562-bc33-643a-ae28-705256fb5b3d@roeck-us.net>
Date:   Thu, 10 Oct 2019 15:19:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/19 1:34 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.3.6 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 12 Oct 2019 08:29:51 AM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 391 pass: 391 fail: 0

Guenter
