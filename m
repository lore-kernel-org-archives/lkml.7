Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FF8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB5920883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554845693;
	bh=3Rn/tLNFiLmHFC8vgadLzksy1JdM3dfI4xofu9xTBuY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PQaXZ7bIyYkic3gZL9VpOXapRJACJVxGd5ynX475/rV0wUcOboowsn/R9MeJLUT4m
	 uzTk3ptcfKjYkjHt1fHXAS9I0lYUjqI3HJsnrWGIgVXkLe+w1wp78i2Qk5EirZLjZF
	 JVFpaoUb32c+z5u+LCxntWxgLrh0ESjwpU+MMqaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDIVew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:34:52 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:36664 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfDIVew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:34:52 -0400
Received: by mail-oi1-f172.google.com with SMTP id l203so14905079oia.3;
        Tue, 09 Apr 2019 14:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCj8/Jh2lzAX/ifQOqTmL3TNG1QpFM+KmxMgxpaY2b0=;
        b=USsq/KkjoobeKX8bzvlZhwc0sw5lgrNbgDFOHtpRFkH0Hwbxdd9LjzQxLohdilM9DL
         5k6tPC9KPfTaxIMznNwkqVSVCC9knTpNpNFhzbUTKN7/p+N5NYbTe029+7HFv+W3nlNf
         al7w0onkk3TMXE4EBkVcj5MGpqC/KNxD+38Q/vd9JrtRnDDCVd5zGWEjlA+VF/Dr8LTd
         +8B08gqwVpjMJY/3YixFE68rA3FiHgsEqHmVmVGKw0M4rrxT9aAQ1saewCjpjA786sSf
         eUOvHeM5FykTXZdXhFVVmztMXbKI8jGr3qIlaoli73ysJOTOwqFQwR8PinY4QKBKuNy0
         OXIQ==
X-Gm-Message-State: APjAAAXyy+cZaiYSDKvcCCshOF726MbxS//6Q69bqE+zKSPLDiDePGKm
        19KqzACGokytJp/jh/RsWqnJ+3coALhTTmtH2Jo=
X-Google-Smtp-Source: APXvYqxRtIOamILXpNgWHGXCVRFM6O+kD1ULGS7OydC1r8bpiYBolDJQxNbp3mn7Z9hAlrw6cnhouXOuS33l2Af2t00=
X-Received: by 2002:aca:8d3:: with SMTP id 202mr356699oii.76.1554845691361;
 Tue, 09 Apr 2019 14:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190406181704.33574-1-cai@lca.pw> <CAJZ5v0jxUn_Hhm21FFBc2eSp49kCciCzR1_UGewHkpJiTy3LGw@mail.gmail.com>
 <1554816309.26196.46.camel@lca.pw> <CAJZ5v0g_oLdqv_sp8Un-44wO6vtQH6rVeUTKxSynO8VPPascxA@mail.gmail.com>
 <1554823996.26196.48.camel@lca.pw>
In-Reply-To: <1554823996.26196.48.camel@lca.pw>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Apr 2019 23:34:40 +0200
Message-ID: <CAJZ5v0jSutxp0jadaj3d2rR+2i4xX7BHaf6g0o_UDQ4-decw8g@mail.gmail.com>
Subject: Re: [PATCH -next] acpi/hmat: fix memory leaks in hmat_init()
To:     Qian Cai <cai@lca.pw>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 5:33 PM Qian Cai <cai@lca.pw> wrote:
>
> On Tue, 2019-04-09 at 16:54 +0200, Rafael J. Wysocki wrote:
> > Fewer jumps are easier to follow in general, so avoiding ones that can
> > be avoided is helpful.
> >
> > I'm not buying the argument about more code line changes needed if the
> > function name changes.  It's meaningless.
> >
> > And if you check the return value of acpi_get_table() for SRAT after
> > calling acpi_put_table(tbl), you will only need the out_free label, if
> > I'm not mistaken.
>
> I don't really understand this.

Sorry, I didn't have the original code in front of me when I was
writing my reply.

I was thinking about checking the return value of
acpi_table_parse_entries() after calling acpi_put_table(tbl).  Then,
if it returns an error, you only need to call hmat_free_structures().

Similarly, if acpi_get_table(ACPI_SIG_HMAT, 0, &tbl) returns an error,
you only need to call hmat_free_structures().

But I didn't remember the other jumps to out_put.

Still, since it is valid to pass NULL to acpi_put_table(), you can
jump to out_put if acpi_get_table(ACPI_SIG_HMAT, 0, &tbl) returns an
error too.
