Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE753C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC7C20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220988;
	bh=lu3Gl4kYfadce26fIqlSb6esx/qPxezHI7oRC8rsMAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R2pgfekDFkZ9QjSeacrgEfu1RJ9Y1NH1jg2QTFUIwr6zkG2U7uqm4ewwrjnqhjEHJ
	 riVOUQkwgU5aoAUWQ6pIBkCsaHMlTONJpIGAeEDVvBBthW3+XCzAX6kbAbGMgZBe1l
	 vjTL6aTyPZpZbGn1WhcLUX7sU2Wds26jjHdploSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfDYTg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYTg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:36:27 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C7FC20685;
        Thu, 25 Apr 2019 19:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556220986;
        bh=lu3Gl4kYfadce26fIqlSb6esx/qPxezHI7oRC8rsMAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsvMmBVwxBQALsyT0vDAx3VN7HQHk3kAjRwyMKrdHkBOhK9SqqE3uxOKfhUqJa9hW
         x6xVDtzRQ1VkRhGae2jwoRGeXYWyEWAExOIbx22QMP80CuKmhBfgNvE2RD85QIXQOg
         G9+Q9mL/kt4jntljf5T1HFETWBNOGXHqgXDEaPi0=
Date:   Thu, 25 Apr 2019 21:36:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
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
Message-ID: <20190425193624.GA11240@kroah.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <20190407152550.451a7f63@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407152550.451a7f63@archlinux>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 03:25:50PM +0100, Jonathan Cameron wrote:
> On Tue,  2 Apr 2019 15:30:35 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
> > Changes in v10:
> >   - Fix minor typographical errors in documentation
> >   - Merge the FlexTimer Module Quadrature decoder counter driver patches
> > 
> > This revision is functionally identical to the last; changes in this
> > version were made to fix minor typos in the documentation files and also
> > to pull in the new FTM quadrature decoder counter driver.
> > 
> > The Generic Counter API has been and is still in a feature freeze until
> > it is merged into the mainline. The following features will be
> > investigated after the merge: interrupt support for counter devices, and
> > a character device interface for low-latency applications.
> 
> Hi William / al,
> 
> So the question is how to move this forwards?  I'm happy with how it turned
> out and the existing drivers we had in IIO are a lot cleaner under
> the counter subsystem (other than the backwards compatibility for those that
> ever existed in IIO).  For those  not following closely the situation is:

I've now sucked this into my staging-testing branch and if 0-day is fine
with it, I'll merge it to staging-next in a day or so.  This way you can
build on it for any iio drivers that might be coming.

I do have reservations about that one sysfs file that is multi-line, and
I think it will come to bite you in the end over time, so I reserve the
right to say "I told you so" when that happens...

But, I don't have a better answer for it now, so don't really worry
about it :)

thanks,

greg k-h
