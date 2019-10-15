Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBB3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73EA2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j//bl2xT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfJOSOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 14:14:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34532 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfJOSOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:14:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so13007595pfa.1;
        Tue, 15 Oct 2019 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aiO6fnmOebhSknlJtLcepnlwWYgRHp87sjaMlelwgA8=;
        b=j//bl2xTjIRqoTgXJMPZhqSciCYOncfXD8ROoWxqKQZWly0RJ0AnP/vEnxPfiMRBmt
         Ff4QUogeyJQBdOLkJU9//XXoTrqw86WKKnQ8qvu8U/o4pDu+ZWaBebGhXJD3dNJM0Ock
         KhtV31dyoi6k760PdljGdyqhX+mt8bl1C/JCR0l/J7liX9IugqpdxVGGy6rxE+QbWRS1
         6GyBpflg3BPchdgX9HbkcN4oIQTLuFFptp4EC4zKfwaVLc9IgGqjUX1RXKz/mXutM3cQ
         t4xCj6craAM0APDFmW6eAdzMud+JcId8eEi4cFjUpxfdX+f6CrRUjxGzPxbAbjbXhYnX
         YGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aiO6fnmOebhSknlJtLcepnlwWYgRHp87sjaMlelwgA8=;
        b=i0b3rge1KcW48bXpmwPFB4qZecWviN1isEAJ+ZHoM4Y+RxciMHKf6WQy8SDLEQPxr4
         qg+hnWpNo42BLHxQFu3vTAOUwLSpKGLqEtyyf/hmA6ms3H0CTkxgdO/DXv+/D4JfPLOx
         0scmPIfRFech6gTO1xd4OefDLeMbRSrky22GXAomooP1efpiSWXA0Je7+cRLSN4JVgFM
         eft+eCfmRCi/mvcMViVfKpZf9adDSyzMhDna6+hUbPAE/nfCCCB1RUS/U9f8mulPD4s0
         wF2ctsct1c8wwGTNL4vQ4ZzolVWgUQ9Co+GkiJXye/jrD5x3TjIUK7X42mr/oSkfKA1R
         Nx9w==
X-Gm-Message-State: APjAAAXro6YXGsplP7WKuFoZEy4pWESul5emrLVULpKuYRayInu2rxRz
        l8NMIHj3Mesk9XEWhBT9Ufk=
X-Google-Smtp-Source: APXvYqzuKih9LyfsA+hZywf3l+TrUM+PFKJQ8DhGwomcwdFFk8csRHuAeY9y6eM1KggSZqDzs03XYQ==
X-Received: by 2002:a65:5249:: with SMTP id q9mr382079pgp.390.1571163261194;
        Tue, 15 Oct 2019 11:14:21 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 69sm3448693pgh.47.2019.10.15.11.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 11:14:20 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:14:18 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 06/14] software node: get rid of property_set_pointer()
Message-ID: <20191015181418.GE105649@dtor-ws>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-7-dmitry.torokhov@gmail.com>
 <20191015120949.GH32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015120949.GH32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 03:09:49PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 11, 2019 at 04:07:13PM -0700, Dmitry Torokhov wrote:
> > Instead of explicitly setting values of integer types when copying
> > property entries lets just copy entire value union when processing
> > non-array values.
> > 
> > For value arrays we no longer use union of pointers, but rather a single
> > void pointer, which allows us to remove property_set_pointer().
> > 
> > In property_get_pointer() we do not need to handle each data type
> > separately, we can simply return either the pointer or pointer to values
> > union.
> > 
> > We are not losing anything from removing typed pointer union because the
> > upper layers do their accesses through void pointers anyway, and we
> > trust the "type" of the property when interpret the data. We rely on
> > users of property entries on using PROPERTY_ENTRY_XXX() macros to
> > properly initialize entries instead of poking in the instances directly.
> 
> I'm not sure about this change since the struct definition is still available
> to use. If we would change it to be opaque pointer, it will be possible to get
> rid of the type differentiation in cleaner way.

We expose type and other fields that should not be manipulated directly,
for the benefit of being able to use static initializers. Having value
structure allows for not too ugly non-array initializers.

Thanks.

-- 
Dmitry
