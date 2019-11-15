Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BCEC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8733D20715
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Xma2EgzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKONmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:42:38 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44037 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfKONmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:42:38 -0500
Received: by mail-lf1-f67.google.com with SMTP id z188so8013150lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 05:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7M8XWf+aSDuZ60G0e6vwA3UVsGqy52moHTICwgTGdKE=;
        b=Xma2EgzKd5UJeq5rjgYO/fzDuIC/Z9BgtHLjQs9+P5c/7/SXXE2ft7Hh+9GwYMfTE+
         9du2iMEIHbg/0YaeyOJHFdSyMe9GMWHFRsBrm9DXPfQ+JJIx7HZWZ8DNnGCQrqRN50pY
         8CiCBcoL8DRIdBmVshEqN4b0TeAtXiVOcIOLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7M8XWf+aSDuZ60G0e6vwA3UVsGqy52moHTICwgTGdKE=;
        b=nYvyJpt7f63Y5hRrdgtWYHfMGNPtdUi9820yQsG4KMn4xDLiis7STN1FLdb1zvCXmX
         ZHNfyf4U8I+EeGWr0AxLJ/4s1pV/76xSFXOKtZYBdbI1Sjgfkhk54vls8qs9dmcPTvpY
         e3SfDrhVRNnSsXL50bFT0mGvQ2p2a8YvvmLVoxTTJ5JTBqxOWCUD683/2/aXuuXzsBBm
         xJL7hUSuWTwKqpsYNQa93fOoTjofQDU5ySjVbVxemRAD5xenu+/jt9P1F5zSo8eo8B10
         GvRrztKjv2/OgjeUcDZOzrc7920OKwcDmpl1as6VHxsKOoUkugcdZ/h+te7UMvUK2qNU
         COCQ==
X-Gm-Message-State: APjAAAUXCJsm/aJ7Sg6j92piU4Zl5C7jaWOun9a+mGHfDQIBTmDM/NPT
        1Qt98Xh5JF6/o/4fKnW1u6PUkcfqzxiQ225t
X-Google-Smtp-Source: APXvYqwHN2Yvm0PLT+a7BaSRp11SLB5XySfnSHH3TF13kuNUSwKuiAUR9T+ZHUG0/JfvfbuuNjwNSA==
X-Received: by 2002:ac2:43a3:: with SMTP id t3mr11623097lfl.150.1573825355715;
        Fri, 15 Nov 2019 05:42:35 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u4sm4063165ljj.87.2019.11.15.05.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 05:42:35 -0800 (PST)
Subject: Re: [PATCH v3 36/36] soc: fsl: qe: remove PPC32 dependency from
 CONFIG_QUICC_ENGINE
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Qiang Zhao <qiang.zhao@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>
References: <20191101124210.14510-37-linux@rasmusvillemoes.dk>
 <201911152105.ojcD68ZC%lkp@intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <41765275-dbd5-406e-8ba1-bd0f92b737ee@rasmusvillemoes.dk>
Date:   Fri, 15 Nov 2019 14:42:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <201911152105.ojcD68ZC%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2019 14.31, kbuild test robot wrote:
> Hi Rasmus,
> 
> Thank you for the patch! Perhaps something to improve:

Hello kbuild

Thanks for your reports, but this has already been fixed. Is there some
way to indicate to the kbuild bot that it should stop using resources on
a specific patch set? There's really no point in the bot doing lots of
builds and sending out reports for a series that has already been
superseded - and reviewers might easily think that the report concerns
the latest revision. Perhaps something like

kbuild-ignore: <msg id of cover letter of revision N-1>

in the cover-letter of revision N? Or is there some smarter (automatic)
way of doing this?

Rasmus
