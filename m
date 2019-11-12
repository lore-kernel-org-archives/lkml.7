Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74667C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5A92067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K16IxrZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKLWCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:02:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKLWCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7jAEbZsBzv3PFISvUcPFIFd7joU8uP8zZrxP8zk/r9M=; b=K16IxrZqUhqYgrANYfZo7ZnoD
        feYnXP9G733dvNL6/NsO3XGUkXqkNGRgGIRqKsPy38+Ued5nKS4GIFDNZhC5X7kAhq241K5uLSzHK
        cgqa7pAgkjuTVkfuyHdgHl3AawqxRhEQX5mFdKogL4n85ZBuXblzmmuSVRmEYCaReEhQTYtkVqdh/
        Ewg8hdV2JRyXaUqsBSBGiEGssfnGsfoTfpjqrwty7p9wEM50oTuSkQY1OZAoQUW87W5Xy7Ftm7fMf
        3W7ntvKrQMgeDFRIyqugl/z8IxQ0C895lbV5qQ3zgU+6Y7kbuGXRR3YjWZ73FpjOpGuU/AxrFAImg
        NseFvGxSA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUeEm-0001EA-GF; Tue, 12 Nov 2019 22:02:12 +0000
Date:   Tue, 12 Nov 2019 14:02:12 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>
Subject: Re: DAX filesystem support on ARMv8
Message-ID: <20191112220212.GC7934@bombadil.infradead.org>
References: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
 <CAPcyv4j75cQ4dSqyKGuioyyf0O9r0BG0TjFgv+w=64gLah5z6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j75cQ4dSqyKGuioyyf0O9r0BG0TjFgv+w=64gLah5z6w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 09:15:18AM -0800, Dan Williams wrote:
> On Mon, Nov 11, 2019 at 6:12 PM Bharat Kumar Gogada <bharatku@xilinx.com> wrote:
> >
> > Hi All,
> >
> > As per Documentation/filesystems/dax.txt
> >
> > The DAX code does not work correctly on architectures which have virtually
> > mapped caches such as ARM, MIPS and SPARC.
> >
> > Can anyone please shed light on dax filesystem issue w.r.t ARM architecture ?
> 
> The concern is VIVT caches since the kernel will want to flush pmem
> addresses with different virtual addresses than what userspace is
> using. As far as I know, ARMv8 has VIPT caches, so should not have an
> issue. Willy initially wrote those restrictions, but I am assuming
> that the concern was managing the caches in the presence of virtual
> aliases.

The kernel will also access data at different virtual addresses from
userspace.  So VIVT CPUs will be mmap/read/write incoherent, as well as
being flush incoherent.
