Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE3EC32753
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C0C20842
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYWko3dG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfHMGQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:16:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39664 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfHMGQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:16:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id i63so368368wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 23:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Uq6joo7/5ZR7hjpnc1juLuWW3DBC5KKl2gE88hrhoaY=;
        b=YYWko3dGkkv+jThy9YuZcvodd+UYEd0mTcJGPmmz4J2S9ESI65Kiy+JOnQxUG3oCIU
         Xl4NxQ4AJK22eQYTr80DPTgydWN3ygOCQR22rIZDLn61qsSStEDdj5NoR6fg5B56l1Q9
         ufNHqBICHOZ25bxK+emULpL86gqZTDMGZDPMjC0flAgL7u2EfzgE42oGj5KD7ZUpAqBJ
         26MENyeJmrsYYGKRerqaXbVPjrU6upM7rWRc+AUPGyqpm1nTvZ7xnNGA7SqvH2yF006c
         Ybpk00bGC71bXicQ4SmnxbKWRtmnugElwGB+T5B1dv94dcXbvyzzPduggBm5Ohj3igH7
         VLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Uq6joo7/5ZR7hjpnc1juLuWW3DBC5KKl2gE88hrhoaY=;
        b=sSzNkZLzaTlziDA7G9Zp4Em0KLG9tPPrA3pGntM6DWnUzu4qvtigJZatLNEtIBElm0
         cJTbl18wZN2zKC/HRSVXD7sZFwxE6b550nYSwvnlRpO4jFc2Txd5z/mCn+S2fHOwAe2Q
         L6R3NV6h7iyrg8g8PNufv930gov/nCk02lAZUIV4ujEG3WytquV87Y1Ba9OI7bs8W5M6
         z352vCSecYsHMm7UzP43fkkj8Y/GqEnLFYK7bcKoSPeEXkGxpUQlHAtvTU6j1jweMYas
         Atvw7A771GVFp02MplTdDdbfzzqkNrcKdeISbIe1rt6Ypct3bKezXIuo+nuCe5/7QEVP
         jpew==
X-Gm-Message-State: APjAAAWp2qdHEnnAws5mLrLp0QqLxeSq2QQbMWgjRhnytOigfkMWlcjb
        w3IiszWh3V3SBp+DDXoi45LEQg==
X-Google-Smtp-Source: APXvYqx/xUpYpYDABRie20RVCnuk+h8wt/leE8chLfH2LpmPa5EJrwQshklrXhdvRbgCRM6FGnJPvA==
X-Received: by 2002:a7b:c857:: with SMTP id c23mr1142210wml.51.1565676969063;
        Mon, 12 Aug 2019 23:16:09 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id b3sm18957790wrm.72.2019.08.12.23.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 23:16:08 -0700 (PDT)
Date:   Tue, 13 Aug 2019 07:16:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] MAINTAINERS: altera-sysmgr: Fix typo in a filepath
Message-ID: <20190813061606.GX26727@dell>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190813055841.9816-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190813055841.9816-1-efremov@linux.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Denis Efremov wrote:

> Fix typo (s/sysgmr/sysmgr/) in the header filepath.
> 
> Cc: Thor Thayer <thor.thayer@linux.intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Fixes: f36e789a1f8d ("mfd: altera-sysmgr: Add SOCFPGA System Manager")
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
