Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C0CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3439C20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552333928;
	bh=FzJoP1PVVRpZOsc1uYb0nG6enormz8Z92EO3g29jX18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sm6iEXE11jpLlFvMj7qf1upCY72LURNOaO0zjcz8VSiofDJBaRyxUshuLR0cuctWt
	 eHfdE+TNJFPLQiGkBTsRjm5A8M6HdSsRGifuAEbhcdcTGs8cqT2qmUjeuMs+mzqYGI
	 cePUzGwzKv75KhxL6UbgKL+VS7wt5wABzUpjcylI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfCKTwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:52:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:6585 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbfCKTwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:52:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 12:52:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="281718711"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 11 Mar 2019 12:52:05 -0700
Date:   Mon, 11 Mar 2019 13:52:44 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv7 07/10] acpi/hmat: Register processor domain to its
 memory
Message-ID: <20190311195244.GF10411@localhost.localdomain>
References: <20190227225038.20438-1-keith.busch@intel.com>
 <20190227225038.20438-8-keith.busch@intel.com>
 <20190311112041.000015ba@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311112041.000015ba@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 11:20:41AM +0000, Jonathan Cameron wrote:
> On Wed, 27 Feb 2019 15:50:35 -0700
> Keith Busch <keith.busch@intel.com> wrote:
> > +static __init void hmat_register_target_initiators(struct memory_target *target)
> > +{
> > +	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
> > +	struct memory_initiator *initiator;
> > +	unsigned int mem_nid, cpu_nid;
> > +	struct memory_locality *loc = NULL;
> > +	u32 best = 0;
> > +	int i;
> > +
> (upshot of the below is I removed this test :)
> > +	if (target->processor_pxm == PXM_INVAL)
> > +		return;
> 
> This doesn't look right.  We check first if it is invalid  and return....

Yeah, Brice mentioned the same bug. I must have been mistakenly
reintroduced that when I rebased to linux-next. I also have a test case
for this and recall it was working at one point. I've got it fixed up
now for the next revision.
