Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B85C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5144021734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qiy+Yf7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgAFHvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:51:52 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41842 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFHvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:51:52 -0500
Received: by mail-pf1-f201.google.com with SMTP id x18so27936009pfo.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 23:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qas2eq1ihBigEPLC5lEK4tlkBkvo0M4yUxxYSt69jQM=;
        b=Qiy+Yf7yEHo892zN2/olTIIWe0NbHumBXuD3J/GB6wv/bmep/Kc6t0sOisPCWJGIeU
         URm44MY5fEv/c0ewhGjIRPUw6744OBA7XVlJBlS0mzQk45YyvdZJ9+VWCmPH66zEp/kw
         LkAV8GCdS+5JdjIWqME3TGVJEJIsSVacEGhOEIh0fThsLQODTzPo8IxU/z0xH5897mmI
         EIAbs1rAil0rLZJmrTfCuC6xMUErkZYOl/KOqtozXDOLvRtdJ6ABbNSHKCQiFKD3xrT0
         XMN6IuaIkND8zo0WvvZJYIi9jAyZeTIyykLbQk1N4+bHxhYl0UovZTOrC6dsdnNVwAIw
         9bBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qas2eq1ihBigEPLC5lEK4tlkBkvo0M4yUxxYSt69jQM=;
        b=mz5S/D3WCoyg3ftAv6LyqBuCzYa1p3suFkMj9jR0/d2WFBem0U0XBhop5HrP+HKa14
         2ALIWNGNAfDn55svpCismSyo04EZqORPj42A44QuTW0LjLfSRGpf5vHLM1BHJR9Smv5i
         crD6lQ7iGjC7Bamf3h5UPa262vPNWmw6zppgG/3dSsyzzIjQECs0pxAgnEOU44IQfhre
         1mcaJzk+07NWhvKxC1kGG7oGw/QSMz9AM0LuQ6vRPOlShApPGJkEqBIjHrCDxOLBYcQr
         ZmH2ar+H/oSBz4hbKudXgGIh5DtQ0Gy/+Lke+slCxxypgyyfk72yriMVwN48YNZ/uD2z
         ujlg==
X-Gm-Message-State: APjAAAUguZ2mCzki0RBaxd15R06VeID/O4MbpUV1TSBx2B1yM5fGlVVM
        vHACHUBWNR70r3NBQcOMAcTj2vwgvPgF
X-Google-Smtp-Source: APXvYqyVgMALN7tkwXRbRHotd5HIacbmp4O3cPGx0HtwE/C/jnAb9BAuCOEwT6wxFYR+t5QjsU0gRLD4c/dj
X-Received: by 2002:a63:4282:: with SMTP id p124mr106018455pga.155.1578297111170;
 Sun, 05 Jan 2020 23:51:51 -0800 (PST)
Date:   Sun, 05 Jan 2020 23:51:48 -0800
In-Reply-To: <20200104150238.19834-9-masahiroy@kernel.org>
Message-Id: <xr93a7716mzv.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20200104150238.19834-1-masahiroy@kernel.org> <20200104150238.19834-9-masahiroy@kernel.org>
Subject: Re: [PATCH v2 08/13] initramfs: specify $(src)/gen_initramfs.sh as a
 prerequisite in Makefile
From:   Greg Thelen <gthelen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> wrote:

> Specify the dependency directly in the Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Greg Thelen <gthelen@google.com>
