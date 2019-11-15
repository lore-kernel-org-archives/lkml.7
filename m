Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CC7C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DF320706
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573788035;
	bh=PiIS7yZbS9fEJm3OF/jynPajFSd2cFJT194PH0QlBWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RLqRMvzyl7WV0l3m/4iHcqbFJe9IOahu39BYTOgAm5bEFwmUfxlHcrPrFYErAO/+3
	 zo64Q2LEUD0WpTdENPtlqziY1ZwaEYoZa8X7oZxszY10wNLXNjsz8W/rdP/4m57y/V
	 Mj1OY0my1KoUrs1DYW4tXq55Ac+dUq+VIgPIpuIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfKODUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 22:20:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfKODUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 22:20:33 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEBA5206F4;
        Fri, 15 Nov 2019 03:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573788033;
        bh=PiIS7yZbS9fEJm3OF/jynPajFSd2cFJT194PH0QlBWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fKC/RQgwC7siUSag2RQgnJu+dgSU2VictpP0hSTbuf4pd3iVsuNtjQ34ue5Hl0ah9
         RFm8uTwWp4JsK2Elkbq3JlaMAxLFK71zwNEGDcjI4NHV4UPA3dBVgaZTaEYXEoznAA
         6bHYx4ahAGFmuaJgiY1gI9JnSfjm7EgYwdJfBYF8=
Date:   Fri, 15 Nov 2019 11:20:30 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Felipe Balbi <balbi@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH 1/1] usb: gadget: add raw-gadget interface
Message-ID: <20191115032030.GB793701@kroah.com>
References: <cover.1573236684.git.andreyknvl@google.com>
 <282c5da077ad53ce4e5ff9b4350bbf62b33bb6a9.1573236684.git.andreyknvl@google.com>
 <20191108211745.GA1282512@kroah.com>
 <CAAeHK+w-nB4MngSNhazkZAa-Ovdu1C45HaD6XCPoJ79qRo8keQ@mail.gmail.com>
 <CAAeHK+y1O39gX5wDtF2j4jzpqKT8Z2c6cCHnZrh4hGWTS2Y65w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+y1O39gX5wDtF2j4jzpqKT8Z2c6cCHnZrh4hGWTS2Y65w@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 04:33:56PM +0100, Andrey Konovalov wrote:
> On Thu, Nov 14, 2019 at 4:08 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > On Fri, Nov 8, 2019 at 10:17 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > > +static void gadget_reset(struct usb_gadget *gadget)
> > > > +{
> > > > +     pr_debug("ignoring\n");
> > > > +}
> > >
> > > I think you don't even need functions for these, right?  If not, just
> > > remove.  If you do, we should fix the gadget core to not require them :)
> >
> > Will do in v2.
> 
> Actually, I just hit that Dummy HCD/UDC requires a disconnect callback
> to be present. And I assume other UDCs might do the same, so I'd
> rather include the callbacks just in case. WDYT?

If they require it to be present then yes, leave all of these.

thanks,

greg k-h
