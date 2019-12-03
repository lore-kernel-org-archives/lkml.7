Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F61C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDA020640
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575362464;
	bh=xNXnJQMqxsoMv7LLaUi0i2Vx2d7CHjbfF+XyAr5UNpk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rhhEJtjnafEZWWmx82e83f8ECL9MKnU1z1gWXtgYR5ZfQFOTqeDmwHfBMrTMTVrUW
	 6kMltzReN8WCm0OEvub24FYUBkqFkKEcOnTca6HOP0swdvHf1WJehU8TDY+RKvfyz1
	 XV6cpn0AkHBMCWl7dQ8MX20h+IqWfAaG0gEi5AgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfLCIlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:41:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfLCIlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:41:03 -0500
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F316F206DF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2019 08:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575362462;
        bh=xNXnJQMqxsoMv7LLaUi0i2Vx2d7CHjbfF+XyAr5UNpk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nsKyqEW1GpkfYJMMDx/Ca9z+dwFg0Oef8NTJGyCHGlF5uZGoZ51gQPswVkQ9cg7ma
         6V/Rl+lRsqWk5gQH8lqNfA62jKFMdG8N/ysX6ojc2XihD4w8DRylicaKLdh0JhI9wK
         5C8ta1GFhhbmI9+6qGmYCkxfT3X9lepTwF3q2Ts0=
Received: by mail-lj1-f176.google.com with SMTP id j6so2822591lja.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 00:41:01 -0800 (PST)
X-Gm-Message-State: APjAAAV9NMW6HbzRglz5bBZ0EbfxcUGArdI8VmMbHCCiuE5gLJQlP+AD
        OSjVfT/H0/tSm1XjxWpuCK2CFUkVpzSARd7nhmA=
X-Google-Smtp-Source: APXvYqzBXp6dwlc5mHUlmWK4YfCHWiu1mg0M2AAq7fhngtn6OVEIiUUGc/raSEzmPaHAzMTOKyQjyLzDf69bpqvh6hQ=
X-Received: by 2002:a2e:9d9a:: with SMTP id c26mr1828903ljj.225.1575362460172;
 Tue, 03 Dec 2019 00:41:00 -0800 (PST)
MIME-Version: 1.0
References: <1574906800-19901-1-git-send-email-krzk@kernel.org>
 <87a78gnyaz.fsf@intel.com> <ab3309596fac1c5a0cb4e0abed0cf1ee7ac13a3d.camel@perches.com>
In-Reply-To: <ab3309596fac1c5a0cb4e0abed0cf1ee7ac13a3d.camel@perches.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 3 Dec 2019 16:40:48 +0800
X-Gmail-Original-Message-ID: <CAJKOXPdqn7+ucwqu2vJFL9ggCerpBz1qN6BSJvcsi4BQ3DU6fg@mail.gmail.com>
Message-ID: <CAJKOXPdqn7+ucwqu2vJFL9ggCerpBz1qN6BSJvcsi4BQ3DU6fg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Look for Kconfig indentation errors
To:     Joe Perches <joe@perches.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019 at 17:35, Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-11-28 at 11:29 +0200, Jani Nikula wrote:
> > On Thu, 28 Nov 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > Kconfig should be indented with one tab for first level and tab+2 spaces
> > > for second level.  There are many mixups of this so add a checkpatch
> > > rule.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > I agree unifying the indentation is nice, and without something like
> > this it'll start bitrotting before Krzysztof's done fixing them all... I
> > think there's been quite a few fixes merged lately.
> >
> > I approve of the idea, but I'm clueless about the implementation.
>
> I think that a grammar, or a least an array of words
> that are supposed to start on a tab should be used here.

This won't work for wrong indentation of help text. This is quite
popular Kconfig indentation violation so worth checking. I can then
check for:
1. any white-space violations before array of Kconfig words - that
2. spaces mixed with tab before any text,
3. just spaces before any text,
4. tab + wrong number of spaces before any text.

It would look like:
+               if ($realfile =~ /Kconfig/ &&
+                   (($rawline =~
/^\+\s+(?:config|menuconfig|choice|endchoice|if|endif|menu|endmenu|source|bool|tristate|prompt|help|---help---|depends|select)\b/
&&
+                     $rawline !~ /^\+\t[a-z-]/) ||
+                    $rawline =~ /^\+\t* +\t+ *[a-zA-Z0-9-]/ ||
+                    $rawline =~ /^\+\t( |   )[a-zA-Z0-9-]/)) {

Best regards,
Krzysztof
