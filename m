Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BCFC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DBD21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfGSARV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:17:21 -0400
Received: from kanga.kvack.org ([205.233.56.17]:50944 "EHLO kanga.kvack.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfGSARV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:17:21 -0400
X-Greylist: delayed 1256 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jul 2019 20:17:21 EDT
Received: by kanga.kvack.org (Postfix, from userid 63042)
        id 3889F6B0006; Thu, 18 Jul 2019 19:56:16 -0400 (EDT)
Date:   Thu, 18 Jul 2019 19:56:16 -0400
From:   Benjamin LaHaise <ben@communityfibre.ca>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: Support read/write with non-iter file-ops
Message-ID: <20190718235616.GM29731@kvack.org>
References: <20190718231054.8175-1-bjorn.andersson@linaro.org> <20190718231751.GV17978@ZenIV.linux.org.uk> <20190718234352.GN30636@minitux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718234352.GN30636@minitux>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 04:43:52PM -0700, Bjorn Andersson wrote:
> On Thu 18 Jul 16:17 PDT 2019, Al Viro wrote:
> 
> > On Thu, Jul 18, 2019 at 04:10:54PM -0700, Bjorn Andersson wrote:
> > > Implement a wrapper for aio_read()/write() to allow async IO on files
> > > not implementing the iter version of read/write, such as sysfs. This
> > > mimics how readv/writev uses non-iter ops in do_loop_readv_writev().
> > 
> > IDGI.  How would that IO manage to be async?  And what's the point
> > using aio in such situations in the first place?
> 
> The point is that an application using aio to submit io operations on a
> set of files, can use the same mechanism to read/write files that
> happens to be implemented by driver only implementing read/write (not
> read_iter/write_iter) in the registered file_operations struct, such as
> kernfs.
> 
> In this particular case I have a sysfs file that is accessing hardware
> and hence will block for a while and using this patch I can io_submit()
> a write and handle the completion of this in my normal event loop.
> 
> 
> Each individual io operation will be just as synchronous as the current
> iter-based mechanism - for the drivers that implement that.

Just adding the fops is not enough.  I have patches floating around at
Solace that add thread based fallbacks for files that don't have an aio
read / write implementation, but I'm not working on that code any more.
The thread based methods were quite useful in applications that had a need
for using other kernel infrastructure in their main event loops.

		-ben

> Regards,
> Bjorn
> 

-- 
"Thought is the essence of where you are now."
