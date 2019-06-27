Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDFFC48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA08021851
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="l0fRgG6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfF0CeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:34:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32919 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfF0CeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:34:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id y17so482406lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 19:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bmZJISlXE+U3LQbzyWPwLynPr7jlpqsoB8iC1INwlmM=;
        b=l0fRgG6s+Fq4A18lpg1cxdbOcioeTu4Lm9DFecpTmnboqpRODLS8/3Ezj5SdtIZIuk
         Wn8UgPzpC7ysvIfJ/75x/ph8s+Ph2ewQWvhqysp2uS+X8WmOh7bxpCmBHVBMHAAbLwFc
         7zAUBNpZLUaf/MMon/8EPpcAGWLRKDbyYzbT1wglTq2YDzLiG3k7BXAAiODHLOyuUPlB
         iZZdljnqJHv8rQaCplv+KHAV6aUoZ7U2cuYRQMTjpTrTrhg78j55H0mnOamxgp6AVOwX
         pPWJ7BGJL6bMRcXxZZ3/JhelsJ/7RnCnggOPohTYWj4Q/nU3YYn5dH66kVOHw2nu8p81
         UQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bmZJISlXE+U3LQbzyWPwLynPr7jlpqsoB8iC1INwlmM=;
        b=YAbLmoDRL+pMptWaOBlmq8noSoI+WtZ7N0bEk410mCkw9q+62bDRtwGE4vCpFfhLWL
         jb0J6ZMv4bUJ/8vrJ4SToeB/KlZ/9JwKqgt77bMdTRi8/BWdrdOdakDuGNoW/WLViGyl
         1lfBfBXDVXRWjhpfJ5cKlbVhUWvEwr5QYZMDhY2LC6lA2urykDgA/VlSfyVxv9OPD1rg
         4YWy5ZhNXP9Q/6PA+eFYuLH7kYDgjelHFjsXvco7dwfNwkea7ggrSk/15tz/s5AGSBsK
         ozYCkRNdmMvF3DzgRCV5hv8uWF3+AU+ow2rz9RjDxsQCYY5z9fsSKbvU4Ir07GZszcfn
         /sDw==
X-Gm-Message-State: APjAAAVa9nNXzQ/n59hooEhhsOINpRmQzxJqDSDrR+fW3hRQYnNA4YFR
        5JZT8Q5GUy+90fg83lm5TbJIEA==
X-Google-Smtp-Source: APXvYqzcEMNH2SId1inLyk+J0pyMhziInEuh2kv5k68TYehUYeGHVMexHLTYWG7dVGa5w4SVlN6Qwg==
X-Received: by 2002:a19:6e41:: with SMTP id q1mr691970lfk.20.1561602842567;
        Wed, 26 Jun 2019 19:34:02 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id b6sm121113lfa.54.2019.06.26.19.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 19:34:01 -0700 (PDT)
Date:   Wed, 26 Jun 2019 19:30:33 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 4/4] ARM: exynos: Mach for v5.3
Message-ID: <20190627023033.kvw7dvbifwkvfcav@localhost>
References: <20190625193451.7696-1-krzk@kernel.org>
 <20190625193451.7696-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625193451.7696-4-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:34:51PM +0200, Krzysztof Kozlowski wrote:
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.3
> 
> for you to fetch changes up to a55e040c6f21f55f81c53c56e1d8095df35e1d02:
> 
>   ARM: exynos: Cleanup cppcheck shifting warning (2019-06-25 20:45:09 +0200)
> 
> ----------------------------------------------------------------
> Samsung mach/soc changes for v5.3
> 
> Only cleanups and minor fixes.

Merged, thanks!


-Olof
