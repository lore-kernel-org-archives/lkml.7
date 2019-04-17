Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F90C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D464B20656
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbfDQMN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:13:59 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:45642 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfDQMN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:13:59 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id BFA075C2F68; Wed, 17 Apr 2019 14:13:09 +0200 (CEST)
Date:   Wed, 17 Apr 2019 14:13:09 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH V2] ARM: mvebu: at least report the kzalloc failure
Message-ID: <20190417121309.GA20864@osadl.at>
References: <1555386991-8855-1-git-send-email-hofrat@osadl.org>
 <20190416133957.GB29190@lunn.ch>
 <20190417114228.GA20280@osadl.at>
 <877ebsal7z.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ebsal7z.fsf@FE-laptop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 02:07:44PM +0200, Gregory CLEMENT wrote:
> Hi Nicholas,
> 
> Nicholas Mc Guire <der.herr@hofr.at> writes:
> 
> > On Tue, Apr 16, 2019 at 03:39:57PM +0200, Andrew Lunn wrote:
> >> On Tue, Apr 16, 2019 at 05:56:31AM +0200, Nicholas Mc Guire wrote:
> >> 
> >> > Note that this will trigger a checkpatch WARNING
> >> > "WARNING: Possible unnecessary 'out of memory' message"
> >> > but comparing the oops with an without the one-line pr_err I would
> >> > argue that it makes sense to include it:
> >> 
> >> Hi Nicholas
> >> 
> >> It might be worth adding this as a comment, so that newbies don't
> >> submit patches removing the pr_err() because of the checkpatch
> >> warning.
> >>
> > hmm... I think if we start doing that we would make quite a mess of
> > documentation in the kernel. Also note its a warning stating "possible 
> > unneceessary" - so I would not see the necessity.
> >
> > At most I would include a note on this in the commit message so that
> > anyone checking the origin would see that this is intenttional - assuming
> > that people modifying code would be using git blame to locate the
> > origin of any code...
> 
> Don't bother to send a new version I don't attempt to take this
> patch. As you pointed it is very unlikely that we get an error so early
> during the boot for a very small amount of memory.
> 
> If it happened then we have serious trouble and the message provided by
> the BUG() call will be more than enough.
>
yup - its a corner case - I'm trying to filter out those
cases that are actually in __init function returning void - as
those cases are, it seems, are generally cases where k{m,z}allocs
will not have explicit checking.

thx!
hofrat 
