Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0A7C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF19208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZcgC51b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfFQSRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:17:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34835 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFQSRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:17:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so418343wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HuJFcmsyNowSj7shgSaNHidPdm9Km/mTYLWEB2juwtg=;
        b=bZcgC51bcrK/acaAs5g8ExM6R5vPigm0q4M7B8CEzD7fJx3KGWyztC+98TfT553O+v
         FnRE7457cm7nRsSItCShFtk3mz4zPpyCHfbWZCbN2v6uwTSb0g/zm9DTSmRn6Fg/7Xqa
         2uD3fmG6hLgnqsL/drTVXp+yP+eurfdI1gD7piqHsOSPSjTKeN+tGfDObDSk4PJ8bFWA
         YoXEa+rvq/p5rs2L09g3hDQsXzKWsahzFe88Uu3vfX8H7xK1d+bRhtysiRUNhoaMT3CK
         1kyKk4Yb/i0I1uz1xvAuRCvyFdxpjq171sgPpqU/ySYh9XMbBkA8r38TSk4PjAE6jci3
         Ynvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HuJFcmsyNowSj7shgSaNHidPdm9Km/mTYLWEB2juwtg=;
        b=rwgG4IFMDNB0ysnf+mc4kffxyBM4WqRpwNQx4mjtOFGPZ4bwm+g3lxIFSCshIlOWTY
         9uI8cVOTdbrtsnitsh//U1ZPtAIWU72zxXnePE3BrAgpzldIJU0hVeB0RfPLD+8vQrRC
         51qlHNOCfVb0LQPEtrJNhFIXojyVpvRwYJ5rrIXMcRONRrQjaXzUFDD/PNXjW9K26xDB
         2kvjaE1ZJgGcUxKk9f2mAF18yyeUt0qTwAirb6EUTciVSwnx8YYNgQlLXMaOUZJwHjC/
         FXpFYd2yaBvwo9tbaYwxajBSnQ9bx95nTA+uJIqzRnL1uoZqbQbYbFTCLBBeDUBiB4D1
         QBVg==
X-Gm-Message-State: APjAAAXKg2BWmq7EL9+jWW1xs3NHPbSaiUgb/WITisnOwV2GJb38KjWM
        zuD1viSBeyEKmkuEZ2lIhtY=
X-Google-Smtp-Source: APXvYqy4Hn59t0ekI17MVt+Y8qWWBAiJNPqZFt0pnpZnTV6JsCNM2BYdcPgdWJxS0u9P2NfTOgwjVg==
X-Received: by 2002:a1c:6585:: with SMTP id z127mr21526065wmb.25.1560795421338;
        Mon, 17 Jun 2019 11:17:01 -0700 (PDT)
Received: from [10.67.49.123] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n14sm4406475wra.75.2019.06.17.11.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:17:00 -0700 (PDT)
Subject: Re: [PATCH] perf: Don't hardcode host include path for libslang
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Stanislav Fomichev <sdf@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
References: <20190614183949.5588-1-f.fainelli@gmail.com>
 <20190616094605.GB2500@krava> <20190617181115.GC3927@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <fc31608b-768c-80b2-dae8-98b43e62b1b0@gmail.com>
Date:   Mon, 17 Jun 2019 11:16:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617181115.GC3927@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/19 11:11 AM, Arnaldo Carvalho de Melo wrote:
> Em Sun, Jun 16, 2019 at 11:46:05AM +0200, Jiri Olsa escreveu:
>> On Fri, Jun 14, 2019 at 11:39:47AM -0700, Florian Fainelli wrote:
>>> Hardcoding /usr/include/slang is fundamentally incompatible with cross
>>> compilation and will lead to the inability for a cross-compiled
>>> environment to properly detect whether slang is available or not.
>>>
>>> If /usr/include/slang is necessary that is a distribution specific
>>> knowledge that could be solved with either a standard pkg-config .pc
>>> file (which slang has) or simply overriding CFLAGS accordingly, but the
>>> default perf Makefile should be clean of all of that.
>>
>> fedora 30 is ok with this, I guess acme's distro test will
>> tell us about the rest ;-)
> 
> Seems to be just needless old cruft:
> 
> [perfbuilder@7143ebde35eb /]$ cat /etc/redhat-release
> Fedora release 20 (Heisenbug)
> [perfbuilder@7143ebde35eb /]$
> [perfbuilder@7143ebde35eb /]$ ls -la /usr/include/slang.h 
> -rw-r--r--. 1 root root 87562 Apr 11  2011 /usr/include/slang.h
> [perfbuilder@7143ebde35eb /]$ ls -la /usr/include/slang/slang.h 
> lrwxrwxrwx. 1 root root 10 Jun 17 16:41 /usr/include/slang/slang.h -> ../slang.h
> [perfbuilder@7143ebde35eb /]$ 
> 
> So I'm removing that comment:
> 
>>>      # Fedora has /usr/include/slang/slang.h, but ubuntu /usr/include/slang.h
> 
> And adding a:
> 
> Fixes: ef7b93a11904 ("perf report: Librarize the annotation code and use it in the newt browser")

OK, I was not sure if you would consider that a worthy fix or not, but
that works for me.

> 
> Will do a build with all the containers and check that the output for
> all the ones with the slang devel package installed have slang
> successfully detected.

Thanks, let me know if that does not work somehow.
-- 
Florian
