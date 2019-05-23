Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2141C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 03:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7155220673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 03:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P6dAJzkr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MTQCPFe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfEWDuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 23:50:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58332 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfEWDuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 23:50:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 673AC607C3; Thu, 23 May 2019 03:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558583402;
        bh=Hrr/PtP34IJ2Z7aiXFVzZQp9WZiRECimfmz68C6xDyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P6dAJzkreK0A4OhMbsOZBw3zWV8by0C0/zoxpH9DyRE9yxfyIZzSHbeA4AyitwEyO
         B2gpo+ZVxRcQWOXH9Bx7O45aKdfRs27gHgYfvv1W/sX3aeIHHFJb/cFLgbLIjd4tMg
         R8jW6nRGZqAAvKeegm69tbKB2Jf1JCxZShkhHmEY=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EF566025A;
        Thu, 23 May 2019 03:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558583401;
        bh=Hrr/PtP34IJ2Z7aiXFVzZQp9WZiRECimfmz68C6xDyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MTQCPFe1tKOYi39hkVr4OJ6GVlKGOWoH04qTUR+MgZW5iYuM5YKe1R/2RFEhLTJO6
         tBmsbE5GuwbMXKeslIixBz2WnpLv08eoBG9bDrjGcsgdULGMeQyxz1gODc14INZFUr
         RLb+s3PsrCuMpW8mzNMwSWutfYIGUBprV4b9pjuc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EF566025A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Thu, 23 May 2019 09:19:56 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Joel Becker <jlbec@evilplan.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] configfs: Fix use-after-free when accessing
 sd->s_dentry
Message-ID: <20190523034956.GA10043@codeaurora.org>
References: <1546514295-24818-1-git-send-email-stummala@codeaurora.org>
 <20190131032011.GC7308@codeaurora.org>
 <0081e5c8083f5ed9f1c1e9b456739728@codeaurora.org>
 <20190517082312.GA13457@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517082312.GA13457@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 10:23:12AM +0200, Christoph Hellwig wrote:
> On Thu, May 16, 2019 at 06:27:53PM +0530, stummala@codeaurora.org wrote:
> > Hi Christoph, Al,
> >
> > Can you please consider this patch for merging?
> 
> I've been sitting on this for a while, mostly because I can't convince
> myself it is safe.  What protects other threads from using ->s_dentry
> just when we clear it?  Also why would sd->s_dentry == dentry ever be
> false?

Thanks Christoph for getting back on this.
I will try to find answers to your queries and get back on this.

Besides, Al Viro reviewed this patch [1] and commented that fix looks
good. Hence, I was following up to get this merged as I thought it
must be a miss to not pick it up :)

[1] - https://lkml.org/lkml/2019/1/3/47

Thanks,
Sahitya.

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
