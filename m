Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399D5C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C122146E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EGIHk2y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgAGSMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:12:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42258 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgAGSMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:12:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id s64so239470pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 10:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=otNEfPZRhfkH889yZruDaz8ZPdXQW2OeMKDCutsW3ng=;
        b=EGIHk2y8X43q+dSv8uJDGfXbIXgfrsvaXk3EkCjao8JZyS6xL3yyYa/IPsSxKx7I/8
         OZLFuBfwTr+9/eEGtHS7pPYUOArjVm9BVeCqWXH460W3KfIdq00ZZnwox4+RJdvlEP5X
         pUm+kxpQ6C9u3/4s26HyNZoDVnj1J0J8D05Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=otNEfPZRhfkH889yZruDaz8ZPdXQW2OeMKDCutsW3ng=;
        b=lGYBh3RVPqOaeSWVQDSZgG6eEQ1OlEOHNxPbMOaNFKm4RBRyUPXsiyu9UFSgAqA3NM
         f/eGU4YW6kZcIZ+/CWGqIrtMfjD7dsktWEcNB+0YL5SFgssU/8S00TfwFBxNlC01UK6E
         rcZF1yq2qBfYqP4WPcBvruAboS75o2MZjdoEjlsslg7ButTNX7g70TPHDwToOpMNkv8W
         DYrTSbnuxHOl2k9jEQM2bO9CZvWB1t/NZocrPHd1amq1d0+oTD9u2bOT+erDi3TGflQu
         5rxEegXCvyOoqV2uIJDiA8BrDOnhNjL0Y2nlWW+AG8vVw0tbmOxmSVl2TT6e7/7juWXF
         P4Wg==
X-Gm-Message-State: APjAAAV6m+Ih06b79P1plLQ29nl3+oU4Jfq6hGLZ3HFQHVXozXSB8IKd
        dd2pPLUVjdLwaudHfk/Z9wnRwA==
X-Google-Smtp-Source: APXvYqwOo+HzjTqist30x982uq+NRP2n7KSTQc6r6187ME5VXodlSE2JU9i1b2bbt/FBtxQZvAtBqw==
X-Received: by 2002:a63:184d:: with SMTP id 13mr790298pgy.132.1578420761599;
        Tue, 07 Jan 2020 10:12:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u7sm200377pfh.128.2020.01.07.10.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 10:12:40 -0800 (PST)
Date:   Tue, 7 Jan 2020 10:12:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Amanieu d'Antras <amanieu@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/7] arm64: Implement copy_thread_tls
Message-ID: <202001071011.9517D9C0D@keescook>
References: <20200102172413.654385-1-amanieu@gmail.com>
 <20200102172413.654385-3-amanieu@gmail.com>
 <20200102180130.hmpipoiiu3zsl2d6@wittgenstein>
 <20200106173953.GB9676@willie-the-truck>
 <CA+y5pbSBYLvZ46nJP0pSYZnRohtPxHitOHPEaLXq23-QrPKk2g@mail.gmail.com>
 <20200107090219.jl4py4u2zvofwnbh@wittgenstein>
 <20200107174508.GC32009@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107174508.GC32009@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 05:45:09PM +0000, Will Deacon wrote:
> On Tue, Jan 07, 2020 at 10:02:27AM +0100, Christian Brauner wrote:
> > [Cc Kees in case he knows something about where arch specific tests live
> >  or whether we have a framework for this]
> > [...]
> > It feels like we must've run into the "this is architecture
> > specific"-and-we-want-to-test-this issue before... Do we have a place
> > where architecture specific selftests live?
> 
> For arch-specific selftests there are tools/testing/selftests/$ARCH
> directories, although in this case maybe it's better to have an #ifdef
> in a header so that architectures with __builtin_thread_pointer can use
> that.

Yup, I agree: that's the current best-practice for arch-specific
selftests.

-- 
Kees Cook
