Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FC1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F5023401
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="oNnxhTlu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389230AbfHVNnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:43:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46661 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731907AbfHVNnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:43:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id j15so7641937qtl.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xO/6xaE9MGMH+or7wVjBVvh58YMNnJ0aqS9HSIkNkks=;
        b=oNnxhTlud9r17BML3hLv41CDghUmIHxG6Dr5Or92qHO0oo/B3fxPwmrWP+yKrj4u5U
         qfvTUktfZS52ymoXXvVoVly0/xWPgppGYuL4g853pbWJjGZfJ+M7hpi5KCAQlBZCRXRP
         vNzSjcceWRq/72eVCC3Z3HTBRH91ad2L3rnS6kXxYaJM9humiuVqxK1GDyq1a8Amj1wQ
         cPnz2AKCSiiouK+OOmvq+E6SQnjipcDnRjMcQVkAfcitT+JVxIwbSdvH5GDMp+tUs/LM
         6KALkRvjJoS2teN7jW8eNjFnuoqKVpAyrXHj70QlHB14c0GrcOT/hP6zyOEmFNRMmzDL
         +IPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xO/6xaE9MGMH+or7wVjBVvh58YMNnJ0aqS9HSIkNkks=;
        b=kjc1Vy4Fuk27w0aJx3h9Lecm95CmbOJOUIRHRkZ1/Ge13+0QD+avX8X51GLS5Q2inD
         w+WohaKjEMPXjRbeD/+uAx/UOz7+I+gpL2UAxDzMTeWEyuJUjqV6p7SwFD9FBKCluCgy
         xLF6+cSOVye+IEOvvvc0MbSASPp+9xuMKfWsT4qZEkOHQQDyUuFDlM89oGbbKaAT+CdR
         hkdB/CqVC5P247q9AnGH7xiCobiUqhKNwlrH0+H4M/t4ufLeUaAhYctlyt1IQlfot8zH
         sLCD6f4cCJ2PY6xf1S+1fcWel2Kq0uFUUJ8JTSFfxueyJRr3qO6mPZPhbV5M1xPHi+at
         UDNQ==
X-Gm-Message-State: APjAAAVYGlP7iRMOZD/FrdWxE/vgZnxWPVeEed5+oDlVsSaNlJw1Of1I
        yUi8yVAeo9+7+yfLaUgZpxoYwg==
X-Google-Smtp-Source: APXvYqxs3n27LO8gcTZ+sUMUSO3JT9qplLf76Jvr1umXaqLwRRpuIxjdmMYFz0gjtmAhd48/ri6H8g==
X-Received: by 2002:ac8:51c4:: with SMTP id d4mr33744945qtn.176.1566481430289;
        Thu, 22 Aug 2019 06:43:50 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j6sm14466100qtl.85.2019.08.22.06.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 06:43:49 -0700 (PDT)
Message-ID: <1566481427.5576.5.camel@lca.pw>
Subject: Re: [PATCH] x86/kaslr: remove useless code in mem_avoid_memmap
From:   Qian Cai <cai@lca.pw>
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 22 Aug 2019 09:43:47 -0400
In-Reply-To: <20190822132628.GA3887@MiWiFi-R3L-srv>
References: <1566477146-32484-1-git-send-email-cai@lca.pw>
         <20190822132628.GA3887@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-22 at 21:26 +0800, Baoquan He wrote:
> On 08/22/19 at 08:32am, Qian Cai wrote:
> > MAX_MEMMAP_REGIONS is a macro that equal to 4. "i" is static local
> > variable that default to 0. The comparison "i >= MAX_MEMMAP_REGIONS"
> > will always be false.
> 
> Seems not true. mem_avoid_memmap() could be invoked many times if
> multiple memmap= added. It will carry the value accumulated from
> the past.

Ah, I am still a newbie in C after all those years. Sorry for the noise.

> 
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  arch/x86/boot/compressed/kaslr.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/arch/x86/boot/compressed/kaslr.c
> > b/arch/x86/boot/compressed/kaslr.c
> > index 2e53c056ba20..a4a5a88edb94 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -176,9 +176,6 @@ static void mem_avoid_memmap(char *str)
> >  {
> >  	static int i;
> >  
> > -	if (i >= MAX_MEMMAP_REGIONS)
> > -		return;
> > -
> >  	while (str && (i < MAX_MEMMAP_REGIONS)) {
> >  		int rc;
> >  		unsigned long long start, size;
> > -- 
> > 1.8.3.1
> > 
