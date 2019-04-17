Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3621EC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24D0217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owTlK4dN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbfDQUfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:35:41 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40585 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQUfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:35:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id x12so28929118qts.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y0gSZC3e7v+zRMrjxF2iOu0LhIl2hIx8oHSYnJB5xqg=;
        b=owTlK4dNJjULEmoT55/pbtslDWiUsJk+2UOEYT+aduC7VxJXwit5Va6kn8aTy7S94C
         4Z2MvYaTaidkSfubQ696DUpZkhsPaZqWZKl9t7hua3yFqc8xFH306G7wkEUx1zWsmXFl
         unq6iNIMM3Oh6aHmI0dZ9EbHVDsW3y0Soe2Vvz6QeAy4OI/TkvqvBETcY/xVlDAXB+h3
         4rvxJ8jYBXNGRCju01ZX5hfN0vKVXlokyJTJ3wrp1esixjwbRKYtt0YcU+hYevwirSkn
         n8vcKaQi90EHUyfdUYKkbpbn4oxu/gaUIKtQO5nU2oeduV1G0k1oa6lhzzcCJuyHn9BE
         4uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y0gSZC3e7v+zRMrjxF2iOu0LhIl2hIx8oHSYnJB5xqg=;
        b=UONahPjV5RJ6cmO1O9tI8EglDBB1iuFmXpKBMZywO2x8pJHH4fKkIBAq+6CF5UvqG9
         Ac1Rn+DzeWzAUQZFMklmDYiGrzC3N7XEaaykHoaJuK9QPOecwecOn6yJXbmO/QXzshqj
         /hLvmIxU6Pe4Fre5PuN8f5/pTcVSxIvKi6QKfdU9KeokACii+ODGqKYNUe3/JhzxsZ1c
         DF3Te7NNsKkda7x7cbH899RZo7ueJNv6W/7KbGIcoac+uz5Alc5bFrUAGxCbHSPKwjF7
         l/ylPyifPBerU0SrDSfvNpz5B+R7oxwjkYGs/Jq/UBcerKi1oC0gTz99vuzwO8CZF5lh
         Ye2w==
X-Gm-Message-State: APjAAAUGAMc5a5lexHVGP4JWVi2NAC8060ljknWF81U3S3J4+BEQS30s
        ci//VFmrYUJc8ZjNrhDrDhWAuBE=
X-Google-Smtp-Source: APXvYqwrnGz9iPSvV4ozbpRxHKuKTijUUpg8gUXy7dv0zWMg9U7Tei2lmhsFpywHMrI6CHOPH/2lUg==
X-Received: by 2002:ac8:2b83:: with SMTP id m3mr75227372qtm.305.1555533340292;
        Wed, 17 Apr 2019 13:35:40 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x5sm28024224qki.26.2019.04.17.13.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 13:35:39 -0700 (PDT)
Date:   Wed, 17 Apr 2019 16:35:33 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ktest: Add support for meta characters in GRUB_MENU
Message-ID: <20190417203532.3hcj5onuhbxpeuz4@gabell>
References: <20190417201114.14839-1-msys.mizuma@gmail.com>
 <20190417161739.7046d028@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417161739.7046d028@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:17:39PM -0400, Steven Rostedt wrote:
> On Wed, 17 Apr 2019 16:11:14 -0400
> Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> 
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > ktest fails if meta characters are in GRUB_MENU, for example
> > GRUB_MENU = 'Fedora (test)'
> > 
> 
> Thanks for the patch! One little nit below though.
> 
> > The failure happens because the meta characters are not escaped,
> > so the menu doesn't match in any entries in GRUB_FILE.
> > 
> > Use quotameta() to escape the meta characters.
> > 
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > ---
> >  tools/testing/ktest/ktest.pl | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> > index 87af8a68ab25..ea07d43856b8 100755
> > --- a/tools/testing/ktest/ktest.pl
> > +++ b/tools/testing/ktest/ktest.pl
> > @@ -1866,9 +1866,10 @@ sub get_grub2_index {
> >  	or dodie "unable to get $grub_file";
> >  
> >      my $found = 0;
> > +    my $_grub_menu = quotemeta($grub_menu);
> 
> I'd like to avoid names that start with underscore. Could you call this:
> 
>   $grub_menu_qt
> 
> or something similar, to be a bit more descriptive of what the variable
> is.

Thank you for your review! I'll fix it and post the v2.

Thanks!
Masa
