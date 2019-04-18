Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5E3C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D69F2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUvVKmob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfDRX6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:58:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34763 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfDRX6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 19:58:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so1876220plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 16:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sU+dkTNcZ80jwL9xre61U9X22J/tQZYN7nSc1/Vcvro=;
        b=HUvVKmob5OgyCcuwu5O4fZ3mIHu4eosFjS1HKsRAKz7acPgKp0YDYY5Fh4MtRdeUBn
         bWL082LVXjvcFcJoeNZC1x0CQ9G6DthHPqkr50GHlHHhJzzM+jZtnfrFu/7pNSavwAEY
         TAshiDI9Gpnttsrknb4Qbs4QSefBgLXEMHLZtZYR6fOu/3koC017CY/WrjKZlLtEYsa/
         Y/FMRv+UoO5jNVYAO0eHS0zS8vyGKsLNuRtU2pknNHi8qCY8MW6sLScZzjS6F6Zi/Xj8
         A4P0eqNB33ZmMxwg6gKVXUE+ZhdkL1p9ZblXsWC6nraE7To8K3B2FgH0UxXHniTgB0kT
         M88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sU+dkTNcZ80jwL9xre61U9X22J/tQZYN7nSc1/Vcvro=;
        b=Cc2nm2nwuo5AuamubP+kHR7fTUpmRRPEEDaNZdMrfFHJIwZaGregpfwLUzrjAG4AOh
         xLxjsT5gC225bNvJkKJUq5XlIzZd4OnjqVP6wlT+nW/TkC+q5jS1DnUspBFaDllDJH2S
         Ms24qXMhANfnTlFjj6TCL2ChxFECiLNqY2aTsUH07m6wsFcaFoo3Vr5VoxZSLEDYjx8b
         k9s26Xkf7YH7eSICImQErVijDY+fmbIowARWvYDhe+/xvCyB9HUGHglNWzhvI3XfBXTg
         W+lfeIJsNVXFkLzTZNgN1cgG54Q/VsBJOJ1Q1d3kosv9VqKs8AGjZtRYm1LRzOc/x09g
         Ehnw==
X-Gm-Message-State: APjAAAXAktzWtlXcFGN0322XhyutQiP4VFLKK+mLWIqm2g1hDQwQcfNu
        AqU5C+YqeL05aZX7YV7ISIzie41i/zpsGjiSeikKHd+h
X-Google-Smtp-Source: APXvYqyv6SLkzPGBIrOTjNaCDgjNxG+NsJGonueL5M5UEbTEW92jcV4Lh7ERKhjZw2w6VrYrT/YXCXMMo0sLnXk1mPk=
X-Received: by 2002:a17:902:f094:: with SMTP id go20mr478615plb.159.1555631914576;
 Thu, 18 Apr 2019 16:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190418220229.32133-1-tony.luck@intel.com> <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic>
In-Reply-To: <20190418232910.GR27160@zn.tnic>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 18 Apr 2019 16:58:22 -0700
Message-ID: <CAM_iQpVWvg-U6hzKsCPXdObiwKJhQ=BkGDDeP+p671cCWK7QFA@mail.gmail.com>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 4:29 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Apr 18, 2019 at 03:51:07PM -0700, Cong Wang wrote:
> > On Thu, Apr 18, 2019 at 3:02 PM Tony Luck <tony.luck@intel.com> wrote:
> > >
> > > Useful when running error injection tests that want to
> > > see all of the MCi_(STATUS|ADDR|MISC) data via /dev/mcelog.
> > >
> > > Signed-off-by: Tony Luck <tony.luck@intel.com>
> >
> > We saw the same problem, CONFIG_RAS hijacks all the
> > correctable memory errors, which leaves mcelog "broken"
> > silently. I know it is arguable, but until we can switch from
> > mcelog to rasdaemon, mcelog should still work as before.
>
> It is "arguable" because this is not how the CEC is supposed to be used.

No, it is all about whether we should break users' expectation.

>
> If you want to collect errors with mcelog, you don't use the CEC at all.
> And there's ras=cec_disable for that or you simply don't enable it in
> your .config.
>
> As Tony says in the commit message, the enable should be used only for
> injection tests. Which is where that thing should only be used for -
> debugging the CEC itself.

This doesn't sounds like a valid reason for us to break users'
expectation.

Prior to CONFIG_RAS, mcelog just works fine for users (at least Intel
users). Suddenly after enabling CONFIG_RAS in kernel, mcelog will
no longer receive any correctable memory errors _silently_. What's
more, we don't even have rasdaemon running in our system, so there is
no consumer of RAS CEC, these errors just simply disappear from
users' expected place.

I know CONFIG_RAS is new feature supposed to replace MCELOG,
but they can co-exist in kernel config, which means mcelog should
continue to work as before until it gets fully replaced.

Even the following PoC change could make this situation better,
because with this change when we enable CONFIG_RAS,mcelog
will break _loudly_ rather than just silently, users will notice mcelog
is no longer supported and will look for its alternative choice.

diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index b834ff555188..f2e2b75fffbe 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -1,5 +1,6 @@
 menuconfig RAS
        bool "Reliability, Availability and Serviceability (RAS) features"
+       depends on !X86_MCELOG_LEGACY
        help
          Reliability, availability and serviceability (RAS) is a computer
          hardware engineering term. Computers designed with higher levels


Just my 2 cents.

Thanks.
