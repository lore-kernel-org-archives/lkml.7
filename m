Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E5FC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34E4217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDdazYUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404435AbfEXV62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 17:58:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43974 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404259AbfEXV62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:58:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so5727894pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rjRYUfRcBF14ALsdZVh4eUyf5Gn6zszEh7GbEagkgVg=;
        b=HDdazYUAalR9pmaU15ErWgu3PPVgDob9gVSXou7nW8UbxW+nbqgg83fKIuRahiHvNj
         tdubuAZZ2Ttt7HHiKwuc26Sq17xC83Ib470RH5PW1XuNmnQZ0hq7VPoLwzcV7eoJwOVD
         CO74edwK8T9ZI/DS22/Hw0d3MUrpLxutWI/dlj640wnD0r7zPnN91bjkrCTApOT2pmIC
         SifOKm99DPebExgAjupYhlihe44nxHm5dvK718xnM1/v49ehi2l+lbf7kOeWzH50fL3V
         vzHm4HdywQ/s7YUnGH8+KFfYIxttaJ0NEmPEubm2K7DxmdWNhO8nr7tMF2XlHHNmJ1pt
         GBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rjRYUfRcBF14ALsdZVh4eUyf5Gn6zszEh7GbEagkgVg=;
        b=c3JFl/f3Gcg0lx5vMRlMoXSwXvDjhUpfpQFD6DwVF/tFTnqMXyZtDN1zUlyI9MNZdF
         6x2ibKfH92G/qu5djCYvLCoftiKE3uH31h00E7UoGq+dWaBxwmANNcZIbmBpd98mHGWe
         lyeSf9z9z7NGr+9YIv1LekjExAf3RUxoyK33w4AuwADaGaZiwulMq0R7c5013+/RJ5yb
         Ip+7EdmX7RZzjiZ5TYA8SKtTtUgyXqKEZ6kdI+VI48rRrjmvc9CWOfCtvklj7JDGXHFv
         FiSxqu+bOBWqB2vA/RkCK63G2XfHf8mLfU2U2Mnvbjd+9NhR+rtIu8TC3hmG52jg0FiS
         Ce/Q==
X-Gm-Message-State: APjAAAW0tn9o2IwRrCl7SJ2usNo9ESsAQXCOYAzQeZpdlIXEqjUXnpBT
        2EAdHcRkYF9HUQ3EAFK8rqkVVg==
X-Google-Smtp-Source: APXvYqwGvV4AAhDHnYnoO9rGokKbRvf0J1/MwriiAClSboTIy5vRpZPPKTQbD+KJ+behpeqmaGdv7g==
X-Received: by 2002:a62:1c06:: with SMTP id c6mr33598081pfc.168.1558735107458;
        Fri, 24 May 2019 14:58:27 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id n33sm3859887pjc.3.2019.05.24.14.58.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 14:58:26 -0700 (PDT)
Date:   Fri, 24 May 2019 14:58:21 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: use the correct function type for
 __arm64_sys_ni_syscall
Message-ID: <20190524215821.GA37129@google.com>
References: <20190503191225.6684-1-samitolvanen@google.com>
 <20190503191225.6684-4-samitolvanen@google.com>
 <20190507172512.GA35803@lakrids.cambridge.arm.com>
 <20190507183227.GA10191@google.com>
 <20190515114035.GG24357@fuggles.cambridge.arm.com>
 <20190524183551.GE9697@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524183551.GE9697@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 07:35:51PM +0100, Will Deacon wrote:
> > In the absence of a patch from Mark, I'd suggest just adding a SYS_NI macro
> > to our asm/syscall_wrapper.h file which avoids the error injection stuff.

If we don't want to use SYSCALL_DEFINE0, I don't think we need a macro
at all. I believe it's cleaner to just define __arm64_sys_ni_syscall with
the correct type in sys.c.

> Do you plan to repost this?

Yes. Sorry for the delay. I'll post v3 shortly.

Sami
