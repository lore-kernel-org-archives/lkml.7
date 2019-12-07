Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C34C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 01:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BBA2064B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 01:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575681068;
	bh=FXf6f0LodJ3g4NUoj/Ba5RlgD5YItBl5ZUrjmyza25k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G5zrwTfcPQpGc8zuidjyHwoEwMu8MrmdILg8MHX+iUSZfSx89MY1/ggrIpqcYY22L
	 pHdG9f79MSRFZXPOL+n1d6kcB9wkOpcD6y4WuhS2+3ZHPkRACoBoDALfZSnaa0eZlh
	 in8Jx2MvZe8wW5ZJxDkFof5IS1gGhfNgv26Kzr9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfLGBLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 20:11:07 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40355 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfLGBLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 20:11:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id y5so6611465lfy.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 17:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xp39wpo5AR+pbRP/tZoeRSZICS3SHzWRMfhJEvbxIGA=;
        b=F9QgFlzOLVDvV/NH9kO5C38Tw6X+Hr1zV9nvDrPtaW9IdmdHU1TNQTmWgtmr08QLWs
         m/LzPoUZk/NRRXSGyCni67pyjPAjI1csctIc4AcmS9vEoOX/8bco5LDaWzkI+5Pvvxsm
         tA5h/kF2wpsxbPSmFh84K3eYpHR4dbqT6qkZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xp39wpo5AR+pbRP/tZoeRSZICS3SHzWRMfhJEvbxIGA=;
        b=YWYwj70CJOFyxtYhS+ZirIEDoURs8mfevWfhrtvsbDnugmx7gaEF8f/qOMX96osNHs
         DVqtkrWOHW3IXUJ85b5AP1mIhoEjAsq/jztuntqJr/vtZsyuElrPMm9A6c9bKzUTSBN8
         D9hsjIrBGUQBG5FmkmMOui0VEBG1K8KR6z8DFwggXxgYP4Cwv5ahq8ZltmQ16vfhVs+b
         JyyfMy++bIhhhM4bzrHlZyGxjWX9dJL7zcHtU3gzSijShMZTAKm4Kft4gOWfmnk5tvH8
         5GnOXlKBMeWihPVavwQ2yv7Vk+NYxT5Ja7qfvgfSq6GbPSi8Uz8RptNVSDx/pmwV+w/e
         62Bg==
X-Gm-Message-State: APjAAAXzJyANT3+JVx/f1oCFsKsxeRhvK7m8GIwO9iLFauxzMDImXQjf
        4VyGOMDyCv+43p6VBsBg5ku0ehkR5Lc=
X-Google-Smtp-Source: APXvYqwzW9+QGbgqtTK8dyBglEsOMB/W7PYsPEqrIugTZ0WJZnnLBBv4qlhfpd8XEYEDuwH64qQhEw==
X-Received: by 2002:a19:c205:: with SMTP id l5mr9348330lfc.159.1575681064502;
        Fri, 06 Dec 2019 17:11:04 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id q12sm7289078ljc.74.2019.12.06.17.11.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 17:11:04 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id r14so6618181lfm.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 17:11:03 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr9400181lfk.52.1575680636244;
 Fri, 06 Dec 2019 17:03:56 -0800 (PST)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
 <20191206214725.GA2108@latitude> <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
 <20191207000015.GA1757@latitude>
In-Reply-To: <20191207000015.GA1757@latitude>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 17:03:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjEa5oNcQ9+9fai1Awqktf+hzz_HZmChi8HZJWcL62+Cw@mail.gmail.com>
Message-ID: <CAHk-=wjEa5oNcQ9+9fai1Awqktf+hzz_HZmChi8HZJWcL62+Cw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 4:00 PM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> Tested with 5.4.0-11505-g347f56fb3890 and still the same wrong behavior.

Ok, we'll continue looking.

That said, your version string is strange.

Commit 347f56fb3890 should be  "v5.4.0-13174-g347f56fb3890", the fact
that you have "11505" confuses me.

The hash is what matters, but I wonder what is going on that you have
the commit count in that version string so wrong.

                   Linus
