Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D34C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D973820645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5bgSuFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfFXTyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:54:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35582 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfFXTyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:54:12 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so1043719ioo.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCg/MjFmfZjibFv1+zfjJ/08w0AqICIa/H9ziec7kII=;
        b=T5bgSuFF2J0SClg2TX96KcIkt8PMoAR1G3u6wAV9ZlHT11IjSJBWqyLCR87fxH+c29
         LTufoMIaOaS5RzlQZdhwIhVGqFpXAIChtxNsI8BWjtM0tF2pFRYeHCKuLi5czhKl6iw/
         Kh4t45FA7uaBdu+cxYKWG6S4qqD66Wb7/01m2fvDCCMbfZCFA4qJWtcmCxfFo0R0UJYn
         9RwhYjanjDxnX37mmFLMatT8eDcY+4IhBRCV/7mN+h5oZP/SOk7UlIo3kxh2grH6N1Aq
         nB2By88uwy0THJJ3z/Iol2KMXK0mq8grrgUkxODb07Yba6xPmycLbGleHl0GH6KQvt/o
         4a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCg/MjFmfZjibFv1+zfjJ/08w0AqICIa/H9ziec7kII=;
        b=S3dd33qtYDW8vQE0qiwqA2sjgbwhBMs8yrFV1dvMhg8yne2SRqN5R2WXrjA16tdqdh
         VtyMcnpVP61ufaH95WUGsVEq//Y71VypSZSfCoWhpuS12lTcFW529Tse9cfISTU7esUo
         PbeYS9gL9qeLBnxcvQ1NujXvYI5ZgxHLsFESmbaINavjoIsG2VOuQsn5UC7055Dp/3W9
         AjkGdrMCvgBi8BkBJ13zxSogn0zQq93s23s8Bt+mL2ynPWrSqdrRk4TbwtwYXkbHGbKk
         Gujx04JbztJWCkSzalS5jhJ5jZxDcabsKSBfFKKUHqFOs+2JjKM/zo4HAqetJhpcjsnt
         0tJA==
X-Gm-Message-State: APjAAAVYvgOBxQ5ghQCGv7sNyFyKKetq6yhdsHsR8/w4LKIkI0y+GCYg
        0LIqRpdayg9/yEUphaKQQVDHSf4OrQLjavOCsMW41A==
X-Google-Smtp-Source: APXvYqyFU7p5SRJ6nKCqIZqMdeK3zYkp5IdfxuzZhylp6PCqxOOHmnAokMWRrX7K9YZRQdLi+tIxlDW1HYKDsttAmXA=
X-Received: by 2002:a05:6638:3d3:: with SMTP id r19mr30442055jaq.53.1561406051539;
 Mon, 24 Jun 2019 12:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-24-matthewgarrett@google.com> <739e21b5-9559-d588-3542-bf0bc81de1b2@iogearbox.net>
In-Reply-To: <739e21b5-9559-d588-3542-bf0bc81de1b2@iogearbox.net>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 24 Jun 2019 12:54:00 -0700
Message-ID: <CACdnJuvR2bn3y3fYzg06GWXXgAGjgED2Dfa5g0oAwJ28qCCqBg@mail.gmail.com>
Subject: Re: [PATCH V34 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>, Jann Horn <jannh@google.com>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 8:37 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 06/22/2019 02:03 AM, Matthew Garrett wrote:
> > From: David Howells <dhowells@redhat.com>
> >
> > There are some bpf functions can be used to read kernel memory:
>
> Nit: that

Fixed.

> > bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
>
> Please explain how bpf_probe_write_user reads kernel memory ... ?!

Ha.

> > private keys in kernel memory (e.g. the hibernation image signing key) to
> > be read by an eBPF program and kernel memory to be altered without
>
> ... and while we're at it, also how they allow "kernel memory to be
> altered without restriction". I've been pointing this false statement
> out long ago.

Yup. How's the following description:

    bpf: Restrict bpf when kernel lockdown is in confidentiality mode

    There are some bpf functions that can be used to read kernel memory and
    exfiltrate it to userland: bpf_probe_read, bpf_probe_write_user and
    bpf_trace_printk.  These could be abused to (eg) allow private
keys in kernel
    memory to be leaked. Disable them if the kernel has been locked
down in confidentiality
    mode.

> This whole thing is still buggy as has been pointed out before by
> Jann. For helpers like above and few others below, error conditions
> must clear the buffer ...

Sorry, yes. My fault.
