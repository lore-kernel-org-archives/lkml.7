Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B12C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC61206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggKewme8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfCZAiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:38:24 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51884 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfCZAiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:38:23 -0400
Received: by mail-it1-f195.google.com with SMTP id e24so16934460itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPFcO/E0+04cgg8r2G+LaaIoJHN1RftgmR0rilCvvGI=;
        b=ggKewme8pwCcQlqbJgVAc1WM0ojxcdndr8sFQjWW2PFGLLP6eLq4Nd+rOmOKU/zDgp
         dHYfX6RWEsWqgYu8E1ZfRWybzTiEscgTZXDSXapFb6fLh5Nklc/NdVtf07wwdLT4HsdT
         Aenwq1arAG/ubWo4gOVfOk5lxiojZfdJ7VZXJJZmxX25AZd5lQLIVspVstDxMHpRExzz
         JBEaxYfApb4DydPsMnqQbmV/xdAsk/8V72CZh/kmiJz/0y6wJqghlQ70LEjeF1Aom/8e
         oR5YAMiD4rqf24DVCoMWTPnSH0sgtwRNHOS+Evn78GT5kqXyVHOUT58SRplygsgm75JW
         0+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPFcO/E0+04cgg8r2G+LaaIoJHN1RftgmR0rilCvvGI=;
        b=YykVOiD/gbuolWkfPRe7vYSVvdZMpPfftGWeZbTl8Ty6TvUJWQCZAJqZQwIkTtXedD
         SiSdjfeuS/b+533V5phJYglZ41LZrcunM/WiylJ6oX1Ku38mceucIxTOKUx7Rq/FtihO
         h1OV88zMUN/GpHSEFc92+fzUb2q/Tscn7MZD55/ppw4DYlNjh//utj3PqUfCWYvuDR79
         diFCsrPIJ2YKkDtzbJsxkknK4bD6thsywzYT717OjFcxBzEy8d7IFPdENrSssIJ6+M95
         w5uJLoRaTk4iPgIH8hBAUUnqu0/T+vUQWUJiZU7OFVF9ilPZRf+ipG4+lNr0sv1KJ8bA
         ayTw==
X-Gm-Message-State: APjAAAXX4dcgdCmSs5RLlVsCidMiTxqADObh/WbaimvObWewe7gSmPkm
        8GGwRrhxdw8F/GW4c0KnzpX9K5HqVxBWWq4dM5jlNQ==
X-Google-Smtp-Source: APXvYqz1N4SQGyCASuRxfppij0p3w3HM77ABuvHWNgG7+0hIGXaZAwAZ1bjUYRW7L8lbMUv6BZUEocp2CxPKFqwsR8E=
X-Received: by 2002:a24:4e91:: with SMTP id r139mr6552606ita.118.1553560702121;
 Mon, 25 Mar 2019 17:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
 <20190325220954.29054-26-matthewgarrett@google.com> <20190326003137.GB5112@kroah.com>
In-Reply-To: <20190326003137.GB5112@kroah.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 25 Mar 2019 17:38:09 -0700
Message-ID: <CACdnJus6a_7VUR27K7dJE037b3TPwDNMh1AyAOptHepB18vjxw@mail.gmail.com>
Subject: Re: [PATCH 25/27] debugfs: Restrict debugfs when the kernel is locked down
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 5:35 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Mar 25, 2019 at 03:09:52PM -0700, Matthew Garrett wrote:
> > Normal device interaction should be done through configfs, sysfs or a
> > miscdev, not debugfs.
>
> Then why not just not allow debugfs at all if it is such a "big
> problem"?

Previous attempts to do so have resulted in strong pushback from
various maintainers. If you're happy just having any complaints
reassigned to you then I'm more than happy to turn it off entirely.
