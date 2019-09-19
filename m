Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EA8C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7C1208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Skg8FBDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbfISU64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:58:56 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:40941 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732070AbfISU64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:58:56 -0400
Received: by mail-pg1-f180.google.com with SMTP id w10so2554062pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CUgsbf/jB2T41BbAqv3yJJ6qnY+emEeWTF8GouW0W7k=;
        b=Skg8FBDYI3SI80OiRaZsajZIS+mB/ws1Benp96vjZIICX5FQ+h9kfoOXJI3HVESzW+
         GK+aessLoKXzNbE0qDzjfAAkxFLtfNQTm/gGUDRHm1zFBR+P6Gi2NLWI+G0ABr0jhmwy
         qWUOkMVTLwXp2lAvy82OQuTS8G5C4Pwp9SWq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CUgsbf/jB2T41BbAqv3yJJ6qnY+emEeWTF8GouW0W7k=;
        b=gr2q1PcoYe6MRWkIcTIdxiioNv4BHvRXEMAivCrfdttwhwId5A3+JuGrjhE0mwmMQW
         u9lECHXzwnWplFNakQj7+yHtUbXnyHdRloSlHuEz0NWIjPe3KnrBcrEsq/4p5n/YGAkZ
         PWPgUa2KutyUemipr6YUALumWn2sLJ6FodEu2GJDrnN1RkUY4xfH73YHGQ+Box5yz6wk
         RoNvS9JQBfAV3RsyZ3O9v5lbslhYBA1HFseDCoGmFXc4KwQJfklJBLWEgtFFxe0gLMtt
         gV7c+sU7+DufdgWgCTkAkT/WJeERWlJDuYADPNp14QAXtXqLJFGURrUlKm2jDYARVVxf
         NUpA==
X-Gm-Message-State: APjAAAUgvmSaTo6nJfHGqgjcexuIYRfQ91beba3VYXjsRA+YX6NJG8pF
        dEP8viiXGtPoKm8a8VGNA961Zg==
X-Google-Smtp-Source: APXvYqxxK218iueQ1y1JKMl7jjQZnPgxxYGDjjTCbDmU0HJIUVzwPt4wc4a+8kSux480STH1xOWYKA==
X-Received: by 2002:aa7:93b7:: with SMTP id x23mr12589265pff.250.1568926735403;
        Thu, 19 Sep 2019 13:58:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f18sm3666342pgf.58.2019.09.19.13.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 13:58:54 -0700 (PDT)
Date:   Thu, 19 Sep 2019 13:58:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tim.Bird@sony.com
Cc:     shuah@kernel.org, anders.roxell@linaro.org,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/kselftest/runner.sh: Add 45 second timeout per
 test
Message-ID: <201909191357.7B79D5D427@keescook>
References: <201909191102.97FA56072@keescook>
 <ECADFF3FD767C149AD96A924E7EA6EAF977BA636@USCULXMSG01.am.sony.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977BA66E@USCULXMSG01.am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977BA66E@USCULXMSG01.am.sony.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 08:49:14PM +0000, Tim.Bird@sony.com wrote:
> > > +export timeout_rc=124
> > what are the units here?  I presume seconds?
> 
> Nevermind.  I misread this.  This is the return code from the 'timeout' program, right?

Correct -- given the skip_rc usage, it felt weird to hard-code it in the
if/else statements.

As for the "45" I chose, that was just to be "more than 30" which was
the per-sub-test for tests built using kselftest_harness.h.

-- 
Kees Cook
