Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ACCFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F20B20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571239934;
	bh=n2NOvEYEqv4lSGUyIJF666vrlhz9L9BzoevNrWqRz9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=s6tYGbzWfz6p5QYWw5yV/Na+yUVX9gsPdnk+AM+jjMsNOcGzBnEZWhhSKF2J+0wmJ
	 pJBhSD/Dz2MNQ2t6svMdgTz/AoMAlle4BW/Ff3/zWt+3oCXwVLmRxGP4vZPSiQ9ETn
	 QylDLUq9B8BRQWNw35XU6klgVAKNaoEPkIZuShaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404969AbfJPPcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:32:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38299 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfJPPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:32:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so24510225ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 08:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4sUXBF9N+gOqGoXUSe/0E2VksmAjHdkiv7KSR2ftGI=;
        b=KN++Zn81C01LK7bngv2WQhecCB2pvDWa6MiPOCNK9giCb55GzPd38NprLWCi9y4Rmp
         G5JVpEFhN07gxtvQKkcodZ0c/iin5yb7op+6svXAeHTJxJPM5HZz2LuFX2hGczINIWnp
         zjAlhPJ3IIlR8ZNhwPZ4TPeH42AI6XYGcDMmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4sUXBF9N+gOqGoXUSe/0E2VksmAjHdkiv7KSR2ftGI=;
        b=uHQyc84jtG9yhtaDKwVl/mW0JofwcKsrFKX02nI20lPNpI5IDwJGAVDfgq0AYv2uHI
         5By8Va647NgxI4Jgb/c9fQO++kuUnfG2QDyx0gAR2No13alpkNjUKNR8iTkIam9Zr9iL
         qk7AMTqt36NGYIRf8Bz87QMFH+aWsxIxKASZ/Amek6fcwKiY0lT6tCynNUlBbgrz1TUZ
         iWKCIhJnQbqiqNB88RbCWEZeUWlB7Xp5gSZsQU8kBJFvGK9PN6KkG7wpuhwEcEKlZIPO
         gklHkXRp/J9T0SmcgRcn2DcL2Z4UkZyh3NE4rojyJ/t1I6Oanris5FetdY/qjwCuTpCZ
         fwYQ==
X-Gm-Message-State: APjAAAW5l0Cbm5ijBroJf2UXf8cV6ll+MfTjJ85kzB6hb7l6OsLTCPTr
        bpKaPZ/FVNLBvucqIenNgfcMmaCqEZ0=
X-Google-Smtp-Source: APXvYqxrAubzqBNDQsl5oaMlalW824MhSMd+mIdkg1K3kgr2Bea+40ec8qNw1iQTKiwvWL/FGdl3pA==
X-Received: by 2002:a05:651c:102e:: with SMTP id w14mr19570568ljm.159.1571239929340;
        Wed, 16 Oct 2019 08:32:09 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id m10sm6270932lfo.69.2019.10.16.08.32.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 08:32:06 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id l21so24514031lje.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 08:32:05 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr4189350ljf.133.1571239925218;
 Wed, 16 Oct 2019 08:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
 <157117608708.15019.1998141309054662114.stgit@warthog.procyon.org.uk>
 <CAHk-=whiz1sHXu8SVZKEC2dup=r5JMrftPtEt6ff9Ea8dyH8yQ@mail.gmail.com> <6900.1571235985@warthog.procyon.org.uk>
In-Reply-To: <6900.1571235985@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Oct 2019 08:31:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMZR8TWpmRBPytGmWJX=C=-bCb5D2PsCx0LUNemAPexA@mail.gmail.com>
Message-ID: <CAHk-=wgMZR8TWpmRBPytGmWJX=C=-bCb5D2PsCx0LUNemAPexA@mail.gmail.com>
Subject: Re: [RFC PATCH 02/21] Add a prelocked wake-up
To:     David Howells <dhowells@redhat.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Wed, Oct 16, 2019 at 7:26 AM David Howells <dhowells@redhat.com> wrote:
>
> Btw, is there any point in __wake_up_sync_key() taking a nr_exclusive
> argument since it clears WF_SYNC if nr_exclusive != 1 and doesn't make sense
> to be >1 anyway.

Ack, looks sane to me.

We have _very_ few users of nr_exclusive. I wonder if it's even worth
having at all, but it's definitely not worth it here.

I'd love for nr_exclusive to go away and be replaced by WF_ALL
instead. Right now it looks like there is one SGI driver that uses it,
and the sbitmap code. That was all I could find.

Oh well. You removing one case is at last a small amount of progress.

         Linus
