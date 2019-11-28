Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7D9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD4421771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="J5jjpQUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfK1IVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:21:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43226 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfK1IVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:21:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so4310265ljm.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 00:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2ihFBr3cTZF5UbIGSrYneP3g3wP0dgTzFZ3UMdlINS8=;
        b=J5jjpQUv5v2GF6DCYcBiew6lGQkc4ZwvwIu/adjixp+GYregx+1kd88yD6wTfr4JDS
         1K9Yo9uTNRwhLz8fkQ46u8c8uvYkHDhZnJuX3RAxwormPTkV2qghhQBujmD39++SZaJ5
         tkwxsTjduuxNN8T1OpT9MCwU/3rTKOGzUpF3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ihFBr3cTZF5UbIGSrYneP3g3wP0dgTzFZ3UMdlINS8=;
        b=oLs0XvDzztM1kbRMYEC4LanyC13hpNw/GafBOFvj/g/qY64d4nHZxtjomh0YRwdISw
         F/B7dPBQWDaN77AIjO2FxLFVH/HLJX3xKOIKwzCx5hfDtb+m0ycts5D3OR2S27Y0467e
         sgU9l/1kc59ih4X9HVT39cQ1DfqxTs6470o4Q6f5QjrF2zs4ZVpSHJe91PeJM9m7b7D3
         1yY11whYfLGnhlPAqvB8ocv4zUmIRpiM3NsYHACRQGcmGseEEQF5aDkdBL2AmI/EmEtH
         ejdVkY0grPm3kRAxebt/Y5QjMnxaNGUCqCoNBL9vHm4GuF6Hfi7R63Zs8qxyYOucE0nW
         4jMg==
X-Gm-Message-State: APjAAAUh63dVzEMoC4SyONmB+wrEb0hlsyPdm8v2UediJmN4sRxVzMcZ
        8IZ32AvD+vfTEBTqsyy+Aqci1w==
X-Google-Smtp-Source: APXvYqzylbVeM08rCOM1v3hRMPRHexwt8hy7HEAa9Cw6a9N7StNSvCeWptnC34PM8HODyUpqqteTBg==
X-Received: by 2002:a2e:884c:: with SMTP id z12mr32823718ljj.41.1574929290783;
        Thu, 28 Nov 2019 00:21:30 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id k10sm8096512lfo.76.2019.11.28.00.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 00:21:30 -0800 (PST)
Subject: Re: [PATCH 05/16] dyndbg: fix overcounting of ram used by dyndbg
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        linux-kernel@vger.kernel.org
Cc:     greg@kroah.com, Andrew Morton <akpm@linux-foundation.org>
References: <20191127175055.1351403-1-jim.cromie@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0f373a8c-8301-41d9-e042-cfe0cef4bd25@rasmusvillemoes.dk>
Date:   Thu, 28 Nov 2019 09:21:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127175055.1351403-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2019 18.50, Jim Cromie wrote:
> during dyndbg init, verbose logging prints its ram overhead.  It
> counted strlens of struct _ddebug's 4 string members, in all callsite
> entries, which would be approximately correct if each had been
> mallocd.  But they are pointers into shared .rodata; for example, all
> 10 kobject callsites have identical filename, module values.
> 
> Its best not to count that memory at all, since we cannot know they
> were linked in because of CONFIG_DYNAMIC_DEBUG=y, and we want to
> report a number that reflects what ram is saved by deconfiguring it.

That, and we avoid 1000s of (mostly cache-cold) strlen() calls during boot.

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

I'll see if I can find time to review the other patches, then I think
you need to resend with Andrew on the cc-list (added here). I think he's
the one routing lib/dynamic_debug.c patches.

Rasmus
