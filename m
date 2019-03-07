Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3BDC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF48D20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551992110;
	bh=Z8ExJUXfOihxLauWUj9aMlmQzss/q/n71+IPpaYmzJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gMQkgDl91PS29L2ouwA5bSTNgbgWJPZ4bmcQhIbsfHQnOcI8cGLPFYgQIcNwKoDeo
	 y4l3efPUTxaOn00Cej/AAG/hOVxFJjaU9hQpahPRHzT+RmSBhgyLS6Ye6Fl/YFlpgk
	 +dDjrVQse/i58Oaz/G02VQwh0KMAUL7CUXLGZs+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfCGUzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:55:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfCGUzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:55:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1BE720684;
        Thu,  7 Mar 2019 20:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551992107;
        bh=Z8ExJUXfOihxLauWUj9aMlmQzss/q/n71+IPpaYmzJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=znI9BTlOoRGBn9f8JaFDuausGFCjHPcefx+jgvBgUPGPZlFz+hNvUVdPHVDpu9fyN
         owr8HjpcYI1O0UuUWZORmem9xXzT4yMDD0NuRF6GK1hjDJEvgwp0eK8CDQyoKH5TzP
         YB8Ta3uz+MMbKUcULyL57CzQZxalfixN/p1Nsspk=
Date:   Thu, 7 Mar 2019 21:55:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Daniel Colascione <dancol@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atish patra <atishp04@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
Message-ID: <20190307205505.GB30028@kroah.com>
References: <20190119232503.GA149403@google.com>
 <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
 <20190120155838.GA23827@google.com>
 <20190306230944.GB7915@amd>
 <CAKOZuetOePf89cXRkvmWeGnvG7zYN=SW1yyrZibuyOqZQFTGkg@mail.gmail.com>
 <754146f0-8b57-8644-81c1-528b5ca7dba1@zytor.com>
 <CAKOZuesjYZ2EH=BHBAJAFFaTOHjWU7BELJUV3QC9cjXVB2HhUw@mail.gmail.com>
 <0c46ab5f-8bd6-6916-fc4a-b6f00d456011@metux.net>
 <CAKOZuevksKGAPif_pUYVzFpbuBCxOZ5WzT6ukLCYm4TzyLUTMw@mail.gmail.com>
 <5ebec282-57b0-6ebe-0876-ce0dd7b0c11c@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ebec282-57b0-6ebe-0876-ce0dd7b0c11c@metux.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 09:41:24PM +0100, Enrico Weigelt, metux IT consult wrote:
> On 07.03.19 02:49, Daniel Colascione wrote:
> 
> > Entirely FS-less operation is uncommon, granted. :-) I guess I've just
> > spent too much time debugging emulators that refuse to mount their> root filesystems. :-)
> 
> Fix these emulators ?
> 
> > There are legitimate reasons why a device's> filesystems might not be rw-mountable though, and I can imagine a
> > world where I want to attach tracing tools *very* early.
> 
> Ok, but the filesystem where the modules live is mountable, right ?
> 
> > Sure. There's some support for a ramdisk already in fastboot. But just
> > including a blob in initrd doesn't *automatically* make it available
> > to userspace in any uniform way. With Joel's approach --- which> defines both a propagation mechanism and an access interface --- we
> 
> I can define such an interface with a few words:
> 
> * the kernel headers lives in a (compressed) squashfs image in the
>   module directory for the corresponding kernel version:
>       /lib/modules/<version>-<flavour>/headers.img"
> * this image shall be mounted at a canonical mountpoint, eg:
>       /usr/src/linux-headers-<version>-<flavour>
> * the kernel needs to support squashfs (may be module or built-in)
> 
> That's it. I don't need to touch a single line of kernel code for that,
> just a very simple and small convention.

Ick, no, no more squashfs please, let's just kill that mess once and for
all :)

Again, putting this in a simple compressed tar image allows anyone to do
whatever they need to with this.  If they want a full filesystem,
uncompress it and use it there.  If they just want it in-memory where
they can uncompress it and then discard it, that works too.

And if no one wants this, just don't select the config option and do not
load the module with this data in it.  Just like /proc/config.gz is
today.

thanks,

greg k-h
