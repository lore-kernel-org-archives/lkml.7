Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F24C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097F620833
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfDBEWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:22:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:64466 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfDBEWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:22:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 21:22:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,298,1549958400"; 
   d="scan'208";a="219697975"
Received: from rajeev-desktop.iind.intel.com (HELO intel.com) ([10.223.84.39])
  by orsmga001.jf.intel.com with ESMTP; 01 Apr 2019 21:22:38 -0700
Date:   Tue, 2 Apr 2019 09:52:32 +0530
From:   Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
To:     Nick Crews <ncrews@chromium.org>
Cc:     Joe Perches <joe@perches.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        benjamin.tissoires@redhat.com, jikos@kernel.org,
        jettrink@chromium.org, Gwendal Grignou <gwendal@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v3] HID: intel-ish-hid: ISH firmware loader client driver
Message-ID: <20190402042232.GA2736@intel.com>
References: <1553889813-17677-1-git-send-email-rushikesh.s.kadam@intel.com>
 <CAHX4x85jFVYhOpRCKfvhYEqhXFwpKaK3_5gEit1EMaXY3L4Z4g@mail.gmail.com>
 <20190330102230.GB19202@intel.com>
 <e2d8ab93c97acf1254830e6f51edb8f19c8767d6.camel@perches.com>
 <CAHX4x85=Sot62T=DtGPLkyFhudyp=jvxcU_W-oShg8iKTach+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHX4x85=Sot62T=DtGPLkyFhudyp=jvxcU_W-oShg8iKTach+Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick, Joe

thanks for your comments

Regards

Rushikesh

On Mon, Apr 01, 2019 at 03:17:13PM -0600, Nick Crews wrote:
> I tried to send the last message from my phone, and surprise it wasn't
> formatted correctly, so it may have been marked as spam. repeating
> myself again...
> 
> Ah, I guess I was wrong about logging OOM. I hadn’t hear about the
> recommendations against it, but they make sense. Thanks for the
> clarifications!
> 
> On Sat, Mar 30, 2019 at 10:27 AM Joe Perches <joe@perches.com> wrote:
> >
> > On Sat, 2019-03-30 at 15:52 +0530, Rushikesh S Kadam wrote:
> > > On Fri, Mar 29, 2019 at 04:30:18PM -0700, Nick Crews wrote:
> > > > On Fri, Mar 29, 2019 at 1:03 PM Rushikesh S Kadam
> > > > <rushikesh.s.kadam@intel.com> wrote:
> > > > > +       ldr_xfer_ipc_frag = kzalloc(LOADER_SHIM_IPC_BUF_SIZE, GFP_KERNEL);
> > > > > +       if (!ldr_xfer_ipc_frag) {
> > > > Log error here.
> > > The error code is logged in calling function
> > > load_fw_from_host(). Is that good enough?
> > >
> > > I believe the checkpatch script too, would
> > > recommend against adding debug print for ENOMEM
> > > error.
> >
> > The generic kernel allocation functions already do
> > a dump_stack() on OOM conditions when called without
> > __GFP_NOWARN so any additional OOM message isn't
> > particularly useful.
> >
> > > Again, I thought it was against practise to log
> > > "out of memory" debug prints in probe()
> >
> > Or anywhere else given the generic OOM stack dump.
> >
> > > But will add if you tell me this is the right way.
> > >
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       loader_ishtp_cl = ishtp_cl_allocate(cl_device);
> > > > > +       if (!loader_ishtp_cl)
> > > >
> > > > log error here
> >
> > The ishtp_cl_allocate function just calls kmalloc then
> > initializes the struct so an additional OOM message
> > isn't useful here either.
> >
> >

-- 
