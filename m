Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF3FC606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA622189F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ3DRy2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404028AbfGHRty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:49:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35246 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403870AbfGHRtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:49:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so8643693plp.2;
        Mon, 08 Jul 2019 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/ancY3EFLWrWbOtiL61BFmmz+2+LYOXr28AVKYlsboM=;
        b=ZZ3DRy2AB9jjXaaZclJtiEqiGrrohKz++rVEG+SoD5ns9yAK/NrkarsxDMEIQaF0TI
         rdtLQYAsp8m36P3/LrUQNzNj0WQ1eVPK+GLAqmkZ4Jr4fGLFCw7QGWg0UFqQaHJYR8jZ
         WAPy0Y061TGQCSPRwJ5GV1uNGLn+sZehMQBgSI3jCOXddLlIQcBM5xrumBonGw4WcWb8
         Lb27EJ4fY5DdW3OgJ843HaZsJdua0L2AE0FcYzNC5J/Lk48hPVamyrO6VWTOBbKJ8Vr6
         bQ9X1yqU+zXwWMhwBgMOStKpsmVaBNp9vZf0qoAiCgm9Z5AXdTKm4XfLK5DRcDFmTGJE
         dAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ancY3EFLWrWbOtiL61BFmmz+2+LYOXr28AVKYlsboM=;
        b=WIDfkZ/Wq01LB+bmfFFuCoaT5uvfxkLYXiFQ0+8jCGrB3OgcfRFQn52EXsyNL5jk9z
         pjWo8TSAiWDl1EExzHFkZwytqBHkSnIykHHZIs9TumCZK40dhtPHoN6n5ZPBnxgmLJXL
         dok4z3gDVZN+7BG36xgs7uyLOEypIUTxfIu9vvF1eRKo9Z/QU2IuRpUJJv0roS4tA1xV
         627zrZh90k0jzAJrI9odt6bkkVreINCCLnQ3M9zUi9udiRIxwaJ1nPoBOF2M7541L8NY
         aUQ2DC40Uug/BRSF4VKgr05blFcxFaNYd0TObhT+akbhqM/siO7Gn2Q1mlLgYVQDKEOz
         1G7Q==
X-Gm-Message-State: APjAAAWhZqb2UkEaxcMTBgKamZQ9Lf7DdqKKe+67Zd3R40zdKByUZghD
        209oKIWRPy4iXQaUIPwsoC38z6VP
X-Google-Smtp-Source: APXvYqzHnvoi64IAIYQAQwAjuuMAntEhX7GX0pOHKTC9bgLPVxmBM8eJrVrMWtkmJ8mmPUq2/gkPSg==
X-Received: by 2002:a17:902:2a27:: with SMTP id i36mr26194794plb.161.1562608192793;
        Mon, 08 Jul 2019 10:49:52 -0700 (PDT)
Received: from ?IPv6:2405:4800:58c7:1881:3232:ec6:81a5:864b? ([2405:4800:58c7:1881:3232:ec6:81a5:864b])
        by smtp.gmail.com with ESMTPSA id x9sm11038532pfn.177.2019.07.08.10.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 10:49:52 -0700 (PDT)
Cc:     linux-kernel@vger.kernel.org, tranmanphong@gmail.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 5.1 00/96] 5.1.17-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
From:   Phong Tran <tranmanphong@gmail.com>
Message-ID: <c1498293-f0f6-0599-bd72-4156370a7599@gmail.com>
Date:   Tue, 9 Jul 2019 00:49:48 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/19 10:12 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.1.17 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 10 Jul 2019 03:03:52 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
> and the diffstat can be found below.
> 

build and boot fine with qemu-system-riscv64

root@(none):~# uname  -a
Linux (none) 5.1.17-rc1-00097-gb64119f8dffe #4 SMP Tue Jul 9 00:44:23 
+07 2019 riscv64 GNU/Linux
root@(none):~# cat /proc/cpuinfo
processor	: 0
hart		: 0
isa		: rv64imafdcu
mmu		: sv48


