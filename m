Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE27C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7F9206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdHI7rNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfGSEnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:43:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35607 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfGSEnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:43:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so14992895plp.2;
        Thu, 18 Jul 2019 21:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3y2rn1zyYl3FAzWIcsCn6DEvZ0xQkk0FsNB4R1a2HOw=;
        b=cdHI7rNK/8lWfg9YxCuns21Et6ufA8uM8suvLg+0PBLZxMuA8KnDBUbAmQByMF8IsP
         Co2mADsae7vXWUVgScZWE7xL1bLDT7Z2PCQXRqT4XeyLXxXw9G5zwiONg+5srI+p4TEE
         IqoAJW0sdjjVCGtJMR58/uo0Qok6Liy4IDaLi1xS2Rdlo9sNKOM3qUQYhOn+PVLul/6a
         nNyD8nSKkENWhuxooeDamvRPuYOVA26Ko1HbLeAjLyIIbpnU1qu4IFGxj85DdN7LrGuO
         LA6Cvw4627tK+pEgmubJzACLgiFlbIUgN+Vh+TPHmvSZMD3VHrsRXspXzV6UUX78AmfF
         9ZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3y2rn1zyYl3FAzWIcsCn6DEvZ0xQkk0FsNB4R1a2HOw=;
        b=YFjLPRT+2cFcjkEvVKpBtNdHT8krT7PdmsYqPq/MSRn3yocEmzoSEOCPT9SVZVhHuA
         LcoIrrzoh4V+yaAqu6SCm5NZnr9TamjmPCbSY5ovosgeSX/b9JPrDsyWOnO6d+Crfl3y
         BQhkBqomN12c8P1RAjU74x098ogF2anjzyfLONWKalypciEHskehSMpS2f0hWr/cBYsO
         3Uo7QRAyxS5iBICt9wpAgMByE5bIO5J/EfCPZf4XdzGEJM/6EeoLeSMgrd9uUfIR8lh2
         Pv5LR16vbhR2pjfZhOWKNEeDE9kw4i8rAcSBqkHb3oQMYgsHlUhHuv8ebNx3K25DqPZk
         NrRQ==
X-Gm-Message-State: APjAAAVa5w8X5mfYrsTzHXArXghFsGsi27OAa90RaLeghqkbbHPbqXEu
        DIgcp2Q4dOQyUY8mRRKoztg=
X-Google-Smtp-Source: APXvYqyLdAjnDpVtgaSO/y2j2QkD2HT/ejyRk++/oOrTCAOfsicD+XHQCTEb6mLxZOq52BonH0Tvwg==
X-Received: by 2002:a17:902:aa03:: with SMTP id be3mr54292672plb.240.1563511410826;
        Thu, 18 Jul 2019 21:43:30 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id q126sm33487981pfq.123.2019.07.18.21.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 21:43:30 -0700 (PDT)
Date:   Fri, 19 Jul 2019 10:13:23 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.1 00/54] 5.1.19-stable review
Message-ID: <20190719044323.GA3886@bharath12345-Inspiron-5559>
References: <20190718030053.287374640@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718030053.287374640@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Built and booted on my x86 machine. No dmesg regressions found.

Thank you
Bharath
