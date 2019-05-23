Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F285EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67232081C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAHsstRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfEWBrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 21:47:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40605 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWBrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 21:47:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id j12so6656051eds.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 18:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GhDOpD+a8hZjtMNIICSVb0siagk1dgNYZl1xyc8Nh/s=;
        b=RAHsstRpbLf3k0oQL3ZdAxZNnhWB9ZQx211cpf9TbvlO+3D6SP3+7mmzu0LlgM8ldM
         YwAGFs03guyR/13fWGrGfOdZTr/4PaK0iMdmiCPXcSlfRGUqpo8DxXbX92/urJpReydV
         ZjMcA3YzivAX4MdtizE4zM2cqlAYzaJ6ofb2Iz/tCiBMhFHhoO1Ln/GsI0hd8uSESLm5
         ekrjS6LIpq+TSnewT23Yp7Fd825pMCcCj10h04CJZEpHj9FPgUqM+w5N50Bq50LoFzva
         QPaI8Irw+hkLdwcEis8BoraD6dx5NA7m5xWV/KpTMQpf0oBfAknVCAYX1XMfmXp0SvHg
         gpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GhDOpD+a8hZjtMNIICSVb0siagk1dgNYZl1xyc8Nh/s=;
        b=NVOmBdOftoW2yx0pvba/JiO3xlflkRYuH6HpqvzC94Hvi/7bZT8E1cxkAk2ErteS2J
         23DBvlAnUB96gdWHKU4xaCK9xYWgRjjWLEXK9n2mt7ROnI2brLV2Q3q+NXDKR8hbL5LG
         muPSsaq4J9jSpFw9P1V/fyqUg1KLhG/IICACvk9pS2OjUwhQys6G2bYtv6ozsd4lEgWQ
         cXGouumsIlBq/BkukCPOJlA1tjAyFsbdcYwObLZNV1Of5ouKS8zjHAhI0/4t8ln56tMg
         KMDf11QH35TVWb5t66tL+Q3JzlN4uq5QaRMDP0qFdtnuboD0H9gpG7epx+g2wNg6sA6Q
         DwMQ==
X-Gm-Message-State: APjAAAXi76DHxcZSGS5JkFZVqlxw1nA/E/IMtbuSEg0s5fi6E7IGwmM0
        JVhSHT6sedh4Pbn6ioKb0k4=
X-Google-Smtp-Source: APXvYqw/Jq1ILra5N4580sMe/IeEHxM9pGabgCBEXURpJwUD5K34xnviPekD1/bHpG4yUCsySFosJA==
X-Received: by 2002:a17:906:488e:: with SMTP id v14mr33945656ejq.216.1558576055392;
        Wed, 22 May 2019 18:47:35 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id x22sm7584539edd.59.2019.05.22.18.47.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 18:47:34 -0700 (PDT)
Date:   Wed, 22 May 2019 18:47:32 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] kasan: Initialize tag to 0xff in __kasan_kmalloc
Message-ID: <20190523014732.GA17640@archlinux-epyc>
References: <20190502153538.2326-1-natechancellor@gmail.com>
 <20190502163057.6603-1-natechancellor@gmail.com>
 <CAAeHK+wzuSKhTE6hjph1SXCUwH8TEd1C+J0cAQN=pRvKw+Wh_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+wzuSKhTE6hjph1SXCUwH8TEd1C+J0cAQN=pRvKw+Wh_w@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 06:40:52PM +0200, Andrey Konovalov wrote:
> On Thu, May 2, 2019 at 6:31 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > When building with -Wuninitialized and CONFIG_KASAN_SW_TAGS unset, Clang
> > warns:
> >
> > mm/kasan/common.c:484:40: warning: variable 'tag' is uninitialized when
> > used here [-Wuninitialized]
> >         kasan_unpoison_shadow(set_tag(object, tag), size);
> >                                               ^~~
> >
> > set_tag ignores tag in this configuration but clang doesn't realize it
> > at this point in its pipeline, as it points to arch_kasan_set_tag as
> > being the point where it is used, which will later be expanded to
> > (void *)(object) without a use of tag. Initialize tag to 0xff, as it
> > removes this warning and doesn't change the meaning of the code.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/465
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> 
> Thanks!
> 

Thanks Andrey! Did anyone else have any other comments or can this be
picked up?

Cheers,
Nathan
