Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFFBC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A398F206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="G5KV+1mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfKEWqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:46:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38680 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbfKEWqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:46:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so1176412wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 14:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7xwWVXiuG1tLPN6CPka9ylUlJIP2hCJ9RzlJKfzF5/I=;
        b=G5KV+1mriyllS9vliRA/FB2eSB8+Y1pVuDH+yOGI9/dlU6p4f0CEBcf1v3g2sqUVJJ
         2ZuBQ9rKXI0+Unyi+pLfp6ghnwr3XOeicCMuKJ0jFCjXXJlMRdxRxf3s3fKZcJdPdWWN
         oeQTWKOv+Pi/dicJidS5o5yDQuS2gidH2b8t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7xwWVXiuG1tLPN6CPka9ylUlJIP2hCJ9RzlJKfzF5/I=;
        b=UULkuGCTnCdNa0mKMR2UV+9IKW/ZoL8Ax7a1VdnuMllRoRwBPYsKeHjD/PNENjSsVv
         8Z0l6e6V5ZudpzG1fHCEjktVqMCjbgz67wfRczdBlh2S4Ot2uYDJ1jrrXokkNY45BDnO
         qwwUqaZgpEIXkJBoyE6PcHfV79hxQq19qX4D+6FDDiVfA/YgfVZp6Sy7/yO04E3SXaS+
         KX0fxH8Q/ffXxqQW1mNzMLvovnIcAPxvFPXxTDYrV3T/L+zFoDtWnqU48LK8F0q89nvI
         uFtaB7bOdnr5LlsP9FYj1PVY+AbZZJ3NC0dOyvupMdn+ogM+84SfyjuKv/MgXECu3Tsj
         gb8Q==
X-Gm-Message-State: APjAAAUEYo8wUk4G8r1/McvUWl43H47IfSqeKug/ku2etTKrnj8F9CE/
        Y1PX40Rp8dKud5YR71niE1DMSA==
X-Google-Smtp-Source: APXvYqyILKyWyx8z/N+HI9ObpIe8L/xuTBO+aWfJYAW3owIrX4/P2lrMpGLQn5+ocDXByWt/4qGYzg==
X-Received: by 2002:a7b:c7c7:: with SMTP id z7mr1055811wmk.85.1572993971089;
        Tue, 05 Nov 2019 14:46:11 -0800 (PST)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id i3sm22220902wrw.69.2019.11.05.14.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:46:10 -0800 (PST)
Subject: Re: [PATCH v3 35/36] net/wan: make FSL_UCC_HDLC explicitly depend on
 PPC32
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-36-linux@rasmusvillemoes.dk>
 <4e2ac670-2bf4-fb47-2130-c0120bcf0111@c-s.fr>
 <VE1PR04MB6687D4620E32176BDC120DBA8F620@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <24ea27b6-adea-cc74-f480-b68de163f531@rasmusvillemoes.dk>
 <CADRPPNQ4dq1pnvNU71vNEgk1V5ovrT9O2=UMJxG45=ZSRdJ4ig@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f48df0c7-77f1-268f-8588-7eff5e9fd7c5@rasmusvillemoes.dk>
Date:   Tue, 5 Nov 2019 23:46:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADRPPNQ4dq1pnvNU71vNEgk1V5ovrT9O2=UMJxG45=ZSRdJ4ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2019 21.56, Li Yang wrote:

>> No, this patch cannot be dropped. Please see the kbuild complaints for
>> v2,23/23 about use of IS_ERR_VALUE on not-sizeof(long) entities. I see
>> kbuild has complained about the same thing for v3 since apparently the
>> same thing appears in ucc_slow.c. So I'll fix that.
> 
> When I made this comment I didn't notice you have removed all the
> architectural dependencies for CONFIG_QUICC_ENGINE.  If the
> QUICC_ENGINE is only buidable on powerpc, arm and arm64, this change
> will not be needed.
> 
> BTW, I'm not sure if it is a good idea to make it selectable on these
> unrelavent architectures.  Real architectural dependencies and
> COMPILE_TEST dependency will be better if we really want to test the
> buildability on other platforms.

Well, making QUICC_ENGINE depend on PPC32 || ARM would certainly make
things easier for me. Once you include ARM64 or any other 64 bit
architecture the buildbot complaints start rolling in from the
IS_ERR_VALUEs. And ARM64 should be supported as well, so there really
isn't much difference between dropping all arch restrictions and listing
the relevant archs in the Kconfig dependencies.

Rasmus


