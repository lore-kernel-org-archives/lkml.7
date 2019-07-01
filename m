Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180F7C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E611A2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfGALT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:19:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58952 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfGALT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:19:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hhuLf-00038r-6I; Mon, 01 Jul 2019 11:19:51 +0000
Date:   Mon, 1 Jul 2019 12:19:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] vfs: move_mount: reject moving kernel internal mounts
Message-ID: <20190701111950.GY17978@ZenIV.linux.org.uk>
References: <20190701010847.GA23778@ZenIV.linux.org.uk>
 <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629202744.12396-1-ebiggers@kernel.org>
 <20190629203916.GV17978@ZenIV.linux.org.uk>
 <2578.1561966690@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2578.1561966690@warthog.procyon.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 08:38:10AM +0100, David Howells wrote:
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > 	/* The thing moved must be mounted... */
> > 	if (!is_mounted(old_path->mnt))
> > 		goto out;
> 
> Um...  Doesn't that stuff up fsmount()?

Nope - check is_mounted() definition.  Stuff in anon namespace
*is* mounted there, so that's not a problem.

FWIW, is_mounted() would've been better off spelled as
ns != NULL && ns != MNT_NS_INTERNAL; the use of IS_ERR_OR_NULL
in there works, but is unidiomatic and I don't think it yields
better code...
