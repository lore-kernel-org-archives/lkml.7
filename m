Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5AAC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 11:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686F1208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 11:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556365791;
	bh=micoXllDruCvx3gGFlYFaFNFGyDXOM8yAbo6P5dAYeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=x6LMLAD6QU52M3kpC98VnQETuxhpZ1N/oj/HTT87TTo6MfBiuAcSfiJ5nCJUG+tOa
	 PQWkMMjYMYvwdvMmA2d73HpRLQ/N4xxYsmjrsM2dYN1qIlOv5q5P/EhrAeoTLz3tna
	 hFzc+fsGCKJdj7gn0PtJKdaJ7QgzclGhKWddeqwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfD0Ltu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 07:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfD0Ltu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 07:49:50 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33845208C2;
        Sat, 27 Apr 2019 11:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556365789;
        bh=micoXllDruCvx3gGFlYFaFNFGyDXOM8yAbo6P5dAYeA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2ExrCDaIak/HJASR4XsuGCZUxmgJS5UwpMQutPER+NyybPzWgCbu0qLe3JM0MXvw1
         oxi3Lu3fHqi6q9JBVOwLjmYMmjvWk2b18k4RtrnQ0RLej+twdB4Ti+SWXkaLKv40SH
         rhgpe21hzpDVCz0661W77VP0ANZaJNy08E0aipxk=
Date:   Sat, 27 Apr 2019 12:49:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, akpm@linux-foundation.org,
        david@lechnology.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, thierry.reding@gmail.com, esben@haabendal.dk,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patrick.havelange@essensium.com, linux-api@vger.kernel.org
Subject: Re: [PATCH v10 00/18] Introduce the Counter subsystem
Message-ID: <20190427124937.1a9920ea@archlinux>
In-Reply-To: <20190425193624.GA11240@kroah.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
        <20190407152550.451a7f63@archlinux>
        <20190425193624.GA11240@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 21:36:24 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Apr 07, 2019 at 03:25:50PM +0100, Jonathan Cameron wrote:
> > On Tue,  2 Apr 2019 15:30:35 +0900
> > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >   
> > > Changes in v10:
> > >   - Fix minor typographical errors in documentation
> > >   - Merge the FlexTimer Module Quadrature decoder counter driver patches
> > > 
> > > This revision is functionally identical to the last; changes in this
> > > version were made to fix minor typos in the documentation files and also
> > > to pull in the new FTM quadrature decoder counter driver.
> > > 
> > > The Generic Counter API has been and is still in a feature freeze until
> > > it is merged into the mainline. The following features will be
> > > investigated after the merge: interrupt support for counter devices, and
> > > a character device interface for low-latency applications.  
> > 
> > Hi William / al,
> > 
> > So the question is how to move this forwards?  I'm happy with how it turned
> > out and the existing drivers we had in IIO are a lot cleaner under
> > the counter subsystem (other than the backwards compatibility for those that
> > ever existed in IIO).  For those  not following closely the situation is:  
> 
> I've now sucked this into my staging-testing branch and if 0-day is fine
> with it, I'll merge it to staging-next in a day or so.  This way you can
> build on it for any iio drivers that might be coming.

Great thanks. 

> 
> I do have reservations about that one sysfs file that is multi-line, and
> I think it will come to bite you in the end over time, so I reserve the
> right to say "I told you so" when that happens...
> 
> But, I don't have a better answer for it now, so don't really worry
> about it :)
> 
> thanks,
> 
> greg k-h

Looks like a few late breaking comments came in, but nothing that can't
be fixed up before this reaches a release.

Thanks,

Jonathan


