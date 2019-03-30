Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EE3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65202085A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbfC3Q1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:27:38 -0400
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:44058 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730537AbfC3Q1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:27:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id BA11E182CF671;
        Sat, 30 Mar 2019 16:27:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: doll98_24fd9dbeda04f
X-Filterd-Recvd-Size: 2414
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Mar 2019 16:27:34 +0000 (UTC)
Message-ID: <e2d8ab93c97acf1254830e6f51edb8f19c8767d6.camel@perches.com>
Subject: Re: [PATCH v3] HID: intel-ish-hid: ISH firmware loader client driver
From:   Joe Perches <joe@perches.com>
To:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Nick Crews <ncrews@chromium.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        benjamin.tissoires@redhat.com, jikos@kernel.org,
        jettrink@chromium.org, Gwendal Grignou <gwendal@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Date:   Sat, 30 Mar 2019 09:27:32 -0700
In-Reply-To: <20190330102230.GB19202@intel.com>
References: <1553889813-17677-1-git-send-email-rushikesh.s.kadam@intel.com>
         <CAHX4x85jFVYhOpRCKfvhYEqhXFwpKaK3_5gEit1EMaXY3L4Z4g@mail.gmail.com>
         <20190330102230.GB19202@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-03-30 at 15:52 +0530, Rushikesh S Kadam wrote:
> On Fri, Mar 29, 2019 at 04:30:18PM -0700, Nick Crews wrote:
> > On Fri, Mar 29, 2019 at 1:03 PM Rushikesh S Kadam
> > <rushikesh.s.kadam@intel.com> wrote:
> > > +       ldr_xfer_ipc_frag = kzalloc(LOADER_SHIM_IPC_BUF_SIZE, GFP_KERNEL);
> > > +       if (!ldr_xfer_ipc_frag) {
> > Log error here.
> The error code is logged in calling function
> load_fw_from_host(). Is that good enough?
> 
> I believe the checkpatch script too, would
> recommend against adding debug print for ENOMEM
> error.

The generic kernel allocation functions already do
a dump_stack() on OOM conditions when called without
__GFP_NOWARN so any additional OOM message isn't
particularly useful.

> Again, I thought it was against practise to log
> "out of memory" debug prints in probe()

Or anywhere else given the generic OOM stack dump.

> But will add if you tell me this is the right way.
> 
> > > +               return -ENOMEM;
> > > +
> > > +       loader_ishtp_cl = ishtp_cl_allocate(cl_device);
> > > +       if (!loader_ishtp_cl)
> > 
> > log error here

The ishtp_cl_allocate function just calls kmalloc then
initializes the struct so an additional OOM message
isn't useful here either.


