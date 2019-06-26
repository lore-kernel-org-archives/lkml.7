Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830D2C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A5621726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561587684;
	bh=Tqz80iJYZg/0GvkxSfm5luZWdZskDvCbYXS8JM/P41M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B32GAnxKaD2hn3TAzTAU0byYE+v0xGPOltwSCKlRulDIEsy6xWqR+75qQyS8bZmcB
	 mf07/ViLIrH8extPVEX3GEe5Is4ItJif/YubFyXLG/xoWE/rmZ37rIZbCBOK38Ccam
	 HseP786fFAJutbXEeIM9qepVR2aeL7MyBEKBhVM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfFZWVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfFZWVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:21:22 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6062E217F4;
        Wed, 26 Jun 2019 22:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561587681;
        bh=Tqz80iJYZg/0GvkxSfm5luZWdZskDvCbYXS8JM/P41M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rDRINPrARYm4y0gTMKieViIBMlqLk3pfnXd5IX5+U0eQmw2kxZF/3a0rjGwTKySrr
         MG1EkmO5tV9AOiFnuzSNFhgmLZRPX99sIh0nZcKUbjTRMX2v8nLdVYLvrDGOSexOcf
         VzU/Ol9q0oq/agucEG8UfeMFWJQg7/Cf8EnIwDDE=
Received: by mail-vs1-f46.google.com with SMTP id m8so295376vsj.0;
        Wed, 26 Jun 2019 15:21:21 -0700 (PDT)
X-Gm-Message-State: APjAAAUS0Mjo4O9cnmerQYbEoyhNKyz/m996M3Xge9mPWJqt49RZqZoi
        8HXd7IpwPcD6RvKZLSeqdvvqz6WzOX3CMMOc6rU=
X-Google-Smtp-Source: APXvYqxiURrS3kYi96trsVNlLi7NqOcM8326ys8JoB7UHyO3AYKMXjoykeMiQXetdNc9DXfJMTI9H3ax6sGVyKS63kE=
X-Received: by 2002:a67:1143:: with SMTP id 64mr472922vsr.133.1561587680499;
 Wed, 26 Jun 2019 15:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <20160818175505.GM3296@wotan.suse.de> <20160825074313.GC18622@lst.de>
 <20160825201919.GE3296@wotan.suse.de> <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
In-Reply-To: <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Wed, 26 Jun 2019 15:21:08 -0700
X-Gmail-Original-Message-ID: <CAB=NE6XEnZ1uH2nidRbn6myvdQJ+vArpTTT6iSJebUmyfdaLcQ@mail.gmail.com>
Message-ID: <CAB=NE6XEnZ1uH2nidRbn6myvdQJ+vArpTTT6iSJebUmyfdaLcQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Add CONFIG symbol as module attribute
To:     Christoph Hellwig <hch@lst.de>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Cristina Moraru <cristina.moraru09@gmail.com>,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <mmarek@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        backports@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Bolle <pebolle@tiscali.nl>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Tejun Heo <tj@kernel.org>,
        Jej B <James.Bottomley@hansenpartnership.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Daniel Jonsson <danijons@student.chalmers.se>,
        Andrzej Wasowski <wasowski@itu.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 2:07 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> In lieu of no Luke Skywalker, if you will, for a large kconfig revamp
> on this, I'm inclined to believe *at least* having some kconfig_symb
> exposed for some modules is better than nothing. Christoph are you
> totally opposed to this effort until we get a non-reverse engineered
> effort in place? It just seems like an extraordinary amount of work
> and I'm not quite sure who's volunteering to do it.
>
> Other stakeholders may benefit from at least having some config -->
> module mapping for now. Not just backports or building slimmer
> kernels.

Christoph, *poke*

  Luis
