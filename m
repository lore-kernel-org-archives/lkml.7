Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EFDC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03B92190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="GFq+S6tS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfGXNkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:40:09 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46031 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfGXNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:40:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so33768203qkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5XZ9K/SwxKdddKyC7k0SqQ29rr6lzsU+b9jBDeXxEMs=;
        b=GFq+S6tSW8wwIf68Zbp/TAZ8HwcvghPgo5lr601U6nGjYYLU4vUEoK8MiMlLTogQeQ
         aqQwsqTVuzqYmqBLXu+koBwO1c914nYOScc6gEaaKY/yZT3LkLOc/GEqr96Sod+QEDg2
         PW7wUg7bT8yYKBnB6bAM3cLanp5IODh+LnSokpOEak5aND0qZJrhkFKk1rdUOshFHDRG
         DYbNeLQV4cuix1guUVumwX3vX+OrmHjY+Ff+tbP3heoLVLaEtVYLiDwSkjP80XfZLnGL
         wDQWGxbQrMbozIzW+SP/iXxGwMlld9WyuaEf1kef6lM292fuY5ToZdDvi8lOJvAWlR9j
         1OJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5XZ9K/SwxKdddKyC7k0SqQ29rr6lzsU+b9jBDeXxEMs=;
        b=iQ0EW0EltfxZYH0CO6jBOZ/rnKXb9zc/uaysWCp6fwyiJlei8PSgLz05BRorqMLCNQ
         d6h1+WmU9V6SpaLTNawxnH5DiNi5hszCekD0GunvetMl26lY8JfuLH8cL/rCj2eEZC5j
         oYSft5NCFZeYGF2lW1Ulvp1FyTv80iQQzIs1o7iDOXfKUDdu+sEMVipwJ7iJ+918VHzV
         BTU5faFYjM0nY3pFNqSxVfBY8WJbnDUE6OebsgaoeiYBbxAtc/EucgyYQqDCjKVd/G+i
         GhjpzQa4LtKMHp4bP6DMuP9ojn8JFC0AqOc9O7F7sUiSuyoJebCqh8N2WLlQ0MoKN8/S
         IQaQ==
X-Gm-Message-State: APjAAAUsUsQMThhh4FZtB6z07+vtAqNlpjE45ap/auS8Fsh2CKPVb+V3
        o5wP0gw+7uI6+A9AQxj0r57CQQ==
X-Google-Smtp-Source: APXvYqzUVvLNfaBc8+WcDpyR5QEO2g6mbdd9uJSw4aZ3wmPrlXd92pON1JtRJLfphbEp7hMfagnfXw==
X-Received: by 2002:a37:484a:: with SMTP id v71mr53222506qka.29.1563975607570;
        Wed, 24 Jul 2019 06:40:07 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f133sm22561094qke.62.2019.07.24.06.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 06:40:06 -0700 (PDT)
Message-ID: <1563975605.11067.8.camel@lca.pw>
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
Date:   Wed, 24 Jul 2019 09:40:05 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661869@ORSMSX110.amr.corp.intel.com>
References: <20190717033807.1207-1-cai@lca.pw>
         <CAKwvOdmPX2DsUawcA0SzaFacjz==ACcfD8yDsbaS4eP4Es=Wzw@mail.gmail.com>
         <73A4565B-837B-4E13-8B72-63F69BF408E7@lca.pw>
         <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661869@ORSMSX110.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 20:49 +0000, Moore, Robert wrote:
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > ---
> > > include/acpi/actypes.h | 4 ++--
> > > 1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index 
> > > ad6892a24015..25b4a32da177 100644
> > > --- a/include/acpi/actypes.h
> > > +++ b/include/acpi/actypes.h
> > > @@ -500,13 +500,13 @@ typedef u64 acpi_integer;
> > > 
> > > #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
> > > #define ACPI_CAST_INDIRECT_PTR(t, p)    ((t **) (acpi_uintptr_t) (p))
> > > -#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR
> > > (u8, (a)) + (acpi_size)(b)))
> > > +#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (a) +
> > > (acpi_size)(b))
> 
> We have some questions concerning this change. If (a) is not cast to a u8, the
> addition will be in whatever units are appropriate for (a) i.e., the type of
> (a). However, we want ACPI_ADD_PTR (And ACPI_SUB_PTR) to simply perform a byte
> addition or subtraction - thus the cast to u8. I believe that is the original
> thinking behind the macros.

I posted a v2 a while ago, and should clear this concern.

> 
> > > #define ACPI_SUB_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR
> > > (u8, (a)) - (acpi_size)(b)))
> > > #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8,
> > > (a)) - ACPI_CAST_PTR (u8, (b))))
> > > 
> > > /* Pointer/Integer type conversions */
> > > 
> > > -#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0,
> > > (acpi_size) (i))
> > > +#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, 0,
> > > (acpi_size) (i))
> > 
> > IIUC, these are adding `i` to NULL (or (void*)0)? X + 0 == X ?
> > --
> > Thanks,
> > ~Nick Desaulniers
> 
> 
