Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BE5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BB920823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="VE5YyXLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbfCZNyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:54:49 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:34288 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfCZNyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:54:46 -0400
Date:   Tue, 26 Mar 2019 13:54:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1553608482;
        bh=I8leFMsO3HenGI6y3gSEwRSQNYsaL+xYNOArJrnCBa8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=VE5YyXLwwdQ/jdwmp3i46uspjiatx32IOjjP4Ch/z+IY3VyPp3tq077jFsQ+mwsZB
         7Iidu25AMuJLR1jqEwrbxAyxaF2bYUCcwaAK6NlpKKk/yGURNIOxP5jzWCYNWcmGJM
         GBhknS9fef0Qbyf4QE61EbPitO72vXlm3Ic0b8DE=
To:     Daniel Borkmann <daniel@iogearbox.net>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH 23/27] bpf: Restrict kernel image access functions when the kernel is locked down
Message-ID: <dPp-BlyzEqZTTJfOrFzxSsFZj1eDOH4k4Lx7Qc0DGBdsRXPJHP-K5866dzAoZTvw4-GsBRHc4bfkL2zrajh8-KXWeR2B0pLIy0SIjK0-K5c=@protonmail.ch>
In-Reply-To: <1cfa7345-c807-db76-f50a-ea3ba70f07b2@iogearbox.net>
References: <20190325220954.29054-1-matthewgarrett@google.com>
 <20190325220954.29054-24-matthewgarrett@google.com>
 <20190325164221.5d8687bd@shemminger-XPS-13-9360>
 <1cfa7345-c807-db76-f50a-ea3ba70f07b2@iogearbox.net>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 26, 2019 12:00 AM, Daniel Borkmann <daniel@iogearbox.net>=
 wrote:

> On 03/26/2019 12:42 AM, Stephen Hemminger wrote:
>
> > On Mon, 25 Mar 2019 15:09:50 -0700
> > Matthew Garrett matthewgarrett@google.com wrote:
> >
> > > From: David Howells dhowells@redhat.com
> > > There are some bpf functions can be used to read kernel memory:
> > > bpf_probe_read, bpf_probe_write_user and bpf_trace_printk. These allo=
w
> > > private keys in kernel memory (e.g. the hibernation image signing key=
) to
> > > be read by an eBPF program and kernel memory to be altered without
> > > restriction.
>
> I'm not sure where 'kernel memory to be altered without restriction' come=
s
> from, but it's definitely a wrong statement.
>
> > > Completely prohibit the use of BPF when the kernel is locked down.
>
> In which scenarios will the lock-down mode be used? Mostly niche? I'm ask=
ing
> as this would otherwise break a lot of existing stuff ... I'd prefer you =
find
> a better solution to this than this straight -EPERM rejection.


AFAIK this change breaks IPAddressAllow/IPAddressDeny usage in systemd serv=
ices
which makes them LESS secure.

https://www.freedesktop.org/software/systemd/man/systemd.resource-control.h=
tml
https://github.com/systemd/systemd/blob/04d7ca022843913fba5170c40be07acf2ab=
5902b/README#L96

Jordan
