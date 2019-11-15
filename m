Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC805C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22BC2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BjHqHXiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKOH5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:57:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38592 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfKOH5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:57:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id q28so7291053lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 23:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zLHtq3yfrffU9o2nF0X7zoTmdgeT+a2HOFrUz+0J25Q=;
        b=BjHqHXiGMgpJVRBuo+lq+sEes/L+3Pgkfq4t22+sAm3ZkEfNZJjCgNxK0Lq2+SC82z
         q4IiSNGldEN1uq+0oO7YsbEQj/jG8NjDGr2TQGUPclpVxjdT+bLba2JJiXE7NvHKORtO
         xVd6o/D+7FumLWsNsyWQxMok7BRgJFk6bpv/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zLHtq3yfrffU9o2nF0X7zoTmdgeT+a2HOFrUz+0J25Q=;
        b=VVaBVn6G0c/ImGFv58aLOhnrpymdreolbQbD+oZYjQDS4EQjkLdL0DCXHc39vybNN6
         5b4vq91dG0b8oxctFGqfDIn+M/oX/uacrj5AyVr5z25KoLd1dHzbq6lZbrFVbT6mSVGv
         rnlz7ESpo6zYnCALRh0Jb++d8fV0c0p/qIC1Wjx/MPgdArCBsP3rL4koHCKNWTK4x0gd
         is6p3xv0GJa/zATe9uAqVnnvIaHaFdkWOQ+f4LhCmn6mVyBEuJA6b5HuVQ8sW4kVMX9Q
         3zC6ZThjyq9S0cCpav6+1Jd1gFffpQ1Za2oDKR7bDHqSM1S+jYxKcXnATZfERmRqvRn5
         M/Fw==
X-Gm-Message-State: APjAAAUK6WO52B0nv3wx/YCZ2JyrJRgGLhmysexDv6mPNTDDrqUOtZdF
        noSeD+QH85iVKo8xVregaQCChQ==
X-Google-Smtp-Source: APXvYqzS4mGv0Td6lhMx6P1LJw0rbb74jK3Vo5agUi9HiQO2P985F1jTJV8/p7ydSoDXjafwq0X1nQ==
X-Received: by 2002:ac2:5236:: with SMTP id i22mr10287608lfl.19.1573804623889;
        Thu, 14 Nov 2019 23:57:03 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z21sm4888837lfg.0.2019.11.14.23.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 23:57:03 -0800 (PST)
Subject: Re: [PATCH v4 32/47] serial: ucc_uart: use of_property_read_u32() in
 ucc_uart_probe()
To:     Timur Tabi <timur@kernel.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-33-linux@rasmusvillemoes.dk>
 <CAOZdJXVpDSk2AWT7pYjrsk5HUmAeosCNf8zWX1CEEtZshAh9Sw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f584ea71-694f-3d3a-7228-9232531e3918@rasmusvillemoes.dk>
Date:   Fri, 15 Nov 2019 08:57:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOZdJXVpDSk2AWT7pYjrsk5HUmAeosCNf8zWX1CEEtZshAh9Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2019 05.25, Timur Tabi wrote:
> On Fri, Nov 8, 2019 at 7:03 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> +       if (of_property_read_u32(np, "cell-index", &val) &&
>> +           of_property_read_u32(np, "device-id", &val)) {
> 
> I know that this is technically correct, but it's obfuscated IMHO.
> 'val' is set correctly only when of_property_read_u32(...) is "false",
> which is doubly-weird because of_property_read_u32(...) doesn't
> actually return a boolean.
> 
> I would rather you break this into two if-statements like the original code.
> 

Sure, I can do that.
