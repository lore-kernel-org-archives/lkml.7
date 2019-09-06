Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F6AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638AE2082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbfIFQVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:21:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39319 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfIFQVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:21:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so7208213wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 09:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YyFs4U3ikiTAqwiYM1xeX9g2LY/fcWKN2WJ80eqPNSk=;
        b=nHKWzwJEcTwkpSy9DqLd/W0PNW9yq9keDn8HaEhnQtavg8cilXdEnbWvLslHAA5abG
         lfbkSWbbrKXzggI1zIngcIGFzSBueAOcK3+DWIurRaxv4D7UtpC70KKetSaSFiwW+Ju/
         53Oelg2UFISt+6tnyIQKvzSvDZZvVrsuU+Asmmj2FprhNSM4N7NeOSv8D5zWIHoDJAW6
         mC/Q3RcFEN+KKtM3O2TSIB0B/Ws7nXX39oAdCSMOJXvuwjvbcguUSzFE/2L0GoPutl+J
         7ankZ4lE2yeh25jwvHX9yYsIrrImxqTEitFpj8DhKIi1vRJ0eslnTnaeUS/KV3DYqITH
         pZVg==
X-Gm-Message-State: APjAAAUdze6lNzLLBylltrs6IygJKRv1THqVc+mRAYiZN9IBKMPMIo5S
        gaoHKxTb36LHnPDGAsA8w1fp4yhL4GI=
X-Google-Smtp-Source: APXvYqy+srdRIn/GNan0TyQsI3oyjlCYapvUe8TDap4339AXwUgcqrzM4pXnKGs7D7Xp5xlMGWplwA==
X-Received: by 2002:adf:ec41:: with SMTP id w1mr8382828wrn.215.1567786911095;
        Fri, 06 Sep 2019 09:21:51 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id c6sm10994479wrb.60.2019.09.06.09.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 09:21:50 -0700 (PDT)
Subject: Re: [PATCH] lz4: make LZ4HC_setExternalDict as non-static
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
References: <20190906153700.2061625-1-arnd@arndb.de>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <5ce4f4c7-f764-8937-75bf-83a4d4c57fa7@linux.com>
Date:   Fri, 6 Sep 2019 19:21:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190906153700.2061625-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> kbuild warns for exported static symbols. This one seems to
> be meant as an external API but does not have any in-kernel
> users:
> 
> WARNING: "LZ4HC_setExternalDict" [vmlinux] is a static EXPORT_SYMBOL
> 
> I suppose the function should not just get removed since it would
> be nice to stay close to the upstream version of lz4hc, so just
> make it global.

I'm not sure what is better here. But just in case, I sent a different
patch that removes EXPORT_SYMBOL from this function some time ago:
https://lkml.org/lkml/2019/7/8/842

I checked first that this functions is indeed static in the original lib[1]
and this symbol is not used in kernel.

[1] https://github.com/lz4/lz4/blob/dev/lib/lz4hc.c#L1054

Thanks,
Denis
