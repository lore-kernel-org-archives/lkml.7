Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7AFC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1D8217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="c/JyPMzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfGXOkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:40:00 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40267 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXOkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:40:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id s145so33914790qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U2Vjt/ngoWwRTHJ/HnXQ3A5kSE9G176ORXuJs7Iic5c=;
        b=c/JyPMzwHZygBTC3mWa6rTYaWyQuO3bxyVlM+XuwF+yUAYgtIFu0TMUvtqVhCP3dnM
         EP2Kp3JAC2nBUlzAmzRYQFtKsqYcAkyfMhn+Kmcdu0QWBxHblRMwWoBWuNoSEXt720Q2
         ZFmL4IuyWEHYnVkPYFkmLm/bDYGV820xfI3Cuw+Eont5+V7HAJx1lTNibQsdrHAH2AtB
         sLQGF71NqzVdqOqNx0BGh4eIMC4o2D82asu2ne9nvIcgOVY/v7NwaPe7lqwQwKgjPouC
         CAvDDyWt+2axBFYQTNtGswDLH3LiXn0xVL4LfevY0DWbUqbcV3FChH7+M0gPEfdo2YfJ
         MMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U2Vjt/ngoWwRTHJ/HnXQ3A5kSE9G176ORXuJs7Iic5c=;
        b=R1svQDwqQcfbXyG8x6pnuBtNrjxWiCezupcW1xkRee15DejLmZSbVdnhR1IcDZRJYy
         gYoyOeMNAlzcqmy5/nxPd0MfCGCArcfg+6C7E/yNfCHfWJLMl9KsXeEuf1NCST9qEuUX
         U3VDWTtjsA55UiuEVYgKT3RpeeL9+jqj9SKJGjHSoy2L8jwrgqLi78ex+f8k2HvjPx36
         EgZy36cwm+XYIKVfO5qnZgKNwpHwAUNiyO7eizYb3lMVwlKFK57N7koteBQB16y24zWH
         BVydGgAR6XVgdldda+LEjMS1clYdXCmnCak22WBvoKdFcdcfwphYidYnK0PGM1TVHUgk
         fKAQ==
X-Gm-Message-State: APjAAAWjw9ZwP+SRAobrUVhn8/wBKORh9K347qf0MM/UgSF1Qhj4Mfuv
        i3jLYDP8Q19omaL7/YfM6HZvTA==
X-Google-Smtp-Source: APXvYqwf4BmGuxpej+hiJipFUX2lSUMntbGtB+6M1IebjkBK9UhvMa2Di7AUYtTWOVvfSZSTGvy5DA==
X-Received: by 2002:a37:dc1:: with SMTP id 184mr54711685qkn.10.1563979199355;
        Wed, 24 Jul 2019 07:39:59 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l6sm19603999qkc.89.2019.07.24.07.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 07:39:58 -0700 (PDT)
Message-ID: <1563979197.11067.11.camel@lca.pw>
Subject: Re: [PATCH] acpica: fix -Wnull-pointer-arithmetic warnings
From:   Qian Cai <cai@lca.pw>
To:     "Moore, Robert" <robert.moore@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "jkim@freebsd.org" <jkim@freebsd.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Jul 2019 10:39:57 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96618DB@ORSMSX110.amr.corp.intel.com>
References: <20190717033807.1207-1-cai@lca.pw>
         <CAKwvOdmPX2DsUawcA0SzaFacjz==ACcfD8yDsbaS4eP4Es=Wzw@mail.gmail.com>
         <73A4565B-837B-4E13-8B72-63F69BF408E7@lca.pw>
         <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661869@ORSMSX110.amr.corp.intel.com>
         <1563975605.11067.8.camel@lca.pw>
         <94F2FBAB4432B54E8AACC7DFDE6C92E3B96618DB@ORSMSX110.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-24 at 14:17 +0000, Moore, Robert wrote:
> 
> -----Original Message-----
> From: Qian Cai [mailto:cai@lca.pw] 
> Sent: Wednesday, July 24, 2019 6:40 AM
> To: Moore, Robert <robert.moore@intel.com>; Nick Desaulniers <ndesaulniers@goo
> gle.com>
> Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Schmauss, Erik <erik.schma
> uss@intel.com>; jkim@freebsd.org; Len Brown <lenb@kernel.org>; linux-acpi@vger
> .kernel.org; devel@acpica.org; clang-built-linux <clang-built-linux@googlegrou
> ps.com>; LKML <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] acpica: fix -Wnull-pointer-arithmetic warnings
> 
> On Tue, 2019-07-23 at 20:49 +0000, Moore, Robert wrote:
> > > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > > ---
> > > > include/acpi/actypes.h | 4 ++--
> > > > 1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index
> > > > ad6892a24015..25b4a32da177 100644
> > > > --- a/include/acpi/actypes.h
> > > > +++ b/include/acpi/actypes.h
> > > > @@ -500,13 +500,13 @@ typedef u64 acpi_integer;
> > > > 
> > > > #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) 
> > > > (p)) #define ACPI_CAST_INDIRECT_PTR(t, p)    ((t **) 
> > > > (acpi_uintptr_t) (p)) -#define ACPI_ADD_PTR(t, a, b)           
> > > > ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
> > > > +#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (a) +
> > > > (acpi_size)(b))
> > 
> > We have some questions concerning this change. If (a) is not cast to a 
> > u8, the addition will be in whatever units are appropriate for (a) 
> > i.e., the type of (a). However, we want ACPI_ADD_PTR (And 
> > ACPI_SUB_PTR) to simply perform a byte addition or subtraction - thus 
> > the cast to u8. I believe that is the original thinking behind the macros.
> 
> I posted a v2 a while ago, and should clear this concern.
> 
> OK then this change only affects ACPI_TO_POINTER?
> 
> +#define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, i)

Yes.

> 
> 
> > 
> > > > #define ACPI_SUB_PTR(t, a, b)           ACPI_CAST_PTR (t, 
> > > > (ACPI_CAST_PTR (u8, (a)) - (acpi_size)(b))) #define 
> > > > ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8,
> > > > (a)) - ACPI_CAST_PTR (u8, (b))))
> > > > 
> > > > /* Pointer/Integer type conversions */
> > > > 
> > > > -#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void 
> > > > *) 0,
> > > > (acpi_size) (i))
> > > > +#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, 0,
> > > > (acpi_size) (i))
> > > 
> > > IIUC, these are adding `i` to NULL (or (void*)0)? X + 0 == X ?
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> > 
> > 
