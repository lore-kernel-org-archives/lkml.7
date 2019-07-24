Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8571DC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A25020665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563980117;
	bh=w7ViP5DmnrEWshJH7D8v+RanQ4AwyI/As/a9dXASa28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1i8LrKlFihA+abEwwdxi9kmqHHYrsJJWvXt99NYywfCymWqAq+2sDriutbpsLQRSP
	 ml9Wz35Tp7EBffgoVckJFVOwTf034SXMX+aGxDju9Ch4ybGQw99jaecS5ckux7/lv2
	 IjeW/tXnpmdiU6iMovkiLlxi0XjkESQNb1QDeH5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfGXOzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:55:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45344 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfGXOzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:55:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id y8so22114806plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 07:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AnMjYMyYNOp0m8tnXIZkBUykehYk+b+OcZJQjrPSv9E=;
        b=rB2BZjJNVQd8+BD+NyoNf+FlZmTry+lgUKxKUiVjSRGCBpRaClYZNIuyL2aY9pN0t6
         S8JsGcnuwPjkvdLXttwi+pOvORYBVH0eCGqhbymvxj4Vd7PGRv+2VGxC4dq3WR7kSZs7
         RmG0EKJglfdBIAGCaGftUr/cWjiyF/qF6jSbTU1SZ+jInhWgCzoEpHnm737Je56GaHka
         7vOsfFlMy3jHZM4BCEUpnzfQLYdziQ8X8lHkKW0wxuifmbCaI/fMGEmBRwj5c7RI+f4D
         egu7X4PAOIXNEz/rhHNK0imKZPUhQFfLYnwa+lrlfWDtojkD8SuJdrL0hUsAL6+Cl833
         a/hA==
X-Gm-Message-State: APjAAAVeHbqLqas4MahDtfTp1YzKFGxjEm7yYx9rDrxUClH3BHhocOA6
        ptVtueWvApOMB5pr1aijHEfG0Q==
X-Google-Smtp-Source: APXvYqwjv64SetaHu6CfG+LpB6Vaz6OsESW8kZgLdikVzQVkAutUKDOV4fTrsfrAwv7QU0vnyUrZxA==
X-Received: by 2002:a17:902:9a84:: with SMTP id w4mr84048626plp.160.1563980114929;
        Wed, 24 Jul 2019 07:55:14 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id u7sm41658770pgr.94.2019.07.24.07.55.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 07:55:14 -0700 (PDT)
Date:   Wed, 24 Jul 2019 07:55:13 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org
Subject: Re: [GIT PULL] FPGA Manager fix for 5.3
Message-ID: <20190724145513.GA24455@archbox>
References: <20190724052012.GA3140@archbox>
 <20190724072056.GA27472@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724072056.GA27472@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 09:20:56AM +0200, Greg KH wrote:
> On Tue, Jul 23, 2019 at 10:20:12PM -0700, Moritz Fischer wrote:
> > The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
> > 
> >   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fixes-for-5.3
> > 
> > for you to fetch changes up to c3aefa0b8f54e8c7967191e546a11019bc060fe6:
> > 
> >   fpga-manager: altera-ps-spi: Fix build error (2019-07-23 17:29:17 -0700)
> > 
> > ----------------------------------------------------------------
> > FPGA Manager fixes for 5.3
> > 
> > Hi Greg,
> > 
> > this is only one (late) bugfix for 5.3 that fixes a build error,
> > when altera-ps-spi is built as builtin while a dependency is built as a
> > module.
> > 
> > This has been on the list for a while and I've reviewed it.
> > 
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> 
> This message is not in the signed tag in the repo, are you sure you make
> this correctly?  All I see is the first line:
> 	FPGA Manager fixes for 5.3
> 
> And it's a singluar "fix" :)

Yeah, over the top. I wanted to figure out the workflow with an easy
example ... and ... learned something again :)

So basically the message above is what is supposed to go into the tag
message?

> Care to fix this up and resend, or, just send the single patch as email,
> as that's probably easier here.

I've seen you've queued it up the patch by hand, so next time.

Thanks,
Moritz
