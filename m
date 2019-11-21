Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043C9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3E220674
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1y2D8nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKUIio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:38:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36450 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKUIim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:38:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id n188so747292wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 00:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y2xcXcuu7QkgZSFDX7K3ZB9sDdGxUw+zaaPU8rkP3yk=;
        b=C1y2D8ncNoAHA9p1zqtEh25JVKEOU1ZHKGljI/BNa9fDQN/mg0sHen1B16PFaLtUIv
         4X2aWQEvMYgY2/AEttw5LanNaPHOe2vgDnwY+tO22K2uWCIDCR4VepN8PpR1iSJbBros
         pOPofrd7zcZDilNhfzZbsMCz8W45W31i/cSrM7Pw3QAcdHsTFUS3Fk8FOW5Fbq3Pzg0m
         0HfJAki0pGGEMNPFYJ8+s84bDEwCLiW2JXIlCICi/EwqQrn96RBhQwemoAgrfJLXq09o
         uSC3j9BXeB/W09GYcl1CekPFc6RgPsgMB1xlIvsfG3kCzK0B8O03pGGg6WdJuVKXfFA/
         w8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y2xcXcuu7QkgZSFDX7K3ZB9sDdGxUw+zaaPU8rkP3yk=;
        b=GjsJ4Za5/+1KTzhe4H+3giygrHIMPTBBtZ6WjuGjRY//82Jkgk4imW37DX+0AUl6cn
         riAd/dX98emRJ6cs6Rm+innqaTVYRPXnq07xwveNQMVX+Ef+v7MO1LtC2d3JCOn8Ccp2
         lBdBww7ukupTSZykm+bU24E178QGsFRve9IleTrNdMNj6P0ZeV8mfVGcqfoMtI/zlC08
         29LzOUUlPz2F6oMi5csxFKMKSQeQWzlhulds6pYM110Pall/go3cXX4J4+hYjPrsS1Ee
         Q7g55VTiUFr3stMf0XQXXrCZ0ten0fd1nqkNxFhwFzooHGuybkO6WngpAPOudzueCJll
         Oh6A==
X-Gm-Message-State: APjAAAWc7kpw0kdUJyq/bpnRCoc0V+JYiIs0e12SCdNpq8QZcpuhTKY8
        Dmyg7KobE/lLomHZ/xWPrbZrukFB
X-Google-Smtp-Source: APXvYqyEnBVxbPYFGm17ceLb5RtAd9LHunLUMRjHzGgnrD4ULBn2jF2yfcjxJ4S6sHKUm4GSFSQYDw==
X-Received: by 2002:a05:600c:299:: with SMTP id 25mr8700708wmk.50.1574325519728;
        Thu, 21 Nov 2019 00:38:39 -0800 (PST)
Received: from ?IPv6:2001:a61:3a4e:101:8d4d:f454:a7e5:543d? ([2001:a61:3a4e:101:8d4d:f454:a7e5:543d])
        by smtp.gmail.com with ESMTPSA id j11sm2296802wrq.26.2019.11.21.00.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 00:38:39 -0800 (PST)
Cc:     mtk.manpages@gmail.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: man-pages-5.04 is released
To:     Jim Davis <jim.epost@gmail.com>
References: <5c4f8af1-723b-1b10-5163-f8f8b14b38ca@gmail.com>
 <CA+r1ZhjZRED8OCyxMK=71H2obYhccB8q1+nCZ6bnMNQ7SmFkdA@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <87047341-0e25-3c1b-fc72-139848f07075@gmail.com>
Date:   Thu, 21 Nov 2019 09:38:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CA+r1ZhjZRED8OCyxMK=71H2obYhccB8q1+nCZ6bnMNQ7SmFkdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/19 11:15 PM, Jim Davis wrote:
> On Tue, Nov 19, 2019 at 2:48 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
> 
>> Git repository:
>>     https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
> 
> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git ?

Ahh yes, a cut-and-paste error that crept in somewhere 
along the way. Thanks for pointing it out.


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
