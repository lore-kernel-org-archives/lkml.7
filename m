Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B6EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03E9206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtgFiufZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbfCZRtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:49:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46557 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729800AbfCZRtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:49:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id q1so427261pgv.13;
        Tue, 26 Mar 2019 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rntwGReWmiyD1/3yB3+Lxj+dUcFI9ALhpbdjfiMtxWw=;
        b=GtgFiufZwCdic9O6u2hsOi6EpiCHeZ400cx4mL2gB8RS7Zm2Omvvox7ScLs38PVyPz
         Bqf7/xU/f2HhDwddz/lkjYQOKUcwSeTDTkiajJmpH1GHXZufFs6yGTB4aSSct69XpRXX
         R54mcq5QrHPTdDcHtC5zsJoglCNyiBUf6ytel5y+sY4sodwtmddFyiWrl6v84bxI+uuh
         NEf0pSTw27Lu7HLH6a3/H+JJgAVyMRQ1YQT9pT+LACQEH6Cx8xm6p1DiG0S+JHZsug/k
         UWvDTDVhAuukef9bMeHKhF0EwCkt1VLSjXArs++GS5Z1QyOdsmoxZ6r7xJx/oNp6VeRs
         JSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rntwGReWmiyD1/3yB3+Lxj+dUcFI9ALhpbdjfiMtxWw=;
        b=SwL1Q9aLiJcpNaOvRZJf4pgmNYt6MW5iY0Ko8csribr6gXVNuapXLjGKCXZ/SP0VKX
         UHbildHcOvbbyRK0u9RAtRhSSFTHMqxcRcr5Zi8kRE+br82yGcHhtlCm/i400pEK8X2I
         5xI7+RvmNzUcbPKz/ZVX5h25MKTW8oWHcQnKN1/XgeuiCThCYoxZxvrWyqTYcRIz/7W3
         fuPbroDtsnsEk7joY/oMoQqUKPaMANjrVlamHDBY4bN4EXyGnX0NCt7ILX5mOC43zgKz
         vvHUQmx+Rw16SsEBCJYkz4EOAKQ/V/R6yM3x7Qk6E4JcJzrpxQjEOQdz3r6WHYkxu586
         fM9Q==
X-Gm-Message-State: APjAAAXc0sqYlJA/xfrVmg+m0nptZcy4txuyEoHMcEzwucJjXIRMbpuc
        ikb7jDQuXIqIv5htXSaxGkU=
X-Google-Smtp-Source: APXvYqzhtX4Rm8xVKBv5HL75LSXwXfk4ObDlGJiLO3dylH4FDqiiI8nPtln22T5b4B0e05sw6Nr10A==
X-Received: by 2002:a63:4287:: with SMTP id p129mr29009095pga.84.1553622589530;
        Tue, 26 Mar 2019 10:49:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d130sm43093815pfg.49.2019.03.26.10.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:49:49 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:49:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/45] 4.19.32-stable review
Message-ID: <20190326174948.GD9916@roeck-us.net>
References: <20190326042702.565683325@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 03:29:43PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.32 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 28 04:26:41 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 345 pass: 345 fail: 0

Guenter
