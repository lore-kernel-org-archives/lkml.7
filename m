Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62289C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37360205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561654286;
	bh=ZJeG6e/5ex7Oi3+NrkGCaYVu2coSPS31gk3u5jQWWjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=boZ7y7XPKcWLYhZpJjmJ1SXywqRdXEIF5z9k74Uw2KbgXXFP2p+XMb/ZlYy06CWgU
	 z2EzZ5RLA3H4BNL7vZuAW+aJV+anT3+ge7d8cCzrmIRQvHxFeARnqwWmWbp+KwakD0
	 HMLOLG4Fb8bpX/0SA0DJyh/6hqz7lfHoE28zs3kM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfF0QvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfF0QvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:51:24 -0400
Received: from localhost (unknown [89.205.136.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89D8C2054F;
        Thu, 27 Jun 2019 16:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561654283;
        bh=ZJeG6e/5ex7Oi3+NrkGCaYVu2coSPS31gk3u5jQWWjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZ148xhhRuY36EaSXlOq2p/UuE2/te/REcS9lHEb28ZfBZTo1mpl3owe357ai8X+g
         dMqgFdvIOf4atRjO1kkZ0Ze2AabPXt4HhkDiO1d16DWrBC6Md2kCSJOOd/tEoUzLqT
         LKgTrlyB/AduI6aU7BnoiU6rwCqmu2NvJCH7m6oQ=
Date:   Fri, 28 Jun 2019 00:51:16 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] powerpc/powernv: remove unused NPU DMA code
Message-ID: <20190627165116.GA9855@kroah.com>
References: <20190625145239.2759-1-hch@lst.de>
 <20190625145239.2759-4-hch@lst.de>
 <7bde96e0-7bc5-d5fe-f151-52c29660633c@ozlabs.ru>
 <20190626074935.GA25452@lst.de>
 <027a5095-a22c-2799-8ff6-42d0bc4d2bc9@ozlabs.ru>
 <20190627072240.GA9916@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627072240.GA9916@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 09:22:40AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 27, 2019 at 10:21:55AM +1000, Alexey Kardashevskiy wrote:
> > > Which comment?  Last time I asked you complaint "it is still used in
> > > exactly the same way as before" which you later clarified that you
> > > have a hidden out of tree user somewhere, and you only objected to
> > 
> > It is not hidden, anyone can download and inspect that GPL driver.
> 
> For one no one has ever posted a link.  And second as mentioned
> countless times it doesn't matter, it only matters if it is in mainline,
> or as a special exception actively trying to go mainline.
> 
> > > the word "dead".  That has been fixed and there were no further
> > > comments.
> > 
> > You still have it in the cover letter so at very least 3/4 is not a part
> > of this patchset then.
> > 
> > And I still want to see a formal statement about out-of-tree drivers
> > support/tolerance. If you manage to remove this code, I'll have to post
> > a revert (again and again) but I would rather know the exact list of
> > what we do and what we do not do about such drivers and if the list 1)
> > exists 2) is reasonable then I could try to come up with a better
> > solution or point others to the policy and push them to do the right
> > thing. Right now it is just you pretending that the nVidia driver does
> > not exist, this is not helping. Thanks,
> 
> We had that discussion at kernel summit and it was reported.  Anyway,
> adding Greg, who usually has some pretty good prewritten letters for
> this kind of thing.

I used to have one but it's been so long since anyone tried to even
think about defending the removal of functions that are not used in the
kernel tree anymore, that I can't seem to find it anymore :)

Christoph is completely correct here, if it isn't in the tree, it
doesn't matter.  We have made this "formal" statement again and again
over the years, starting with the old "stable api nonsense" document
that is in the kernel tree itself.

And he is also correct in that we talked about this specific issue, in
detail, at the maintainers summit last year, see lwn.net for the details
if you somehow missed it then.

thanks,

greg k-h
