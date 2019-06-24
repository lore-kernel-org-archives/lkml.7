Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1B1C48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F2F20665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/wtny6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbfFXRwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:52:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40722 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731941AbfFXRwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:52:18 -0400
Received: by mail-ot1-f65.google.com with SMTP id e8so14398163otl.7;
        Mon, 24 Jun 2019 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MCQN6msgppUQW4O/T7y5pKWHp92LoOmLLo22qkbzGno=;
        b=e/wtny6MsqW3FF7aW3WKEPb63uKd43EIU6Lt6Laf7sFlIR5v/eD4EvRjHAoD1JmDAj
         oBNAuRpz3AwQx2R/wVMIMwxFHfOCNfhiCwoj1xjNGoSzph4ydLUhdRheofcakrlcQ4Et
         yf1EIssSxoxjEnxR+aKB7J98Yr3s2EmoBxDFRZPuTBFbNuQSTSRyWwOc/UD8FgvlMDoU
         mN5GIcWI2UKw8g8h5g8wszKxiXTTU/0DI0gd6uAKUWmQKtW5eOR4zcSd8N9QUDffWDjh
         kRDB4dyA/pO1444DEZWKy1RAxWxNXLfFD93K2l6zSVfa4wCUWEtIKIFgyK6iPoW+PH6w
         9Y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MCQN6msgppUQW4O/T7y5pKWHp92LoOmLLo22qkbzGno=;
        b=HV0vnAWdNEFCXTTBo2gBxINL4mtREMV9MqqAS94wgup61N2SpcNaY1RBml8uzT5ZhJ
         0YBewQG/FsUXchLV5LiJf3C25K2kQ3S3fiejEJKyT6DiHZpCEWJabrvDDxHnnC0sDoMv
         gms7BOsiuD3pXy/1Sby9XKIiX3D4ehWUmwa/+RS2toYmL31ObkKlnsFj3CQEPMoaE/L2
         HhZXupd1wlAO8k12IrpOu1fhFSRsewDUAxHhq/pc+/N8yKgEOxwu2va4cSuMPzd0XynC
         3H7qvwv4fgvyA+R9YAg6wqRKrBBzh6o6Fwwe7Yv3N5jYYtQguFPjR/Kf2m5A+frSeeAG
         G+NQ==
X-Gm-Message-State: APjAAAWxeFg1UmLEj70OqvFdNDx7bFXrUa2hynt4wS8dFMoVoElDuqan
        tHm2r4dumvtTviCcb5J2N3M=
X-Google-Smtp-Source: APXvYqxrn4WhU9uFli8NmuYlmt6iGhsu/s+XA6fuxfJ7qFmtz5BiPOvFeE8L20niahYwGYXBE6u4qw==
X-Received: by 2002:a9d:3bb6:: with SMTP id k51mr38299914otc.238.1561398737916;
        Mon, 24 Jun 2019 10:52:17 -0700 (PDT)
Received: from rYz3n ([2600:1700:210:3790::48])
        by smtp.gmail.com with ESMTPSA id c21sm3993247oib.4.2019.06.24.10.52.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 10:52:17 -0700 (PDT)
Date:   Mon, 24 Jun 2019 12:52:16 -0500
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.1 000/121] 5.1.15-stable review
Message-ID: <20190624175215.s5gtvatc3gqqeact@rYz3n>
References: <20190624092320.652599624@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:55:32PM +0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.1.15 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 26 Jun 2019 09:22:03 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------

Hello,

Compiled and booted fine.  No regressions on x86_64.

THX

Jiunn
