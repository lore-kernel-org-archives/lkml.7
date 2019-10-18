Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2E821925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hz3XrSB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404584AbfJRHil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:38:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40659 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbfJRHil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:38:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id o28so5066686wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 00:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dSeQpsX1lWyhJjjqgCnSOVYN/QoRMRw+pYlbFd08lMw=;
        b=hz3XrSB+KBpqUPLDKyw2Jxr41b1CEp+1/qVyRxUWVhXQ2yO3pcwZzRTc/RmcOuftAe
         JDBdUygHnnCUA5eOUl15iri/Q+pJwjNj8QpABl/LDSDeAgJpmMZHz+yGbcIXyfe2T2rZ
         FdvN77qt6r5RmRuiTi8yBUPRt0a5xjswyuHdWiBKGCTG+oN1++x4EHZ0rAVV+SFC9hs6
         UDxdd63AtrdBw+WdHn1Vt/5QnsArLFY/nkfXoHP1FgeOnU37SLfzYzzzlHSa1ZHOSYSi
         ztfjgTFwRkHM3MohnmPFb+9aAdSDakwj2NKY9LhRrbQ4q9QibxP+9iEtqyGG4Bho2xcJ
         y52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dSeQpsX1lWyhJjjqgCnSOVYN/QoRMRw+pYlbFd08lMw=;
        b=SsoIClYyKSWzu15hqZbfhqlwRfPTb86RPfX+CRd61O7+LWTWS3xO0JyMaWUkcHiJKE
         +Pd1yI0OUHL/en7F8AouXCYh8tbumPaWrhRUWiOhIphse0018qiv8hf+k7Rfk44bsPoh
         BflgZSrKZC09fF12tXZoWHtd/cPmdFlFfy0JocAiHJXSUHYo0M6GrkBj/2xIvUPmwotH
         i+pJMsBa//U43vb8QCdgWDjQbRJdbnrbvyJDJD8R/pebyvIEqZyCLYOmdHk4V6/T+fI5
         xUNCZOiamQ+cYTGWpSshCqkhtRDyUXRLWvJx9zIW6uA8aKoOtJocIU1liglNRLBZpEEx
         ZfjA==
X-Gm-Message-State: APjAAAV+B1LCRorssuR7wPNIIVIIo4/ONoFS6DIcoRL5zFeNNjgADIkP
        dtZ6sCxOuAPTIxnQ9+Z0GfwxKA==
X-Google-Smtp-Source: APXvYqyMG++9BlE+2Kvq0zYfc9v90AGN3ajctmqk/j3JHgJFv9ZF19h9kZYjj54VOjc0kFu8V8CcXg==
X-Received: by 2002:adf:ed84:: with SMTP id c4mr6235302wro.333.1571384317887;
        Fri, 18 Oct 2019 00:38:37 -0700 (PDT)
Received: from dell ([95.149.164.47])
        by smtp.gmail.com with ESMTPSA id 36sm5585697wrp.30.2019.10.18.00.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Oct 2019 00:38:37 -0700 (PDT)
Date:   Fri, 18 Oct 2019 08:38:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 29/34] backlight/jornada720: Use CONFIG_PREEMPTION
Message-ID: <20191018073835.GU4365@dell>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-30-bigeasy@linutronix.de>
 <20191017113707.lsjwlhi6b4ittcpe@holly.lan>
 <20191017132324.GP4365@dell>
 <20191017132846.ojsh27celyl76dlx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017132846.ojsh27celyl76dlx@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019, Sebastian Andrzej Siewior wrote:

> On 2019-10-17 14:23:24 [+0100], Lee Jones wrote:
> > So what are the OP's expectations in that regard?  I see this is a
> > large set and I am only privy to this patch, thus lack wider
> > visibility.  Does this patch depend on others, or is it independent?
> > I'm happy to take it, but wish to avoid bisectability issues in the
> > next release kernel.
> 
> It is independent, you can apply it to your -next branch. All
> dependencies are merged.
> 
> Sebastian

Wonderful.  Thanks for the info.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
