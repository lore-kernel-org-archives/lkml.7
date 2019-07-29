Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EF1C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B29206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVGeuI7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388190AbfG2Sn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:43:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44855 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbfG2Sn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:43:26 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so122163420iob.11;
        Mon, 29 Jul 2019 11:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=geRb+xmd/f1jkfORhsVtE+k/0a+B//EFaGFVIsLhObc=;
        b=bVGeuI7+q/E6mMswliDCz5OpxuOF2eZwPcikFI3x4GEAaaAXOXFZ+8Htj8ll/l9F2t
         /Q/VMn6gBqwyipbpE8ng2QfLvCZpmE6bdnvk7aOgwIY2JaHwhTF0UgMlMLiSpvImPTKR
         HigBQNrJF8VslcQO9/DI1GUodVbgwlm17LlysCTTUShA8QNosP1S/Nf2w+8tZebujVZp
         Bf0oEFRr9pNxj1oJHJWuaxcisdKodimMFYVrKHpC/VTEBiXwrm9119y6yOI88ozlWomw
         HKOrJsEoLIHCvmw1cyr5vrfVo0KK7UEIiRpg2fLiysi5SgYWm8qeOj87mMO/LVnoDGrH
         JOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=geRb+xmd/f1jkfORhsVtE+k/0a+B//EFaGFVIsLhObc=;
        b=MM4oxbzb1dx8EYMbx/vT94u9M3eDoJbsr+RSganQsdewoopXCLnrP3Kgxzrs3LKvWm
         tsSqpgeNLRPfFdy9cJtNEDA+2Mgf2729UHj/cHdQGkbovw7MfbTNjE1sEnHWl4jqqgE4
         qd9+LamDN2bhJXc9nBAjSjhXOgcm0XPsFOfG6ei/HIYSlIlIgihmFyCM27Fif7/b150P
         M88zBs1u90X+Zhxq4ZY+1QcLBWkm0PyBkGiPRzOtBVA7XcPEYWxB3UsTu22LOiy4OnVA
         3HCWcIRQeA3RcVD1P/fRHRyKs9W5uSJ30u8IiGTuHe2AqOfagdXo9NNohHxk6WobVaKF
         vLzQ==
X-Gm-Message-State: APjAAAUfr9FXRqLvf4kdSVW1cdnStcdsRunDjcwRHrJx8FLfUH5UJGd4
        hVqhTNUCl+tbSbLP52V2tcc=
X-Google-Smtp-Source: APXvYqzChUsC55AGMMrdotkBYf7SylCuLSJNaWeI3qCUXDnZzs22DtP+LVRSR2fdOOx7zcHNUg6HRA==
X-Received: by 2002:a02:710f:: with SMTP id n15mr75388873jac.119.1564425805584;
        Mon, 29 Jul 2019 11:43:25 -0700 (PDT)
Received: from localhost ([8.46.76.96])
        by smtp.gmail.com with ESMTPSA id u4sm60634224iol.59.2019.07.29.11.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 11:43:25 -0700 (PDT)
Date:   Mon, 29 Jul 2019 20:43:06 +0200
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/2] input: keyboard: gpio_keys_polled: use gpio lookup
 table
Message-ID: <20190729184306.GA767@penguin>
References: <1564415994-22871-1-git-send-email-info@metux.net>
 <20190729172607.GB755@penguin>
 <b2912c1d-a6d8-ad2a-3e37-19e4d3d1bd3b@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2912c1d-a6d8-ad2a-3e37-19e4d3d1bd3b@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 08:14:52PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 29.07.19 19:26, Dmitry Torokhov wrote:
> 
> Hi,
> 
> > As I think I mentioned a while back I would prefer to get gpiolob >
> > support swnode-backed properties so that the driver would not need
> to> know about differences between ACPI, DT and static board files.
> Indeed would be nice. But I think we should get rid of raw gpio IDs in
> favour of gpiod lookup tables first.
> 
> > I just recently re-posted patches for this, let's see if we can get them > landed in the kernel.
> Can you give me a pointer ?

https://patchwork.kernel.org/cover/11042915/

I tried putting you on CC list there, did you not get them?

Thanks.

-- 
Dmitry
