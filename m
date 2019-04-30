Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A583C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC04120854
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WPBSwm2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfD3SOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:14:37 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33866 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfD3SOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:14:35 -0400
Received: by mail-yw1-f65.google.com with SMTP id u14so6622480ywe.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 11:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bse4S0Z7lUf/SmcUVMhmxnkZgM+H7sFlIuWL16fY2hs=;
        b=WPBSwm2V0oeuI+bplyqdGWE4RLVzulE0noF0etJZsE7TZccsrAjKH1+fPUa8IBFj1/
         3RZeVujhrkl2FmoxDwgroiXOjcRApCnE+Uuqqt7EOlLxPbIkJOWvOF8rWeR6XIPlKW9g
         eckn6b7lehgVJ0wG5jRpqcZ8GWsxzBmROvb8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bse4S0Z7lUf/SmcUVMhmxnkZgM+H7sFlIuWL16fY2hs=;
        b=FEo7Q7RyAdTBMXMAmp2GeinjjAe9iokJfStrB/wSmjULz/Xji+Vo2t3TCZuCWyeNZn
         fOQlc2ZDoLTVIJr4o+Km7r0KMAZbCm8DMufMGV7svLN4jcAnElBf8XqBaorvH/LLF+AN
         7vUGL712XUzaX+DZmCqfNPa08fs9Ut1SPXWDKJimdfTzgYZ2xKxyDuZmQ2hgS0c78ZM8
         elQHylhkOAWyIagr/wiCu2oBw2GToz0z3MU33lo3u8Dd19DnKpRT3BvV0vKbWp8ymUBJ
         +ThLxj8cyB+H5Gwtaj7tXU70X32m1wlSy2QYdD0mfMl7ZAWxy2JDQA2ZdU7GpdDtL3w2
         gtww==
X-Gm-Message-State: APjAAAVXYUF5LPX/vPSYku78G6kTVWr4cU4cBIfG9RGc2P0+11gZ265V
        pQjT95pRkpQ/8iMdR0oHf060PurZ3LE=
X-Google-Smtp-Source: APXvYqy5Y6qNysychzSqFM+aYK+Y7gPSjjTwazT+mxW6TKCDtFyzELTZGe/fSoGz0Tzm8BQaaUrTWA==
X-Received: by 2002:a25:e757:: with SMTP id e84mr54721906ybh.259.1556648074623;
        Tue, 30 Apr 2019 11:14:34 -0700 (PDT)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id a67sm20126953ywh.36.2019.04.30.11.14.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 11:14:33 -0700 (PDT)
Received: by mail-yw1-f54.google.com with SMTP id q11so6627901ywb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 11:14:33 -0700 (PDT)
X-Received: by 2002:a81:2e08:: with SMTP id u8mr52020872ywu.55.1556648072989;
 Tue, 30 Apr 2019 11:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190430180111.10688-1-mcroce@redhat.com>
In-Reply-To: <20190430180111.10688-1-mcroce@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Apr 2019 11:14:20 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJG1D6YvTaSY3hpB8_APmwe=rGn8FkyAfCGuQZ3O2j1Yg@mail.gmail.com>
Message-ID: <CAGXu5jJG1D6YvTaSY3hpB8_APmwe=rGn8FkyAfCGuQZ3O2j1Yg@mail.gmail.com>
Subject: Re: [PATCH v5] proc/sysctl: add shared variables for range check
To:     Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 11:01 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> In the sysctl code the proc_dointvec_minmax() function is often used to
> validate the user supplied value between an allowed range. This function
> uses the extra1 and extra2 members from struct ctl_table as minimum and
> maximum allowed value.
>
> On sysctl handler declaration, in every source file there are some readonly
> variables containing just an integer which address is assigned to the
> extra1 and extra2 members, so the sysctl range is enforced.
>
> The special values 0, 1 and INT_MAX are very often used as range boundary,
> leading duplication of variables like zero=0, one=1, int_max=INT_MAX in
> different source files:
>
>     $ git grep -E '\.extra[12].*&(zero|one|int_max)\b' |wc -l
>     248
>
> Add a const int array containing the most commonly used values,
> some macros to refer more easily to the correct array member,
> and use them instead of creating a local one for every object file.
>
> This is the bloat-o-meter output comparing the old and new binary
> compiled with the default Fedora config:
>
>     # scripts/bloat-o-meter -d vmlinux.o.old vmlinux.o
>     add/remove: 2/2 grow/shrink: 0/2 up/down: 24/-188 (-164)
>     Data                                         old     new   delta
>     sysctl_vals                                    -      12     +12
>     __kstrtab_sysctl_vals                          -      12     +12
>     max                                           14      10      -4
>     int_max                                       16       -     -16
>     one                                           68       -     -68
>     zero                                         128      28    -100
>     Total: Before=20583249, After=20583085, chg -0.00%
>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
