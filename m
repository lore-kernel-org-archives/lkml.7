Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85677C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4453C218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNHMhyXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfCPWrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:47:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44677 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfCPWrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 18:47:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id a3so8722276pff.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 15:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vh9QpzVJ1GnogVWkgaXISddHjcJKCi1xFYlnKtK9wOE=;
        b=MNHMhyXvftpQW8gv5WoQbgRbKVm1TayLyZziA2ArrhZflHNcY438MGg/vRNDuJQ7Dq
         STfudT7sgRJZZlV03hoDE2m6MaLL1E3VTXDd1ha2OPmfWGESbSmPuhQ6ONZcGVptwkVm
         Krnv1y8DRl4aCSgHlCvTmZEcQN95GTiPRZ7lglJlVw+McD5q0XEx6CG4DG2C0fH0Yz/3
         EafB1GR41nAeUs5HLH9d8qrX9j90MuPJxXuTDIT62I0+jRtoe5p7qHgPnpYlS7eQlmIu
         sS40RVIb9IVlz0MtQFOltLgOwO6VlMpDoWV5Ll9RuJXPoS5x/+v6Qih+0ySfqigsQcj9
         Ph7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vh9QpzVJ1GnogVWkgaXISddHjcJKCi1xFYlnKtK9wOE=;
        b=UW1q6W0CrRGZ3diahTQZhAVwve76FQQ3crKMtDDkiZvcHh0g7Hz6o4cTznRc7fGLVS
         7q+bTXgSfQ1iDcIOFjPcdmjC6sG0hSOKV0Ar4o3DkiuATCPr3wlcSIYJ9oFOCPjti9Jh
         RKXzCso8eIQMktfI/bAd+vRePkYmVc/wWHtncV7M2l6o7I2nvLB8oe0g5c4gvn4F1EeS
         T2T8GmU/SyGdckQKvmAng7rz9DL1jcuYMq2CwJZR4zI5A8h7czmDbsIH51MCIPFPuyvJ
         2Tav9RiZpLAb6Bm8peWGNUPZhU7IDO1FGylZadjKFquKhEd3OWtgb6f9LZDCrULwbMrt
         Lw4Q==
X-Gm-Message-State: APjAAAVudNUO6BNHgSxxvkdxUPV2EMYuDqabW2obPZToxLlV7lHELRLO
        yHbthqPCD+91SSJTM8ULO6JuOg1t
X-Google-Smtp-Source: APXvYqzQUedoP/ERtt4XvHLELuGClnVTPF0/WGUV+n9Zl63CLpk/PLpneR5GudEPKKfUx+ELXPRcjg==
X-Received: by 2002:a17:902:6b48:: with SMTP id g8mr11929887plt.21.1552776444362;
        Sat, 16 Mar 2019 15:47:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g2sm15479420pfm.144.2019.03.16.15.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 15:47:23 -0700 (PDT)
Subject: Re: [PATCH] powerpc/6xx: fix setup and use of SPRN_PGDIR for hash32
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <7e45ca3f0283fb24c2642e5b91bd75c55f2ba96f.1552028583.git.christophe.leroy@c-s.fr>
 <20190308160334.GZ3969@gate.crashing.org>
 <7681ad2b-35d4-6e43-f727-21545e3bb223@c-s.fr>
 <72bac00c-d2e3-515e-3ab1-99f20c058ea1@c-s.fr>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fac535c2-af61-1a1b-ebed-82ca0bd2e4a4@roeck-us.net>
Date:   Sat, 16 Mar 2019 15:47:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <72bac00c-d2e3-515e-3ab1-99f20c058ea1@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/19 6:20 AM, Christophe Leroy wrote:
> Michael,
> 
> Are you able to get this merged before 5.1-rc1 comes out ?
> 

Looks like this patch got lost. I don't see it in Michael's most recent
pull request, the one that got merged today.

Guenter

> Thanks
> Christophe
> 
> Le 08/03/2019 à 17:06, Christophe Leroy a écrit :
>>
>>
>> Le 08/03/2019 à 17:03, Segher Boessenkool a écrit :
>>> On Fri, Mar 08, 2019 at 07:05:22AM +0000, Christophe Leroy wrote:
>>>> Not only the 603 but all 6xx need SPRN_PGDIR to be initialised at
>>>> startup. This patch move it from __setup_cpu_603() to start_here()
>>>> and __secondary_start(), close to the initialisation of SPRN_THREAD.
>>>
>>> I thought you meant an SPR I did not know about.  But you just misspelled
>>> SPRN_SPRG_PGDIR :-)
>>>
>>
>> Oops.
>>
>> Michael, can you fix the commit text (and subject) when applying ?
>>
> 
> 
> 

