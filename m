Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA3AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7178C21835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576589451;
	bh=Iq7wwjEt29kicSJhEhtg7KMG1eYzpaSwrHdICJOWuCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t/IvlHZpURwx0sLjIAALhrtZ1/zT9g/upxGYEHth+t2hBJtC7MLIxnTnLbBoLr60T
	 upvWPSuwdqzStXZxSwU0nfJ4k4F5W46rSL1Le5t/N+34QjXvD+tmXawwLWzNYWbfL1
	 gBHDZasfkOes/ki35QA3R3ZGfxx1NBviGxPvODIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfLQNau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfLQNar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:30:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5D3420717;
        Tue, 17 Dec 2019 13:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576589447;
        bh=Iq7wwjEt29kicSJhEhtg7KMG1eYzpaSwrHdICJOWuCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+egFA7fXn9QWsyYuyWAj2gTR76Hsd+CFh1RgtQcwA8EnNkdWMr3USbE4FUMwMZun
         kxT8nt0s4hUSza5D54oToUVhIJTyHGL7Hhmg+yEElVbDtVaZ27tCLjvUqv8iO2nnhx
         TEZTmuwpyl8EqLZuh7cvXwovGMHSlRIBVH0S1IJ8=
Date:   Tue, 17 Dec 2019 14:30:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, rfontana@redhat.com,
        allison@lohutok.net, tglx@linutronix.de,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] ALSA: seq: a possible sleep-in-atomic-context bug in
 snd_virmidi_dev_receive_event()
Message-ID: <20191217133045.GA3362771@kroah.com>
References: <db47108d-3967-6760-3de2-17bf60741bc2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db47108d-3967-6760-3de2-17bf60741bc2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 09:24:21PM +0800, Jia-Ju Bai wrote:
> The driver may sleep while holding a read lock.
> The function call path (from bottom to top) in Linux 4.19 is:
> 
> sound/core/seq/seq_memory.c, 96:
>     copy_from_user in snd_seq_dump_var_event
> sound/core/seq/seq_virmidi.c, 97:
>     snd_seq_dump_var_event in snd_virmidi_dev_receive_event
> sound/core/seq/seq_virmidi.c, 88:
>     _raw_read_lock in snd_virmidi_dev_receive_event
> 
> copy_from_user() can sleep at runtime.
> 
> I am not sure how to properly fix this possible bug, so I only report it.
> 
> This bug is found by a static analysis tool STCheck written by myself.

Patches for this is usually best :)
